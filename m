Return-Path: <khazhy@google.com>
Return-Path: <khazhy@google.com>
From: Khazhismel Kumykov <khazhy@google.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Khazhismel Kumykov <khazhy@google.com>
Subject: [RFC PATCH] blk-throttle: add burst allowance
Date: Thu, 26 Oct 2017 16:54:04 -0700
Message-Id: <20171026235404.62336-1-khazhy@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="94eb2c05b0ee81690a055c7bf148"
List-ID: <linux-block@vger.kernel.org>

--94eb2c05b0ee81690a055c7bf148

Allows configuration additional bytes or ios before a throttle is
triggered. Slice end is extended to cover expended allowance recovery
time.

Usage would be e.g. per device to allow users to take up to X bytes/ios
at full speed, but be limited to Y bps/iops with sustained usage.

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/Kconfig        |  11 +++
 block/blk-throttle.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 186 insertions(+), 10 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 3ab42bbb06d5..16545caa7fc9 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -127,6 +127,17 @@ config BLK_DEV_THROTTLING_LOW
 
 	Note, this is an experimental interface and could be changed someday.
 
+config BLK_DEV_THROTTLING_BURST
+    bool "Block throttling .burst allowance interface"
+    depends on BLK_DEV_THROTTLING
+    default n
+    ---help---
+    Add .burst allowance for block throttling. Burst allowance allows for
+    additional unthrottled usage, while still limiting speed for sustained
+    usage.
+
+    If in doubt, say N.
+
 config BLK_CMDLINE_PARSER
 	bool "Block device command line partition parser"
 	default n
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index d80c3f0144c5..e09ec11e9c5f 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -156,6 +156,11 @@ struct throtl_grp {
 	/* Number of bio's dispatched in current slice */
 	unsigned int io_disp[2];
 
+#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
+	uint64_t bytes_burst_conf[2];
+	unsigned int io_burst_conf[2];
+#endif
+
 	unsigned long last_low_overflow_time[2];
 
 	uint64_t last_bytes_disp[2];
@@ -506,6 +511,12 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 	tg->bps_conf[WRITE][LIMIT_MAX] = U64_MAX;
 	tg->iops_conf[READ][LIMIT_MAX] = UINT_MAX;
 	tg->iops_conf[WRITE][LIMIT_MAX] = UINT_MAX;
+#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
+	tg->bytes_burst_conf[READ] = 0;
+	tg->bytes_burst_conf[WRITE] = 0;
+	tg->io_burst_conf[READ] = 0;
+	tg->io_burst_conf[WRITE] = 0;
+#endif
 	/* LIMIT_LOW will have default value 0 */
 
 	tg->latency_target = DFL_LATENCY_TARGET;
@@ -799,6 +810,26 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
 		   tg->slice_end[rw], jiffies);
 }
 
+/*
+ * When current slice should end.
+ *
+ * With CONFIG_BLK_DEV_THROTTLING_BURST, we will wait longer than min_wait
+ * for slice to recover used burst allowance. (*_disp -> 0). Setting slice_end
+ * before this would result in tg receiving additional burst allowance.
+ */
+static inline unsigned long throtl_slice_wait(struct throtl_grp *tg, bool rw,
+						unsigned long min_wait)
+{
+	unsigned long bytes_wait = 0, io_wait = 0;
+#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
+	if (tg->bytes_burst_conf[rw])
+		bytes_wait = (tg->bytes_disp[rw] * HZ) / tg_bps_limit(tg, rw);
+	if (tg->io_burst_conf[rw])
+		io_wait = (tg->io_disp[rw] * HZ) / tg_iops_limit(tg, rw);
+#endif
+	return jiffies + max(min_wait, max(bytes_wait, io_wait));
+}
+
 static inline void throtl_set_slice_end(struct throtl_grp *tg, bool rw,
 					unsigned long jiffy_end)
 {
@@ -848,7 +879,8 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
 	 * is bad because it does not allow new slice to start.
 	 */
 
-	throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
+	throtl_set_slice_end(tg, rw,
+			     throtl_slice_wait(tg, rw, tg->td->throtl_slice));
 
 	time_elapsed = jiffies - tg->slice_start[rw];
 
@@ -888,7 +920,7 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 				  unsigned long *wait)
 {
 	bool rw = bio_data_dir(bio);
-	unsigned int io_allowed;
+	unsigned int io_allowed, io_disp;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	u64 tmp;
 
@@ -907,6 +939,17 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	 * have been trimmed.
 	 */
 
+	io_disp = tg->io_disp[rw];
+
+#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
+	if (tg->io_disp[rw] < tg->io_burst_conf[rw]) {
+		if (wait)
+			*wait = 0;
+		return true;
+	}
+	io_disp -= tg->io_burst_conf[rw];
+#endif
+
 	tmp = (u64)tg_iops_limit(tg, rw) * jiffy_elapsed_rnd;
 	do_div(tmp, HZ);
 
@@ -915,14 +958,14 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
 	else
 		io_allowed = tmp;
 
-	if (tg->io_disp[rw] + 1 <= io_allowed) {
+	if (io_disp + 1 <= io_allowed) {
 		if (wait)
 			*wait = 0;
 		return true;
 	}
 
 	/* Calc approx time to dispatch */
-	jiffy_wait = ((tg->io_disp[rw] + 1) * HZ) / tg_iops_limit(tg, rw) + 1;
+	jiffy_wait = ((io_disp + 1) * HZ) / tg_iops_limit(tg, rw) + 1;
 
 	if (jiffy_wait > jiffy_elapsed)
 		jiffy_wait = jiffy_wait - jiffy_elapsed;
@@ -938,7 +981,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 				 unsigned long *wait)
 {
 	bool rw = bio_data_dir(bio);
-	u64 bytes_allowed, extra_bytes, tmp;
+	u64 bytes_allowed, extra_bytes, bytes_disp, tmp;
 	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
 	unsigned int bio_size = throtl_bio_data_size(bio);
 
@@ -950,18 +993,28 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
 
 	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
 
+	bytes_disp = tg->bytes_disp[rw];
+#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
+	if (tg->bytes_disp[rw] < tg->bytes_burst_conf[rw]) {
+		if (wait)
+			*wait = 0;
+		return true;
+	}
+	bytes_disp -= tg->bytes_burst_conf[rw];
+#endif
+
 	tmp = tg_bps_limit(tg, rw) * jiffy_elapsed_rnd;
 	do_div(tmp, HZ);
 	bytes_allowed = tmp;
 
-	if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
+	if (bytes_disp + bio_size <= bytes_allowed) {
 		if (wait)
 			*wait = 0;
 		return true;
 	}
 
 	/* Calc approx time to dispatch */
-	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
+	extra_bytes = bytes_disp + bio_size - bytes_allowed;
 	jiffy_wait = div64_u64(extra_bytes * HZ, tg_bps_limit(tg, rw));
 
 	if (!jiffy_wait)
@@ -1017,7 +1070,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 		if (time_before(tg->slice_end[rw],
 		    jiffies + tg->td->throtl_slice))
 			throtl_extend_slice(tg, rw,
-				jiffies + tg->td->throtl_slice);
+			    throtl_slice_wait(tg, rw, tg->td->throtl_slice));
 	}
 
 	if (tg_with_in_bps_limit(tg, bio, &bps_wait) &&
@@ -1032,8 +1085,10 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	if (wait)
 		*wait = max_wait;
 
-	if (time_before(tg->slice_end[rw], jiffies + max_wait))
-		throtl_extend_slice(tg, rw, jiffies + max_wait);
+	if (time_before(tg->slice_end[rw],
+			throtl_slice_wait(tg, rw, max_wait)))
+		throtl_extend_slice(tg, rw,
+				    throtl_slice_wait(tg, rw, max_wait));
 
 	return 0;
 }
@@ -1704,6 +1759,108 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
+static u64 tg_prfill_burst(struct seq_file *sf, struct blkg_policy_data *pd,
+			   int data)
+{
+	struct throtl_grp *tg = pd_to_tg(pd);
+	const char *dname = blkg_dev_name(pd->blkg);
+	char bufs[4][21];
+
+	if (!dname)
+		return 0;
+
+	if (tg->bytes_burst_conf[READ] == 0 &&
+	    tg->bytes_burst_conf[WRITE] == 0 &&
+	    tg->io_burst_conf[READ] == 0 &&
+	    tg->io_burst_conf[WRITE] == 0)
+		return 0;
+
+	snprintf(bufs[0], sizeof(bufs[0]), "%llu",
+		tg->bytes_burst_conf[READ]);
+	snprintf(bufs[1], sizeof(bufs[1]), "%llu",
+		tg->bytes_burst_conf[WRITE]);
+	snprintf(bufs[2], sizeof(bufs[2]), "%u",
+		tg->io_burst_conf[READ]);
+	snprintf(bufs[3], sizeof(bufs[3]), "%u",
+		tg->io_burst_conf[WRITE]);
+
+	seq_printf(sf, "%s brbyte=%s bwbyte=%s brio=%s bwio=%s\n",
+		   dname, bufs[0], bufs[1], bufs[2], bufs[3]);
+	return 0;
+}
+
+static int tg_print_burst(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), tg_prfill_burst,
+			  &blkcg_policy_throtl, 0, false);
+	return 0;
+}
+
+static ssize_t tg_set_burst(struct kernfs_open_file *of,
+			  char *buf, size_t nbytes, loff_t off)
+{
+	struct blkcg *blkcg = css_to_blkcg(of_css(of));
+	struct blkg_conf_ctx ctx;
+	struct throtl_grp *tg;
+	u64 v[4];
+	int ret;
+
+	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
+	if (ret)
+		return ret;
+
+	tg = blkg_to_tg(ctx.blkg);
+
+	v[0] = tg->bytes_burst_conf[READ];
+	v[1] = tg->bytes_burst_conf[WRITE];
+	v[2] = tg->io_burst_conf[READ];
+	v[3] = tg->io_burst_conf[WRITE];
+
+	while (true) {
+		char tok[28];	/* bwbyte=18446744073709551616 */
+		char *p;
+		u64 val = U64_MAX;
+		int len;
+
+		if (sscanf(ctx.body, "%27s%n", tok, &len) != 1)
+			break;
+		if (tok[0] == '\0')
+			break;
+		ctx.body += len;
+
+		ret = -EINVAL;
+		p = tok;
+		strsep(&p, "=");
+		if (!p || (kstrtoull(p, 0, &val) != 0 && strcmp(p, "max")))
+			goto out_finish;
+
+		ret = -EINVAL;
+		if (!strcmp(tok, "brbyte"))
+			v[0] = val;
+		else if (!strcmp(tok, "bwbyte"))
+			v[1] = val;
+		else if (!strcmp(tok, "brio"))
+			v[2] = min_t(u64, val, UINT_MAX);
+		else if (!strcmp(tok, "bwio"))
+			v[3] = min_t(u64, val, UINT_MAX);
+		else
+			goto out_finish;
+	}
+
+	tg->bytes_burst_conf[READ] = v[0];
+	tg->bytes_burst_conf[WRITE] = v[1];
+	tg->io_burst_conf[READ] = v[2];
+	tg->io_burst_conf[WRITE] = v[3];
+
+	tg_conf_updated(tg, false);
+	ret = 0;
+out_finish:
+	blkg_conf_finish(&ctx);
+	return ret ?: nbytes;
+}
+#endif
+
 static struct cftype throtl_files[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	{
@@ -1713,6 +1870,14 @@ static struct cftype throtl_files[] = {
 		.write = tg_set_limit,
 		.private = LIMIT_LOW,
 	},
+#endif
+#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
+	{
+		.name = "burst",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = tg_print_burst,
+		.write = tg_set_burst,
+	},
 #endif
 	{
 		.name = "max",
-- 
2.15.0.rc2.357.g7e34df9404-goog


--94eb2c05b0ee81690a055c7bf148
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS5wYJKoZIhvcNAQcCoIIS2DCCEtQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBNMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BQUHMAKGNGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzaHZzbWltZWNhMS5j
cnQwHQYDVR0OBBYEFMnO7tLwRUm/Kh/G63DTEdz9N5wmMB8GA1UdIwQYMBaAFMs4ErDHmcB4koyz
IZXm9CZiwOA/MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8v
d3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NodnNtaW1lY2ExLmNybDAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBCwUAA4IBAQA5gzhiP9g5DzgYyM4K
/OtFFFKyrluiKx9OmOb1Mx9UCxEi9vzRrG5j1rFMAwNAx+xEESoq1JVNe8fJKBimOsKpWstAhYlO
Cg6Qm43dzb+5CcPWDC3j6XxfsUIKvektE79/IeVhdRVj+Op1gSEGaBJQP2c0/MeXPPhQKPjAPVQW
bEOJaemCXr1UIoEHMoisd0Smdm1NjxLYLk3bK1RDgO0RTu2hNmVAT9WypS9uiquOQWeK3u9QBuUK
BhOZjgo70YosoRVRBIKNqStZ++IpaDEWfDme3EH4H8tlOzwCvAiO8c1uF7ZX68wXWJPjq6uxu1cZ
5lT83BZ34AElNAzFvsLhMYICXjCCAloCAQEwXDBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xv
YmFsU2lnbiBudi1zYTEiMCAGA1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMQIMPycjokgk
Gdp8HTY2MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAOzI7Hqb3l6cf+MRlL3azk
uaqSMrWw4wPLXFInsHmOhzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xNzEwMjYyMzU4MDZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglg
hkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJRAVwpQ/MfawA7jnXoW+gade3KWDaMOshxIkQBvj
YZbRyZ++OpxmzpgVB+/cgqvK1eJx7HyRz2Pv+xTYP+0DpSD6shz61ldckzaWymecmTGiXl8r+JhI
JLacgEvPG79/GGaVNNV416qZnURcHITsXVdS7Dtlqsy1KtOjq0CLPMBqNYmLRBI4vYdZQVhO8SYM
v1vNqyIUPlZuDM4UBwjebcIgOA4v1Nlq3DgpqxldiT27VKZ3RoCNXxePz/Y2jlXnUZ/frEExNOgS
Ju2Z1uWAXINrJdtMKT2TIvzKaFgeYJvYdSZ3Ws8uqQixhBvKERdRnAHyRwasUClWiGudlGfkSA==
--94eb2c05b0ee81690a055c7bf148--
