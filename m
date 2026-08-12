Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44C486652
	for <linux-block@vger.kernel.org>; Wed, 12 Aug 2026 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558463; cv=none; b=YGH1CLdp7ZxbvHG7udlByiv6WyuduQI0MPwlyYmNpjssgg9Mi2BkLF2WZ0uR8a7zUZ02nE4hTdzBcYAauEoo6D1Ltm7gYnWTbYz4hTe6SEql3aHams9fYQY+Q0CcMZpIL0hxqY88V/tYNUyfcUYtHxzkbsVp2o1bj4ru6Dn5R+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558463; c=relaxed/simple;
	bh=Tozo6v9zSWNbSekcCtx0iIWT50xK3WeyS2R6i0Dl6PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n70fIUrVuWnUuGE28mgUi9URc9a5bZjSCHbQ66dSq83l7ut5ZaAktua1bM5xFhe9e8IhHV4jjceWn3izgqWqr0r5h19jl9Brv8/a1qVAO7IzpQK3X8sc3el5EZGjCJeIleRdbqB9AV3flOGgxaQiG+bEGms0GwR5ZbSClHoNQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNx4y/Aa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNx4y/Aa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786558460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6MmefElPADUsUlsKoVw0MoCzb8atKySep+Ag3qO74g=;
	b=ZNx4y/Aa3gCxVWrsW43kcmjbRGR9HQaK/Ku/xU54e401IqvWXBwPSDEOdQrGjk2gNhHcdg
	CtRgcAmONgTRYVum0D5aD0WBxtXasIxmMyViA6A/sYc3WUutDpEGC9wDSmeGgmf8BpUZTg
	WHCXruv6G8q9XiMmkPizkSvmsW/QRYE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-3CiHzm0rMVS3JEMHq_k8ZA-1; Wed,
 12 Aug 2026 14:13:54 -0400
X-MC-Unique: 3CiHzm0rMVS3JEMHq_k8ZA-1
X-Mimecast-MFC-AGG-ID: 3CiHzm0rMVS3JEMHq_k8ZA_1786558426
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 155DD19560AD;
	Wed, 12 Aug 2026 18:13:46 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.22.88.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F79D18005BB;
	Wed, 12 Aug 2026 18:13:40 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Hannes Reinecke <hare@suse.de>,
	Jesse Taube <jtaubepe@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	"Ewan D . Milne" <emilne@redhat.com>,
	shinichiro.kawasaki@wdc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Muneendra Kumar <muneendra.kumar@broadcom.com>
Subject: [PATCH 06/13] nvme: sysfs: emit the marginal path state in show_state()
Date: Wed, 12 Aug 2026 14:12:53 -0400
Message-ID: <20260812181300.3712426-7-jtaubepe@redhat.com>
In-Reply-To: <20260812181300.3712426-1-jtaubepe@redhat.com>
References: <20260812181300.3712426-1-jtaubepe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Bryan Gurney <bgurney@redhat.com>

If a controller has received a link integrity or congestion event, and
has the NVME_CTRL_MARGINAL flag set, emit "marginal" in the state
instead of "live", to identify the marginal paths.

Co-developed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Muneendra Kumar <muneendra.kumar@broadcom.com>
Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
V10 -> V11:
 - No change
---
 drivers/nvme/host/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 75b2d69b5957..01c771dc88cb 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -527,7 +527,9 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	};
 
 	if (state < ARRAY_SIZE(state_name) && state_name[state])
-		return sysfs_emit(buf, "%s\n", state_name[state]);
+		return sysfs_emit(buf, "%s\n",
+			(nvme_ctrl_is_marginal(ctrl)) ? "marginal" :
+			state_name[state]);
 
 	return sysfs_emit(buf, "unknown state\n");
 }
-- 
2.54.0

