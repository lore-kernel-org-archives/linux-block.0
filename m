Return-Path: <SRS0=JXuJ=C2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B848EC43461
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 17:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB87206C3
	for <linux-block@archiver.kernel.org>; Thu, 17 Sep 2020 17:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qSY5F6BD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIQRuv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 13:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgIQRus (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 13:50:48 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6784EC06174A
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2020 10:50:30 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id m12so2747415otr.0
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2020 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VxNOaXEECYIPiRMfEtgGM6J1GaNFcdRWrXQNfSu136U=;
        b=qSY5F6BDO89WMA1sSn7TKzY4HEDf4VLctTXFU6b+T/WBItGXomuSgN+7+NMY5BhScG
         ip0r54waBP9e1I7OQGS2akynGeo4RhDqTdMS8Vk1TUN2HwSBISGr8mApFjtpPwA/IVrh
         //msBJVf0pH4LGY0Lkl0ZLuKCN4Tyyw917nmch5DdE23duXnAfZT7QyqV765S9dYX/dm
         ooFMWohAP2+hij2S/DoUoZ47GKbmQyrBV8/TaWUcSe+u2Jkdo5tDjbLBhAPUSRsyquOT
         nNSnCrr3VxOskVGOOk1KqCeMY1+x9E6QJMID6jfYDyAYJOz3UKbFKdcp04M9jRaph4gy
         w0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VxNOaXEECYIPiRMfEtgGM6J1GaNFcdRWrXQNfSu136U=;
        b=GzHnx+wtzZ4Chx/Q20jGYVvSNw/XEjhPjLN6PKrcwyyWEut6bvVGB3gurW6ThyI/mR
         lOt0y7jbjGPJMvXBCoUzY2aqrpCnaH/Ce8RIoFVVpoFrlxecW/fRAMWjIgs75QjF6pL5
         WuxX3RUfRPGTKTF09ac4IOJIoRjHcKZJX9vrogIUjSZIfgfp27/AKfT0Mh/zSI8v71pK
         b7pZQoJ1h3dOvWDb45gqD6soaiVIJMK0f5p8LGEs2B+epQ/IjL57SMs16DZOYzd5x6OD
         Sj8erHMD6nfvgje7csmzvy123L6Dnz8MRYD71PLhOx3B6oBzRv5aptUnYzWTMh/QYoZE
         AmCA==
X-Gm-Message-State: AOAM532DOqjuixD5W6V7to3KgdBftQCwe5axWxzNC0jMIHCP5Fl1GkEw
        dSoENnks8cEnZ5is5pDuN6oHeVrQYEQB2Q==
X-Google-Smtp-Source: ABdhPJzwaXf26BDvAr9jXYMUUqbBTXgS9OmYfDxadvq7iqdRZ8UO9UrLPu3sOlKvXnAJJwXdfBaGhg==
X-Received: by 2002:a9d:5509:: with SMTP id l9mr22106336oth.154.1600365029636;
        Thu, 17 Sep 2020 10:50:29 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h28sm356619ote.28.2020.09.17.10.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 10:50:29 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.9
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20200917173654.GA3311729@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e2954fdd-c161-5a5b-def5-f93dcbcefcc0@kernel.dk>
Date:   Thu, 17 Sep 2020 11:50:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917173654.GA3311729@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/20 11:36 AM, Christoph Hellwig wrote:
> The following changes since commit 709192d531e5b0a91f20aa14abfe2fc27ddd47af:
> 
>   s390/dasd: Fix zero write for FBA devices (2020-09-14 19:40:21 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.9-2020-09-17

Pulled, thanks.

-- 
Jens Axboe

