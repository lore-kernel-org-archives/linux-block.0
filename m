Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B182459CF
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160244; cv=none; b=L+RLzUJOQ5VzWF14JN1HA3IFCJfVunUEVybxA7fCTPMCove8RCO4osLraal0dpIBlhUbU6B6CXhTLomLln8tVFtBO1NpoRvcRpv1RA75bYrcA5Cl7hnrMsrsaj7vNYl+2lN0plch+jMQH8bkQtWb/QnWeqswgiFpvHTfxnKR4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160244; c=relaxed/simple;
	bh=zglDI8ekvlbvaBrEDXtTIrPLQWoQaU4piNmxTxwAah0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juo7wlki9SYIl7CngfCyuFPKYNZ5fFIGzrpCBt+FEulPdSP8HxhYtQ9LWfaFfL+f56KCIPSrGV6IW81ufLDWirXDNBoA2m2snIpd6es3TYCCfHxkhtW4N7Csh21nY9MXAjv1J8iWBfLT7eFqzOZ0nuOc1Gysv2m7Pnykgl8bles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bpryQPbz; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bpryQPbz"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-b522e2866bcso19581a12.0
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160240; x=1758765040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qHOe+Rzb6hy6Xk1mhk6pczOStc2z3C6VJDa7IAomhI=;
        b=bpryQPbzaAHqoIWS88J/FvVBE8mn9Ox1Xdm7UMtf7hAOuE7CNLdWzEjNFqp4CDjiYk
         W6FiU30peO/FgOYChjqqyyPqUQ6cvm4VZ+jTWgeMLIXvpGqDM1BYv69KC5Vctr1Cu3Gw
         +qprTopbQ66TJLRf3T0cwAwsHkEyBCMY6ayiJ1W8mnGXYq4//t4OzqWbkLr0RvGuvKIm
         kTnCQX91BMdliGixLz1oNWp5WpXgkYOaTpjbiobJ7Uj4E3Dg39vGtDFIZR92ithh651M
         VKFff3+8HVG9Ylsxla18vZTJOuY04ii2Qry4uXNhw014Nt5zJ93nbBiGXlkLISxyIaUu
         bj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160240; x=1758765040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qHOe+Rzb6hy6Xk1mhk6pczOStc2z3C6VJDa7IAomhI=;
        b=HqSsKdrb/m20Hagr0ComLbWXqbitA4D9MxKSCbgtuQCl1OicsopyS6+0hTALgbJwjQ
         PKZ5EFtkBkFXTIkSkOntSNO9yjHYF2o/CjG74A+y/rHZ8QZv+ud15/kJYZYFo4fyoQdh
         njNdJCMQsxg65HVNeE9iD4rJjDw6jy8NhuXzHyr3em1ykt8NRYZ+1IWUjnk7Brg0Jy/K
         kVAc+0lddAyjx5jxeQjIKZTwdo9GcNk8EpfRKvdDBDcPGf6kzY4jqPVOAvbieeOrwzG3
         uDFBNSWyxZGzqBK4/dgtvyZ6bmiou9iB2x+/qdd691ZMASOeSyxRoNAG4fJoUafXpnvo
         C8cA==
X-Gm-Message-State: AOJu0Yxu+nTRveVHLfL6mOEpa1gdcVWY6cEyCYJsYwuPfMRx6S6HD6hd
	aKwLrQgxr8bLVOrczS0FgNUem9gTv0DSbUf1pzLDFMXtQ4NproCgwSi8po56bk4O5bkzD0BUsdb
	VJQlcgcpKThBRiDQXYotb32FTk4ta9bbsBKX7Kfu8BTFlLZiXiKZv
X-Gm-Gg: ASbGncvaqFritb8y3+XC8fAzR1LmXnYcLFPkU4AFNZqR+VKQc48GTpVQryIMwMKWj14
	VRApmBgwGMcm61VDPw5Pk2rUGUBYRQRe16uLhQPfh+8ogUQsf+p90Wgw2ToaCrVXzzMh1NtEgC/
	9gnnrPjvKF/CEFbgmPduacu5lCR2Bc6lsAXwSWXTlr9nneNWlIsji343XLmeJCWuNwqXrii7V/U
	eChf3MS7WdkscForldNXLAMmWAqdkSN5zm2fXupyqlZ/HJ00SsJA7ZkBHwQ7fiSN502SnxrWyxP
	iir7s4t9ZwFzTuCfzvJne0Ot3QgPRRyNfVukn0lkRHFQeBxJceWNAVp4rg==
X-Google-Smtp-Source: AGHT+IHGYEVM/B4JIiuc7vdPObaycRl2mlQW+p36GyxGWT5ScETrpAmcpVQ1M2/c6Cw1LO25lMZXi2165n2k
X-Received: by 2002:a05:6a20:1586:b0:279:e1df:e63c with SMTP id adf61e73a8af0-27aab85ee8bmr3080789637.3.1758160240438;
        Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-32ed257bd28sm366457a91.0.2025.09.17.18.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BDAD234059B;
	Wed, 17 Sep 2025 19:50:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B9320E41B42; Wed, 17 Sep 2025 19:50:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 16/17] ublk: pass ublk_io to __ublk_complete_rq()
Date: Wed, 17 Sep 2025 19:49:52 -0600
Message-ID: <20250918014953.297897-17-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers of __ublk_complete_rq() already know the ublk_io. Pass it in
to avoid looking it up again.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 750d0a332685..a677eca1ee86 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -527,11 +527,11 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 	return BLK_STS_NOTSUPP;
 }
 
 #endif
 
-static inline void __ublk_complete_rq(struct request *req);
+static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io);
 
 static dev_t ublk_chr_devt;
 static const struct class ublk_chr_class = {
 	.name = "ublk-char",
 };
@@ -736,11 +736,11 @@ static inline bool ublk_get_req_ref(struct ublk_io *io)
 }
 
 static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
 {
 	if (refcount_dec_and_test(&io->ref))
-		__ublk_complete_rq(req);
+		__ublk_complete_rq(req, io);
 }
 
 static inline bool ublk_sub_req_ref(struct ublk_io *io)
 {
 	unsigned sub_refs = UBLK_REFCOUNT_INIT - io->task_registered_buffers;
@@ -1144,14 +1144,13 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
 {
 	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
 }
 
 /* todo: handle partial completion */
-static inline void __ublk_complete_rq(struct request *req)
+static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io)
 {
 	struct ublk_queue *ubq = req->mq_hctx->driver_data;
-	struct ublk_io *io = &ubq->ios[req->tag];
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
 
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
@@ -1748,11 +1747,11 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 
 	if (ublk_nosrv_should_reissue_outstanding(ub))
 		blk_mq_requeue_request(req, false);
 	else {
 		io->res = -EIO;
-		__ublk_complete_rq(req);
+		__ublk_complete_rq(req, io);
 	}
 }
 
 /*
  * Called from ublk char device release handler, when any uring_cmd is
@@ -2393,11 +2392,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
-			__ublk_complete_rq(req);
+			__ublk_complete_rq(req, io);
 
 		if (ret)
 			goto out;
 		break;
 	case UBLK_IO_NEED_GET_DATA:
-- 
2.45.2

