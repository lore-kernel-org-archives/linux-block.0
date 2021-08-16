Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D95C432BE
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D692560F38
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhHPQx7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhHPQx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:53:56 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A6C0613C1
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:53:24 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 108-20020a9d01750000b029050e5cc11ae3so21718536otu.5
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g7L5+WzsIvTLUERtXFkH56DdEnmU2g0oMI370Ugvcmg=;
        b=vTis+s4hlAm+FTr++090MtQwF0P5/lh0FBWDSi8RTA1wUVCr0BpRfK/us9pFVxUpog
         uu6jEUL2BHfveOB48loIkRaHp5bz5albTobFZvpvuwPRAEzMEGIuPI5kuvuubBK+AOQ0
         E55mGtikm7jUclvHQ2OBlF2FM0V2wuXIbbWCANJa4VATG6XRRBq0jlpJJliUp0uUwgwB
         oVjeRBwvP53F5AFe9UvDWGAGJK354/coFul8xwoLl0TFA4DBRK1WEWtza51fjJyL/6hp
         2ENq6H7kNagObY44cbihm3AMlndCLLsjuoR24ZxXM6HUn4PiQF9lftOMb/v4/GrY6jra
         QGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g7L5+WzsIvTLUERtXFkH56DdEnmU2g0oMI370Ugvcmg=;
        b=hkTH5dt9qn90FUBlBzWprKqDoFjck82XQdW5uK8+LWTPsxOwYJ/IdJRaklEOTQS+Z7
         IlHdyb8KImV+c4iQdJEWD1jLAxA64TRFuGUcCXbYTSHprFZrGSR5Wj/tsOjg1XVVhGrT
         f+rFNV9RQmQ10CXzTej4fieBNpNv8EAf0SlItbLGNXTc/dzJuw2i2FEFBm+AsrOpt40Z
         OqC5ME6Jn/gGK9TGzMYisZw0waeZ0P5nnQ25O4frZor4BoAdWXjco/0F1YBOanfZXkWD
         llPgqrTEoGF0fxss4Yjg5wSk5qkG+TisZv2DPet55Vg2rCxEhvAoGDjZkk7QVMRvw82S
         sB8w==
X-Gm-Message-State: AOAM533Hl42WAqiJ6VQlvozf1NeKs0DEUuvE2Ypmzuly9HdkvO0FYViT
        1oMk8tCpnGOfMdPCX1PCGGXxVJtjxeo2cpbg
X-Google-Smtp-Source: ABdhPJwl6C1pb1r7w6BRQRHMIIyRy460EQOcX121G30c+MwpxTGtjhNnwgFPpxDCyviQI/c+7nJkxQ==
X-Received: by 2002:a05:6830:31ac:: with SMTP id q12mr3809057ots.152.1629132803747;
        Mon, 16 Aug 2021 09:53:23 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v29sm1190332ooe.31.2021.08.16.09.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:53:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-cgroup: refactor blkcg_print_stat
To:     Christoph Hellwig <hch@lst.de>
Cc:     tj@kernel.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <20210810152623.1796144-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e090f6f4-6f15-f917-79fd-b516c6cca656@kernel.dk>
Date:   Mon, 16 Aug 2021 10:53:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210810152623.1796144-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/21 9:26 AM, Christoph Hellwig wrote:
> Factor out a helper to deal with a single blkcg_gq to make the code a
> little bit easier to follow.

Applied 1-2, thanks.

-- 
Jens Axboe

