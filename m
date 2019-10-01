Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AF3ECE587
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 19:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07AA20B7C
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 19:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZPycgWvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfJATdd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:33:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40293 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfJATdc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 15:33:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so4467531wmj.5
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JiHkBcFF9QGKSMF3hIUTLU+zid7TMdspW3045+AEJlQ=;
        b=ZPycgWvl2h+aHUHp06XdvjewtgM29fzf/AeUg8xKzELsCUN7fqdxZ2Ko8wyH1v3OgO
         6cbI5fFQok9nm7zF0Sdezj0f/ayPXceaD/BIC6Pfym9Zbvu1vbKqpd/5CdpS5WWgb0mM
         JFzb7RKoBj53G4DkOlFcppmGEoOzCdAw++138O/YF6JonUrHobCbwZWZibNesC+AKZBI
         tMDSqXbxo3j6jcvm/zRn7A+doKunH4UgdY+XNJN/+ziuhdZmBElCqkwK6ZEkx0iVmZDQ
         wL+tn+Rjnklt9C/+ESpvIF634AiWYbN1LKE60Y3bupfg70QqCS0nSvmWM6UGX8gDDMfW
         HjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JiHkBcFF9QGKSMF3hIUTLU+zid7TMdspW3045+AEJlQ=;
        b=Vzq5bpcPw6KpH8Ocl9TdqoRAqsbXSqyRugQWHSjidnvZNGh+Goo0OubxbUH/lFsvL6
         2Qx3Ym4YLjG3FcWfhg3Pr2NM2esonE50KYogP0LlEE+trQr040+UIctTINOxhKWFe5Xu
         XSRnuKKHmJkJV+QHbTOXfu2+50jh8I4jef6G6JA6SFu14/BOYAbvp8GkIYzA6iPIYbkZ
         FcpsBQDm4YW08oC6Pd2v5u8NdKXT6+46ItyNJN6sldZKak6VM1ju29ti5eKQFFjmYU/7
         9UF4JHH5pCs/3uxi8ira2Nyeqswuk0UkuwnhyKNysnMVUcXbpa+tYwfJx7L4Tlj7F03t
         D/CA==
X-Gm-Message-State: APjAAAXjAZh8wUPmEWF7JAtEE1UdyUPfqWhM887ayUeIILjTnXMYjf7X
        YlGZ7xkWMhFJa/SYA1xdXnZAqw==
X-Google-Smtp-Source: APXvYqxbhhToG7DvbciJrZ+f1CnZFN7SXXQgCuhoWJbL33UMWWXzcjijb5Wb40Tk3V7CkQr+pFLxtg==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr4944750wmk.11.1569958409373;
        Tue, 01 Oct 2019 12:33:29 -0700 (PDT)
Received: from localhost.localdomain ([212.140.138.217])
        by smtp.gmail.com with ESMTPSA id q15sm36967632wrg.65.2019.10.01.12.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 12:33:28 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/2] block, bfq: make bfq disable iocost and present a double interface
Date:   Tue,  1 Oct 2019 20:33:14 +0100
Message-Id: <20191001193316.3330-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

the first patch in this series is Tejun's patch for making BFQ disable
io.cost. The second patch makes BFQ present both the bfq-prefixes
parameters and non-prefixed parameters, as suggested by Tejun [1].

In the first patch I've tried to use macros not to repeat code
twice. checkpatch complains that these macros should be enclosed in
parentheses. I don't see how to do it. I'm willing to switch to any
better solution.

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/9/18/736

Paolo Valente (1):
  block, bfq: present a double cgroups interface

Tejun Heo (1):
  blkcg: Make bfq disable iocost when enabled

 Documentation/admin-guide/cgroup-v2.rst |   8 +-
 Documentation/block/bfq-iosched.rst     |  40 ++--
 block/bfq-cgroup.c                      | 260 ++++++++++++------------
 block/bfq-iosched.c                     |  32 +++
 block/blk-iocost.c                      |   5 +-
 include/linux/blk-cgroup.h              |   5 +
 kernel/cgroup/cgroup.c                  |   2 +
 7 files changed, 201 insertions(+), 151 deletions(-)

--
2.20.1
