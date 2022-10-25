Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696E8C38A2D
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 19:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiJYTS2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiJYTSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 15:18:09 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3A2CC819
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 12:18:06 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id q9-20020a17090a178900b00212fe7c6bbeso6999800pja.4
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 12:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE3c0UdCxk6q6921hHl/ECGVqKFDkwe1mg3ve0/Ys7c=;
        b=jXaPaDLh9sFiOahID/jD6EHtJbvBKQBltvkp7EVr8gA5XY83ZzhzjkuWmKjULmKRWH
         5vYP8NRRtoR2oOyOxBKeSAaWdjwfKhrXCyMqcrfMcp+MlRa+TBWmkv18SBh0xt6oO6mr
         b7CKXfDLL0nUePTwNFoSN4kuxT0Q8k32tkCSIYRDqiupRkYNdAdCfEUidfPrcNLn/32U
         kJ/yTbSTuIlt0ClDvL2gXTYyUrSTBWGXkByFfGpJc3Kjejqmj7npGxUAfi7GEdsor9Bw
         SwQsQtzYHgdwCTCQHNcxKo2zHN8lQ2OMnPHyK6gGiZzRi7yOHj41Jbn+WX+h9kCAR9Sy
         WC6g==
X-Gm-Message-State: ACrzQf2CUwF9YI8AXpXqMkcNI+Qy1/E3NEHvte0e6f7fBbhQ6+PJGdwB
        cTh535dlvYzXapbWVEsgYBU=
X-Google-Smtp-Source: AMsMyM6fMmTyD5Etkd0r/pUIqJAEOJl+aqBXMEa6xqawWltYBpkkwBMzIEpjwzKs6dWoCv1UPhxHKQ==
X-Received: by 2002:a17:90a:4d04:b0:212:ee1c:b0ec with SMTP id c4-20020a17090a4d0400b00212ee1cb0ecmr19751809pjg.66.1666725485888;
        Tue, 25 Oct 2022 12:18:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:58c7:bc96:4597:61cd])
        by smtp.gmail.com with ESMTPSA id b23-20020a170902d89700b00186a8beec78sm1540737plz.52.2022.10.25.12.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:18:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 1/3] block: Remove request.write_hint
Date:   Tue, 25 Oct 2022 12:17:53 -0700
Message-Id: <20221025191755.1711437-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221025191755.1711437-1-bvanassche@acm.org>
References: <20221025191755.1711437-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit c75e707fe1aa ("block: remove the per-bio/request write hint")
removed all code that uses the struct request write_hint member. Hence
also remove 'write_hint' itself.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
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
