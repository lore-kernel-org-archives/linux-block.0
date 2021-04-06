Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8EBC433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B12F613CA
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbhDFPbW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDFPbW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 11:31:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DFC06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 08:31:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y32so7432616pga.11
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FVR8clygzLUFKEPmLFMXFMAq/CEtkPBvYlQe7K+S0wM=;
        b=DVtq8pczW0+cPS/j2Z4qsIjU8D6sXeTAZp0sJuYcGT//v+pcWVzgzeggqfSOCHIP7M
         rILDfEGbGmafL7JwZawTzoIZs7GVAmY+weY26PDox6YhskP0OXFCki0ccJxwlH8TV/kx
         mir+4UQvTB5mzWtJmbASNka+wqB5sSusIK8SSFmaMuxMjsxbmqJ6/P1YvUGX2YNhjdJ4
         +lwAkcGy3ZyV76N3M6c36RLCdfpMOi9BXUqRqgDJlyzLGbgYj7Z5IVh1B2jCEBxmDwae
         rqO3dknEyTTrdxNTd/y0KLOMds3UPKl49Q6kTuqMt47SDlIlXVAY5njn5Jwsq2SBTuXN
         UBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FVR8clygzLUFKEPmLFMXFMAq/CEtkPBvYlQe7K+S0wM=;
        b=eoy55xOZPx8rXogWvOH15pV08Clg3tKA53jRO6UxP33SS4eBczP4DeMH6ud3RcnFcf
         M0kMFADldVP7atgr75FS83BVfwcPttJwoJhsrxLT/iHjyAW/aHPPdzCWEmytttMGioSz
         SAmcTK/XvUDsW+I43C/zhSHsNyMWvtcCHamYBuQEf63e5vTt/oCdFQCVm/PCLy8EiFxd
         a1gzli1ajhldku6d4WAIlxfLQkEAZD0C5Yi6Oc+sLEPspP80dmHVDKiMNKU8CT20ru64
         1rjc+H5PecBuIIxmSTbUyxgwdenVZfAWqmw3tO+IvTX55UQO6Y92UIgjanME005oVAHB
         l9zA==
X-Gm-Message-State: AOAM530E0HPaaLGEQSDoklZ+9f0LwnSns9TcQg/GTEnKnGYpyF2PHPyP
        rTrpYq3VAOSzoO7ksAmKtsfOhn6gR21Fgg==
X-Google-Smtp-Source: ABdhPJwLy6+3XFFIb/kUj2Zi2Kpcjuq1vEVWRCe2DwIsxwTXQsvD7YkWlZhyg7Rnv+jccqvyAm8stg==
X-Received: by 2002:aa7:8d4c:0:b029:21c:104b:f6cb with SMTP id s12-20020aa78d4c0000b029021c104bf6cbmr27683675pfe.26.1617723074063;
        Tue, 06 Apr 2021 08:31:14 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id kk6sm2953044pjb.51.2021.04.06.08.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:31:13 -0700 (PDT)
Subject: Re: [PATCH] swim3: support highmem
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20210406061839.811588-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5b1e84c0-afbf-389d-2929-d92e914e2613@kernel.dk>
Date:   Tue, 6 Apr 2021 09:31:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406061839.811588-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/21 12:18 AM, Christoph Hellwig wrote:
> swim3 only uses the virtual address of a bio to stash it into the data
> transfer using virt_to_bus.  But the ppc32 virt_to_bus just uses the
> physical address with an offset.  Replace virt_to_bus with a local hack
> that performs the equivalent transformation and stop asking for block
> layer bounce buffering.

Applied, thanks.

-- 
Jens Axboe

