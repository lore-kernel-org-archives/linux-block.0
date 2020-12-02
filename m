Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D07C83018
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 16:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 957162173E
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 16:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgLBQ5q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730628AbgLBQ5q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 11:57:46 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DA7C061A4E
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 08:56:53 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x15so2181203ilq.1
        for <linux-block@vger.kernel.org>; Wed, 02 Dec 2020 08:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QPknBxtQoCpT/zvKKXpkK/ZoNkojGaFc65IMqcOjeCo=;
        b=znT+GrC5ntQsghSmwd5WkHL3YyU0u2hS19p2l25n+qsOlECRun1wQOJ1DtAoqGdodf
         PF5JAPnJCuBUwxdNrk6p4h+FIJg2BqSsMNaewCVgWso+ViL/rtZ+rgVDHcOkgS2BE9eW
         APSE5ahzEyaYTydVbHwbo3esRnf7gdOYytcFoHbX+1dcSZKmx4rz9RhEpJsFDBFSUX7E
         8AEWLMykbOFYAAya4uUWrV+jPXSOvrwlNTfJ0lEIWsYXpx8Anmxoyb9/AYHbj30JFTdW
         AYqgFXSJhi5gMOIPnQVXDTYpROxYpOv5zke96hODa5KIF9AqgvUKDqw65sOKwbrzH1bS
         +6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QPknBxtQoCpT/zvKKXpkK/ZoNkojGaFc65IMqcOjeCo=;
        b=CMpY6rN9d2CLQis05y15a9Jf+NUC3G4dmMrvUDikW0QB1LUcOanLcGn8HENLSMER9f
         pVFY1ZTV0FMWv00P4cDope4ZMncZ7KvSGTfUtq7zF0rbb9O7nafdID3hVboyb56XrdcO
         XToblkJdX32XJM3ZdQtirJ0eG1xdJjPY5a6JCWAr2jKtuR7CM4FO48VrS18+9ntJXjH2
         XeAtvItl0LpSzPrAYW3pw7OYIayMSCWfgC0NaKlzwNV68Y8KUOo2S4i53LpdY0JSpDIT
         TAsJWcHihzIDbUtZUoQDokcxn6DliV1ZAUBNrd0vcmgmuzpiOD5LBmP6iSSspSyYT+OF
         QXww==
X-Gm-Message-State: AOAM5312beiNYvvck+6BRJ/hg/84no7T6meNnOIAQd93qeUeJz7lkszQ
        RXb3dqQauk8KhN+5sB2IqqzVvg==
X-Google-Smtp-Source: ABdhPJyxz4IgRtE5sxlFOWEwmI1ekbF5NyPTv+/LiPUVGAiUYzljzebwvQt0VpHBPvn/n7GDuyx3RA==
X-Received: by 2002:a92:c88d:: with SMTP id w13mr3003916ilo.37.1606928212666;
        Wed, 02 Dec 2020 08:56:52 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p18sm1376199ile.27.2020.12.02.08.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 08:56:52 -0800 (PST)
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20201201120652.487077-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <335f3f7a-8b24-8ef2-8481-0139687d0dbb@kernel.dk>
Date:   Wed, 2 Dec 2020 09:56:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201201120652.487077-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/20 5:06 AM, Ming Lei wrote:
> Pavel reported that iov_iter_npages is a bit heavy in case of bvec
> iter.
> 
> Turns out it isn't necessary to iterate every page in the bvec iter,
> and we call iov_iter_npages() just for figuring out how many bio
> vecs need to be allocated. And we can simply map each vector in bvec iter
> to bio's vec, so just return iter->nr_segs from bio_iov_iter_nvecs() for
> bvec iter.
> 
> Also rename local variable 'nr_pages' as 'nr_vecs' which exactly matches its
> real usage.

I'd really prefer to keep the renaming separate from the actual change.

-- 
Jens Axboe

