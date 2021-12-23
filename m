Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD041C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Dec 2021 14:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348793AbhLWOQY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 09:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbhLWOQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 09:16:24 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110F2C061401
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 06:16:24 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id y16so4337798ilq.8
        for <linux-block@vger.kernel.org>; Thu, 23 Dec 2021 06:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pRpBPDhxLs6Waq0J5E1RS70m0OtAAsHg+rNKseOJAag=;
        b=s5f0AnXM4L+l/44k25By2hz4/nIAOleKxT6+icAEPCeDwWbDvKKCeoW42s6yxkkIMC
         PfPzHvEi+6DZRRnKgpQAdv6BIRlTXjoPteg0mWEIXUZi14KyZNF9K1A65oMmTRaNjTyM
         eRrRg8SRcd+5mQj2p7tlE3be3xKiJRhgd2OKUrh6ti/YN8WIlcrH3KEoYB97DqL2QvgQ
         zm8dYepxAqGexNi3JbYT+gfovyVnXOer3gbEf1dLTCbgr6YCP2lnbM6slkJM8+qLr56r
         crqK+nxY38/VB5MkDD7NPnoW5ZoYJs2ro8ybFNtEQBuSSWf9uJAh+GWpLd4WQIv989yK
         22TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pRpBPDhxLs6Waq0J5E1RS70m0OtAAsHg+rNKseOJAag=;
        b=PjovHK0ZteVWgr7rZLCzNb8GxJLB/FN+nxRnYRSbYOiJLFYD6BlFs3sgoIkzox1lBF
         YRdNshR7jxnrksxoK9jsSfycTRXOHA3J73jFz68k9ANPSPzv1sPuZyqFYwOGAtHM+0xu
         ONP3GWuV0hqbRu2WF1Y5oAfoZ+dO2VmpORX+7IbnUYV8b8Cccy7JJ0F7COVzt5El2cMD
         5HoRN9GP0hPZVWW7URNbKQlFq9dwlnbOEiypdL0apwDjFswR5JI6q6nS7ZKtYmvhkyis
         RQmTGCU6z7AwifYX8v/zvJWGgs7Xy8s/ipR+qarnyLrcpc6mX0IEwvemm2ECbmbdqJP0
         OiWw==
X-Gm-Message-State: AOAM5331qkl6A4XByZq1beKE+qKyVvZ7wiv73nFeSxlDPzcZMffUeTtI
        KwOnO8UPYiReAC2XWZRi8s6gSA==
X-Google-Smtp-Source: ABdhPJz1t2sL69Z+YLJpM6FLXJ44eFnKm7LNCV7OHzTa8WvN9sZcoaKARo/MfK2ImA99Rtl7NWx/cw==
X-Received: by 2002:a05:6e02:1c0e:: with SMTP id l14mr1071191ilh.16.1640268983409;
        Thu, 23 Dec 2021 06:16:23 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q17sm41466ilj.40.2021.12.23.06.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 06:16:23 -0800 (PST)
Subject: Re: [PATCH] block: remove paride
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tim Waugh <tim@cyberelk.net>,
        Ondrej Zary <linux@rainbow-software.org>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
References: <20211223113504.1117836-1-hch@lst.de>
 <20211223113504.1117836-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6660785e-5954-1b8f-eeb1-1a23604571d7@kernel.dk>
Date:   Thu, 23 Dec 2021 07:16:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211223113504.1117836-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/23/21 4:35 AM, Christoph Hellwig wrote:
> From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

Hmm?

-- 
Jens Axboe

