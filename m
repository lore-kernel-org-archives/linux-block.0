Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED77ECE588
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8735320872
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 16:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o9XGBBs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbfJOQNo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:13:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37165 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfJOQNn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 12:13:43 -0400
Received: by mail-io1-f65.google.com with SMTP id b19so47258780iob.4
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7czjHeR/FYw7akeQYJ1942FO11nkZtthgVwneKW5uvk=;
        b=o9XGBBs9WdsZoPM4Xp2XRT3UqqzpM17jhvw7ktI5q0Edsw8K2MrsOFEJoH6bMrVb45
         k6NlaB5CIDT5y/uhk+bJHPAbIAzdNtZM3XS7ZV0bqt5sXn6osREMH6DDBKgzvCjMizNl
         uxBMCdAlPDZSzlPBI6UHPnbQPLDOoAtLqYpFulKfCBGQFuSh0fkVttCEjdQiErfDo6PF
         o1VuVtiCPL1M0JORafeFgSDGfqoVDBGOog5a5CPm1Pca2HQAFliP6+B2trLRWOxf0zyl
         6SrvtmOQ9RTZiS68/6r0/pGdaazpjCHBUez6idMJOwu6Wo8dlJvSUrIcpwgfnfmfYReu
         pdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7czjHeR/FYw7akeQYJ1942FO11nkZtthgVwneKW5uvk=;
        b=ukh2O5Gk0YgjuuNBjvbY2mkjBrf9eoq3UTKfTUyAY8O2WjxI7nNqBl5CFGHwI/751q
         ybqq04JxqKnbnl0c40Wo9JP6CW2PA6lBEzePdIrIH/px6sHBMI3wmAlxNRST1czqd3fN
         tLceeOHoFgxxRaUmb7MgOH/bQrHWINQjaKxcbzuvfmLDUvYUMRqIHRUjrSjA6efyQ91M
         JvL2mThYR2ZLh4Fq4a9rPu5150FatmOc8xhxajf1h7VYWOfOvfz/b8vmpK0OVsGI3I19
         18nxEkdtf3f226gj3J7otWqDVYm9atCN+QgMGBXtV+WoBZWQkVxzFKpEVhb+Q5xt7cgS
         bsew==
X-Gm-Message-State: APjAAAX7z1bvFKf+e/YINKj+1s8KfUGVv6sVI/yG2ugPU2YTctFBXsp7
        gFpNrNAa7wLe4ZoWcoprUxReRYkTRNg9Cg==
X-Google-Smtp-Source: APXvYqyjH0HLXuoo2Q17ycX0CesZ6wuNYKJsBuQyWNrIqamUmXePJxoXgbY3yt+wO4RmNzb/2vmQTg==
X-Received: by 2002:a6b:b54a:: with SMTP id e71mr25689901iof.132.1571156020825;
        Tue, 15 Oct 2019 09:13:40 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q3sm14539813ioi.68.2019.10.15.09.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 09:13:39 -0700 (PDT)
Subject: Re: [PATCH block/for-linus] blkcg: Fix multiple bugs in
 blkcg_activate_policy()
To:     Tejun Heo <tj@kernel.org>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-block@vger.kernel.org
References: <alpine.DEB.2.21.1910151232480.2818@hadrien>
 <20191015154827.GK18794@devbig004.ftw2.facebook.com>
 <07cbc404-65db-b236-9ae2-558197b8cdb6@kernel.dk>
 <20191015160347.GM18794@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8406cdae-fa26-3db5-f97d-347059cdbc16@kernel.dk>
Date:   Tue, 15 Oct 2019 10:13:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015160347.GM18794@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/15/19 10:03 AM, Tejun Heo wrote:
> blkcg_activate_policy() has the following bugs.
> 
> * cf09a8ee19ad ("blkcg: pass @q and @blkcg into
>    blkcg_pol_alloc_pd_fn()") added @blkcg to ->pd_alloc_fn(); however,
>    blkcg_activate_policy() ends up using pd's allocated for the root
>    blkcg for all preallocations, so ->pd_init_fn() for non-root blkcgs
>    can be passed in pd's which are allocated for the root blkcg.
> 
>    For blk-iocost, this means that ->pd_init_fn() can write beyond the
>    end of the allocated object as it determines the length of the flex
>    array at the end based on the blkcg's nesting level.
> 
> * Each pd is initialized as they get allocated.  If alloc fails, the
>    policy will get freed with pd's initialized on it.
> 
> * After the above partial failure, the partial pds are not freed.
> 
> This patch fixes all the above issues by
> 
> * Restructuring blkcg_activate_policy() so that alloc and init passes
>    are separate.  Init takes place only after all allocs succeeded and
>    on failure all allocated pds are freed.
> 
> * Unifying and fixing the cleanup of the remaining pd_prealloc.

Great thanks, applied.

-- 
Jens Axboe

