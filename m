Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB14C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 09:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AC82083D
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 09:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttETt1Q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfGOJcJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:32:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37815 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfGOJcJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 05:32:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so14433089wme.2
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2019 02:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2eM8zTsGyf584RmX/FkfC6pSZbSa4qt71o0cGq7/Ass=;
        b=ttETt1Q5sinqI8hZDNkG/TMjeRA5i6HVLX4POPVD5jCR71MlEtJ2S6jSSTWUiHS/Np
         ILij4ADgSI7gyshL56Yb/bcxN/Obvy48UOq/4P7gmxvanXIHdtwg5UNgcZkqEXrPgFVE
         0SgfMl7/tibK8yB+Kept+iY1mm+vOQvERkCZOC6ciogzck711bFVH/5+8wCSl7JP35Gi
         S1OcmqQcyOANTBkmzbFXiUiRLLLwh+CeRhs4+/+dWJsRFsQkk58ePdVBQCWCpdEG6kmr
         b/9iltvzo/UHWnUSI7wUpOhfcuwFXjrNxwnFd+JSRpXYeH2dT2KVBJ5nIXCevInoju8K
         2N6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2eM8zTsGyf584RmX/FkfC6pSZbSa4qt71o0cGq7/Ass=;
        b=rhzUWQ5R2Ac7/OZvdT416BRu07VHlWcMx5cXgb+jCCmyh4ARmPOPNtW9JEhMagZohA
         zXCmnb3IsNvc7fMr+47OkFuFtYaNdGug7rW5ezbvEEP2imrnk3NqXOtrFwi5XNypkaS5
         KEIbgv4hRi0w7+gSqDnvvbeLpLXZgu0egQw7KbyPnViONDIXA0XL8NWPxyfWxEeQAgw9
         wT9P5dQ+OK+tPDVKgsxo+DdLnUxSpQHkyMT4Rg3EjIJXvhQiYY+C1Pt5XExKJcZvN0D7
         +etErUwlyR4Z7ffX44PPopAA1V4nDCAIexSJw8jvQJHc04RUPSO0k+B3ZH6M4+OEdhNS
         pmRw==
X-Gm-Message-State: APjAAAVR3QuISiPtxtR2q30OMJxcMRvhyrIMu+0nfBgzklYzbxRr012m
        gyVzr+0YFl9STyXdEBuZXZOPIpyY29A=
X-Google-Smtp-Source: APXvYqxjaXB7dBtLJSDCQ1FAMQDvr+AHekW2YTw088x8woO8LTCaZpggG1e+c1gd2u9LFH1R4Zbf2g==
X-Received: by 2002:a1c:b706:: with SMTP id h6mr23020807wmf.119.1563183127246;
        Mon, 15 Jul 2019 02:32:07 -0700 (PDT)
Received: from localhost.localdomain (146-241-97-230.dyn.eolo.it. [146.241.97.230])
        by smtp.gmail.com with ESMTPSA id g12sm22544993wrv.9.2019.07.15.02.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 02:32:06 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX IMPROVEMENT 0/1] block, bfq: eliminate latency regression with fast drives
Date:   Mon, 15 Jul 2019 11:31:52 +0200
Message-Id: <20190715093153.19821-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
