Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061C6C433FF
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 14:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81F42133F
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 14:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfHNO0g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:26:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40496 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNO0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 10:26:36 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hxuET-0000lK-BY
        for linux-block@vger.kernel.org; Wed, 14 Aug 2019 14:26:33 +0000
Received: by mail-pg1-f198.google.com with SMTP id z35so22048139pgk.10
        for <linux-block@vger.kernel.org>; Wed, 14 Aug 2019 07:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/sOlrlK8gBvtNw2aQtPk5OiaZzwZpHssKF1CduSfhVc=;
        b=bRdTqeuDiqH4UwlTQ0dxX1xMAkj0i3K2LZEBPHhDqaLB3SHUU0MTpi3OhIjySMKLax
         aIMJemhYmZ3vmsZdz8NpYt9BSqpYl/VacOdmKCn1Rrubhsaku3tAN79N9w9/do2wcRUO
         ve/dOjRZeOAJPVO+6K4C+s5tMblPCG1wpd7Jg/mtLPCX855TX4jgiIHaEG6HvaO1qlB4
         R+mk3QSmSBDYHfHO/6xMYSKi0Ric+V3wGxCcF+/soZsp+3QBO70fmUtxrh35YsVddjI8
         giayvvToBySloZ2tBX8GENyDJr3qxDLJ1p836c0Ae0uXrDHeAVzB0ZUSszwO9mOdTJZQ
         GakA==
X-Gm-Message-State: APjAAAWw8JhQEI6OK+SUr+VXlma5LOIoOKZUTAGvMeGopGbQpLRnb0rV
        2Sxw6geCh0sQz/nHOL9vhjTmDmD+/HkGp/jk6Qm39o901wn5gPPDm8RqxqLQQoPROUglJtEZG8f
        SiQAIwG+VuHsPyvHnEnf3DNmz+ZQSIHR1JKwKe3RT
X-Received: by 2002:aa7:95b8:: with SMTP id a24mr169766pfk.103.1565792792082;
        Wed, 14 Aug 2019 07:26:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyQX5n8LybIauUTO+zmFV3TGVyX5lxGaNufJfKVnDL7p+P2qYZ7ZlPJKYr4BF2c01ZynVKGaw==
X-Received: by 2002:aa7:95b8:: with SMTP id a24mr169743pfk.103.1565792791866;
        Wed, 14 Aug 2019 07:26:31 -0700 (PDT)
Received: from localhost ([191.13.19.2])
        by smtp.gmail.com with ESMTPSA id v8sm80245pjb.6.2019.08.14.07.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 07:26:30 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, gpiccoli@canonical.com,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: [PATCH] nvme: Fix cntlid validation when not using NVMEoF
Date:   Wed, 14 Aug 2019 11:26:10 -0300
Message-Id: <20190814142610.2164-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 1b1031ca63b2 ("nvme: validate cntlid during controller initialisation")
introduced a validation for controllers with duplicate cntlid that runs
on nvme_init_subsystem(). The problem is that the validation relies on
ctrl->cntlid, and this value is assigned (from id_ctrl value) after the
call for nvme_init_subsystem() in nvme_init_identify() for non-fabrics
scenario. That leads to ctrl->cntlid always being 0 in case we have a
physical set of controllers in the same subsystem.

This patch fixes that by loading the discovered cntlid id_ctrl value into
ctrl->cntlid before the subsystem initialization, only for the non-fabrics
case. The patch was tested with emulated nvme devices (qemu) having two
controllers in a single subsystem. Without the patch, we couldn't make
it work failing in the duplicate check; when running with the patch, we
could see the subsystem holding both controllers.

For the fabrics case we see ctrl->cntlid has a more intricate relation
with the admin connect, so we didn't change that.

Fixes: 1b1031ca63b2 ("nvme: validate cntlid during controller initialisation")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8f3fbe5ca937..cca270836892 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2591,6 +2591,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 			goto out_free;
 	}
 
+	if (!(ctrl->ops->flags & NVME_F_FABRICS))
+		ctrl->cntlid = le16_to_cpu(id->cntlid);
+
 	if (!ctrl->identified) {
 		int i;
 
@@ -2691,7 +2694,6 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 			goto out_free;
 		}
 	} else {
-		ctrl->cntlid = le16_to_cpu(id->cntlid);
 		ctrl->hmpre = le32_to_cpu(id->hmpre);
 		ctrl->hmmin = le32_to_cpu(id->hmmin);
 		ctrl->hmminds = le32_to_cpu(id->hmminds);
-- 
2.22.0

