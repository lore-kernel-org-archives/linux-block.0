Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C728EC04A95
	for <linux-block@archiver.kernel.org>; Wed, 28 Sep 2022 17:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiI1RPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbiI1RO6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 13:14:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D760EEDD05
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 10:14:04 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 9so13051665pfz.12
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Jh9eWU+9mrNPTUe7n2XDSMVIRIH621BbaH57pHKSEXs=;
        b=3Nj5sGfJC5OZ+q27cw8BCANNclJB+ZB6bpdkm0S8AToOBzztoE5ImkablpCURsuzrq
         /fYxz6jW+JpH5aRgRNQs3cmH44csQAVO8CLm2JPEi/mazDyTM0BrYUkbADqcA4a2LhJ9
         BcLyLJ1nmkny3Jm7e7+R5yixm9GidJXtaP28nV3df01XhmodUJbmEpdMNRTpNZ332AX1
         2XLPhhabFe4/IplPKgI2z3aEeLfr03cbO74Htkr97cRuEisTsVOa5vIhcmJblT4rlEDi
         d7Jh0OU57NpZGN3hbwaAYc4NF8HLwX1nNyTFlk5hZvCmA7KMRRkxWPzS/8unPOJnHnmp
         iqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Jh9eWU+9mrNPTUe7n2XDSMVIRIH621BbaH57pHKSEXs=;
        b=lp9UCAdHKfGSf4Uyg5e9B83zzgn2Kln8EiWxokSuLTlI7QhBB6T9MPUpvD3MPpvqM7
         MDREz0VbuAyNMaIhiTK2PuTdiXGNf8MKFnhnkHsYzJj4QSrcW3CnkPcxqqoAaGHH8KcX
         aMAnX/FzoyzZona2tbqBWoJnlgxto2U9zUcyYq45Wdv4XmANVhOMpGg7QjoLq7ff3ucD
         kgM3qUUyf6pD8wG+0PfF89u3fKwKkRqzD1vQvNcCRGPqo8WgOhmU5oWAEeTNdZNZSzEr
         +gT/n3hP1MOHPrfi9wHqt1YA3JIf8HnuK0n8hDEDBNuNFHgI+hc7p3VFlXQrnEmqK5ao
         opQg==
X-Gm-Message-State: ACrzQf1FGFcLwvKK1a19d+9FZ8ho0mq1GDLCO8Ir0a6m9deEdc7OFu8s
        i8LQtSWgjjgNocJFTSbGlGE/Hg==
X-Google-Smtp-Source: AMsMyM4zbU4SElkthmZkTBUuJaxlh8Sy1/OordHUQuJRkxmz/OEs8JHug8428/xBMIys5ppAdQHYnA==
X-Received: by 2002:a05:6a02:28b:b0:439:19d6:fad5 with SMTP id bk11-20020a056a02028b00b0043919d6fad5mr31000289pgb.591.1664385244344;
        Wed, 28 Sep 2022 10:14:04 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x30-20020aa79a5e000000b0053e468a78a8sm4216177pfj.158.2022.09.28.10.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:14:04 -0700 (PDT)
Message-ID: <bdce48ab-6227-a54b-de3c-7a43ed3e0309@kernel.dk>
Date:   Wed, 28 Sep 2022 11:14:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [GIT PULL] second round of nvme updates for Linux 6.1
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <YzR/6HNJeGTDkxSQ@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YzR/6HNJeGTDkxSQ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/22 11:10 AM, Christoph Hellwig wrote:
> The following changes since commit 99e603874366be1115b40ecbc0e25847186d84ea:
> 
>   blk-cgroup: pass a gendisk to the blkg allocation helpers (2022-09-26 19:17:28 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-09-28

Pulled, thanks.

-- 
Jens Axboe


