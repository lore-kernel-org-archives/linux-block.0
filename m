Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D15C43217
	for <linux-block@archiver.kernel.org>; Thu, 12 May 2022 12:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353655AbiELMYq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 May 2022 08:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353669AbiELMYo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 08:24:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD335247377
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 05:24:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j14so4712255plx.3
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=NSorybdfmfgNWFB1MTbFXjyZ5W8ms9nXp2QkIM3c5PA=;
        b=DcBLh9aRu5Kcl0BE8bwvSRrItSvbETWKB1olm5miXf5Ns8cNc12ZjFQkCTm6DGSTSq
         W/20zTHjUKLqIZCUwSwit93zbUZ3wHmMSV0DYrOZp/DyibGwWA+eZ+6ILot4oecESsBz
         1KVBIpm/c+HWAMeLMpLwfkuQbT/0dk5amzQByFbmCUQJlPG2xUXerRc7X3//jqkn6XPQ
         nsi+vNzo0+OaBJ3DOBAKPxajctulirgGMJz0QwKyr1RgnmYtYRIPIflSYfNgSatrIDlk
         MKSJoVw0KYn9TB4CxU18wTZ22Pj6R4rgzJikIU96yWxID7T/bnuLwS3/cIVgDftB6x65
         YDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=NSorybdfmfgNWFB1MTbFXjyZ5W8ms9nXp2QkIM3c5PA=;
        b=Y2mBUsivqAhe7OuFbbUqpOPl5PGA7eJO1psVwUBFSDnfwjlCkqVk2VWAxNqsgtyn8I
         Wq0bmzlGHCjhIM1kxvNuDhwt8Sd7jQIRMz7br7IlA0hEUyK1yDNMV5D6YqnfBMhJKEHy
         dMpKvgACn+/9UfCgvcErVFFbPLpeSBWHGOfecNYPNNeJ8Sv6LkbJYP/T8Dbok7JduZBk
         R/oPz/gQN3mI+E5heIqSrV/dJG47uANYRjvCTiBUnXMVAM8nSl4CJCxJZC0DDm5nnwSu
         3C/0btESXXVDtpkmDn7+QIyjGqZeA6P1YV62Wc6DjtG+W6caiZsqiWztaAomQgFbr6qY
         o/fw==
X-Gm-Message-State: AOAM532jeJZVBOazqHTu3vnxvNgvZ2riiDkbMqi/nR/CDfHYP1Nw5Y+m
        OLPObbUX9sLbOiZVwD/xtnfgJx0xPnb6dw==
X-Google-Smtp-Source: ABdhPJxlIZgGXA7gd0Ps17hHuR/b5MP7ZADf7rgd/HdVDaXITNeplZMQYy/mgZ3fyb1ov2L2Sqxgow==
X-Received: by 2002:a17:902:e494:b0:15a:4b81:1c16 with SMTP id i20-20020a170902e49400b0015a4b811c16mr30747200ple.10.1652358280921;
        Thu, 12 May 2022 05:24:40 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g23-20020a170902d5d700b0015e8d4eb27bsm3726409plh.197.2022.05.12.05.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:24:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220512061408.1826595-1-hch@lst.de>
References: <20220512061408.1826595-1-hch@lst.de>
Subject: Re: [PATCH v2] block: reorder the REQ_ flags
Message-Id: <165235827941.228388.17766889075262231976.b4-ty@kernel.dk>
Date:   Thu, 12 May 2022 06:24:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 12 May 2022 08:14:08 +0200, Christoph Hellwig wrote:
> Keep the op-specific flag last so that they are clearly separate from
> the generic flags.  Various recent commits just kept adding new flags
> at the end.
> 
> 

Applied, thanks!

[1/1] block: reorder the REQ_ flags
      commit: 5ce7729f25c16d5045deff4c9577e6d565da2d8d

Best regards,
-- 
Jens Axboe


