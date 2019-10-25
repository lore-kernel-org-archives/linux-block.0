Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4936BCA9EBC
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1183721D7B
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqUBCze/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438611AbfJYJbq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:31:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35577 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406341AbfJYJbp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 05:31:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id v6so1293781wmj.0;
        Fri, 25 Oct 2019 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=744iXlZUhGtRbNI1jwDoT8T6tb3N+po5FhQinftwlTo=;
        b=LqUBCze/eivip+ZIDjECbEB58Y/7xWHJBXDj5tzXBtpt1zWGgvTw640ukfDBWNMETm
         fGPAF34nNY0w11lIpVSlKjvMnZkF71iCsphBi45EL398J7kr5uk9bzdxVQCCecpUO/u+
         Op0CobKkWrjEvvk4/gnTtjqag8uBRs0ZAiSpZg4xtK2UgqBtDXUfszBa8yaJtF40pg4l
         PliGYjrROykwSO8a/jEf9JApm3goNC6DYF9ZbGRsFW0DJmJrLcI08Pi2ov6nVND6HT/c
         Y9/MDBTA68OtETtofeNbREOoTTHEmE0KUkl3Cf363sqz5XXzUvtU8NwjHhPt1XeaNESb
         ICaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=744iXlZUhGtRbNI1jwDoT8T6tb3N+po5FhQinftwlTo=;
        b=k6yjkxr6jdZgP6hF2NglISa/SLicVkk49af4eXyTf0AHD3X+AaOO20gWzPFbz8OKot
         zV74HT57GLiwQL0u2u3ldIKGs086HIW3OFoS1LCZyUecvn70+m7aW3Qy35IXZdTlnsZ1
         1d2e7qnLBWJzuiuimHDCf7U7uJtzaaykZT7MLQJaZ29oV6qghSwtSnDcSRaRzgTwEdPu
         eDrrp33p9DAEpZq08HIZAPah2CuTw8G1woZmhH7hwWg0nbKQJyUbmfPCRWYnh2s/v+cE
         pawVrPX1yUWxpZIp4g9+kFX7WdL7PIco1m90nmduAmTsMtiYF+OT1WWM3Tf6ZNS9R4Pz
         YpXQ==
X-Gm-Message-State: APjAAAVsMHiD5ONWXi0K+ztklWDezb4InLJLGb1bwR+QZ5hPl88d8IC+
        VMPh4qAJlMxYkvdFoBYyvdA=
X-Google-Smtp-Source: APXvYqwrW/mpMB4LaY43U1dcwxF8rn16v3ktVqOYZfY0RKSfqIdoRp/DIw6/SQ3Uc3BqDzLr9Q0sYA==
X-Received: by 2002:a1c:a791:: with SMTP id q139mr2495930wme.155.1571995903661;
        Fri, 25 Oct 2019 02:31:43 -0700 (PDT)
Received: from localhost.localdomain ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id l7sm2054551wro.17.2019.10.25.02.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 02:31:42 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 0/3][for-linus] Fix bunch of bugs in io_uring
Date:   Fri, 25 Oct 2019 12:31:28 +0300
Message-Id: <cover.1571991701.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

The issues are mostly unrelated. The fixes are done with simplicity
and easiness to merge in mind. It may introduce a slight performance
regression, which I intend to address in following patches for-next.

Pavel Begunkov (3):
  io_uring: Fix corrupted user_data
  io_uring: Fix broken links with offloading
  io_uring: Fix race for sqes with userspace

 fs/io_uring.c | 67 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

-- 
2.23.0

