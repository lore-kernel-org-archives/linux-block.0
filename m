Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F7C433F5
	for <linux-block@archiver.kernel.org>; Fri, 20 May 2022 12:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiETM5R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 May 2022 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiETM5Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 May 2022 08:57:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF325119066
        for <linux-block@vger.kernel.org>; Fri, 20 May 2022 05:57:14 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id x12so7661758pgj.7
        for <linux-block@vger.kernel.org>; Fri, 20 May 2022 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=f8BllMGt0DYrgZ7mzYdWgLIxWxCsIts4IW4I6pKKWtc=;
        b=RNcoXGypZDioVph1O0OX0LwHX7CKzO3XnZtlOeNg7NlC61e+KAmcG4AQq3E809aGtl
         Xb8cwnw+K2yRbGrxxq7/RnUnZbFfvZE0GQXKZQ2CoFtxNRyL2cCdFnLkMXzZ9sXwrOnM
         ytowWP12hICjzilfMWS4XPrHn5QBWKEptJGsySZoNUl4WPoTpc+UGK0MPGXhJ3FkLAdL
         D92xKRBmWKHFMdmSv+URdySvZ0cQHUes7N1MQBR4iGUhkowblG6EufVS1Lc+G03OwHy/
         59Knia68tgWhHXhs+2fNqiGMkL1knEfYYTE7jUqgiU/lpRDm1c8rfS/pTVkrp0MeyW22
         3roQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f8BllMGt0DYrgZ7mzYdWgLIxWxCsIts4IW4I6pKKWtc=;
        b=rIN+pWDbgQYiqnOR9EcbauAcv17doj/GOdR/dbNKGvNBafJtS0dZc/EQSH+BxqE6hV
         eFIJpJKv2uwzg/jbDPFwzkN1e/xLSragJo5X/iUGq5Zb0LahmGSqH0/jCxdGl/0b8USA
         agW3iwzMQ3Ba7UXXztEzNjtaim0TpFeFSUX4uL9DbNTjAvneUXEnqLNlP5DNuOwEaDjM
         q2YC+tMn72mhGlxPr8jaGjJiT9GkRPIf1e1/C8lettYeS3nKHlkO9yw1s1mE6YOdLJlG
         IT0tn4qcdVFa60hqfNc3gdqIz35EjZZEfuU/86fXJp90LQ0o3p//Gmi8RPW+k2GXgmX0
         QcBg==
X-Gm-Message-State: AOAM533HP22qBkRrrpZLTRWtRizIrRNpZhry0f6ELOoXT3w8NmIqkNcx
        ziGBidihdhZNlF4SfonUqtOb7tSLLA3t0A==
X-Google-Smtp-Source: ABdhPJxD5FYqpfytlW6KVR8LQY82NU50dB4cCl4CTAmPc7Zm3oIfI49Fwegv0EFUCAeqP32stnMsbA==
X-Received: by 2002:a63:4b16:0:b0:3db:2389:8403 with SMTP id y22-20020a634b16000000b003db23898403mr8505829pga.594.1653051433642;
        Fri, 20 May 2022 05:57:13 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l6-20020a056a00140600b00512e4b5af0fsm1806351pfu.174.2022.05.20.05.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 05:57:13 -0700 (PDT)
Message-ID: <98ad79da-7d15-2fa2-d15e-50ad5b2b3a82@kernel.dk>
Date:   Fri, 20 May 2022 06:57:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YoaeuNGHGE/t29gY@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoaeuNGHGE/t29gY@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/19/22 1:47 PM, Christoph Hellwig wrote:
> [note that my GPG key expired today and I had to extent it.  It
> might take some time to propagate to all key servers]
> 
> The following changes since commit da14f237ceef059ff1a9ee14de283905c2dac11c:
> 
>   Merge tag 'nvme-5.19-2022-05-18' of git://git.infradead.org/nvme into for-5.19/drivers (2022-05-18 06:28:04 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-05-19

Pulled, thanks.

-- 
Jens Axboe

