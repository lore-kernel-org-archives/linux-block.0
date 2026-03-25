Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92E52777EA
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475138; cv=none; b=owVaCXEutz+Cm6h3jqi/gmDzi8xhmOham1q73GUApmwtiDeG8MuQvhxvdDpaC9tmmGwq2HDXNog+gRbO7eHKrQART8GvvvNBKMp0S5Ha1KS9MSlxUtQ7FIQqcjK6oL7cH8xzD5C1uzaX6Mj8bKCKX2T1M4qUh4Wz36dCbO84YUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475138; c=relaxed/simple;
	bh=KLPyvPHOrcyq7ak+4ueK4G7c+7/raUhBY9SSzzdcyqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJ0ApOnXveOqSl/aIqtOeO6vmzd2y2uJRf+v9e+HHKvtUaDLG1NWV1jvMQ0xvRIJf25EZReTZ5b9ybz5IX4j3SrJ3cL37BJDTfj5DenX+hGeSsI+a/gixXFWLYu3fq7AnteDBkUIqnqnNKpdcZuiIxalcYZbHMCJ+Bprue7Tegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=5HSzCeHN; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="5HSzCeHN"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0ns2hlXzlgwN4;
	Wed, 25 Mar 2026 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475133; x=1777067134; bh=/Ae5q
	WmVQ7RQknLJmAyjsdjnzUXgk92ujvfpRnvBYQs=; b=5HSzCeHNbTn+wJuBMRCtz
	HzIN//m5QPoZopNVrNlk/qWQMyNDsx8qIZomf2x8r80KEuks0DeCgP1Y9mae5Dow
	zpGK8UAMzIWKj3Te0mAxOE2atN65wQu4sM08B+UKhZ1e8dTny9eD1vhNAvgUY5FC
	DQ+SKP6Z1lDaei2bfDzCMjPO5Zn2dpm4e7nw3B7I1GdqREh+5oHyk0bDMiNfaeQt
	O9TQReLcMwRa2ZKimBixQ83lz5I8j/MqxE9fxumKJgd3YWx9B77ngS4N+idoX+WC
	a4THAaElnaiH2zzkBLRZdOTmsQH7vAo9iabIOrfpN+O10emfr1jep5S6JnIdMmS0
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1vjzg0xnSqKC; Wed, 25 Mar 2026 21:45:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0nl0W9FzlfpMC;
	Wed, 25 Mar 2026 21:45:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 02/26] block: Annotate the block device functions
Date: Wed, 25 Mar 2026 14:44:43 -0700
Message-ID: <20260325214518.2854494-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling thread-safety analysis by adding __release()
annotations where appropriate. Explicit __release() annotations have
been added since Clang does not support adding a __releases() annotation
to a function pointer.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/bdev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index ed022f8c48c7..1f710b8bfb9f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -312,7 +312,9 @@ int bdev_freeze(struct block_device *bdev)
 	mutex_lock(&bdev->bd_holder_lock);
 	if (bdev->bd_holder_ops && bdev->bd_holder_ops->freeze) {
 		error =3D bdev->bd_holder_ops->freeze(bdev);
+		/* bdev->bd_holder_ops->freeze() released bd_holder_lock */
 		lockdep_assert_not_held(&bdev->bd_holder_lock);
+		__release(&bdev->bd_holder_lock);
 	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
 		error =3D sync_blockdev(bdev);
@@ -355,7 +357,9 @@ int bdev_thaw(struct block_device *bdev)
 	mutex_lock(&bdev->bd_holder_lock);
 	if (bdev->bd_holder_ops && bdev->bd_holder_ops->thaw) {
 		error =3D bdev->bd_holder_ops->thaw(bdev);
+		/* bdev->bd_holder_ops->freeze() released bd_holder_lock */
 		lockdep_assert_not_held(&bdev->bd_holder_lock);
+		__release(&bdev->bd_holder_lock);
 	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
 	}
@@ -1254,9 +1258,11 @@ EXPORT_SYMBOL(lookup_bdev);
 void bdev_mark_dead(struct block_device *bdev, bool surprise)
 {
 	mutex_lock(&bdev->bd_holder_lock);
-	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
+	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead) {
 		bdev->bd_holder_ops->mark_dead(bdev, surprise);
-	else {
+		/* bdev->bd_holder_ops->mark_dead() released bd_holder_lock */
+		__release(&bdev->bd_holder_lock);
+	} else {
 		mutex_unlock(&bdev->bd_holder_lock);
 		sync_blockdev(bdev);
 	}
