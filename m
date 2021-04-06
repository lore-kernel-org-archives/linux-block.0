Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93219C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D50E61363
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345573AbhDFPUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345575AbhDFPUG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 11:20:06 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00625C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 08:19:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x26so3928390pfn.0
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JC7snZoKdDIitoATLSQcRE7CQtGzaaPD9ACA1xAq/vs=;
        b=anLnEx+ItWHFlcrYYDZQ4zCpRpt/gLJPuFDotQZ9FBAtBSdIg6y0ejC5tRxbUvPlnj
         JYVf3HDRqTRVLZCzOeT9p6I0I/nXrg5fXnMwnhAhXW9tm1L3IYQMl2UenLMr5dKNcl5R
         d2PmHhhs7UGEDumqClRkcn0K9mJ57Nky3gK97JktGNZcSHWy6V+v8kipp0o7NLBTXURf
         XZC3PRkpq0s1/dafCphQtOjyOI2nArQ0U+ZOVxYQJ5h1QqfP4rTGwAIoQTKMcV4cuSSK
         33bkTdfPfKvEHfM7rN4QgQomDCSZBalslbWg8HSQmCCM5CcTRt+tTpy/BbwvKb0tXpXC
         BkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JC7snZoKdDIitoATLSQcRE7CQtGzaaPD9ACA1xAq/vs=;
        b=XtiShtY6Ns5shN0VWKqSO/xkRfjckJnCHO/RuTy17VqRa6qp/528/8+HuVkTQhGgYw
         YiApVlJW0N7yOUmebqArWpMI0logITjrlhJPAk16y77uVO3GXbqPn3pdgls5QQqh83/n
         EkaexlBA4iVud3jevyzTqvm1oZUSUpzR897g+oNqC70bcu+TZadwdMKG9MdtjHs+hZaz
         zK+YHafEMBwznnGA1Kvwveg4gqpe23QXs6ciM3nWnhOBhKPHOHXzC+TFU5z1sWszfzP+
         miLDpxJEDkfoe9VkiV4yTj4L0zqmiyc2x6OqbjjItZNqb3K1C8RTcFhsNOFIo95itjGI
         bFZA==
X-Gm-Message-State: AOAM5339D9T0uDJKshyIMehtOtmE0643WYskyZKvmXwEJBC/aWgQJfGF
        DWWccGtKoH+pJINLLjjnnk7sKA==
X-Google-Smtp-Source: ABdhPJyEgwrZu35kLrX06uZeT8br+KCWTsJ22XW5RAUJO4SX4qKlwJEkJUmstt7Q2kGTMhqs2f+uwg==
X-Received: by 2002:a62:1847:0:b029:209:7eef:b14e with SMTP id 68-20020a6218470000b02902097eefb14emr1858013pfy.3.1617722398365;
        Tue, 06 Apr 2021 08:19:58 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id i10sm3373032pjm.1.2021.04.06.08.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:19:57 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for Linux 5.13
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YGwJ0h0GCC/118r5@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a9c8ad42-529c-0fb3-5f74-95ea9a0f38d0@kernel.dk>
Date:   Tue, 6 Apr 2021 09:19:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGwJ0h0GCC/118r5@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/21 1:12 AM, Christoph Hellwig wrote:
> Note that there is a conflict with Linus' tree in
> drivers/nvme/host/core.c.  Linus should take the version from this PR.
> 
> The following changes since commit 80755855f808c27c7154937667436f30e47bc820:
> 
>   mtip32xx: use LIST_HEAD() for list_head (2021-03-29 07:38:49 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-04-06
> 
> for you to fetch changes up to 8609c63fce58e94d82f6b6bf29c7806062e2e867:
> 
>   nvme: fix handling of large MDTS values (2021-04-06 08:34:39 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 5.13
> 
>  - fix handling of very large MDTS values (Bart Van Assche)
>  - retrigger ANA log update if group descriptor isn't found
>    (Hannes Reinecke)
>  - fix locking contexts in nvme-tcp and nvmet-tcp (Sagi Grimberg)
>  - return proper error code from discovery ctrl (Hou Pu)
>  - verify the SGLS field in nvmet-tcp and nvmet-fc (Max Gurtovoy)
>  - disallow passthru cmd from targeting a nsid != nsid of the block dev
>    (Niklas Cassel)
>  - do not allow model_number exceed 40 bytes in nvmet (Noam Gottlieb)
>  - enable optional queue idle period tracking in nvmet-tcp
>    (Mark Wunderlich)
>  - various cleanups and optimizations (Chaitanya Kulkarni, Kanchan Joshi)
>  - expose fast_io_fail_tmo in sysfs (Daniel Wagner)
>  - implement non-MDTS command limits (Keith Busch)
>  - reduce warnings for unhandled command effects (Keith Busch)
>  - allocate storage for the SQE as part of the nvme_request (Keith Busch)
> 
> ----------------------------------------------------------------

Pulled, thanks.

-- 
Jens Axboe

