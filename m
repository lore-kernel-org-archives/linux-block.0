Return-Path: <SRS0=81jf=ZZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA07C432C0
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 21:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9712320640
	for <linux-block@archiver.kernel.org>; Tue,  3 Dec 2019 21:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bjMRZrmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLCVDu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:03:50 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:32796 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfLCVDt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 16:03:49 -0500
Received: by mail-il1-f196.google.com with SMTP id r81so4571144ilk.0
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2019 13:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sFn+q5M4OQGy2hAfzIasEpnp/G/IQ19ZE4PBt4z+hKs=;
        b=bjMRZrmxdnENLVxHQwgxiuGhs/pIOOCI7RPVi2IMk3lwgTI7aNB9AryFTQFJ6N34Zz
         znaAPt4pAIhJrr9eVmUHVToYCNxheTmgPByX99LYCSyVMAjJEY/6aWBIurQG20+1KE2p
         B7Xx7tBoXqf5elHivpFxXrpx4F+ZdXzRwgJntZCgFBhUIp+3zU9jA7Kkfwf5ndxxUYIF
         vegXLjcgvhs/y083uQx2obugP2D9bv+dEvcAIvjPPJkew84MoNsU4x0d1yfbOK0T00eX
         t7g3EDZUcj29+n0c7bK3y+ZSqCCnnlF8cPzoVC2tHqeAUYF8OaAC3w0H9ET1FuwRzPg/
         /qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sFn+q5M4OQGy2hAfzIasEpnp/G/IQ19ZE4PBt4z+hKs=;
        b=HpwfF8TwssDrea/PTWxwbhQzQXhiD8CWJiwqoeBgywinXML3h8ajaRpiVhQIG3w1md
         V4G5w41vWIqdhBq2xjZcp65P3CB0nu/wbFq+8xlBwAU5e34pqPRKGmKqJMz0YhKAUd2K
         HqcwiD394qbYGPYFMGc39dxM9jaWvpx/6AQDIRew6qY4bptbUfrl2RtokbG7ZInS5Gmc
         ghtaWVUMLNTndvF7DPxY/LSgzoHDNzAc/WKiWsc0WJWQW8SnDJ7kn5QsROvjGd4yQ+1X
         GkDw1CrXSy5kTbMWmthxnv+7CchhcSrsb+kFHOAREpLT1sZ2NkNOREJILiLC4gsylYzf
         wv/A==
X-Gm-Message-State: APjAAAVdTz5c/CMMbDg3vlaJ+dZDYyXTLVL2l7Lc3MOMpcaBDwMXr/kk
        Tljh31S0oVAZS9tipBrEnNqtpg==
X-Google-Smtp-Source: APXvYqynb9y1GtIc2v9Jt2I8gQfLy2oB0u+TVZ+0gIHqiiCdzgQ3Kw9UoB/KAiRWf5JLsPyTkN/pBA==
X-Received: by 2002:a92:d282:: with SMTP id p2mr134806ilp.73.1575407028959;
        Tue, 03 Dec 2019 13:03:48 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a81sm1136094ill.31.2019.12.03.13.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 13:03:48 -0800 (PST)
Subject: Re: [PATCH] xen/blkback: Avoid unmapping unmapped grant pages
To:     SeongJae Park <sjpark@amazon.com>, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
References: <20191126153605.27564-1-sjpark@amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <43f9881b-4a88-47e9-c321-19033a2bc872@kernel.dk>
Date:   Tue, 3 Dec 2019 14:03:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191126153605.27564-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/19 8:36 AM, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> For each I/O request, blkback first maps the foreign pages for the
> request to its local pages.  If an allocation of a local page for the
> mapping fails, it should unmap every mapping already made for the
> request.
> 
> However, blkback's handling mechanism for the allocation failure does
> not mark the remaining foreign pages as unmapped.  Therefore, the unmap
> function merely tries to unmap every valid grant page for the request,
> including the pages not mapped due to the allocation failure.  On a
> system that fails the allocation frequently, this problem leads to
> following kernel crash.
> 
>    [  372.012538] BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
>    [  372.012546] IP: [<ffffffff814071ac>] gnttab_unmap_refs.part.7+0x1c/0x40
>    [  372.012557] PGD 16f3e9067 PUD 16426e067 PMD 0
>    [  372.012562] Oops: 0002 [#1] SMP
>    [  372.012566] Modules linked in: act_police sch_ingress cls_u32
>    ...
>    [  372.012746] Call Trace:
>    [  372.012752]  [<ffffffff81407204>] gnttab_unmap_refs+0x34/0x40
>    [  372.012759]  [<ffffffffa0335ae3>] xen_blkbk_unmap+0x83/0x150 [xen_blkback]
>    ...
>    [  372.012802]  [<ffffffffa0336c50>] dispatch_rw_block_io+0x970/0x980 [xen_blkback]
>    ...
>    Decompressing Linux... Parsing ELF... done.
>    Booting the kernel.
>    [    0.000000] Initializing cgroup subsys cpuset
> 
> This commit fixes this problem by marking the grant pages of the given
> request that didn't mapped due to the allocation failure as invalid.
> 
> Fixes: c6cc142dac52 ("xen-blkback: use balloon pages for all mappings")

Queued up with Roger's reviewed-by.

-- 
Jens Axboe

