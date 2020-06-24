Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A329C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790C52078A
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 15:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yGzNNUiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404565AbgFXPQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404498AbgFXPQj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 11:16:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90380C061573
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 08:16:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h22so1288357pjf.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TVX/MV1cRkugdklQX2owAo6W7k+5NFqvXnOlDA4kvRY=;
        b=yGzNNUiU0zB4ia/e/BRLyub6jOMkcwxNBtVbxa2YAtqv9bXPxUetSHNyXmsHenrYHt
         cjkFgPmkRZp/X2yNr2u9mju+xed5eYUhQk4Kpx+jH0CGmR61y8a9ouWVJug5DZ7A+Qlv
         DJD/L8PQC/W42O0m9N96kcj4qg7p6UcD14f7MiBpKvVmmzYFuDReGBcXd8RNy518wKPV
         wNXnls0RdYt9lZQO/MEmeg8HOax7edYnC7etow2AGG1sgeWTIFjKemddtFXoz8u+vQRr
         Ma2eSMXnN6YljqXWa7Q+47mtbUe6tyaeYSy4XLkUoOPj471841XsJUywEBTvACE5vQ1m
         8c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TVX/MV1cRkugdklQX2owAo6W7k+5NFqvXnOlDA4kvRY=;
        b=ZaNcjs2u9GKq31CjLtAZHtgIQtxpgiHgyAiabqeLA+mAUc+BdXTsaooqyyJ2MmHyUw
         2AtWYOtjhzUNKnUZWrTs0Wm6qlUnR6xVTWcc51ryr/of4fmjh/4zk78tyO7PQ64WBRRy
         Hpq3fDteGEqKTAGeSrJc8cPmKva5rHPXd4XXtzaWWiuXgbIAPsSZ/owlEZFgn4n5zis7
         J2hdpDZK8pGMh3y/XIekLrNj4WGnQJRMbVTaYpy1Qs44X8sd6kHiXIOHYNCyML97fAmb
         A452d+4YmMjUUHcBRa/CU1aHUHg6SLvTHC+l2zbUb6rF53b40+ofPgQLujpGcPuc9515
         mNDQ==
X-Gm-Message-State: AOAM5302eOE83uLiB54puSZxN6fAe7ENC4KKzoqQJQnq6eZR3F8p3M7Y
        Puu8OV+mVtjjtHpbxMUefsAiWg==
X-Google-Smtp-Source: ABdhPJycIgQsbIB02Wur2mBRtNGc1PyURqcruMtrpODXrvsCtMYEKd4KNUN/T13UfMqBLSg/gfKfEQ==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24mr17314674plo.276.1593011798114;
        Wed, 24 Jun 2020 08:16:38 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n15sm3158702pgs.25.2020.06.24.08.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:16:37 -0700 (PDT)
Subject: Re: move block bits out of fs.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200620071644.463185-1-hch@lst.de>
 <c2fba635-b2ce-a2b5-772b-4bfcb9b43453@kernel.dk>
 <20200624151211.GA17344@lst.de>
 <216bcea4-a38d-8a64-bc0f-be61b2f26e79@kernel.dk>
 <20200624151454.GB17344@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <989cafe3-ddfd-8b0c-2bad-412eb3a20ee0@kernel.dk>
Date:   Wed, 24 Jun 2020 09:16:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624151454.GB17344@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/20 9:14 AM, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 09:14:11AM -0600, Jens Axboe wrote:
>> On 6/24/20 9:12 AM, Christoph Hellwig wrote:
>>> On Wed, Jun 24, 2020 at 09:09:42AM -0600, Jens Axboe wrote:
>>>> Applied for 5.9 - I kept this in a separate topic branch, fwiw. There's the
>>>> potential for some annoying issues with this, so would rather have it in
>>>> a branch we can modify easily, if we need to.
>>>
>>> Hmm, I have a bunch of things building on top of this pending, so that
>>> branch split will be interesting to handle.
>>
>> We can stuff it in for-5.9/block, but then I'd rather just rebase that
>> on 5.8-rc2 now since it's still early days. If we don't, we already
>> have conflicts...
> 
> I'll happily rebase.  rc1 also has funny ext4 warnings which are
> pretty annoying.

Done, pushed it out.

-- 
Jens Axboe

