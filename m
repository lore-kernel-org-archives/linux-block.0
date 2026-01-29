Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D633F8B7
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703638; cv=none; b=AMMU5Gcowisx5o3kpj8jldRVR3nLlliod8CtWsMwuhRoQVkD5UL/cX/RhLkQlmCU0T6rP9mR2h40QuZn/qHXGZ/Pqdy3WjYsBTEB7dKu3NjiGGTmna1JZneLU26V8/A5YjIM92CWaH//IAcRy/rTMVg7GfMbJAK27+CDCh0FF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703638; c=relaxed/simple;
	bh=2I+8vsLnXvT0XENdX/WeP3QdTaOyC1/cwc0HqIRRMRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVFxpk8enleiBgA0BhtICqmyLtBYr17Sk8iLJfiZWlqnbSs3zBtkjFmuiz/KjIuFn/JtQ37c4yVwQIO45fVRBwFF44h8XKxUw6kH8WPiVZHXRGMuOwJEuLHRqAup/wOuJVKYaO92GRTrlffbMytmI3B8iuG9fd/BsZqnL6j6HX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCBsNzWU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCBsNzWU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkATM8EU//UXbBtZsfRjlHdv4jhOmkWjPMQIYzcDMcw=;
	b=JCBsNzWU/Nc1DSaHxenEZD4C6hhkQXrYPgplHHSzWOIQAnR+4E7m0fXQQu0V08XlmbMUXn
	egGrXaLsR8MPtPx8WX0/1mTC4zmNCvCssyliZqNUQdfuG4X9A+qjy94vTEFANndO2R9yhs
	uPLCMBeIanhWCTWCCok5fsHaROZi88k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-OznSp14WPdG9WSRtKtYN1w-1; Thu,
 29 Jan 2026 11:20:34 -0500
X-MC-Unique: OznSp14WPdG9WSRtKtYN1w-1
X-Mimecast-MFC-AGG-ID: OznSp14WPdG9WSRtKtYN1w_1769703633
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E4C419541AD;
	Thu, 29 Jan 2026 16:20:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 727DD1800665;
	Thu, 29 Jan 2026 16:20:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 6/9] selftests: ublk: refactor test_null_04 into separate functions
Date: Fri, 30 Jan 2026 00:19:55 +0800
Message-ID: <20260129162001.3532311-7-ming.lei@redhat.com>
In-Reply-To: <20260129162001.3532311-1-ming.lei@redhat.com>
References: <20260129162001.3532311-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Encapsulate each test case in its own function that creates the
device, runs checks, and deletes only that device. This avoids
calling _cleanup_test multiple times.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_null_04.sh | 248 +++++++------------
 1 file changed, 94 insertions(+), 154 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_null_04.sh b/tools/testing/selftests/ublk/test_null_04.sh
index 7491b8c17f00..22328e0f3925 100755
--- a/tools/testing/selftests/ublk/test_null_04.sh
+++ b/tools/testing/selftests/ublk/test_null_04.sh
@@ -3,163 +3,103 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
+ERR_CODE=0
 
-_prep_test "null" "integrity params"
+_check_value() {
+	local name=$1
+	local actual=$2
+	local expected=$3
 
-dev_id=$(_add_ublk_dev -t null -u --metadata_size 8)
-_check_add_dev $TID $?
-metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
-if [ "$metadata_size" != 8 ]; then
-	echo "metadata_size $metadata_size != 8"
-	_show_result $TID 255
-fi
-pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
-if [ "$pi_offset" != 0 ]; then
-	echo "pi_offset $pi_offset != 0"
-	_show_result $TID 255
-fi
-pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
-if [ "$pi_tuple_size" != 0 ]; then
-	echo "pi_tuple_size $pi_tuple_size != 0"
-	_show_result $TID 255
-fi
-capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
-if [ "$capable" != 0 ]; then
-	echo "device_is_integrity_capable $capable != 0"
-	_show_result $TID 255
-fi
-format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
-if [ "$format" != nop ]; then
-	echo "format $format != nop"
-	_show_result $TID 255
-fi
-protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
-if [ "$protection_interval_bytes" != 512 ]; then
-	echo "protection_interval_bytes $protection_interval_bytes != 512"
-	_show_result $TID 255
-fi
-tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
-if [ "$tag_size" != 0 ]; then
-	echo "tag_size $tag_size != 0"
-	_show_result $TID 255
-fi
-_cleanup_test
+	if [ "$actual" != "$expected" ]; then
+		echo "$name $actual != $expected"
+		ERR_CODE=255
+		return 1
+	fi
+	return 0
+}
 
-dev_id=$(_add_ublk_dev -t null -u --integrity_capable --metadata_size 64 --pi_offset 56 --csum_type ip)
-_check_add_dev $TID $?
-metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
-if [ "$metadata_size" != 64 ]; then
-	echo "metadata_size $metadata_size != 64"
-	_show_result $TID 255
-fi
-pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
-if [ "$pi_offset" != 56 ]; then
-	echo "pi_offset $pi_offset != 56"
-	_show_result $TID 255
-fi
-pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
-if [ "$pi_tuple_size" != 8 ]; then
-	echo "pi_tuple_size $pi_tuple_size != 8"
-	_show_result $TID 255
-fi
-capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
-if [ "$capable" != 1 ]; then
-	echo "device_is_integrity_capable $capable != 1"
-	_show_result $TID 255
-fi
-format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
-if [ "$format" != T10-DIF-TYPE3-IP ]; then
-	echo "format $format != T10-DIF-TYPE3-IP"
-	_show_result $TID 255
-fi
-protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
-if [ "$protection_interval_bytes" != 512 ]; then
-	echo "protection_interval_bytes $protection_interval_bytes != 512"
-	_show_result $TID 255
-fi
-tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
-if [ "$tag_size" != 0 ]; then
-	echo "tag_size $tag_size != 0"
-	_show_result $TID 255
-fi
-_cleanup_test
+_test_metadata_only() {
+	local dev_id
 
-dev_id=$(_add_ublk_dev -t null -u --integrity_reftag --metadata_size 8 --csum_type t10dif)
-_check_add_dev $TID $?
-metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
-if [ "$metadata_size" != 8 ]; then
-	echo "metadata_size $metadata_size != 8"
-	_show_result $TID 255
-fi
-pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
-if [ "$pi_offset" != 0 ]; then
-	echo "pi_offset $pi_offset != 0"
-	_show_result $TID 255
-fi
-pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
-if [ "$pi_tuple_size" != 8 ]; then
-	echo "pi_tuple_size $pi_tuple_size != 8"
-	_show_result $TID 255
-fi
-capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
-if [ "$capable" != 0 ]; then
-	echo "device_is_integrity_capable $capable != 0"
-	_show_result $TID 255
-fi
-format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
-if [ "$format" != T10-DIF-TYPE1-CRC ]; then
-	echo "format $format != T10-DIF-TYPE1-CRC"
-	_show_result $TID 255
-fi
-protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
-if [ "$protection_interval_bytes" != 512 ]; then
-	echo "protection_interval_bytes $protection_interval_bytes != 512"
-	_show_result $TID 255
-fi
-tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
-if [ "$tag_size" != 0 ]; then
-	echo "tag_size $tag_size != 0"
-	_show_result $TID 255
-fi
-_cleanup_test
+	dev_id=$(_add_ublk_dev -t null -u --metadata_size 8)
+	_check_add_dev "$TID" $?
 
-dev_id=$(_add_ublk_dev -t null -u --metadata_size 16 --csum_type nvme --tag_size 8)
-_check_add_dev $TID $?
-metadata_size=$(_get_metadata_size "$dev_id" metadata_size)
-if [ "$metadata_size" != 16 ]; then
-	echo "metadata_size $metadata_size != 16"
-	_show_result $TID 255
-fi
-pi_offset=$(_get_metadata_size "$dev_id" pi_offset)
-if [ "$pi_offset" != 0 ]; then
-	echo "pi_offset $pi_offset != 0"
-	_show_result $TID 255
-fi
-pi_tuple_size=$(_get_metadata_size "$dev_id" pi_tuple_size)
-if [ "$pi_tuple_size" != 16 ]; then
-	echo "pi_tuple_size $pi_tuple_size != 16"
-	_show_result $TID 255
-fi
-capable=$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")
-if [ "$capable" != 0 ]; then
-	echo "device_is_integrity_capable $capable != 0"
-	_show_result $TID 255
-fi
-format=$(cat "/sys/block/ublkb$dev_id/integrity/format")
-if [ "$format" != EXT-DIF-TYPE3-CRC64 ]; then
-	echo "format $format != EXT-DIF-TYPE3-CRC64"
-	_show_result $TID 255
-fi
-protection_interval_bytes=$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")
-if [ "$protection_interval_bytes" != 512 ]; then
-	echo "protection_interval_bytes $protection_interval_bytes != 512"
-	_show_result $TID 255
-fi
-tag_size=$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")
-if [ "$tag_size" != 8 ]; then
-	echo "tag_size $tag_size != 8"
-	_show_result $TID 255
-fi
-_cleanup_test
+	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 8 &&
+	_check_value "pi_offset" "$(_get_metadata_size "$dev_id" pi_offset)" 0 &&
+	_check_value "pi_tuple_size" "$(_get_metadata_size "$dev_id" pi_tuple_size)" 0 &&
+	_check_value "device_is_integrity_capable" \
+		"$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")" 0 &&
+	_check_value "format" "$(cat "/sys/block/ublkb$dev_id/integrity/format")" nop &&
+	_check_value "protection_interval_bytes" \
+		"$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")" 512 &&
+	_check_value "tag_size" "$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")" 0
+
+	${UBLK_PROG} del -n "${dev_id}"
+}
+
+_test_integrity_capable_ip() {
+	local dev_id
+
+	dev_id=$(_add_ublk_dev -t null -u --integrity_capable --metadata_size 64 --pi_offset 56 --csum_type ip)
+	_check_add_dev "$TID" $?
+
+	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 64 &&
+	_check_value "pi_offset" "$(_get_metadata_size "$dev_id" pi_offset)" 56 &&
+	_check_value "pi_tuple_size" "$(_get_metadata_size "$dev_id" pi_tuple_size)" 8 &&
+	_check_value "device_is_integrity_capable" \
+		"$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")" 1 &&
+	_check_value "format" "$(cat "/sys/block/ublkb$dev_id/integrity/format")" T10-DIF-TYPE3-IP &&
+	_check_value "protection_interval_bytes" \
+		"$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")" 512 &&
+	_check_value "tag_size" "$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")" 0
+
+	${UBLK_PROG} del -n "${dev_id}"
+}
+
+_test_integrity_reftag_t10dif() {
+	local dev_id
 
-_show_result $TID 0
+	dev_id=$(_add_ublk_dev -t null -u --integrity_reftag --metadata_size 8 --csum_type t10dif)
+	_check_add_dev "$TID" $?
+
+	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 8 &&
+	_check_value "pi_offset" "$(_get_metadata_size "$dev_id" pi_offset)" 0 &&
+	_check_value "pi_tuple_size" "$(_get_metadata_size "$dev_id" pi_tuple_size)" 8 &&
+	_check_value "device_is_integrity_capable" \
+		"$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")" 0 &&
+	_check_value "format" "$(cat "/sys/block/ublkb$dev_id/integrity/format")" T10-DIF-TYPE1-CRC &&
+	_check_value "protection_interval_bytes" \
+		"$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")" 512 &&
+	_check_value "tag_size" "$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")" 0
+
+	${UBLK_PROG} del -n "${dev_id}"
+}
+
+_test_nvme_csum() {
+	local dev_id
+
+	dev_id=$(_add_ublk_dev -t null -u --metadata_size 16 --csum_type nvme --tag_size 8)
+	_check_add_dev "$TID" $?
+
+	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 16 &&
+	_check_value "pi_offset" "$(_get_metadata_size "$dev_id" pi_offset)" 0 &&
+	_check_value "pi_tuple_size" "$(_get_metadata_size "$dev_id" pi_tuple_size)" 16 &&
+	_check_value "device_is_integrity_capable" \
+		"$(cat "/sys/block/ublkb$dev_id/integrity/device_is_integrity_capable")" 0 &&
+	_check_value "format" "$(cat "/sys/block/ublkb$dev_id/integrity/format")" EXT-DIF-TYPE3-CRC64 &&
+	_check_value "protection_interval_bytes" \
+		"$(cat "/sys/block/ublkb$dev_id/integrity/protection_interval_bytes")" 512 &&
+	_check_value "tag_size" "$(cat "/sys/block/ublkb$dev_id/integrity/tag_size")" 8
+
+	${UBLK_PROG} del -n "${dev_id}"
+}
+
+_prep_test "null" "integrity params"
+
+_test_metadata_only
+_test_integrity_capable_ip
+_test_integrity_reftag_t10dif
+_test_nvme_csum
+
+_cleanup_test
+_show_result "$TID" $ERR_CODE
-- 
2.47.0

