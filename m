Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0695C433C1
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 22:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683CF61981
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 22:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhCSWzq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 18:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCSWzi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 18:55:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55AFC061760
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 15:55:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v186so4665793pgv.7
        for <linux-block@vger.kernel.org>; Fri, 19 Mar 2021 15:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+mKc7fzvtmKcq42w/Ei3G2a4+9kipCCTifLYCq+cQUc=;
        b=fTSSfnD45mdZ0Rg/urKyh1uwj4uUpAETH8fwk7hqT7RUREoh0bDBBI9FZNtKQTpBG/
         gCMrqh92Tp4seSaBDr9tEnhbQlSk/qnnPDhsuQ/I3PHCPIZdPo0vDLV/qONC4N2+AAwr
         wa19dKu8t5AhkcsNUTav6ypcoxoDrGR7GtuxQykLVEFgLa6w/lvmqRlIa0rVG5TPdyZT
         Sx89+6Jsv6rY6pX2nd394mMCq3p3AMmzQCQJl2/ABZpRcslBXlxpLYsJPA+VlIigAzXk
         lDXEvtLiAkeGiKMQ3dGjOLDFkpF0CQ10aVLXAHC53fkrku3CVHK+RBkqusGEEhzcjumK
         2VdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+mKc7fzvtmKcq42w/Ei3G2a4+9kipCCTifLYCq+cQUc=;
        b=gbdbhtg5uh/gfze8enJArOsvMLo0h/RTy7X76jOY/ics4dnAdEBd1D+zviVpaCaVB3
         v51kl89tn95kyj54fA6RyVPKG/AlQhIzmDebz8D1Nh8vqpro05FzCP15l+ffoE1Bs1er
         6FywsMihWZCKoDJl8M8T6SjqYYmXKxemLw+sBw/Mw5Tw/yXr7RV7oxGiF3M50IzUWllP
         zTBeLM9u24qEGnDFozjpMkOQx68/0gNz2E5mK+zONBfGX8Z43ok62MYxXhc72EJLpwJB
         /UFfrQoTELymhZx4D1UsV4vNmsoLRZ1iuJCTI7EAI+/5DOgVjvkfNZHlfM7Fg4n14PpL
         RWFQ==
X-Gm-Message-State: AOAM532NgPV/KWc39lgj5x6XcPui1Qf1VsNrEsJ6JXrxhnHF8/l8Xcc0
        ZM016ny+vwPkpQOyLYzNBlidLg==
X-Google-Smtp-Source: ABdhPJyC/IEs/ys0JgG2hYRBSBTKDcU9qfaF+f2gG+JGeGa80ahadwzxKMNZBXodeu6pa3bYlgpc0Q==
X-Received: by 2002:a63:d70f:: with SMTP id d15mr13705177pgg.397.1616194538100;
        Fri, 19 Mar 2021 15:55:38 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id q25sm6427705pfh.34.2021.03.19.15.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 15:55:37 -0700 (PDT)
Subject: Re: [PATCH V4] blk-mq: Sentence reconstruct for better readability
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
References: <20210319225222.14271-1-unixbhaskar@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2ff3edeb-aef8-6cf1-5974-4edca486feb2@kernel.dk>
Date:   Fri, 19 Mar 2021 16:55:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210319225222.14271-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/19/21 4:52 PM, Bhaskar Chowdhury wrote:
> Sentence reconstruction for better readability.

Thanks, applied.

-- 
Jens Axboe

