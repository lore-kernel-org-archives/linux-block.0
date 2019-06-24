Return-Path: <SRS0=7YUI=UX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB48C48BE9
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3458A20665
	for <linux-block@archiver.kernel.org>; Mon, 24 Jun 2019 19:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loOF0OsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfFXTlK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:41:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45951 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbfFXTlJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 15:41:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so15138296wre.12
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atnBayrLpc2AX2svhMGsm60ysNZ9T7b+BNR7ZDTK0cg=;
        b=loOF0OsDukaQjB4gzqEHf33xXpdkbvyUk80B+5eIPhILYl3VwyDSvqJO1sDzZPH6vR
         rYRmMEWXgZZ+gLv5AELdm+O8YH2kQdVu5DaDMI8iW08rgE1dfcsAHgsEalivjQKP7Jk5
         ccts3YWXMX9OGdxCu3hjcf8sqVTErfRXU8/mZo9lefPBvJg7DWfUfAEC10ylbMWRFaoO
         +xisJCFcz4ITFGyNEpO6/c8P6ktheNpleL+RrZ09eT0srbMUAvnBR3usvSU1419Bmp9e
         GDd6dNe/u6Axk6UZpZxbMgrpyHrxioQvGQOnpNn7WlkjsFbxeTQA/5Wg4ZJTcbJlMJlA
         7stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atnBayrLpc2AX2svhMGsm60ysNZ9T7b+BNR7ZDTK0cg=;
        b=BsMAiKBNoePJDS90if+/5l3Fl9tRlswMgQ+BYR8+jX1p6ukIqyMve9BaSnnKz9SFPa
         HNx5RBc31rN9nGJVKG4scQJg7/9/YPK6N/dLWcOEBQdgs7/dqi7ba5gftoTrp+urc7W7
         saQdSM0WM6EFP3c9TLSC0ZphVTbnV2HqU6KrfQ9Pas6ZFTTK0ResmFn+FtY4szbjIPaH
         MI1fGGCcw43/N/ZI5l8gshRQLy+D5xyIGVGyeL6l0Iicnj8WHev7UVtHBlGrLxhLJZCX
         eUn/oKaybGh+eJhz6Set/EZbxrfYkSb3TfoSh710bP0+Co9olpSsUHw2zDbqaCRMTvqo
         L5Ug==
X-Gm-Message-State: APjAAAWsQMGUBfP8BLfwEhCbXMR4p8lhdZVtfBtaNexwIPtPcUNvh67N
        u3nBmXSUUPf7jPzLqgihdxtKEvPDETM=
X-Google-Smtp-Source: APXvYqwqN7K2xUrBvStkw/0/+NWC3qsndEhJuGUuF96jm/cvwuGDunI66D16FAF8RBYMz+iCOUSBqg==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr34579834wrn.160.1561405267903;
        Mon, 24 Jun 2019 12:41:07 -0700 (PDT)
Received: from localhost.localdomain (146-241-101-27.dyn.eolo.it. [146.241.101.27])
        by smtp.gmail.com with ESMTPSA id q25sm17615395wrc.68.2019.06.24.12.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:41:07 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 2/7] block, bfq: fix rq_in_driver check in bfq_update_inject_limit
Date:   Mon, 24 Jun 2019 21:40:37 +0200
Message-Id: <20190624194042.38747-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624194042.38747-1-paolo.valente@linaro.org>
References: <20190624194042.38747-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One of the cases where the parameters for injection may be updated is
when there are no more in-flight I/O requests. The number of in-flight
requests is stored in the field bfqd->rq_in_driver of the descriptor
bfqd of the device. So, the controlled condition is
bfqd->rq_in_driver == 0.

Unfortunately, this is wrong because, the instruction that checks this
condition is in the code path that handles the completion of a
request, and, in particular, the instruction is executed before
bfqd->rq_in_driver is decremented in such a code path.

This commit fixes this issue by just replacing 0 with 1 in the
comparison.

Tested-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 9bc10198ddff..05041f84b8da 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5481,8 +5481,14 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 	 * total service time, and there seem to be the right
 	 * conditions to do it, or we can lower the last base value
 	 * computed.
+	 *
+	 * NOTE: (bfqd->rq_in_driver == 1) means that there is no I/O
+	 * request in flight, because this function is in the code
+	 * path that handles the completion of a request of bfqq, and,
+	 * in particular, this function is executed before
+	 * bfqd->rq_in_driver is decremented in such a code path.
 	 */
-	if ((bfqq->last_serv_time_ns == 0 && bfqd->rq_in_driver == 0) ||
+	if ((bfqq->last_serv_time_ns == 0 && bfqd->rq_in_driver == 1) ||
 	    tot_time_ns < bfqq->last_serv_time_ns) {
 		bfqq->last_serv_time_ns = tot_time_ns;
 		/*
-- 
2.20.1

