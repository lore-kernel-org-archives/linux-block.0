Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A487C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 22:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1CC20B1F
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 22:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PnGGyLG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfAaWNy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:13:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43306 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfAaWNy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 17:13:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so1948796pgk.10
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 14:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8QekRuGAcLl5aXSGWoJ5gf0Ay98dR/uMyx4ny8dqOF0=;
        b=PnGGyLG30G9OXChzkbiZBAPDLYLUp2jD1tqLc7UMifSYDpSxH1nmZHAl1Rd61nTc5D
         TRjmUbt9XOZHGepYgsNCbNzd/ssJ/Azp/z7Wm4NYBHI3Z1GdvZMTgjRdD66xd0idVt7n
         199dcFNjQ189jg9QLk1D8X1nlV/AQHzo81RRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8QekRuGAcLl5aXSGWoJ5gf0Ay98dR/uMyx4ny8dqOF0=;
        b=FPRmDZQFI1VG1bJ1IVVWlB1MIVrXpOjNjfP4PmBGR4ipRyqQZiTzWrR7G2HgQ9aMRr
         gSnLofPlyAP3V+pJjeKSj42OtQN/5MfwzKios3UqJuXY82AtaSQfSaVxUtGL4t4smBQ0
         ev79xDvZj/FLfp3Lwua9JqHE5b+eTHnIHVi0A3TzPF+W8dmfLKjMYxniTrsRGAIMV/T3
         rRZySIElrP3MUmFcm/gXP29l0Nf3ps08mG+KOc+sY/33vTAFQ74rPnSdmNMGT/X/NC/7
         hkJL4Pd7D/YqVQQCx+GCYjh3k4M3ut9KZx1c24BTSfsTwFkGxj368oumh7k6zTOBJKt/
         XzvQ==
X-Gm-Message-State: AJcUukep1322eywpFtPYV1Rb20HjmmaAnieqCeAQ6yM2yaBw9mccwY6c
        9tf2S/uWOWnw1rW0ERwpHtfxRg==
X-Google-Smtp-Source: ALg8bN5Fk25ydTqhauKto3IYej3vobiyCk0NAyBYCBP0hism+OgTySJKVf/2m1ucVvoYILBcEUMRzw==
X-Received: by 2002:a62:4641:: with SMTP id t62mr36207932pfa.141.1548972833210;
        Thu, 31 Jan 2019 14:13:53 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id z10sm7961681pfg.120.2019.01.31.14.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Jan 2019 14:13:52 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Martin K Peterson <martin.peterson@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/2] loop: Report EOPNOTSUPP properly
Date:   Thu, 31 Jan 2019 14:13:27 -0800
Message-Id: <20190131221328.85343-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131221328.85343-1-evgreen@chromium.org>
References: <20190131221328.85343-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Properly plumb out EOPNOTSUPP from loop driver operations, which may
get returned when for instance a discard operation is attempted but not
supported by the underlying block device. Before this change, everything
was reported in the log as an I/O error, which is scary and not
helpful in debugging.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---

 drivers/block/loop.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cf5538942834..a1ba555e3b92 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -458,8 +458,13 @@ static void lo_complete_rq(struct request *rq)
 
 	if (!cmd->use_aio || cmd->ret < 0 || cmd->ret == blk_rq_bytes(rq) ||
 	    req_op(rq) != REQ_OP_READ) {
-		if (cmd->ret < 0)
-			ret = BLK_STS_IOERR;
+		if (cmd->ret < 0) {
+			if (cmd->ret == -EOPNOTSUPP)
+				ret = BLK_STS_NOTSUPP;
+			else
+				ret = BLK_STS_IOERR;
+		}
+
 		goto end_io;
 	}
 
@@ -1878,7 +1883,10 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
  failed:
 	/* complete non-aio request */
 	if (!cmd->use_aio || ret) {
-		cmd->ret = ret ? -EIO : 0;
+		if (ret == -EOPNOTSUPP)
+			cmd->ret = ret;
+		else
+			cmd->ret = ret ? -EIO : 0;
 		blk_mq_complete_request(rq);
 	}
 }
-- 
2.20.1

