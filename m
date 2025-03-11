Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93E1E7640
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 02:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660912; cv=none; b=dGZ6jXfqcRgajDyZTO1OdSwGdiDHlTS0O04u8WVbPhXm99UNiwoATtJG0hkq3LCXCZfDmVCuMcKZiPIm2qKt8GWmEGhzTXCXqDol/n4Ck8RhHLNFMElFSolMhtCfH4C+axF3aPu9JyB97YWPZMjz2X2py73FbtWhckOR1TGkUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660912; c=relaxed/simple;
	bh=2eHa3qAh5/bTJHdMtvNREfraOikplaosPqsswFPRgAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa9x5AtjMOoJcFLfI0ryEmT/vmGZ8oH9zKbo5YRch2HmBT6BS3vFiRKXoSf4HFxTquOASSz0dQj+ESsz9AiHeA5jFYlowmpP68/p1F0dL40ZO6F5+f2NBi7z/kogCdW8Inb0G/Fr4PbLaAXI3ybslWEc/Z9Tl45So2zoDEeqGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=k3YITf3R; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k3YITf3R"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1741660911; x=1773196911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2eHa3qAh5/bTJHdMtvNREfraOikplaosPqsswFPRgAE=;
  b=k3YITf3RMs+JYmoVCtk22mfVAnlxFdn2VXAi9Bv6UZYeeVI5wc3j4k29
   5JAKLITVqXwTNFk68yc0bFM5rK7G1lT2937tdUKY+YcLrUsULJ+RAsXbo
   swX5hTnsaj7GzxmPyLzuz26Ap3C4XlBOhfhkqSIqh5wVk/hFaOQNj98mY
   QPA91NWxUUb5AkECCEhsAVjTPg+ki6mwzXXkyl/cvAu3PdZLg+9NHfvOo
   7d5IxfNO/OyD0a3+SixeCKk1vyC9O/kBaJ3IkL0pidFEznv4/kjhwY4Rf
   OGc3KWYK2jhS8Krj7BL7Jp19gjfeezCxF/tXmwlTi3z2wYTga033tSNrr
   Q==;
X-CSE-ConnectionGUID: EJI09WrmQGuFgn6hkMz7Fg==
X-CSE-MsgGUID: 92IuNDSWTO2LttYPEGFZdg==
X-IronPort-AV: E=Sophos;i="6.14,237,1736784000"; 
   d="scan'208";a="45125162"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2025 10:41:51 +0800
IronPort-SDR: 67cf9519_WkjzTs2ax1dJAl9THfu012j4b+glWCz7gnMJJXhGnOstyv4
 MzfUPJ3NLHvs/MCt4IHGee4OmY8ZI52hDI4mKTA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Mar 2025 18:42:49 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Mar 2025 19:41:49 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/2] nvme: move error logging from nvme_end_req() to __nvme_end_req()
Date: Tue, 11 Mar 2025 11:41:43 +0900
Message-ID: <20250311024144.1762333-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
References: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the Commit 1f47ed294a2b ("block: cleanup and fix batch completion
adding conditions"), blk_mq_add_to_batch() did not add failed
passthrough requests to batch, and returned false. After the commit,
blk_mq_add_to_batch() always adds passthrough requests to batch
regardless of whether the request failed or not, and returns true. This
affected error logging feature in the NVME driver.

Before the commit, the call chain of failed passthrough request was as
follows:

nvme_handle_cqe()
 blk_mq_add_to_batch() .. false is returned, then call nvme_pci_complete_rq()
 nvme_pci_complete_rq()
  nvme_complete_rq()
   nvme_end_req()
    nvme_log_err_passthru() .. error logging
    __nvme_end_req()        .. end of the rqeuest

After the commit, the call chain is as follows:

nvme_handle_cqe()
 blk_mq_add_to_batch() .. true is returned, then set nvme_pci_complete_batch()
 ..
 nvme_pci_complete_batch()
  nvme_complete_batch()
   nvme_complete_batch_req()
    __nvme_end_req() .. end of the request, without error logging

To make the error logging feature work again for passthrough requests, move the
nvme_log_err_passthru() call from nvme_end_req() to __nvme_end_req().

While at it, move nvme_log_error() call for non-passthrough requests together
with nvme_log_err_passthru(). Even though the trigger commit does not affect
non-passthrough requests, move it together for code simplicity.

Fixes: 1f47ed294a2b ("block: cleanup and fix batch completion adding conditions")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f028913e2e62..8359d0aa0e44 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -431,6 +431,12 @@ static inline void nvme_end_req_zoned(struct request *req)
 
 static inline void __nvme_end_req(struct request *req)
 {
+	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
+		if (blk_rq_is_passthrough(req))
+			nvme_log_err_passthru(req);
+		else
+			nvme_log_error(req);
+	}
 	nvme_end_req_zoned(req);
 	nvme_trace_bio_complete(req);
 	if (req->cmd_flags & REQ_NVME_MPATH)
@@ -441,12 +447,6 @@ void nvme_end_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
-	if (unlikely(nvme_req(req)->status && !(req->rq_flags & RQF_QUIET))) {
-		if (blk_rq_is_passthrough(req))
-			nvme_log_err_passthru(req);
-		else
-			nvme_log_error(req);
-	}
 	__nvme_end_req(req);
 	blk_mq_end_request(req, status);
 }
-- 
2.47.0

