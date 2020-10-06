Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C895C41604
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 20:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931962083B
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 20:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PMTFpJmk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbgJFU0o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJFU0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 16:26:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC63C061755
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 13:26:44 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so8630324pgo.13
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2020 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FLtRXByKp9+5Dg5zm+HtjjP7VdwGyvWoNTaqHuD+Iek=;
        b=PMTFpJmktM2y+80xAhEY2qscCXN0OkQwO2aWowPP4oBrtk5GNM433AxXucgeqCd1en
         GNimloI8v2m/27/SBPwHVZJQOpzT1M51WoLCz5VHPqHUg9M3SUjBmHgMEj3fz2bq+D0d
         m6Ovz1YeGlqnCk8293sFPVkT3tYXI2uctPnlnoGCxgLX7xHsc3l2iZ0aqUmmfZO9Kecc
         xz1ipzOuFuymrg0NvA6UwWu8opx0gvSTN6hnqTbvB8ce1jR5QwJe9cVCVp9LS5wNYTLC
         AROWhfoKSKzgVEfFAcLLJkOpTSeHDIoLieRxzlUWELQgF4wUb+v/Gzm3SeNBf8WJ3Jy/
         ZZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLtRXByKp9+5Dg5zm+HtjjP7VdwGyvWoNTaqHuD+Iek=;
        b=GmFHnWks8WbC2yHw3ObZbWUVCS8BuO2ZBYiz46xcPybePoeuyqV2CQMJI1U4VyD/zq
         HW1IShHXsWW4OuiQwa2Kmki8HSxt+IAYQT3gzbE6PWyZGCmz3OEfRV8CIdGYEbEfq/+e
         HHCo4ls0FSPJR6xyxQtdstVkc0tBxTXKrkhefnTM7NYXxlDgG1niewTIysYFLjQE/xu8
         ge1pWZxP5oe5jNb8X8eytLmZF6QlEOK6PNjQ85br0CYtGE7IFdnnsTYSc6PsE20Fb92Q
         TwuxCz40VdpoxQT3Ph68l7+rLJCoRJjDYKBygLP6iYpqR9hCg1ywBo3+wEyWyGdeezKh
         eAiA==
X-Gm-Message-State: AOAM532QA0CvE2gUJjBWWUTD8LyardvHxGOZluo43y50iyVOd5zzqcOj
        EGnFEoSkZ73UrC4Tdf7OrM79CQ==
X-Google-Smtp-Source: ABdhPJzNF0T5J5Q+RDFMijq5u0hZO3I68498NE+0aFOep3We9kKjbIyRBx5C+TFOYA73D0g+GcLpig==
X-Received: by 2002:aa7:9427:0:b029:142:2501:35df with SMTP id y7-20020aa794270000b0290142250135dfmr6377421pfo.63.1602016003917;
        Tue, 06 Oct 2020 13:26:43 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r14sm7640pgm.7.2020.10.06.13.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 13:26:43 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] io_uring: Fix async workqueue is not canceled on
 some corner case
To:     Muchun Song <songmuchun@bytedance.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yinyin Zhu <zhuyinyin@bytedance.com>
References: <20200923114419.71218-1-songmuchun@bytedance.com>
 <CAMZfGtUFacR9GFfmySEN6EfdxVi7ZKdwTs17HrJmOL9A38J8sg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1488045-afd0-39c5-0b56-079fc51723d4@kernel.dk>
Date:   Tue, 6 Oct 2020 14:26:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtUFacR9GFfmySEN6EfdxVi7ZKdwTs17HrJmOL9A38J8sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/28/20 6:50 AM, Muchun Song wrote:
> Ping guys. This is worth fixing.

Agree - can you respin with the suggested change?

-- 
Jens Axboe

