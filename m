Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3CCC77B7C
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 22:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjDRWk1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 18:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjDRWkY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 18:40:24 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD7093ED
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:13 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1a6674bcad4so20445705ad.1
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 15:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857613; x=1684449613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na/UN07Y3tOQs6f1HQF3EnMDPmZgRcNYCI/h2kAhk8w=;
        b=SvCOUTZFuoguJ1KqVx4xvwI9Qt3uIxWFjhe2rHkLSG/yvZfAM7cUJgpO/suPwZHGW0
         xCcnTmP/tUuJPdvyy5blSgRuKBqr9drXv6jCzskxsW9Rnil1lGZotZXTRgnPeSB93ugr
         A3yPiyAZNp0Wfx+Q/BU8vVlZqp+94Disz+mJ4mvi0n2m9RAcPJRFRdbKpTTqwtTfqT9c
         mZwx6PMmd3omhop8tSev4pmuBg3KfEauTI/MLLeXky9sFltsOD/D4GbxvFgwbGtPEwfd
         BO+TA3BgGQuzcY8Y66Ed8tioyqvlTdPUJmCubgDlO9T4zGW1JRyNk45N/s9JIDhdhcJP
         mGxw==
X-Gm-Message-State: AAQBX9etkDgWm4nlUtwawXo54JV5Aq4mDYTdEevfKeF5N62arndmoVQL
        64/v8RkjPkO/hPjnTIX3s1g=
X-Google-Smtp-Source: AKy350b4SNRhmrtvVtzFLiF6mn6/3UhmpLVF0vbOTKJ1OpAE7Y+7tijW2tiGWCNjEP/wnr5uShkJKg==
X-Received: by 2002:a17:902:b213:b0:1a6:b608:5058 with SMTP id t19-20020a170902b21300b001a6b6085058mr2983075plr.59.1681857613043;
        Tue, 18 Apr 2023 15:40:13 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001a4ee93efa2sm8285646plb.137.2023.04.18.15.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:40:12 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 04/11] block: mq-deadline: Simplify deadline_skip_seq_writes()
Date:   Tue, 18 Apr 2023 15:39:55 -0700
Message-ID: <20230418224002.1195163-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230418224002.1195163-1-bvanassche@acm.org>
References: <20230418224002.1195163-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the deadline_skip_seq_writes() code shorter without changing its
functionality.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 5839a027e0f0..3dde720e2f59 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -310,12 +310,9 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 						struct request *rq)
 {
 	sector_t pos = blk_rq_pos(rq);
-	sector_t skipped_sectors = 0;
 
-	while (rq) {
-		if (blk_rq_pos(rq) != pos + skipped_sectors)
-			break;
-		skipped_sectors += blk_rq_sectors(rq);
+	while (rq && blk_rq_pos(rq) == pos) {
+		pos += blk_rq_sectors(rq);
 		rq = deadline_latter_request(rq);
 	}
 
