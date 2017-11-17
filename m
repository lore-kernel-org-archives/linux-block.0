Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41292 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932634AbdKQE0B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Nov 2017 23:26:01 -0500
Received: by mail-ot0-f195.google.com with SMTP id b54so1059201otd.8
        for <linux-block@vger.kernel.org>; Thu, 16 Nov 2017 20:26:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171116165033.4noofd6gkaj6x3yl@kernel.org>
References: <20171114231022.42961-1-khazhy@google.com> <20171116165033.4noofd6gkaj6x3yl@kernel.org>
From: Khazhismel Kumykov <khazhy@google.com>
Date: Thu, 16 Nov 2017 20:25:58 -0800
Message-ID: <CACGdZY+OdN-yfTGFgd1qmXBn+z3OkKMX3FeCnwSdYVHj7HdQyw@mail.gmail.com>
Subject: Re: [RFC PATCH] blk-throttle: add burst allowance.
To: Shaohua Li <shli@kernel.org>
Cc: axobe@kernel.dk, shli@fb.com, vgoyal@redhat.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="001a11470aec49a009055e26229e"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--001a11470aec49a009055e26229e
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 16, 2017 at 8:50 AM, Shaohua Li <shli@kernel.org> wrote:
> On Tue, Nov 14, 2017 at 03:10:22PM -0800, Khazhismel Kumykov wrote:
>> Allows configuration additional bytes or ios before a throttle is
>> triggered.
>>
>> This allows implementation of a bucket style rate-limit/throttle on a
>> block device. Previously, bursting to a device was limited to allowance
>> granted in a single throtl_slice (similar to a bucket with limit N and
>> refill rate N/slice).
>>
>> Additional parameters bytes/io_burst_conf defined for tg, which define a
>> number of bytes/ios that must be depleted before throttling happens. A
>> tg that does not deplete this allowance functions as though it has no
>> configured limits. tgs earn additional allowance at rate defined by
>> bps/iops for the tg. Once a tg has *_disp > *_burst_conf, throttling
>> kicks in. If a tg is idle for a while, it will again have some burst
>> allowance before it gets throttled again.
>>
>> slice_end for a tg is extended until io_disp/byte_disp would fall to 0,
>> when all "used" burst allowance would be earned back. trim_slice still
>> does progress slice_start as before and decrements *_disp as before, and
>> tgs continue to get bytes/ios in throtl_slice intervals.
>
> Can you describe why we need this? It would be great if you can describe the
> usage model and an example. Does this work for io.low/io.max or both?
>
> Thanks,
> Shaohua
>

Use case that brought this up was configuring limits for a remote
shared device. Bursting beyond io.max is desired but only for so much
before the limit kicks in, afterwards with sustained usage throughput
is capped. (This proactively avoids remote-side limits). In that case
one would configure in a root container io.max + io.burst, and
configure low/other limits on descendants sharing the resource on the
same node.

With this patch, so long as tg has not dispatched more than the burst,
no limit is applied at all by that tg, including limit imposed by
io.low in tg_iops_limit, etc.

Khazhy

>> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
>> ---
>>  block/Kconfig        |  11 +++
>>  block/blk-throttle.c | 192 +++++++++++++++++++++++++++++++++++++++++++++++----
>>  2 files changed, 189 insertions(+), 14 deletions(-)
>>
>> diff --git a/block/Kconfig b/block/Kconfig
>> index 28ec55752b68..fbd05b419f93 100644
>> --- a/block/Kconfig
>> +++ b/block/Kconfig
>> @@ -128,6 +128,17 @@ config BLK_DEV_THROTTLING_LOW
>>
>>       Note, this is an experimental interface and could be changed someday.
>>
>> +config BLK_DEV_THROTTLING_BURST
>> +    bool "Block throttling .burst allowance interface"
>> +    depends on BLK_DEV_THROTTLING
>> +    default n
>> +    ---help---
>> +    Add .burst allowance for block throttling. Burst allowance allows for
>> +    additional unthrottled usage, while still limiting speed for sustained
>> +    usage.
>> +
>> +    If in doubt, say N.
>> +
>>  config BLK_CMDLINE_PARSER
>>       bool "Block device command line partition parser"
>>       default n
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index 96ad32623427..27c084312772 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -157,6 +157,11 @@ struct throtl_grp {
>>       /* Number of bio's dispatched in current slice */
>>       unsigned int io_disp[2];
>>
>> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
>> +     uint64_t bytes_burst_conf[2];
>> +     unsigned int io_burst_conf[2];
>> +#endif
>> +
>>       unsigned long last_low_overflow_time[2];
>>
>>       uint64_t last_bytes_disp[2];
>> @@ -507,6 +512,12 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
>>       tg->bps_conf[WRITE][LIMIT_MAX] = U64_MAX;
>>       tg->iops_conf[READ][LIMIT_MAX] = UINT_MAX;
>>       tg->iops_conf[WRITE][LIMIT_MAX] = UINT_MAX;
>> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
>> +     tg->bytes_burst_conf[READ] = 0;
>> +     tg->bytes_burst_conf[WRITE] = 0;
>> +     tg->io_burst_conf[READ] = 0;
>> +     tg->io_burst_conf[WRITE] = 0;
>> +#endif
>>       /* LIMIT_LOW will have default value 0 */
>>
>>       tg->latency_target = DFL_LATENCY_TARGET;
>> @@ -800,6 +811,26 @@ static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw)
>>                  tg->slice_end[rw], jiffies);
>>  }
>>
>> +/*
>> + * When current slice should end.
>> + *
>> + * With CONFIG_BLK_DEV_THROTTLING_BURST, we will wait longer than min_wait
>> + * for slice to recover used burst allowance. (*_disp -> 0). Setting slice_end
>> + * before this would result in tg receiving additional burst allowance.
>> + */
>> +static inline unsigned long throtl_slice_wait(struct throtl_grp *tg, bool rw,
>> +                                             unsigned long min_wait)
>> +{
>> +     unsigned long bytes_wait = 0, io_wait = 0;
>> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
>> +     if (tg->bytes_burst_conf[rw])
>> +             bytes_wait = (tg->bytes_disp[rw] * HZ) / tg_bps_limit(tg, rw);
>> +     if (tg->io_burst_conf[rw])
>> +             io_wait = (tg->io_disp[rw] * HZ) / tg_iops_limit(tg, rw);
>> +#endif
>> +     return max(min_wait, max(bytes_wait, io_wait));
>> +}
>> +
>>  static inline void throtl_set_slice_end(struct throtl_grp *tg, bool rw,
>>                                       unsigned long jiffy_end)
>>  {
>> @@ -849,7 +880,8 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>>        * is bad because it does not allow new slice to start.
>>        */
>>
>> -     throtl_set_slice_end(tg, rw, jiffies + tg->td->throtl_slice);
>> +     throtl_set_slice_end(tg, rw,
>> +             jiffies + throtl_slice_wait(tg, rw, tg->td->throtl_slice));
>>
>>       time_elapsed = jiffies - tg->slice_start[rw];
>>
>> @@ -889,7 +921,7 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
>>                                 unsigned long *wait)
>>  {
>>       bool rw = bio_data_dir(bio);
>> -     unsigned int io_allowed;
>> +     unsigned int io_allowed, io_disp;
>>       unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>>       u64 tmp;
>>
>> @@ -908,6 +940,17 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
>>        * have been trimmed.
>>        */
>>
>> +     io_disp = tg->io_disp[rw];
>> +
>> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
>> +     if (tg->io_disp[rw] < tg->io_burst_conf[rw]) {
>> +             if (wait)
>> +                     *wait = 0;
>> +             return true;
>> +     }
>> +     io_disp -= tg->io_burst_conf[rw];
>> +#endif
>> +
>>       tmp = (u64)tg_iops_limit(tg, rw) * jiffy_elapsed_rnd;
>>       do_div(tmp, HZ);
>>
>> @@ -916,14 +959,14 @@ static bool tg_with_in_iops_limit(struct throtl_grp *tg, struct bio *bio,
>>       else
>>               io_allowed = tmp;
>>
>> -     if (tg->io_disp[rw] + 1 <= io_allowed) {
>> +     if (io_disp + 1 <= io_allowed) {
>>               if (wait)
>>                       *wait = 0;
>>               return true;
>>       }
>>
>>       /* Calc approx time to dispatch */
>> -     jiffy_wait = ((tg->io_disp[rw] + 1) * HZ) / tg_iops_limit(tg, rw) + 1;
>> +     jiffy_wait = ((io_disp + 1) * HZ) / tg_iops_limit(tg, rw) + 1;
>>
>>       if (jiffy_wait > jiffy_elapsed)
>>               jiffy_wait = jiffy_wait - jiffy_elapsed;
>> @@ -939,7 +982,7 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>>                                unsigned long *wait)
>>  {
>>       bool rw = bio_data_dir(bio);
>> -     u64 bytes_allowed, extra_bytes, tmp;
>> +     u64 bytes_allowed, extra_bytes, bytes_disp, tmp;
>>       unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>>       unsigned int bio_size = throtl_bio_data_size(bio);
>>
>> @@ -951,18 +994,28 @@ static bool tg_with_in_bps_limit(struct throtl_grp *tg, struct bio *bio,
>>
>>       jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
>>
>> +     bytes_disp = tg->bytes_disp[rw];
>> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
>> +     if (tg->bytes_disp[rw] < tg->bytes_burst_conf[rw]) {
>> +             if (wait)
>> +                     *wait = 0;
>> +             return true;
>> +     }
>> +     bytes_disp -= tg->bytes_burst_conf[rw];
>> +#endif
>> +
>>       tmp = tg_bps_limit(tg, rw) * jiffy_elapsed_rnd;
>>       do_div(tmp, HZ);
>>       bytes_allowed = tmp;
>>
>> -     if (tg->bytes_disp[rw] + bio_size <= bytes_allowed) {
>> +     if (bytes_disp + bio_size <= bytes_allowed) {
>>               if (wait)
>>                       *wait = 0;
>>               return true;
>>       }
>>
>>       /* Calc approx time to dispatch */
>> -     extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
>> +     extra_bytes = bytes_disp + bio_size - bytes_allowed;
>>       jiffy_wait = div64_u64(extra_bytes * HZ, tg_bps_limit(tg, rw));
>>
>>       if (!jiffy_wait)
>> @@ -986,7 +1039,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>>                           unsigned long *wait)
>>  {
>>       bool rw = bio_data_dir(bio);
>> -     unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0;
>> +     unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0, disp_time;
>>
>>       /*
>>        * Currently whole state machine of group depends on first bio
>> @@ -1015,10 +1068,10 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>>       if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
>>               throtl_start_new_slice(tg, rw);
>>       else {
>> -             if (time_before(tg->slice_end[rw],
>> -                 jiffies + tg->td->throtl_slice))
>> -                     throtl_extend_slice(tg, rw,
>> -                             jiffies + tg->td->throtl_slice);
>> +             disp_time = jiffies + throtl_slice_wait(
>> +                             tg, rw, tg->td->throtl_slice);
>> +             if (time_before(tg->slice_end[rw], disp_time))
>> +                     throtl_extend_slice(tg, rw, disp_time);
>>       }
>>
>>       if (tg_with_in_bps_limit(tg, bio, &bps_wait) &&
>> @@ -1033,8 +1086,9 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>>       if (wait)
>>               *wait = max_wait;
>>
>> -     if (time_before(tg->slice_end[rw], jiffies + max_wait))
>> -             throtl_extend_slice(tg, rw, jiffies + max_wait);
>> +     disp_time = jiffies + throtl_slice_wait(tg, rw, max_wait);
>> +     if (time_before(tg->slice_end[rw], disp_time))
>> +             throtl_extend_slice(tg, rw, disp_time);
>>
>>       return 0;
>>  }
>> @@ -1705,6 +1759,108 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
>>       return ret ?: nbytes;
>>  }
>>
>> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
>> +static u64 tg_prfill_burst(struct seq_file *sf, struct blkg_policy_data *pd,
>> +                        int data)
>> +{
>> +     struct throtl_grp *tg = pd_to_tg(pd);
>> +     const char *dname = blkg_dev_name(pd->blkg);
>> +     char bufs[4][21];
>> +
>> +     if (!dname)
>> +             return 0;
>> +
>> +     if (tg->bytes_burst_conf[READ] == 0 &&
>> +         tg->bytes_burst_conf[WRITE] == 0 &&
>> +         tg->io_burst_conf[READ] == 0 &&
>> +         tg->io_burst_conf[WRITE] == 0)
>> +             return 0;
>> +
>> +     snprintf(bufs[0], sizeof(bufs[0]), "%llu",
>> +             tg->bytes_burst_conf[READ]);
>> +     snprintf(bufs[1], sizeof(bufs[1]), "%llu",
>> +             tg->bytes_burst_conf[WRITE]);
>> +     snprintf(bufs[2], sizeof(bufs[2]), "%u",
>> +             tg->io_burst_conf[READ]);
>> +     snprintf(bufs[3], sizeof(bufs[3]), "%u",
>> +             tg->io_burst_conf[WRITE]);
>> +
>> +     seq_printf(sf, "%s brbyte=%s bwbyte=%s brio=%s bwio=%s\n",
>> +                dname, bufs[0], bufs[1], bufs[2], bufs[3]);
>> +     return 0;
>> +}
>> +
>> +static int tg_print_burst(struct seq_file *sf, void *v)
>> +{
>> +     blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), tg_prfill_burst,
>> +                       &blkcg_policy_throtl, 0, false);
>> +     return 0;
>> +}
>> +
>> +static ssize_t tg_set_burst(struct kernfs_open_file *of,
>> +                       char *buf, size_t nbytes, loff_t off)
>> +{
>> +     struct blkcg *blkcg = css_to_blkcg(of_css(of));
>> +     struct blkg_conf_ctx ctx;
>> +     struct throtl_grp *tg;
>> +     u64 v[4];
>> +     int ret;
>> +
>> +     ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
>> +     if (ret)
>> +             return ret;
>> +
>> +     tg = blkg_to_tg(ctx.blkg);
>> +
>> +     v[0] = tg->bytes_burst_conf[READ];
>> +     v[1] = tg->bytes_burst_conf[WRITE];
>> +     v[2] = tg->io_burst_conf[READ];
>> +     v[3] = tg->io_burst_conf[WRITE];
>> +
>> +     while (true) {
>> +             char tok[28];   /* bwbyte=18446744073709551616 */
>> +             char *p;
>> +             u64 val = U64_MAX;
>> +             int len;
>> +
>> +             if (sscanf(ctx.body, "%27s%n", tok, &len) != 1)
>> +                     break;
>> +             if (tok[0] == '\0')
>> +                     break;
>> +             ctx.body += len;
>> +
>> +             ret = -EINVAL;
>> +             p = tok;
>> +             strsep(&p, "=");
>> +             if (!p || (kstrtoull(p, 0, &val) != 0 && strcmp(p, "max")))
>> +                     goto out_finish;
>> +
>> +             ret = -EINVAL;
>> +             if (!strcmp(tok, "brbyte"))
>> +                     v[0] = val;
>> +             else if (!strcmp(tok, "bwbyte"))
>> +                     v[1] = val;
>> +             else if (!strcmp(tok, "brio"))
>> +                     v[2] = min_t(u64, val, UINT_MAX);
>> +             else if (!strcmp(tok, "bwio"))
>> +                     v[3] = min_t(u64, val, UINT_MAX);
>> +             else
>> +                     goto out_finish;
>> +     }
>> +
>> +     tg->bytes_burst_conf[READ] = v[0];
>> +     tg->bytes_burst_conf[WRITE] = v[1];
>> +     tg->io_burst_conf[READ] = v[2];
>> +     tg->io_burst_conf[WRITE] = v[3];
>> +
>> +     tg_conf_updated(tg, false);
>> +     ret = 0;
>> +out_finish:
>> +     blkg_conf_finish(&ctx);
>> +     return ret ?: nbytes;
>> +}
>> +#endif
>> +
>>  static struct cftype throtl_files[] = {
>>  #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>>       {
>> @@ -1714,6 +1870,14 @@ static struct cftype throtl_files[] = {
>>               .write = tg_set_limit,
>>               .private = LIMIT_LOW,
>>       },
>> +#endif
>> +#ifdef CONFIG_BLK_DEV_THROTTLING_BURST
>> +     {
>> +             .name = "burst",
>> +             .flags = CFTYPE_NOT_ON_ROOT,
>> +             .seq_show = tg_print_burst,
>> +             .write = tg_set_burst,
>> +     },
>>  #endif
>>       {
>>               .name = "max",
>> --
>> 2.15.0.448.gf294e3d99a-goog
>>
>
>

--001a11470aec49a009055e26229e
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
Gdp8HTY2MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDrqBGy+pxAJNSU5FdSJlle
jsEvWwblHIQv6tCvaEZbkjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0xNzExMTcwNDI2MDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglg
hkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAiJ463Y4Vt5mnIlSOQkdCzxpPXUcMLgVErj9RRS9x
aeHPnym9nlWxYn+VjJKrSYtwEQQWwAn3jdBWOAeKPoJOszYUe1KAIaZjxI2cV0YJdkrMpiAp/pYk
1x8FGtZUV5YHMZTAJRNBMk77mhVhvbK178EhwBR5NlpEbaxro0oBteZ5uoq82d9lzl+JvGYiG/RU
A/L2klGqySw98H3C2DiFnD6H/CQg4Rs3uwr7fIXCeRPMrHgG51xpwNuZyosWxDAOaDTJlXu0VlnC
Sl77rGsozhI8JeWVYV4plxKWQCL7A5xqXKn+dHvXVLvAhVCykwdllg0l0UprP9xFnMaC0eTwRQ==
--001a11470aec49a009055e26229e--
