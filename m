Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D6C43334
	for <linux-block@archiver.kernel.org>; Mon, 25 Jul 2022 23:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiGYX1P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiGYX1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 19:27:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8931926136
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 16:27:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c3so11735182pfb.13
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 16:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=sJaxuAVEjuuuzwRP+WEdaza+y4WuHZU6B7ctR9Fl/fQ=;
        b=UEB55pRSMOYj7iaq8ZG8SXBDU6izpqYb9dXr6E1ggWBpmv7Btq6bSss3UeFJLBlgt2
         wNLwqOI8Hn8fp5QYNO1k3RPJRE+8oXpkN7C8ogq69Jn/TeR4JTqjDu6OMPjOkr0nxWr5
         fxNEGeYFZAD8bviAo7bwy6bUlnjNSKyZU2Am8cVuQsxqKr+kLlivGX30LeTYbHWsnmvr
         X8QDX7STQguHpPAhmG4VbVOk0ZFuIATETTJUo7svpFYJRJtV0FBGTrQ+Au1WjdcjQ6u/
         Jfearnp2cnT7/XAZ9S5hVqBLEld6e87tMlnhu5CF4sQK8O6uOWgV9RBVOIjg5srHiIkS
         FFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=sJaxuAVEjuuuzwRP+WEdaza+y4WuHZU6B7ctR9Fl/fQ=;
        b=LpBRnU5lL4Q8/rgkLKiBEjxCr13wa+5rG6pMRFjywhS/DIMfkX+SIH9WdvsDLBkpRi
         SvQ0OLP6euEcAqRO30OIheJ1RMmBfLwkxfg+VNiMcSc2xCSOUzBrxkryx4+16fh6hSSV
         PyoetBESQaFuXP9dmoFg+YpDfzaAueyhsx+w01dT3lVbSzt7yDB1fXGJuAOWlJEKv8rS
         qdF5qwnOiUsSIfHlpTgIste58YgcXIzE0XfAR/t0RZuS0GBLhWkYTUM1q5ZYUSfSqQpr
         5AtT4N1+OuFP4LojEcC/JV9G+KVgOKI8p0asvtzk40h8Jyy6asTmE4lkKOM7R0AhRmU1
         76Ew==
X-Gm-Message-State: AJIora9FYp1mEL7QJTuBXoJ4Crvr88uhtfRvff+ReTPvHm3dkVtCrBnK
        EczgRHyfri4PD2Ixq7kde5TKry7fFQwKqg==
X-Google-Smtp-Source: AGRyM1uO48X+GcAYSMMYi95i8lCEpqUq2xTIAeLc5gmID+s312dkakg138i4PDQ3Kv+2Df+l+gJCWA==
X-Received: by 2002:a65:6b96:0:b0:41a:617f:e193 with SMTP id d22-20020a656b96000000b0041a617fe193mr12544546pgw.85.1658791633822;
        Mon, 25 Jul 2022 16:27:13 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x20-20020aa79574000000b0052ac5e304d0sm10359975pfq.179.2022.07.25.16.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:27:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220721064102.1715460-1-hch@lst.de>
References: <20220721064102.1715460-1-hch@lst.de>
Subject: Re: [PATCH] remove the sx8 block driver
Message-Id: <165879163325.1275984.13071451348545165129.b4-ty@kernel.dk>
Date:   Mon, 25 Jul 2022 17:27:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Jul 2022 08:41:02 +0200, Christoph Hellwig wrote:
> This driver is for fairly obscure hardware, and has only seen random
> drive-by changes after the maintainer stopped working on it in 2015
> (about a year and a half after it was introduced).  It has some
> "interesting" block layer interactions, so let's just drop it unless
> anyone complains.
> 
> 
> [...]

Applied, thanks!

[1/1] remove the sx8 block driver
      commit: 2dc9e74e37124f1b43ea60157e5990fd490c6e8f

Best regards,
-- 
Jens Axboe


