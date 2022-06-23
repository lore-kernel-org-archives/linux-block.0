Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95919C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiFWTBI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiFWTAu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:50 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274E1B98F6
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:08 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id p14so306439pfh.6
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGk33Dk1rF6WoNxBb1iQ13uzHkxgsMyKqWnhk0peRfU=;
        b=eIrxhEuS06kNj3pFeZdaMJ15Fc9aomULLvLt5DzUi8VzxsOeFUukR3xTPtKzfzeoof
         Up7PFCOmBbxOuKNtxxhY3ZVPh2tDZoG4QP8BcOWJHWWLG1lyAYIGN8bKur7/LRM4n6f2
         2BX2t9apRgeyZ1xAn7+1O/tVpQ4qRv9mbWSz7ehqVpHRgkPbZ04+IjBNIbzQgNNbb9JZ
         aMlot7NG/6IGS8SSXRqqYH/F0pKkQcOr5LWCUPHV2aiqG2Jsy9AxAY4XtKvwFnzrQUS3
         my9v73R9/YtKKD/A1loK8rlgCSPWcylW5L1XULoUvBPKLR2s1roq/8SWn/cCEXx0MWz2
         HiXw==
X-Gm-Message-State: AJIora8iT/lzg1nakuCpGXB4mheN7i6yghTyEcggtVrE467IMq3v2b7a
        HRIJG54vpxdIAWTklidteUU=
X-Google-Smtp-Source: AGRyM1vzBAffZYH4uPCuKV7hqRmsqSG6G9h2v9uwHoN3a2dNGvaDASqqH32Jayp9Y88yP50QSvJMYQ==
X-Received: by 2002:a63:5108:0:b0:3fd:77f1:57a4 with SMTP id f8-20020a635108000000b003fd77f157a4mr8391076pgb.125.1656007567559;
        Thu, 23 Jun 2022 11:06:07 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 21/51] dm/dm-zoned: Use the enum req_op type
Date:   Thu, 23 Jun 2022 11:04:58 -0700
Message-Id: <20220623180528.3595304-22-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for arguments
that represent a request operation.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-zoned-metadata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index d1ea66114d14..9341c46e44b7 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -737,7 +737,7 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
 /*
  * Read/write a metadata block.
  */
-static int dmz_rdwr_block(struct dmz_dev *dev, int op,
+static int dmz_rdwr_block(struct dmz_dev *dev, enum req_op op,
 			  sector_t block, struct page *page)
 {
 	struct bio *bio;
