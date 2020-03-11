Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id C094C7DE71
	for <lwn-linux-block@archive.lwn.net>; Wed, 11 Mar 2020 16:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgCKQNJ (ORCPT <rfc822;lwn-linux-block@archive.lwn.net>);
        Wed, 11 Mar 2020 12:13:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44638 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbgCKQNJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 12:13:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id l18so3352148wru.11
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2020 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Mm/1wSNfZ8uXyCSHWLFqHUu7AbvQmXdPUh//P4RHPc=;
        b=NKegFWB9CXDmFdPt8uL52ueGKEe4WEMywDCPfZ4OkgW02TZOWPaotOuifKyV+02/k/
         dRDYHTvCHek5fTFDUZ6+A6gZbTUI7wsZQoVVfI1SpsYvF2IspOox4NrUIQ37JEj7d5yX
         gX3geQEhym6h0FFCBBwxaT4aKlDifZby/6Hrer91pq0PfS69Rps3Bumi9vfeKUlTl6F0
         15KqRyOAQSH6ZtAbE993ugBHRqvFmrXIdHMbr/mTNMVkfzRg6GAHmmYrIzBQTIoU5L4u
         9pwT30Mv0i2Ni4aVo3BBb3T+5/CIfDHxFcxMUWGENyGmtkogJBJMpdxxN6RD0LBSc49v
         wj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Mm/1wSNfZ8uXyCSHWLFqHUu7AbvQmXdPUh//P4RHPc=;
        b=VSAo6VSr98qYSnisuAUI7x37hfgCDBQamkJIP2WO1Kl2gBecDpzj9uv0rUK/Fz60RB
         Om88HddLmO3tXJzLY8IGBRxXc5A73tI0/UvZl7krY0o1ZJnpe7IgyMKC/dJCGeGnv7u5
         66ROl2nf1iqCPhxuy/dIQJIAm9D4eqlkw2/CU5sKRX8QGJueT0TRzypUEzS45robCIdW
         q9Yf1eYtqAsu8Y55SngD8NJBfqIOSSnnPTVGGBy2wLHQEMzS8ZNZMe15uSTtwkWwetYf
         oSEwUCEE+7kpPN1rkfktYbIPzyYm0nnJIm+/0Y32PE0oEzsc9mQSeqXSRjUI5K/koZvg
         tsCA==
X-Gm-Message-State: ANhLgQ0dUfPgbzbXEplcHmFGbVdATjYE5sFR2kYQ7cSAssBbSAV56GZY
        KXYA/ZaMkar2MzLuntCEk5C2foSotmw=
X-Google-Smtp-Source: ADFU+vv5mswBQHMyfBD6N+WGHTkJHGAfD9At3hbpZU4WyinePeyUqhw8/Cw9ff6DUBzWW1VxfioeGQ==
X-Received: by 2002:adf:f148:: with SMTP id y8mr5173025wro.322.1583943185700;
        Wed, 11 Mar 2020 09:13:05 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:13:05 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v10 15/26] block: reexport bio_map_kern
Date:   Wed, 11 Mar 2020 17:12:29 +0100
Message-Id: <20200311161240.30190-16-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/linux-block/20200311161240.30190-16-jinpu.wang@cloud.ionos.com/>
List-Archive: <http://archive.lwn.net:8080/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>

To avoid duplicate code in rnbd-srv, we need to reexport
bio_map_kern.

This reverts commit 00ec4f3039a9e36cbccd1aea82d06c77c440a51c.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 94d697217887..9190d68adad7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1564,6 +1564,7 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	bio->bi_end_io = bio_map_kern_endio;
 	return bio;
 }
+EXPORT_SYMBOL(bio_map_kern);
 
 static void bio_copy_kern_endio(struct bio *bio)
 {
-- 
2.17.1

