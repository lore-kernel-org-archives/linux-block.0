Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0F33A9EE
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703644; cv=none; b=fcje1jx36hf+N0kqmOoLGzq8T3giBFianvEaOLjRtnAWy7GVwd7rGz0HhlBhOgDKLYi4AA6ZIiVBnii8V+dVbWKdNby1n++4YX7Z4L5wFePf/wpD0adqg6tVkUoNd2OdFv4X0bUOezAmUttdNCkM93kvsOwJwyQY0OWT8w+SO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703644; c=relaxed/simple;
	bh=9zy2J2aaTJCmo0k4+He6kmOLUPNqOYKv7thg9MsyR6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5mwD1sUpuHzXG7AvA/AZUhBUgH3EEMn8/O0V9pLAxJr/UXC7GMLt7g8sxdfXDMADHLhA86TXS34UhmJ5MYZwH95qi0W3nCzG3Jxg7QsxcOkyC+GmxsC6o1BTYflNrd30uUC7b69cjlR8phmYsUXldIG8gfauXmQrrXDPJW4H6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iesdzu2p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iesdzu2p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9wAnwjmH+fnuD3GLiryobxVeMK4kXnLmJ3V/OiZog0=;
	b=iesdzu2p6gmp1mcQ4Tug+DslEfNHqkiKUhWtbfDRDx1hWNza8C1Nt2MZc2mNRdu0076t4r
	h2/gAdIeU0wP65rMrndNAwg7F4vks54UymGNJE31aYlu/SgRlVjUuVsf28i79+gJy1Z36t
	rQbOxmP5VGwcXpx2/Dkq5EE1T4gAWF8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-GrAHfS5dMfaA1riP2hmmfw-1; Thu,
 29 Jan 2026 11:20:39 -0500
X-MC-Unique: GrAHfS5dMfaA1riP2hmmfw-1
X-Mimecast-MFC-AGG-ID: GrAHfS5dMfaA1riP2hmmfw_1769703637
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38F4E19560B4;
	Thu, 29 Jan 2026 16:20:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5847E3000218;
	Thu, 29 Jan 2026 16:20:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 7/9] selftests: ublk: disable partition scan for integrity tests
Date: Fri, 30 Jan 2026 00:19:56 +0800
Message-ID: <20260129162001.3532311-8-ming.lei@redhat.com>
In-Reply-To: <20260129162001.3532311-1-ming.lei@redhat.com>
References: <20260129162001.3532311-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The null target doesn't handle IO, so disable partition scan to avoid IO
failures caused by integrity verification during the kernel's partition
table read.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_null_04.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_null_04.sh b/tools/testing/selftests/ublk/test_null_04.sh
index 22328e0f3925..a5599d38583a 100755
--- a/tools/testing/selftests/ublk/test_null_04.sh
+++ b/tools/testing/selftests/ublk/test_null_04.sh
@@ -21,7 +21,7 @@ _check_value() {
 _test_metadata_only() {
 	local dev_id
 
-	dev_id=$(_add_ublk_dev -t null -u --metadata_size 8)
+	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --metadata_size 8)
 	_check_add_dev "$TID" $?
 
 	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 8 &&
@@ -40,7 +40,7 @@ _test_metadata_only() {
 _test_integrity_capable_ip() {
 	local dev_id
 
-	dev_id=$(_add_ublk_dev -t null -u --integrity_capable --metadata_size 64 --pi_offset 56 --csum_type ip)
+	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --integrity_capable --metadata_size 64 --pi_offset 56 --csum_type ip)
 	_check_add_dev "$TID" $?
 
 	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 64 &&
@@ -59,7 +59,7 @@ _test_integrity_capable_ip() {
 _test_integrity_reftag_t10dif() {
 	local dev_id
 
-	dev_id=$(_add_ublk_dev -t null -u --integrity_reftag --metadata_size 8 --csum_type t10dif)
+	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --integrity_reftag --metadata_size 8 --csum_type t10dif)
 	_check_add_dev "$TID" $?
 
 	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 8 &&
@@ -78,7 +78,7 @@ _test_integrity_reftag_t10dif() {
 _test_nvme_csum() {
 	local dev_id
 
-	dev_id=$(_add_ublk_dev -t null -u --metadata_size 16 --csum_type nvme --tag_size 8)
+	dev_id=$(_add_ublk_dev -t null -u --no_auto_part_scan --metadata_size 16 --csum_type nvme --tag_size 8)
 	_check_add_dev "$TID" $?
 
 	_check_value "metadata_size" "$(_get_metadata_size "$dev_id" metadata_size)" 16 &&
-- 
2.47.0

