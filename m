Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9351210F71
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005875; cv=none; b=tfIRIrQ79Jc3BLh8AQ3U5PVQ3PpNbdBsoROs9HhhgZ4VXO46U7brRR8zKl7sdgP/VJxrEru1AdKCtlgwm+LJ1zvDhaOKlZwwITltQZ32zT7wgEHWqTl5CzGv/rpGP2SVXncBdVjezJAoxUpCeWY14HAZL1O295zNfwN4emsok4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005875; c=relaxed/simple;
	bh=dr+e7jSPepXj4wEctbueFxfKfGyx1PgvUi00ml24KJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVOf5/6cVu18oCVuLHniUx/TTUGsG3hLiPCBGovgXkm8e8mtTcWQtyyBvMnkva43Zgq62wJ0agvv1ztE7Y5XBJ03Bu0bp56F/Uy+BHQICGFCrs7f4vbuuRf38p6wVfPGqrOKH/UF7sOzEJcmvsoOYbWUpa14L0/iwQdJCUgh4T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QX7tDPLY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QX7tDPLY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yi7XL+5N6pTduXp2PEW7UNcPPWNHp7KLLmffm1FzOjM=;
	b=QX7tDPLYxcq/DVvknfcDvfyPxVymnU4ZsZpXNuYZMI/fNSmYOx6Gz6YBEPls3Z0cZO8cvo
	liLmJws6PDIG1ZnjnVY8/Xzcs5ijaW3Wlb/cRXPhxZKHnEEvvNyo9bmsS3tPgSPYFE/KE9
	cvRA7QYVwWzuJyR4JZbH6U1EcVJyKO4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-OGeELeY6MXmOKNzle2pqqg-1; Mon,
 03 Mar 2025 07:44:17 -0500
X-MC-Unique: OGeELeY6MXmOKNzle2pqqg-1
X-Mimecast-MFC-AGG-ID: OGeELeY6MXmOKNzle2pqqg_1741005856
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC8A51800980;
	Mon,  3 Mar 2025 12:44:16 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A634A180035F;
	Mon,  3 Mar 2025 12:44:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 08/11] selftests: ublk: load/unload ublk_drv when preparing & cleaning up tests
Date: Mon,  3 Mar 2025 20:43:18 +0800
Message-ID: <20250303124324.3563605-9-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Load ublk_drv module in _prep_test(), and unload it in _cleanup_test(),
so that test can always be done in consistent state.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 40bf42f1bed2..bcb0c7aa3956 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -64,6 +64,7 @@ _check_root() {
 
 _remove_ublk_devices() {
 	${UBLK_PROG} del -a
+	modprobe -r ublk_drv
 }
 
 _get_ublk_dev_state() {
@@ -78,6 +79,7 @@ _prep_test() {
 	_check_root
 	local type=$1
 	shift 1
+	modprobe ublk_drv
 	echo "ublk $type: $*"
 }
 
@@ -131,6 +133,9 @@ _add_ublk_dev() {
 	local kublk_temp;
 	local dev_id;
 
+	if [ ! -c /dev/ublk-control ]; then
+		return ${UBLK_SKIP_CODE}
+	fi
 	if echo "$@" | grep -q "\-z"; then
 		if ! _have_feature "ZERO_COPY"; then
 			return ${UBLK_SKIP_CODE}
-- 
2.47.0

