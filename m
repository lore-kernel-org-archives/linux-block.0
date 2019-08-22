Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604CDC3A5A3
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 15:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A9A2089E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 15:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxubH5IM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389563AbfHVPVF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:21:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33242 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389542AbfHVPVD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 11:21:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id p77so7326681wme.0
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2019 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfflNsfWkOa6pDM4wMxWMhDSV9/CiHm7eu3wCLgDzBU=;
        b=WxubH5IM9oW568/MgT51L+h21Si3KP9c61YYF5GvYWHjdbSIuOZ/m/Eaaie57qoBBH
         V8hSlixmGOC65GsJmPd0C0vMwWXjyj//eDWScbbXZcZXMyjj6HUdLfXM0lcLyGXG8Oqx
         GJ5rTPeme/pt21MuzMB/06hQvsegWX/XIxG2MNuRJH8fRCO+IuzLj5xORN4EeKkzY48R
         4RnlHXhbuoU8FIWuXnY4575N6dAbeh1VsRMp2bxkHFnqempkE3COghjTH+usytRicBXD
         p227kQctSISa0SnIurmQfANjWM7hT0+E7Ave92JZVbMYqRwBv8syEH+nUGekI7pIrdhA
         hhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfflNsfWkOa6pDM4wMxWMhDSV9/CiHm7eu3wCLgDzBU=;
        b=C8iF8WdrWiCWLLg1LPLOhxbID9DXX9kKT1JbcpGYIpIrtoZQMhMbIhxIcAmSfhreiQ
         VF5EuM18THgxzpyD21or6/PsL8uRaXR0DgQcf/5ttEG+lFnGPSE7NObQePEz+N5SUuem
         AxY6mnEH0CsAe89btrOwh4ytWgIQjM1gA184VKzzvp1IH6YTZBQXAw5BAE769rG+LGRr
         WVn+tpugDKlTps+92o01S447OHRHWNNUSGmVCoUG6TmifMT41CgOVHkb117W/rsVggfR
         XY5zAZqM2Rn/CzW+3q7r8yWay/wSenxU98AYoXq3CsYRbxi5/H3SjdpI3B+0kFt7khMp
         VJ4A==
X-Gm-Message-State: APjAAAUv4s0XEfvaMdowZDcKBo2bw4wC3PxwD64ycwV/wfC5axMzF+rQ
        QZm/8NO6E5ESPTRCpuuVFVBixg==
X-Google-Smtp-Source: APXvYqzMaMgyUxed5nIeBrM7zPfQoFGPc2dhGkxbotpKunfDdfJiEfwav0xtWpFhMC6k+tofaFqNFA==
X-Received: by 2002:a1c:a70d:: with SMTP id q13mr7343210wme.26.1566487261463;
        Thu, 22 Aug 2019 08:21:01 -0700 (PDT)
Received: from localhost.localdomain (146-241-115-105.dyn.eolo.it. [146.241.115.105])
        by smtp.gmail.com with ESMTPSA id a19sm79833974wra.2.2019.08.22.08.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 08:21:01 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 2/4] block, bfq: reduce upper bound for inject limit to max_rq_in_driver+1
Date:   Thu, 22 Aug 2019 17:20:35 +0200
Message-Id: <20190822152037.15413-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822152037.15413-1-paolo.valente@linaro.org>
References: <20190822152037.15413-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Upon an increment attempt of the injection limit, the latter is
constrained not to become higher than twice the maximum number
max_rq_in_driver of I/O requests that have happened to be in service
in the drive. This high bound allows the injection limit to grow
beyond max_rq_in_driver, which may then cause max_rq_in_driver itself
to grow.

However, since the limit is incremented by only one unit at a time,
there is no need for such a high bound, and just max_rq_in_driver+1 is
enough.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5a2bbd8613a8..e114282204f6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5805,7 +5805,7 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 			bfqq->inject_limit--;
 			bfqq->decrease_time_jif = jiffies;
 		} else if (tot_time_ns < threshold &&
-			   old_limit < bfqd->max_rq_in_driver<<1)
+			   old_limit <= bfqd->max_rq_in_driver)
 			bfqq->inject_limit++;
 	}
 
-- 
2.20.1

