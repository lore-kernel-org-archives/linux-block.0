Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAFE364EA9
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848945; cv=none; b=X2nBeQj4QeWNi2L9JKRnLdAyOU1GOfhCxfGtfJTjfC3b30Xw9hpqfSDpxaVQ35PnkqLZN2+xxth3h9SVsToRkNo3q6MPs0v6mvnYPnxCP4v3I8tgKGCTEXyNBPDP0bL1yUMXw3/QhDKfOFQGEa2D2RtXF7egUMQGDWyxUFR1gDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848945; c=relaxed/simple;
	bh=N+K+mkAjexb3ArBnlQ5FJpdPyVxqad94UDdJSyT4ci8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWxRx43rQHr4Yng2RVrhKiNE0QAdT/HFmXz4tspkFNXyhdepcmdjpUMb2CE5hbNIGyIu7zCpkkA37MknejE8rwD5fYtTA9DrJTXTH3HaiPSMewijnmYV29x2Hvos6UJvPlvtbJtNhZUDJGi6SepXvCcKbTBAnf2EgpDprq47ubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=im9uwTmR; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="im9uwTmR"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1771848935; bh=N+K+mkAjexb3ArBnlQ5FJpdPyVxqad94UDdJSyT4ci8=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=im9uwTmRdVXLDaYXn2p64jTDrixM9SYDHf81bBf20Cn+BKfyy2tB1d9ROT4YN3TbF
	 qrF4HHnRlLoFQIPOLhkABhWmVGWIKEdKW30PG+i0gvaPNlJx8OtzIGMZI6iTQX9W/0
	 ZRYUjv0kYGl2IAgPhduGQca60AEytX/xByPorAuaMijOTMipRE5Kg1YPNfCjjDc24d
	 SrrHvOdAZpoo4eT0rMNctY2BHe9niRPEB9bFdJpsM6O/fIjSRfAjE6kDPk5Ac+Avke
	 Um2MdguP3GJEdL5CbDaniMELk/q02wYfFXhTofefunx122yG7TRRnw8WclSH/0EqL2
	 IuXYpQyKEFLdW/+q736fYWwcQT+m5kvwtZrbN7mCJTG8wEPO1kZzkOaKeUL/rpVsUw
	 vV5nLZk41QywivsjOyz6bTru49rQCEfcUkzEwKJabHRrq21cdeE0jciKvwRsWgYXOP
	 wO41iusOGjRtNwVZSEyxQ60GzihKWTJGON+B/ljsRIza57vK+W71JZGshVy8cLo6TO
	 UOktvgx9cf9EIIrDoCAdR12snLHeJ3k44tMUnG0vN2Z5qOv56lF4pg8wKkUSNPm9lT
	 JA+WeyWXxVJekPrHZ/liOv/GiRQ22OEjWbS1imkEqMEEhPyZyv5qVZchBXB9xHAm4m
	 DOfwN3A8LxdG2jfgpd83APx0=
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Alexander Atanasov <alex@zazolabs.com>
Subject: [PATCH 2/4] selftests: ublk: rework partitions tests for new flags
Date: Mon, 23 Feb 2026 12:15:12 +0000
Message-ID: <20260223121515.3296983-3-alex@zazolabs.com>
In-Reply-To: <20260223121515.3296983-1-alex@zazolabs.com>
References: <20260223121515.3296983-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support reworked flags - UBLK_F_PARTITIONS and UBLK_F_AUTO_PART_SCAN
update kublk.
Remove old argument --no_auto_part_scan
Add arguments:
-p, --with-partitions - enable partitions on trusted devices
-P, --auto_part_scan  - enable partitions and perform auto scan

Update test cases to use the new arguments

Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 tools/testing/selftests/ublk/kublk.c           | 18 ++++++++++++------
 .../selftests/ublk/test_integrity_01.sh        |  9 +++++----
 tools/testing/selftests/ublk/test_part_01.sh   | 14 +++++++-------
 tools/testing/selftests/ublk/test_part_02.sh   |  6 ++++--
 4 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index e8279c4acc40..8a4b7c49f788 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1615,7 +1615,8 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_INTEGRITY),
 		FEAT_NAME(UBLK_F_SAFE_STOP_DEV),
 		FEAT_NAME(UBLK_F_BATCH_IO),
-		FEAT_NAME(UBLK_F_NO_AUTO_PART_SCAN),
+		FEAT_NAME(UBLK_F_PARTITIONS),
+		FEAT_NAME(UBLK_F_AUTO_PART_SCAN),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
@@ -1713,7 +1714,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("\t[--nthreads threads] [--per_io_tasks]\n");
 	printf("\t[--integrity_capable] [--integrity_reftag] [--metadata_size SIZE] "
 		 "[--pi_offset OFFSET] [--csum_type ip|t10dif|nvme] [--tag_size SIZE]\n");
-	printf("\t[--batch|-b] [--no_auto_part_scan]\n");
+	printf("\t[--batch|-b] [-p,--with_partitions] [-P,--auto_part_scan]\n");
 	printf("\t[target options] [backfile1] [backfile2] ...\n");
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
@@ -1783,11 +1784,12 @@ int main(int argc, char *argv[])
 		{ "integrity_reftag",	0,	NULL,  0 },
 		{ "metadata_size",	1,	NULL,  0 },
 		{ "pi_offset",		1,	NULL,  0 },
+		{ "with_partitions",	0,	NULL, 'p' },
+		{ "auto_part_scan",	0,	NULL, 'P' },
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
+	while ((opt = getopt_long(argc, argv, "t:n:d:q:r:e:i:s:gazubpP",
 				  longopts, &option_idx)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -1856,6 +1858,12 @@ int main(int argc, char *argv[])
 		case 'u':
 			ctx.flags |= UBLK_F_USER_COPY;
 			break;
+		case 'p':
+			ctx.flags |= UBLK_F_PARTITIONS;
+			break;
+		case 'P':
+			ctx.flags |= UBLK_F_PARTITIONS|UBLK_F_AUTO_PART_SCAN;
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
index 6713b280a6ff..454a846b9a8f 100755
--- a/tools/testing/selftests/ublk/test_integrity_01.sh
+++ b/tools/testing/selftests/ublk/test_integrity_01.sh
@@ -21,7 +21,7 @@ _check_value() {
 _test_metadata_only() {
 	local dev_id
 
-	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --metadata_size 8)
+	dev_id=$(_add_ublk_dev -t null -u --metadata_size 8)
 	_check_add_dev "$TID" $?
 
 	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 8 &&
@@ -40,7 +40,8 @@ _test_metadata_only() {
 _test_integrity_capable_ip() {
 	local dev_id
 
-	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --integrity_capable --metadata_size 64 --pi_offset 56 --csum_type ip)
+	dev_id=$(_add_ublk_dev -t null -u --integrity_capable --metadata_size 64 \
+		--pi_offset 56 --csum_type ip)
 	_check_add_dev "$TID" $?
 
 	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 64 &&
@@ -59,7 +60,7 @@ _test_integrity_capable_ip() {
 _test_integrity_reftag_t10dif() {
 	local dev_id
 
-	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --integrity_reftag --metadata_size 8 --csum_type t10dif)
+	dev_id=$(_add_ublk_dev -t null -u  --integrity_reftag --metadata_size 8 --csum_type t10dif)
 	_check_add_dev "$TID" $?
 
 	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 8 &&
@@ -78,7 +79,7 @@ _test_integrity_reftag_t10dif() {
 _test_nvme_csum() {
 	local dev_id
 
-	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --metadata_size 16 --csum_type nvme --tag_size 8)
+	dev_id=$(_add_ublk_dev -t null -u --metadata_size 16 --csum_type nvme --tag_size 8)
 	_check_add_dev "$TID" $?
 
 	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 16 &&
diff --git a/tools/testing/selftests/ublk/test_part_01.sh b/tools/testing/selftests/ublk/test_part_01.sh
index 8028f6e4b3a5..b6bd3eb16ac5 100755
--- a/tools/testing/selftests/ublk/test_part_01.sh
+++ b/tools/testing/selftests/ublk/test_part_01.sh
@@ -10,7 +10,7 @@ format_backing_file()
 	local backing_file=$1
 
 	# Create ublk device to write partition table
-	local tmp_dev=$(_add_ublk_dev -t loop "${backing_file}")
+	local tmp_dev=$(_add_ublk_dev -t loop "${backing_file}" -p)
 	[ $? -ne 0 ] && return 1
 
 	# Write partition table with sfdisk
@@ -30,8 +30,8 @@ test_auto_part_scan()
 {
 	local backing_file=$1
 
-	# Create device WITHOUT --no_auto_part_scan
-	local dev_id=$(_add_ublk_dev -t loop "${backing_file}")
+	# Create device WITH automatic partition scan
+	local dev_id=$(_add_ublk_dev -t loop "${backing_file}" -P)
 	[ $? -ne 0 ] && return 1
 
 	udevadm settle
@@ -50,8 +50,8 @@ test_no_auto_part_scan()
 {
 	local backing_file=$1
 
-	# Create device WITH --no_auto_part_scan
-	local dev_id=$(_add_ublk_dev -t loop --no_auto_part_scan "${backing_file}")
+	# Create device WITHOUT automatic partition scan
+	local dev_id=$(_add_ublk_dev -t loop "${backing_file}" -p)
 	[ $? -ne 0 ] && return 1
 
 	udevadm settle
@@ -79,9 +79,9 @@ if ! _have_program sfdisk || ! _have_program blockdev; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
-_prep_test "generic" "test UBLK_F_NO_AUTO_PART_SCAN"
+_prep_test "generic" "test UBLK_F_PARTITIONS"
 
-if ! _have_feature "UBLK_F_NO_AUTO_PART_SCAN"; then
+if ! _have_feature "UBLK_F_PARTITIONS"; then
 	_cleanup_test "generic"
 	exit "$UBLK_SKIP_CODE"
 fi
diff --git a/tools/testing/selftests/ublk/test_part_02.sh b/tools/testing/selftests/ublk/test_part_02.sh
index 7d42ab4d6e83..f0a8637714c1 100755
--- a/tools/testing/selftests/ublk/test_part_02.sh
+++ b/tools/testing/selftests/ublk/test_part_02.sh
@@ -22,10 +22,12 @@ _test_partition_scan_no_hang()
 	# for partition scan events to complete
 	if [ "$recovery_flag" = "yes" ]; then
 		echo "Testing partition scan with recovery support..."
-		dev_id=$(_add_ublk_dev_no_settle -t fault_inject -q 1 -d 1 --delay_us 60000000 -r 1)
+		dev_id=$(_add_ublk_dev_no_settle -t fault_inject -q 1 -d 1 \
+			--delay_us 60000000 -r 1 -P)
 	else
 		echo "Testing partition scan without recovery..."
-		dev_id=$(_add_ublk_dev_no_settle -t fault_inject -q 1 -d 1 --delay_us 60000000)
+		dev_id=$(_add_ublk_dev_no_settle -t fault_inject -q 1 -d 1 \
+			--delay_us 60000000 -P)
 	fi
 
 	_check_add_dev "$TID" $?
-- 
2.43.0

