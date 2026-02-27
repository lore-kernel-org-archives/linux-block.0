Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623842B731
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204298; cv=none; b=ADUFy+r7/IGN+YBm2+4N20mpZ6rcUt+nAqJxQvKQLssM4wBGVw/QbdkWWKvEK3e+0LGFomO5+XzWUwnRpYhfIvS+ecVAI7j3lm5vmuW2VxnigC8gDhT1djVXGdqftpRJKD5+ICQe4vfqWO1DWCbV8jfoXJqh4e92gb1ExLCOpCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204298; c=relaxed/simple;
	bh=zvfUEDxDW0zXYQJfAL1aEN2AwZ70SYNgsYsRv8tKL70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EolMsrF67Z80foOJ5QrwT+VV3LjHjwyfvl19UbiZ5Rrw8DCXPrGYnD2IUf/0LMQHxGHVBQRJyugY+aFMm/39sx4UM2ExkGytmaiaNuJpDtyuHKb+jnYKBhxNTDaT6Fvb4YpnYgAuGspbPrRpnuP519k/cjqHSdhAt4kWr9HZRPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=FHLulvvP; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="FHLulvvP"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1772204287; bh=zvfUEDxDW0zXYQJfAL1aEN2AwZ70SYNgsYsRv8tKL70=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=FHLulvvPoLHHfuvyhKFZ9UgBPYUgMXnGkK4gmWjaIr45OR3wV/fVoY7EW+KuUK+34
	 XzW+sZLK5Rc+niW/Xs1GMZb055pc0yd93cokcHAjTtyHHmmmTReXFohtw6kPTR5fDT
	 WPagtUsBEDpuVSDZZGpLD1CZLs8ufRzNvFmFiNlEtv1sxVxrhw+N3BGxCweyDX+Ch9
	 VZCWIRKGF8IQQ07luB+hhTnhRvMHQMhUGnNnY8fQR1ORBu2dfptqySjTfCS7kLuNOb
	 5HQAfdfCkRXSAFJXgGpZ2C8U96MsvHwymQbnhzYuuWJhwbUiuadUisbtMD332KyDol
	 NuPwfwghxWePmTqznsHnAVUUaB6rFgpTBoMOwtXXB8VeusC7ILNcICiH2cd2p0HtCy
	 3rx9GMKHOCF7cQymq4f6yGDGknUgUtGpgzi6JJaHa2+EKfJJPA+ZjuPZXXtaJR4vgr
	 Uqxg3MfkVGIwV7VWhiYa0fWcQlqHwcO65q41Gt2yWyfDNAfLny6dbRcQEA7DXW7Yik
	 gCLhU90VnyjgwC3oryZFaaG69yR9sTNQSSjzioCK4F5/EKj/9D5Gfz7JZofkeZFVLl
	 H1QNCCK5zOd4dIe6t4ItIpINM3HLMxCf6fpfsddpsOEv2Ys6q3mDs55QvaQuDGZ6UF
	 UUHJqCmu/CabKm07an7iQNRU=
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH v2 2/4] selftests: ublk: rework partitions tests for new flags
Date: Fri, 27 Feb 2026 14:57:54 +0000
Message-ID: <20260227145756.3877069-3-alex@zazolabs.com>
In-Reply-To: <20260227145756.3877069-1-alex@zazolabs.com>
References: <20260227145756.3877069-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support new flag - UBLK_F_NO_PARTITIONS
add kublk argument:
-m, --no_partitions - disable partitions on trusted devices
Add short argument for  UBLK_F_NO_AUTO_PART_SCAN
-p, --no_auto_part_scan - disable initial partition scan

Update test cases to use the new arguments

Fix long lines while at it.

Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 tools/testing/selftests/ublk/kublk.c             | 16 +++++++++++-----
 .../testing/selftests/ublk/test_integrity_01.sh  |  8 +++++---
 tools/testing/selftests/ublk/test_part_01.sh     |  6 +++---
 tools/testing/selftests/ublk/test_part_02.sh     |  6 ++++--
 4 files changed, 23 insertions(+), 13 deletions(-)

v1->v2:
  - switch from opt-in to opt-out flags

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index e8279c4acc40..c0dacdc12ebe 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1615,6 +1615,7 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_INTEGRITY),
 		FEAT_NAME(UBLK_F_SAFE_STOP_DEV),
 		FEAT_NAME(UBLK_F_BATCH_IO),
+		FEAT_NAME(UBLK_F_NO_PARTITIONS),
 		FEAT_NAME(UBLK_F_NO_AUTO_PART_SCAN),
 	};
 	struct ublk_dev *dev;
@@ -1713,7 +1714,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
 	printf("\t[--integrity_capable] [--integrity_reftag] [--metadata_size SIZE] "
 		 "[--pi_offset OFFSET] [--csum_type ip|t10dif|nvme] [--tag_size SIZE]\n");
-	printf("\t[--batch|-b] [--no_auto_part_scan]\n");
+	printf("\t[--batch|-b] [-m,--no_partitions] [-p,--no_auto_part_scan]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
@@ -1783,11 +1784,12 @@ int main(int argc, char *argv[])
 		{ "integrity_reftag",	0,	NULL,  0 },
 		{ "metadata_size",	1,	NULL,  0 },
 		{ "pi_offset",		1,	NULL,  0 },
+		{ "no_partitions",	0,	NULL, 'm' },
+		{ "no_auto_part_scan",	0,	NULL, 'p' },
 		{ "csum_type",		1,	NULL,  0 },
 		{ "tag_size",		1,	NULL,  0 },
 		{ "safe",		0,	NULL,  0 },
 		{ "batch",              0,      NULL, 'b'},
-		{ "no_auto_part_scan",	0,	NULL,  0 },
 		{ 0, 0, 0, 0 }
 	};
 	const struct ublk_tgt_ops *ops = NULL;
@@ -1810,7 +1812,7 @@ int main(int argc, char *argv[])
 
 	opterr = 0;
 	optind = 2;
-	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gazub",
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gazubmp",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -1856,6 +1858,12 @@ int main(int argc, char *argv[])
 		case 'u':
 			ctx.flags |= UBLK_F_USER_COPY;
 			break;
+		case 'm':
+			ctx.flags |= UBLK_F_NO_PARTITIONS;
+			break;
+		case 'p':
+			ctx.flags |= UBLK_F_NO_AUTO_PART_SCAN;
+			break;
 		case 's':
 			ctx.size = strtoull(optarg, NULL, 10);
 			break;
@@ -1900,8 +1908,6 @@ int main(int argc, char *argv[])
 				ctx.tag_size = strtoul(optarg, NULL, 0);
 			if (!strcmp(longopts[option_idx].name, "safe"))
 				ctx.safe_stop = 1;
-			if (!strcmp(longopts[option_idx].name, "no_auto_part_scan"))
-				ctx.flags |= UBLK_F_NO_AUTO_PART_SCAN;
 			break;
 		case '?':
 			/*
diff --git a/tools/testing/selftests/ublk/test_integrity_01.sh b/tools/testing/selftests/ublk/test_integrity_01.sh
index 6713b280a6ff..b7ffc6212d24 100755
--- a/tools/testing/selftests/ublk/test_integrity_01.sh
+++ b/tools/testing/selftests/ublk/test_integrity_01.sh
@@ -40,7 +40,8 @@ _test_metadata_only() {
 _test_integrity_capable_ip() {
 	local dev_id
 
-	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --integrity_capable --metadata_size 64 --pi_offset 56 --csum_type ip)
+	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --integrity_capable \
+		--metadata_size 64 --pi_offset 56 --csum_type ip)
 	_check_add_dev "$TID" $?
 
 	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 64 &&
@@ -59,7 +60,8 @@ _test_integrity_capable_ip() {
 _test_integrity_reftag_t10dif() {
 	local dev_id
 
-	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --integrity_reftag --metadata_size 8 --csum_type t10dif)
+	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --integrity_reftag --metadata_size 8 \
+		--csum_type t10dif)
 	_check_add_dev "$TID" $?
 
 	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 8 &&
@@ -78,7 +80,7 @@ _test_integrity_reftag_t10dif() {
 _test_nvme_csum() {
 	local dev_id
 
-	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --metadata_size 16 --csum_type nvme --tag_size 8)
+	dev_id=$(_add_ublk_dev -t null -u --metadata_size 16 --csum_type nvme --tag_size 8)
 	_check_add_dev "$TID" $?
 
 	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 16 &&
diff --git a/tools/testing/selftests/ublk/test_part_01.sh b/tools/testing/selftests/ublk/test_part_01.sh
index 8028f6e4b3a5..0a7ca6b8450d 100755
--- a/tools/testing/selftests/ublk/test_part_01.sh
+++ b/tools/testing/selftests/ublk/test_part_01.sh
@@ -30,7 +30,7 @@ test_auto_part_scan()
 {
 	local backing_file=$1
 
-	# Create device WITHOUT --no_auto_part_scan
+	# Create device WITH automatic partition scan
 	local dev_id=$(_add_ublk_dev -t loop "${backing_file}")
 	[ $? -ne 0 ] && return 1
 
@@ -50,8 +50,8 @@ test_no_auto_part_scan()
 {
 	local backing_file=$1
 
-	# Create device WITH --no_auto_part_scan
-	local dev_id=$(_add_ublk_dev -t loop --no_auto_part_scan "${backing_file}")
+	# Create device WITHOUT automatic partition scan
+	local dev_id=$(_add_ublk_dev -t loop "${backing_file}" -p)
 	[ $? -ne 0 ] && return 1
 
 	udevadm settle
diff --git a/tools/testing/selftests/ublk/test_part_02.sh b/tools/testing/selftests/ublk/test_part_02.sh
index 7d42ab4d6e83..a046ff13856c 100755
--- a/tools/testing/selftests/ublk/test_part_02.sh
+++ b/tools/testing/selftests/ublk/test_part_02.sh
@@ -22,10 +22,12 @@ _test_partition_scan_no_hang()
 	# for partition scan events to complete
 	if [ "$recovery_flag" = "yes" ]; then
 		echo "Testing partition scan with recovery support..."
-		dev_id=$(_add_ublk_dev_no_settle -t fault_inject -q 1 -d 1 --delay_us 60000000 -r 1)
+		dev_id=$(_add_ublk_dev_no_settle -t fault_inject -q 1 -d 1 \
+			--delay_us 60000000 -r 1)
 	else
 		echo "Testing partition scan without recovery..."
-		dev_id=$(_add_ublk_dev_no_settle -t fault_inject -q 1 -d 1 --delay_us 60000000)
+		dev_id=$(_add_ublk_dev_no_settle -t fault_inject -q 1 -d 1 \
+			--delay_us 60000000)
 	fi
 
 	_check_add_dev "$TID" $?
-- 
2.43.0

