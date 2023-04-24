Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3B7C77B76
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 20:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjDXUdo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjDXUdn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 16:33:43 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32F159FB
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:41 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so4240972b3a.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 13:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368421; x=1684960421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6DzJfMAQ5ymngf0FJt4uPULJnWE+0z/3E6xDXxnI+c=;
        b=YFvObPzNMRGBewgRFEPI4OKRpPGX9PWiLK6ziC9uvyGGSOMblpPQ5sBFMrbU9orAbn
         fxHxlOAVj7b7zU1iub4M2nAHgDGlrYIseo6KlRJhb7hjRMfY6z+yf1bCabDQ50ep35d9
         5qVWhHkTDHKrWzyh6Ynr6aduDIb/rAnqpTIXVANqwrsS2fxIePoA2T13+oTL4Zv4oBmG
         Zq2NJT/z2oxbAgKwu2ucjc8oMoM+fEm0Qmo9bZmfUWmrAMxCTjRMaHt1GSBetyjcb1Qq
         2KyXN5CGNbKUJOXOVze7NPm6prLNJlPqMI5DEzPQsRdpLwbotVkBiGfNL1rdtq+K63mn
         RgFw==
X-Gm-Message-State: AAQBX9eLrY1Vj1R+UOVe2iHxz091vd4g/5Bdla7bjQ+c102mgXBrKQWz
        0Q9BhDI5fsTCCHA24Dn9Q74=
X-Google-Smtp-Source: AKy350Z1CH6IKoipdB8eMGFhca5VMyz8C8gtUOdxMKspdGT0vmfcdabuuu7CpbMJwA0wwa6pQ20tRw==
X-Received: by 2002:a05:6a00:a06:b0:63b:5c82:e209 with SMTP id p6-20020a056a000a0600b0063b5c82e209mr24051752pfh.10.1682368421280;
        Mon, 24 Apr 2023 13:33:41 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:56cb:b39a:c8b:8c37])
        by smtp.gmail.com with ESMTPSA id k16-20020aa788d0000000b00625616f59a1sm7417505pff.73.2023.04.24.13.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:33:40 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 6/9] block: mq-deadline: Improve deadline_skip_seq_writes()
Date:   Mon, 24 Apr 2023 13:33:26 -0700
Message-ID: <20230424203329.2369688-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230424203329.2369688-1-bvanassche@acm.org>
References: <20230424203329.2369688-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make deadline_skip_seq_writes() do what its name suggests, namely to
skip sequential writes.

Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 6276afede9cd..dbc0feca963e 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -308,7 +308,7 @@ static struct request *deadline_skip_seq_writes(struct deadline_data *dd,
 	do {
 		pos += blk_rq_sectors(rq);
 		rq = deadline_latter_request(rq);
-	} while (rq && blk_rq_pos(rq) == pos);
+	} while (rq && blk_rq_pos(rq) == pos && blk_rq_is_seq_zoned_write(rq));
 
 	return rq;
 }
