Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E81C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77982206B8
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FS3TKK/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfGOK5f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:57:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36506 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbfGOK5f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 06:57:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so10601871wme.1
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 03:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ub5f0na4GPQpBSoQ+OsF8cwS68edtFbv7d8hORSDg9A=;
        b=FS3TKK/EpKKg26Wo24BT/Zuph86L0wK1B/lZJrIUDXTw8HESm8Q+LV0kFzmUVjKouF
         uIw26FmHjPsGtUNodNQCJWaC4r/3+37YM+e9FK1Et5mse3UqoZAYVWNLRv27VQnExHyC
         YCcQzIuIEde34+2IZwoHMtbIxjEbnSDfRFj0kYtAeWR3ub3pmbLx07WsiZ+qxq3rnUGo
         9PwascXPJ2/jRYYLO/v7OmVnTc+kxRLH8KyA1/YLmkipq7KCULeyggQwBzuMpnie3D3D
         0ajzxpE/CNJ6I19/XQzx9sEGqnVrVsSBdqP3c+AzP7B1egbr40syjjc1JanLB2+bfXn+
         uSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ub5f0na4GPQpBSoQ+OsF8cwS68edtFbv7d8hORSDg9A=;
        b=eAhk1QP6jmYRmRNxoPgObL138GLlZJQuF0wff+sFt2v5aEKj0xibDhlGIiwzDT8CEl
         pfmyyeOw6oTuPMz978nGJ8dm2qMM9t72D/xCEQirgaDj4ajkw2BQXwL6MMunAvMNqTSo
         UfwL1VBhLp3MOvUHuAPk2iK6aT1InITIMwmiQQzNCv/p4d0hA0oLX3u/izrdUKRfz+DJ
         2PhXwNEGApWRbVF/kjVRlwFG7k5kMhLu/a/a2oQY1o+fPRcgIP0fZm/vSsr3TaYXskHI
         rPKssp6b4LodVxb2811URJjr/IfeC6CXFq/iavxhUxguKKH/d9WbQ0KuPJhXT23VSlI3
         lwxg==
X-Gm-Message-State: APjAAAXOC/nN9L6Yogkp0jqZmsDfLGZEO/FoVLLh7g800Kqq/1xHsHfz
        uE/FeSyadgyrsje/zUvJDFdIqNbXApg=
X-Google-Smtp-Source: APXvYqxROvFKewgTDbtvwvjbknUcifi1+bsHFs74Pa8CbcOdOCg4b7cq7uPAKkq7GDP2KQk7rfkiqA==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr22539235wmf.60.1563188253569;
        Mon, 15 Jul 2019 03:57:33 -0700 (PDT)
Received: from localhost.localdomain (146-241-97-230.dyn.eolo.it. [146.241.97.230])
        by smtp.gmail.com with ESMTPSA id z1sm18186559wrv.90.2019.07.15.03.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 03:57:33 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT V2 0/1] block, bfq: eliminate latency regression with fast drives
Date:   Mon, 15 Jul 2019 12:57:18 +0200
Message-Id: <20190715105719.20353-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[V2 that should apply cleanly on current HEAD]

Hi Jens,
I've spotted a regression on a fast SSD: a loss of I/O-latency control
with interactive tasks (such as the application start up I usually
test). Details in the commit.

I do hope that, after proper review, this commit makes it for 5.3.

Thanks,
Paolo


Paolo Valente (1):
  block, bfq: check also in-flight I/O in dispatch plugging

 block/bfq-iosched.c | 67 +++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

--
2.20.1
