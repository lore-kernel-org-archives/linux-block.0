Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0250C433F5
	for <linux-block@archiver.kernel.org>; Sat, 19 Feb 2022 16:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiBSQTV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Feb 2022 11:19:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBSQTU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Feb 2022 11:19:20 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45D47075
        for <linux-block@vger.kernel.org>; Sat, 19 Feb 2022 08:19:01 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z16so4914117pfh.3
        for <linux-block@vger.kernel.org>; Sat, 19 Feb 2022 08:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bVjAGq4bqSq2mue78rPHRIr/uybX2LKSzsfCnYCH0hA=;
        b=OLWgnP9hE10OjUF43PkQvXRUR8jL+UR6CfOrbztG7NUFN1hiNiqA8XE+jLmj4173MF
         dHE22IKx5VENPxA3cebZVW6kx04uoAG1S9BYYXRUykpV+ZAJdGY2pdBuojKMFhLCNE91
         dU2VOg00QnYQrvqWqAt0/eZeq6jRN7z7RWgnQiq/KQN4pA5Ya6NBVHIXzgTiiV5SDyub
         YPnw22j7TKN3zpUCjor4SCMaBFNuYGalfSTdCfvsQP8bJ0HN0xFbRWWzKRhMLPDDo2S6
         Zz8vRSfhiJC4CP9zrsl0qOHptFs8ESnR/F9uLeACexUEqctPTAeGklJXCVAhcPExbY4w
         eRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bVjAGq4bqSq2mue78rPHRIr/uybX2LKSzsfCnYCH0hA=;
        b=aSmXeQrQ1fsdcbdXTPEesPt72Ms985J5fUzwHD87GfLnV1W+X2tWEKnD4hoLisvyiZ
         hydeSGwRat/ab60Xdt97EIV0SenSNqOx1PzPkz8CS5emJPheL0STW1t0RlBFTJbmSQkQ
         WCGREqC4e0eRloxnVTIJp7L4TENbhrKBlkn0AI53oltbak6aJmg4cYZULYFSofxjfiqj
         VyFQ5gKcd6/dUDxCi0BfuUqvsCD1y2KbHBt9YBHuGKA0o0DcXkiTCMeuOGoXdE92Ej7O
         GIs9h8iNjysxj6bk8ND7GnHDHQzQrGol4ciioehX4hxelHt8OZuMHvLG0OXRi4byR+LQ
         zcmQ==
X-Gm-Message-State: AOAM533AV1s6zZZhd1Z1LbtxItIaoJwVm4TCgZ4wHI2OCDH6njMeuJhR
        06vUMd2zdzrGem77yyxVRp+eFQ==
X-Google-Smtp-Source: ABdhPJzYrm2bYGnGXqM4nErgptk8TEC7W20C8/xEkvaUh1eNg5wdUVIiAUoNDd/uUlZc1w7ghMk2BA==
X-Received: by 2002:a63:6c06:0:b0:341:aa1a:28a9 with SMTP id h6-20020a636c06000000b00341aa1a28a9mr10395557pgc.35.1645287540547;
        Sat, 19 Feb 2022 08:19:00 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 189sm7019611pfv.133.2022.02.19.08.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 08:19:00 -0800 (PST)
Message-ID: <cfce5ca9-e845-4b56-e33d-283fee37c3aa@kernel.dk>
Date:   Sat, 19 Feb 2022 09:18:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: block loopback driver possible regression since next-20220211
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <YhBfsIqCNsi7D/st@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YhBfsIqCNsi7D/st@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/18/22 8:10 PM, Luis Chamberlain wrote:
> I noticed that since next-20220211 losetup fails at something stupid
> simple:
> 
> losetup $LOOPDEV $DISK
> 
> I can't see how the changes on drivers/block/loop.c would cause this,
> I even tried to revert what I thought would be the only commit which
> would seem to do a functional change "loop: revert "make autoclear
> operation asynchronous" but that didn't fix it.
> 
> I proceeded to bisecting... but I did this on today's linux-next,
> and well today's linux-next is hosed even at boot. My bisection then
> was completley inconclusive since linux-next is pure poop today.
> 
> Any ideas though?
> 
> Fortunately Linus' tree is fine.
> 
> I'm quit afraid that we wouldn't have caught this issue. Seems pretty
> straight forward. It would seem we don't have such a basic thing on
> blktests, so I'll go add that...

My guess would be that it's:

commit fbdee71bb5d8d054e1bdb5af4c540f2cb86fe296
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jan 4 08:16:47 2022 +0100

    block: deprecate autoloading based on dev_t

-- 
Jens Axboe

