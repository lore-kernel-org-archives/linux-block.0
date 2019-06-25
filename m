Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1655DC48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 05:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25E120656
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 05:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HM0YzezU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfFYFNG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:13:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40602 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfFYFNG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 01:13:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so16212566wre.7
        for <linux-block@vger.kernel.org>; Mon, 24 Jun 2019 22:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6gLoDta3dvks3JMjP4ttL9HRhFOLozt40bGbv9xuKK0=;
        b=HM0YzezUeNwli6ksWOIkCS+8IZfqUikKPl7NJo/yxSA6QsEXEdB5LEBRsqnmnbeIx0
         zDldjruUq0Yppg7OgL+00H0lzxbdubSLldJflP8ydhzO8klqDQRmH7hoDt6IGrzrEU40
         114y3hr4fPYkuMSuDsMhS0rXTTiiYQyyHOFI47OTDMKwWNkDqjl7CvkdsYL/qNqYxKad
         LAqXwG+W2r6VbaG7RIhvxFKaHxO9agS2yiOgH0PNWO7wX/ZPWhpMrAj/MW/UdHFy6LKD
         lwMBPoye6qwgCmNjYwF951JaxoROBH1R9ASIckX3hKtOb+T9BKBtXCE/OUSs8uLn5sKX
         tW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6gLoDta3dvks3JMjP4ttL9HRhFOLozt40bGbv9xuKK0=;
        b=f4MAHDSYYPCDimDbC/PaMmmBwdIlSto99XmB9cRAopGG7vallJyf07xTa4GWV0eWhO
         pzif53cdK7UHm5NK31vo1QkvMbQkzKHBughsJr8u2EAxZCsGc3cn9dYyfY7wov4C2fkZ
         X2nIq62iEQeJq8sC4NioZZnds39VLI5s5fj0BaT1ps2CmtCplL9e7PAm+fbWHtlSlZPR
         oYa9QEsKnxFkK/sSuRgTAJwrLw7v7Cb2a3UNJwtKu4NGX+82riF27lYprLiI5RJ5gld+
         fQWGI88owXIURfe790T/78fUWbkpFgOzmbIsIzw+YQv0QjJot8HIMCiLDik05D2HE0Sf
         jT2g==
X-Gm-Message-State: APjAAAUneu13bSjTcQj1dUIo8Soh9SdeWIM2LAEHEEwLuLrjiTMqr+lL
        3H9GPih8u6hVPXgZNsWHw4buhQ==
X-Google-Smtp-Source: APXvYqxFf5fs/86ySg7E8ipCDZs3uw8tj2dGbt9V4tAZfpD3w53wMOKgDNLx1i71rOdajwtq122gBA==
X-Received: by 2002:adf:fc52:: with SMTP id e18mr49271096wrs.14.1561439584126;
        Mon, 24 Jun 2019 22:13:04 -0700 (PDT)
Received: from localhost.localdomain (146-241-102-168.dyn.eolo.it. [146.241.102.168])
        by smtp.gmail.com with ESMTPSA id q20sm28543149wra.36.2019.06.24.22.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 22:13:03 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        bottura.nicola95@gmail.com, srivatsa@csail.mit.edu,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 0/7] boost throughput with synced I/O, reduce latency and fix a bandwidth bug
Date:   Tue, 25 Jun 2019 07:12:42 +0200
Message-Id: <20190625051249.39265-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[SAME AS V1, APART FROM SRIVATSA ADDED AS REPORTER]

Hi Jens,
this series, based against for-5.3/block, contains:
1) The improvements to recover the throughput loss reported by
   Srivatsa [1] (first five patches)
2) A preemption improvement to reduce I/O latency
3) A fix of a subtle bug causing loss of control over I/O bandwidths

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/5/17/755

Paolo Valente (7):
  block, bfq: reset inject limit when think-time state changes
  block, bfq: fix rq_in_driver check in bfq_update_inject_limit
  block, bfq: update base request service times when possible
  block, bfq: bring forward seek&think time update
  block, bfq: detect wakers and unconditionally inject their I/O
  block, bfq: preempt lower-weight or lower-priority queues
  block, bfq: re-schedule empty queues if they deserve I/O plugging

 block/bfq-iosched.c | 952 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h |  25 +-
 2 files changed, 686 insertions(+), 291 deletions(-)

--
2.20.1
