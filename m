Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFEAC433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Jun 2022 22:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiFSWVn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 18:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiFSWVm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 18:21:42 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976546553
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 15:21:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id u37so8683276pfg.3
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SCkPLyWzPu3GSvcUyrR0u67FRmIwGtikYd36/6LZ4cg=;
        b=2jfrdaEQDfkoYhFsjtbqVugmsuj46dGuoGQ33JrbsXktuQDOlzHoXYAcSAncRY2mLI
         xDJWWebEx4/hMo9gVKmXcB76bmHcgUwdZoucLjuygcd8LgcvbxvOoQW+Qbbhfs5por8T
         Gefdzyl05kciDR/7Zs+OfvWHAN2YOtBjJe/vlbUwCvN5IO14GwDhKPLikVAQ9xz6ST7M
         d2svktb+vH/6yNoJ2l2zj5ehU5eXDvQ/n0/UNUyP5Htv2kPpSCigumPPxou+R98h3RwV
         CzLI0AdzXiPxuzX0E3R3lFpqNYb/nFp8CQLcqWWh0XEEu4q5yubqeXkguHHcX/H4T16E
         0GbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SCkPLyWzPu3GSvcUyrR0u67FRmIwGtikYd36/6LZ4cg=;
        b=RrK9+MUsl0gkmruHAzZBXRHWkcewbOH4iFDCdYYBrAn0ThyA/B3Rx7ENR1z05/z+V2
         CToLQVBljQpqtEY2/1LVdDHqwYKX/TElV8lB4qTRgLvjXbpOAs4a76GDFLIpPRFxeHEv
         NdSWFnKUVUuPiPNe3XErFh+VdaaOYxT7nVjZgopQw47bChRw7aZ3krORDR0C45v+IgQ2
         8BpkhwaUknTJA3a61kKte813L1nVJTLM5J/oKOu8RRs9WXQTIU2/AtnOvgTK5SEyHKzW
         I1Nstq9v8jCHr4msrOzZY/pPexXSxHC9pukswynA+WTUptiTAfR3yGp9MibKNgYEI0n1
         z7Aw==
X-Gm-Message-State: AJIora9Cgx6ZnwV/WRA1YCMOEQ6vUuTafJmxll3PrMHh0rbXHReedxsJ
        64Zz3NnWneA/PbPzdeTqjVmfoA==
X-Google-Smtp-Source: AGRyM1sU2VYh8ZbbEM/7rLEDTZR9yIjrSRCWy3Jv80w2QIR2LAu6CWUEtFIWcU+Bn1kmYy144XJu4A==
X-Received: by 2002:aa7:842b:0:b0:525:1e94:4de1 with SMTP id q11-20020aa7842b000000b005251e944de1mr4073710pfn.36.1655677300868;
        Sun, 19 Jun 2022 15:21:40 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g15-20020a63b14f000000b003fd3737f167sm7506682pgp.19.2022.06.19.15.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 15:21:40 -0700 (PDT)
Message-ID: <67dd8d1c-658c-8833-9630-79ade736b348@kernel.dk>
Date:   Sun, 19 Jun 2022 16:21:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: fully tear down the queue in del_gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220619060552.1850436-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/22 12:05 AM, Christoph Hellwig wrote:
> Note that while intended or 5.20, this series is generated against the
> block-5.19 branch as that contains fixes in this area that haven't
> made it to the for-5.10/block branch yet.

Side note - I rebased on -rc3 anyway because of the series that went
into -rc2, so we should be fine there.

-- 
Jens Axboe

