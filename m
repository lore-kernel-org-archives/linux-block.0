Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210720299B
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594190; cv=none; b=mIby0kgVym7Xu1iCrTk+B3kQa2R9essEpqhJTVc+2h+IXmo+8n3ReKZ4jaokTMnJ03jRXiCNiA8V0AN6IqYjArSTo626Bhf5M3ndLEbYvfp625qB6vksLA1wN8DYg5ntpddUIeBbtHF4wkGKy2axxNbNUWqLIy2yBeqS4SeUeJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594190; c=relaxed/simple;
	bh=PJOvhbCZ42OMvVqAmWmIZubTNoSEQn0YuURtV3J5iQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G82FLuIGJkGTS/follcyAEAqRl16Sr7zZG7INVw0sfqO8R08N/0WDHNxk8cohJVjFM30YyT78bHbFE8MnpBiXbC4xjX23uZ44uocUes2oANIh3Mfzy2pMhNAz2ezZgkdWNJ3PsCTPdTPWgK0rD7ySK6Y/gNomPWM5/jXGoSHxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=abBCkN1h; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="abBCkN1h"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-2cc9045bae9so656497fac.3
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752594187; x=1753198987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0OQpxU41FJXIJdhFsISQeQ40gBS6R2Me/ITeDL8zYWc=;
        b=abBCkN1hg3co5QR0ls+f6UL2BOKCtd4ZBbA9/WExGVcyT86sL515NLFXnaYxdwvJmh
         PuGQPCEAUmuz8uXfAApvaq2G6mDevI68rqwJMNRcS0i7n77myIpt1UNmK3tFs4czBBuO
         Iw4psANW4ueU94iwPKNk8tA2UllBGDu/snUG55oB9YtQfagfsWsbg0NPrvHr0w3E+/R9
         IiYfBWwGQ5ceS3W5tbkrRtvi6o7ql1Dr+M/4BfeWXTB8BrdyHscL4At6Q8m5Lfuvo8T7
         SYSSha2DUKLf6OWSWbFQTdHXr+WspxtPwVrgnBAGx0SlG1h4yO1Znz3EmP18HvO8vdQn
         MFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594187; x=1753198987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OQpxU41FJXIJdhFsISQeQ40gBS6R2Me/ITeDL8zYWc=;
        b=VkHoZoDzqUnbT4gQ9iXa7aeHv+ONjmSfrb+AJPtOtL5Y1c+d4teKPf87gjgNcFUQPa
         peUkHjfpU6VC6JAHCf+D94ovOeuO19n5ALd9NnlqlKIdLGqhBByiSZkVyxujFwqUH2/T
         eHzyXJ4iQNEh2E1OV7mG0yyMksRyoqx60rxULcBGb8v6MCiNF/NFBCo51JG49hbHIg3o
         H5Y5AYLGNJzy3BcWmMfBeltE8gLqkZuOHtZAy0xUlLzypfIHBvHhUdYlqLvM0yvQ9927
         EhTXmHP7dfnrxVQExwNd45+t8FPnY9eHcwT79vrHzhJcFYVPr/nVTNdzexQnYjSfPmKr
         SWDg==
X-Forwarded-Encrypted: i=1; AJvYcCXLp2rh8oN0OrRLqI0ZFFQ7EtDQoAFrNZbX1ARSfRCNQOYdsQFJk94IlhCgsAOX2iFYjAEbBmtPgn7wmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrf+EeeaA9CjoRt+hVu7bN4YLWi+otmKhGOZRtN4RjuyW8tv63
	CtPBiDGsq3Fww5GGhzrRGTkxypa7jVpkYqv5Rctu5KZyJsxuvuUtIcrk8FUZtXqC5QIzTfxfFpj
	hQljZjsfXZAS96D97lPlGYLiybHLZQOPJzeWiWWUs3T2StkIAJkA4
X-Gm-Gg: ASbGncvEYBtc1XlDfn1eVJiJZKsxBRxfVvedYErrO+1eGQDD0EG98zD2A+UPAnmaZmN
	EwcV0Z6qQDsI5BzNcXChvTa454VuwHJ31U010nuIj4Z7LUJimV86CW+dTD4vQVklf+Bjx2QWkFr
	Of0V03rSI6cc0kTfFUG97EwJqvRB/qHV8P6H7cPv092JxLl11IFovOnbz8xSp6cZNM9UG1/5+SU
	Z8/QsKMCquU5lxuTVFOnoBkaiZ3YQJQu0GwVsyRXLlDSiwO17RI3TYa14ek3k/xJ472S2BAz+ad
	AhzS5DIl/SPAV2zcXf5IGTqpWX8ZF3QYlj9c/T4j17XVs9gst3CPHphLFg==
X-Google-Smtp-Source: AGHT+IESlOhZzHAYOnsGKQ2xABGrYBeSAggfx1IJOqNCQvG3DbodMjk+SbeYsSuTpK9YtLaURnSMOs8bzJB+
X-Received: by 2002:a05:6870:32d4:b0:2ff:988a:9c7e with SMTP id 586e51a60fabf-2ff9e86aff2mr489829fac.7.1752594187373;
        Tue, 15 Jul 2025 08:43:07 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6159c08ed80sm31574eaf.14.2025.07.15.08.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:43:07 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8C1363402F0;
	Tue, 15 Jul 2025 09:43:06 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 86515E412A1; Tue, 15 Jul 2025 09:43:06 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: remove unused req argument from ublk_sub_req_ref()
Date: Tue, 15 Jul 2025 09:42:43 -0600
Message-ID: <20250715154244.1626810-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit b749965edda8 ("ublk: remove ublk_commit_and_fetch()"),
ublk_sub_req_ref() no longer uses its struct request *req argument.
So drop the argument from ublk_sub_req_ref(), and from
ublk_need_complete_req(), which only passes it to ublk_sub_req_ref().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d8b378ad6872..57e64c6b5549 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -712,11 +712,11 @@ static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
 {
 	if (refcount_dec_and_test(&io->ref))
 		__ublk_complete_rq(req);
 }
 
-static inline bool ublk_sub_req_ref(struct ublk_io *io, struct request *req)
+static inline bool ublk_sub_req_ref(struct ublk_io *io)
 {
 	unsigned sub_refs = UBLK_REFCOUNT_INIT - io->task_registered_buffers;
 
 	io->task_registered_buffers = 0;
 	return refcount_sub_and_test(sub_refs, &io->ref);
@@ -2241,15 +2241,14 @@ static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
 
 	return 0;
 }
 
 static bool ublk_need_complete_req(const struct ublk_queue *ubq,
-				   struct ublk_io *io,
-				   struct request *req)
+				   struct ublk_io *io)
 {
 	if (ublk_need_req_ref(ubq))
-		return ublk_sub_req_ref(io, req);
+		return ublk_sub_req_ref(io);
 	return true;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
 			  struct request *req)
@@ -2357,11 +2356,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (ret)
 			goto out;
 		io->res = ub_cmd->result;
 		req = ublk_fill_io_cmd(io, cmd);
 		ret = ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &buf_idx);
-		compl = ublk_need_complete_req(ubq, io, req);
+		compl = ublk_need_complete_req(ubq, io);
 
 		/* can't touch 'ublk_io' any more */
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
-- 
2.45.2

