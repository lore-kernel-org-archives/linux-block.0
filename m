Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1E1C48BCD
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949E46128A
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFIPMI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhFIPMF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 11:12:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B455C061574
        for <linux-block@vger.kernel.org>; Wed,  9 Jun 2021 08:10:02 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q15so19702547pgg.12
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IBXcSszBYphaifHgOC2J5NicZzuUQ/7ILUQKgpfvwwk=;
        b=C2gl0t8sa0OyDrmf3CGQvVpN7nKMUYnmoNEFFTwsu1rvQew7e5y/VeHC/86fkQDjj4
         kS0WkTlD8Ceci0rRgBKGIOxxqx5mmfAnsGvIW4D2hP0H2CT8FkfLRyfO4wnEn3CRImXQ
         6hODDRY2KZ2bteVDwMEgv89PWnibSd6Icuq5M/TzFpQgWtOnTzVmHILLuywqqKJ8IWvN
         /GmlpLSyFKiWDVC3wFptS7roPpZxXJqRptRC78LSgz5Q0HQe6Gdy7IRSYoP7kDF1ahzd
         BhDgkaAtBM/PIMwxNDJcCpkOKifkUn+sZTr+VKvHFOtBW0z2aMry+BxYol6/GICuQnbX
         Bomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IBXcSszBYphaifHgOC2J5NicZzuUQ/7ILUQKgpfvwwk=;
        b=B8Mc5tdC4NPdLcJ/83dB9fOHzhce1lb1Lo9EAySIP+etdmhWyjdA8pKooZNiRhYo1M
         Y/klKIUweeLYfeUheRq0u/vUSj2mbwEnL/meNALexkRIdjQm7n2O60555k+mmGjoAbp0
         HTvbWwt1FEphvTriPzweLkDb0JPf1UIkof2cJg5SJzOKnXCB07kLoA7rKxHZSF93uHs2
         lY/HRVHTTvtpkhJeap3Ev5QljuazvV2jHgiF5isGBoP8u9WXvVQUHs1ZQ7t7tdt+Jw7s
         8YIKihVEHh9qAthKIv60hehriLZhO9iU/vGE8pBxfjB9NVd62NUGOPXJ2ayTTuBy63rn
         IqLg==
X-Gm-Message-State: AOAM5305pZxIzfsqL7D4aD3CviLRLQ064J3j1rG1d9HQWCUJj7+Yki/e
        6blZ30FoK6XRutdRqefiFwMsM8Snz9mccA==
X-Google-Smtp-Source: ABdhPJz/wOFlRsZKTXHwHzYsamAIgxhiZCMsps1pYK3Xqq2UY0/65dNFjGGQY7E5ydXHaeMf6n8wUw==
X-Received: by 2002:a63:1114:: with SMTP id g20mr132875pgl.385.1623251401815;
        Wed, 09 Jun 2021 08:10:01 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id u14sm77968pjx.14.2021.06.09.08.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:10:00 -0700 (PDT)
Subject: Re: [PATCH] libnvdimm/pmem: Fix pmem_pagemap_cleanup compile warning
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210609135237.22bde319@canb.auug.org.au>
 <162321342919.2151549.7438715629081965798.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3a32947-80b1-3d12-e96c-88f599d486a3@kernel.dk>
Date:   Wed, 9 Jun 2021 09:10:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <162321342919.2151549.7438715629081965798.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/21 10:37 PM, Dan Williams wrote:
> The recent fix to pmem_pagemap_cleanup() to solve a NULL pointer
> dereference with the queue_to_disk() helper neglected to remove the @q
> variable when queue_to_disk() was replaced.
> 
> Drop the conversion of @pgmap to its containing 'struct request_queue'
> since pgmap->owner supersedes the need to reference @q.

I folded this in.

-- 
Jens Axboe

