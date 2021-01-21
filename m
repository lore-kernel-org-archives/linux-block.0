Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13027C433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 12:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCDB423A01
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 12:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbhAUMoC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 07:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbhAUMmZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 07:42:25 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D124EC061757
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 04:41:44 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y8so1212439plp.8
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 04:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y529FtFERDo7JDSKYw/bu/1ClbCa25CZp5yymZzYueE=;
        b=UptwjYHVCvrX0UGD6PP2MpbRR5snXxoMH+GBR5pTp9rjy40YSpO7/kHjGuC8ETa63P
         9cwW4FSNhH9npCnlEvrcFyCvA7dz2P5L3t9IO4Z3CzFGeN2bV0PQvVdXDrSW1eOJnxQl
         ZfQW4p585R4PMOsMV2fNqFu+jtaLlqfAu1n8YuaIh8kbZ1bxzOiiXONMlPdxD0I/1qmj
         kNCnv/zeMjrx6d2Ur66QVasi5aH6xA26/eHDae/L+N5BbULHBnIBzoAJt7qHgfH4Swg/
         aJFG/YFIPcIPt1WsQREXM+BVQDabiJ9qEtlwbY3TPr6Jv9fJEzeFEc+8d0SzgbJ0PfmR
         ARZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y529FtFERDo7JDSKYw/bu/1ClbCa25CZp5yymZzYueE=;
        b=SbApC+mR+MPX4STaJYjkn7f1zph0VPVTc1/OroLSSdhGzo1RVMHEE9MaaxFm9ABos2
         5BGXUY3Ax1xmnB6kbaE40lCX1DwqSuFnU74YvDMfggR4A01MvgfkuFVa7z7qi4hu/gA/
         hEg1y+DHBjxEBUzj6GsUvzgf20NWWvx0t0WhNduw36LLXQwML7YmoAKzF0D7sZJYze//
         didRAgJQ9AU6XqbMuFuneKKOWxFOSeUez/dU3Yi+TObXQ4lxytdr4+0P7b7Lrut4h/Rm
         rO5ZspiridANpV98ec115w4xbMlt1Q4dCDbR1s24lIymVLcVPbzZRfZyRJsjWKNBLD8t
         hjIw==
X-Gm-Message-State: AOAM5312rPPuj5dgCmhIRYx7yWIzkHIPCYfmgAh/BoVkZ4fadq+cBn53
        UWYKsgmjRa2eyg2KGBeXQGfdTQ==
X-Google-Smtp-Source: ABdhPJxARoaLrWkgDZOaFzrATmKOLqafQTnAGhPT+1NN/SaNxtdaRYvHuglKXHI9hv0C4IguB6cxTQ==
X-Received: by 2002:a17:90a:7085:: with SMTP id g5mr11674367pjk.132.1611232904278;
        Thu, 21 Jan 2021 04:41:44 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id lw17sm5192742pjb.11.2021.01.21.04.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 04:41:43 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.11
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YAk8Kt/DRZ7T6WBl@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <24912e65-18c1-2b15-118b-854b9d9ba658@kernel.dk>
Date:   Thu, 21 Jan 2021 05:41:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YAk8Kt/DRZ7T6WBl@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/21 1:32 AM, Christoph Hellwig wrote:
> git://git.infradead.org/nvme.git tags/nvme-5.11-2020-01-21

Pulled, thanks.

-- 
Jens Axboe

