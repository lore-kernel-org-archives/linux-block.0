Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94EEC433DB
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 14:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A679564DFF
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 14:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbhBDOru (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 09:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbhBDOrb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 09:47:31 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B72FC0613D6
        for <linux-block@vger.kernel.org>; Thu,  4 Feb 2021 06:46:50 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id q9so2810391ilo.1
        for <linux-block@vger.kernel.org>; Thu, 04 Feb 2021 06:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dNCXcUSwniZAxtD6tOMihiSHRPoavoiSF+K3Scy4bbY=;
        b=kMx3l/jsg5JLTgpm59axpTD4aFi5XHGvcWEtHwan5XDS1bVl1KuGfdwt1rdlenjGRN
         cSDdn0ebm5+fR2L9vWRFwwGIuLs3X2b2rI9y+QTso1VI6rYGEkZBBdSu4Gy9bcKuYIi5
         98rB+dQcTV5GdIuiEKBURjGAm/URKaJQrY6S87HqpBMOx3rWVqsmZOhbEkV/K7wQXHGE
         bA27WkPqSzcF6s6veDpIoerHzBy9NAwYzg4arBaJU7Hv79FWfQ8xVWVsJmoIoqflutbN
         ELJ76JomqCXxVeR0quCqCGjOPC48lLa4LEZLnlkyPsK+sQtVg8IenzJm4g7iofROtGvk
         Z2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dNCXcUSwniZAxtD6tOMihiSHRPoavoiSF+K3Scy4bbY=;
        b=kx10q8JvW1d/iXaa/mzseogQEFcEASlfcduw6Do+rbul8X5C1fmuiwtlqRsJ44Ngpe
         A6p/JbOSRpxtC6V/izJYIV9yu6HIr1e4gUORIdIoiisxHS78CJklp5N90szMyjnJYfWP
         YPxS+byV65YCPZJABvPzr9DwjoVJnG3EHPUeB3Z4Hlk0My1IEVPSzl36xCceCQ/dLpgr
         7dXreOt2udfAUW9DV7oZRNEW7Fc+m6Ehrg825NjV55UF7R/bBd6crYxDdR8LGkvq4Lo9
         tWDwN5DVDS6Y+Yji7yBzp87RZFbpgRFvpqRkE+dogMiUoPq61en/zW+vSZ+XMN67FDTa
         bXRw==
X-Gm-Message-State: AOAM533lZ3oH263Pf1M7tck4FnChySdE8yiifLjMOB7IIpTNehh8mLTx
        CIkK9C6vmPB/+ePy4lFh8NbL3wx0UMxgZeg/
X-Google-Smtp-Source: ABdhPJwj3TFH3XAQD5XlHrt8zt8W9Tcbf4+OLbHq/OjE1GyXrBHUqDpcgbyZe58nv2P/5hLiHitzpw==
X-Received: by 2002:a92:cda1:: with SMTP id g1mr7291796ild.267.1612450009645;
        Thu, 04 Feb 2021 06:46:49 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r2sm2628257iln.42.2021.02.04.06.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 06:46:49 -0800 (PST)
Subject: Re: [RFC PATCH 0/2] block: Remove skd driver
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3cb4ca54-b916-5793-0632-bd12ff9d0006@kernel.dk>
Date:   Thu, 4 Feb 2021 07:46:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204084343.207847-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/21 1:43 AM, Damien Le Moal wrote:
> Hi Jens,
> 
> Instead of spending time fixing the skd driver to (at the very least)
> fix the call to set_capacity() with IRQ disabled, I am proposing to
> simply remove this driver. The STEC S1220 cards are EOL since 2014 and
> not supported by the vendor since several years ago. Given that these
> SSDs are very slow by today's NVMe standard, I do not think it is
> worthwhile to maintain this driver with newer kernel versions. I will
> keep addressing any problem that shows up with LTS versions.
> 
> The first patch removes the skd driver and the second patch reverts
> commit 0fe37724f8e7 ("block: fix bd_size_lock use") as the skd driver
> was the one driver that needed this (not so nice) fix.
> 
> Please let me know what you think about this.

I'm fine with removing it. The 5.12 branch doesn't have the later
fix for the bd_size_lock issue, so could you just resend that once
the merge window opens and the block bits have gone in? In case I
forget...

-- 
Jens Axboe

