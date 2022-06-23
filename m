Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE9AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiFWTBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiFWTAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:48 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF56B8F9D
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:06 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so3363979pjg.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDQrp5hiicsBYoO4xA+zFz4qY0MpuwqxhJF2Y5bzmBs=;
        b=qPg7CqgbGVJtxrjK61XWnd/MqGlHCosgkdwvNXiBTW6TWFMi95eaToG3MJiIHwH9Wf
         53lmu6jzoP+psf7qVcIRHH1ZuBiJiXf0hMEF/yYRYD6LL+PdMLtpsFzKONQs23pSSyNK
         5vesDFEZtRB07TGzGlCXDz64IXpCqGEjjI8aD4O5SGKc5gyvbzbXMdMI0RNa1YY5LHP/
         qN6zqgfNLuACKmD7qkMGuQYP3kZvmiRG8ZekbzzeBpvyUkiuEdF6T7w2hlYaP93UFJFN
         GuPbMh/RqUC9oLMLS8s3/cC1M+tc3WGXbrNV1IUrbFapqmnmzDkGXN6BFfH7g8FkhkLE
         uX+Q==
X-Gm-Message-State: AJIora9NXuje8qw+61mgQtQ8VQUwm7Vz9+PU5Vb3lWqzj2d9T0rL6uCR
        rYHCFOXoCLVIw8ZqrtZvB6A=
X-Google-Smtp-Source: AGRyM1tyOrFFgYtUR7vGjl8ebaGbAFLKR2VmNQHJ8NTkK/WzBDHd7WLcnVZ/r2I4HDuqxWPj3bFFhg==
X-Received: by 2002:a17:90a:4749:b0:1e3:27a8:2e2a with SMTP id y9-20020a17090a474900b001e327a82e2amr5235409pjg.170.1656007565863;
        Thu, 23 Jun 2022 11:06:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:06:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 20/51] dm/dm-snap: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:04:57 -0700
Message-Id: <20220623180528.3595304-21-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/dm-snap-persistent.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index 3bb5cff5d6fc..e536f6be63b3 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -226,8 +226,8 @@ static void do_metadata(struct work_struct *work)
 /*
  * Read or write a chunk aligned and sized block of data from a device.
  */
-static int chunk_io(struct pstore *ps, void *area, chunk_t chunk, int op,
-		    int op_flags, int metadata)
+static int chunk_io(struct pstore *ps, void *area, chunk_t chunk,
+		    enum req_op op, blk_opf_t op_flags, int metadata)
 {
 	struct dm_io_region where = {
 		.bdev = dm_snap_cow(ps->store->snap)->bdev,
@@ -282,7 +282,7 @@ static void skip_metadata(struct pstore *ps)
  * Read or write a metadata area.  Remembering to skip the first
  * chunk which holds the header.
  */
-static int area_io(struct pstore *ps, int op, int op_flags)
+static int area_io(struct pstore *ps, enum req_op op, blk_opf_t op_flags)
 {
 	chunk_t chunk = area_location(ps, ps->current_area);
 
