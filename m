Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B793C282CE
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 00:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497C021741
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 00:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MonLjrKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDJACe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:02:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43787 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfDJACe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 20:02:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id c20so140362qkc.10
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4nDLAD27Q4OWNPbZLRqw6ZpL4AbVoix+hHaVQiozN/w=;
        b=MonLjrKrIFa+r7+BMlMlnFGSv0FWebLi8W2qlUSWNS5qnpougU25NKOwGBZ4vdWkss
         ND5ryvwHIauNMDdDC0kuY9+qLEsJlHmbKs82Er9lHW98QJCgZiK06en5ZiPLTaz0QV2g
         RAjZidbeUVAwwitHyKbSbdh0woFh8qXNakMYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4nDLAD27Q4OWNPbZLRqw6ZpL4AbVoix+hHaVQiozN/w=;
        b=lr8UZgGIOXUd0wGIqSa7JPpUja+JEuT2Vn3Wa6KPZqLIgqV0K9uFumjv+ebl8vFNrW
         l18M1wjpOoK3a7xS+pNTFQD235XOw7uosddAxvU9IoJ0W0Ge7yd9EZ6LF8Yo7IsFwZwP
         ytg9COvixnpcHmSzT4hoXyMev6PWK9g81Wark1RHkX7IaI4xl8+ue2ZhqM4eE8ebBWsT
         +udpIhamcY9QWc5XAhnZ9trhtfzZ0Mi5ZJPEIAT3qqLXjUk67rGSJxkSeQJtByoXY2fP
         uaPl4jR9srxbBH5Fbdp21AMKqta24nxu8qVwHtFp6h29PBn3Av/4vKvU1vd9hB5dg5tJ
         jSog==
X-Gm-Message-State: APjAAAXJexXDvyYAjpN0TG4cW0zpVyQPNNUiH/JFwFzE3ceSiFyMqsFs
        Wb3GxakRQ2F2sliNEMq7iJEa98QqeF6BmOA8yHIhhg==
X-Google-Smtp-Source: APXvYqzhwLgMonMi0QBjHCThN80HkXWK3FBZkX6G5m3hfOQ4zMhYngGCNxg8BN0eu1ZZlwMv9EzpukFWtiF3F/SOU40=
X-Received: by 2002:a05:620a:1116:: with SMTP id o22mr3883980qkk.227.1554854553422;
 Tue, 09 Apr 2019 17:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <1554854375-7708-1-git-send-email-jalee@purestorage.com>
In-Reply-To: <1554854375-7708-1-git-send-email-jalee@purestorage.com>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Tue, 9 Apr 2019 17:02:22 -0700
Message-ID: <CAJX3CtgE5oN=uw2rAWS8hsqkEZHCgfy5r=McFTj0rhRd490HhQ@mail.gmail.com>
Subject: [PATCHv2] scsi: core: set result when the command cannot be dispatched
To:     Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When SCSI blk-mq is enabled, there is a bug in handling errors in scsi_queue_rq.
Specifically, the bug is not setting result field of scsi_request correctly when
the dispatch of the command has been failed. Since the upper layer code
including the sg_io ioctl expects to receive any error status from result field
of scsi_request, the error is silently ignored and this could cause data
corruptions for some applications.

Signed-off-by: Jaesoo Lee <jalee@purestorage.com>
---
 drivers/scsi/scsi_lib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2018967..dc2550c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1699,8 +1699,12 @@ static blk_status_t scsi_queue_rq(struct
blk_mq_hw_ctx *hctx,
                        ret = BLK_STS_DEV_RESOURCE;
                break;
        default:
+               if (unlikely(!scsi_device_online(sdev)))
+                       scsi_req(req)->result = DID_NO_CONNECT << 16;
+               else
+                       scsi_req(req)->result = DID_ERROR << 16;
                /*
-                * Make sure to release all allocated ressources when
+                * Make sure to release all allocated resources when
                 * we hit an error, as we will never see this command
                 * again.
                 */
--
2.7.4
