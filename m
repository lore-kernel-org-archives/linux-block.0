Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D95C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 22:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJSWXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 18:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJSWXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 18:23:49 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9812C181DA0
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:48 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id o64so20858119oib.12
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 15:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zB0rFMFO0OVdEx8/8V4uMVJP4WitmGMupaTAuv+UiJE=;
        b=CeDbmdgZHT0DMoT62W+4ek/nKLmYmyz4hQVMUYpcPqIvJEc9Sz4A4IuFeXXFQCkG52
         FvKeGG/cC3NR80PNw3nb/bM8toAsNC8jO+4QlSD2U7fDizfX2/e5CcUgQ+HIFOr1LGJ4
         yTH9F5oFAvSk3mCRa+dPNFhIIu2UOv/5UZblau5ANWW8E5I5KfDZlN4UNEvp6tT+pNbT
         +r38UgRgm4h4yDRhvmdqiqZ8lIu+VcALsv0EtsPYyHYKXQziy8ImtL1tSpKfSUz0Wz0T
         uANnjQ2jEySwXnQ4ZLuDeTiGzJLpiiNA2zixvsTznToCOoYM/wUcpCwz2Rjz0dWLb8sd
         03nQ==
X-Gm-Message-State: ACrzQf3ZVbPX7IskwbA7EGzm/p+siFnrLysc1tt8WL59vC5Ioe2LvP+/
        c69VTo+qySw6CMxXsWiJRAjpNOz3/7Q=
X-Google-Smtp-Source: AMsMyM4F1rCsDEUh6Cv7X+BLsflNMh6swG45fPJlg7gnpELQESihCsgZcdbBm9YZfgej2NNXX/M47Q==
X-Received: by 2002:a17:90b:4a10:b0:20d:8d8d:e7d0 with SMTP id kk16-20020a17090b4a1000b0020d8d8de7d0mr12266580pjb.145.1666218217022;
        Wed, 19 Oct 2022 15:23:37 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8280:2606:af57:d34])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b00174d9bbeda4sm11486866plg.197.2022.10.19.15.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 15:23:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 01/10] block: Remove request.write_hint
Date:   Wed, 19 Oct 2022 15:23:15 -0700
Message-Id: <20221019222324.362705-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221019222324.362705-1-bvanassche@acm.org>
References: <20221019222324.362705-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit c75e707fe1aa ("block: remove the per-bio/request write hint")
removed all code that uses the struct request write_hint member. Hence
also remove 'write_hint' itself.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk-mq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ba18e9bdb799..569053ed959d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -140,7 +140,6 @@ struct request {
 	struct blk_crypto_keyslot *crypt_keyslot;
 #endif
 
-	unsigned short write_hint;
 	unsigned short ioprio;
 
 	enum mq_rq_state state;
