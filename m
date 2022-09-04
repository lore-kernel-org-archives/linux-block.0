Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2301ECAAD3
	for <linux-block@archiver.kernel.org>; Sun,  4 Sep 2022 20:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiIDUim (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Sep 2022 16:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiIDUik (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Sep 2022 16:38:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994732A26E
        for <linux-block@vger.kernel.org>; Sun,  4 Sep 2022 13:38:39 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 72so6868885pfx.9
        for <linux-block@vger.kernel.org>; Sun, 04 Sep 2022 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=iXJZ4e881QRCBkDXXM7HwesUdR/gpeowGn9TKqyGYKo=;
        b=EVe3pF0/CsWQKEAWlyJR8pGHuTyqDH5LhBPIHI52FhmvSGeZmoF3+70qU2vWg4puDS
         eDbbrdY0wVQsgnumzEPu5kYfM3ADGbCtO2BVyn7rYWfASFda6rHWjiHf/WJy26hu3q6u
         oUbcbmvzEAzv2TK44hdfcBoF+XNG6S4EC86kjh/mcdajsy6fBJhRt1I1I9asVxkRLZgX
         U47AmIiNO9qOVTAs1+daIjH8vq1O0oEvXXxcSqP7ILnDnMJWuJqU7zXrtXuztM3nlM1r
         ysWvAwvu6userSDiz4sOgHSdePMQbVpOXw0X0gzvvmyGyVoyJov+DlWpfFpaL1D6jQp5
         BzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=iXJZ4e881QRCBkDXXM7HwesUdR/gpeowGn9TKqyGYKo=;
        b=p12EimFFCtJAN81iiZpxr+bZvX4aKZo1VbB/eHSKj6aM8iLPqprpHTQjlxE6DDhAi+
         SfVtKUajR1DInHMSGBfW55USdmbasLxctnsCb6w7t2/UCjV2ayvVon5cE/NCCtNRTiwg
         09yT0iELJykCK5onnIujN3oE9qAscD+ezkQyM5FL6z8moxTkdQmPDrw1XXr5Id0TbNJs
         8eg4Fj1GsqX6MGyjK8Wb0RryJzNWF8Bgjg50kwg6XCwcMVuJOYOJCBPRHjm1ylvh4J/I
         0koD92Swa1G+FTKRm5hbkwfiaHu4rGiYLK2K3zilXByBvW2D9DnXd1QMIUiP9+Fr5AMS
         +O9g==
X-Gm-Message-State: ACgBeo03kihX9O2XjmR9qjR3pVIb20viJZ6f8tZmXtMx8qmatD1Yx35a
        fl/sY21m9CKmJogZQSzMEia68Q==
X-Google-Smtp-Source: AA6agR5lALPVQPiuqCwoDIMTHet+6gm1yRs9GuAWYIRn12Bpsp1QiJOzt1GIWN9DgD7/grDldTjZYQ==
X-Received: by 2002:a63:cc51:0:b0:41f:12f5:675b with SMTP id q17-20020a63cc51000000b0041f12f5675bmr38320869pgi.69.1662323919075;
        Sun, 04 Sep 2022 13:38:39 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b00174a4bcefc7sm5810156plh.217.2022.09.04.13.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 13:38:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     yi.zhang@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
In-Reply-To: <20220903062826.1099085-1-yukuai1@huaweicloud.com>
References: <20220903062826.1099085-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-throttle: clean up codes that can't be reached
Message-Id: <166232391804.14690.3824114675220691549.b4-ty@kernel.dk>
Date:   Sun, 04 Sep 2022 14:38:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 3 Sep 2022 14:28:26 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> While doing code coverage testing while CONFIG_BLK_DEV_THROTTLING_LOW is
> disabled, we found that there are many codes can never be reached.
> 
> This patch move such codes inside "#ifdef CONFIG_BLK_DEV_THROTTLING_LOW".
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: clean up codes that can't be reached
      commit: 2d8f7a3b9fb31d2566b24fd94d5a533f9322c53c

Best regards,
-- 
Jens Axboe


