Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87FAC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DE6206B8
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 15:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a1O4ncWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfB1PX0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:23:26 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34302 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfB1PX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 10:23:26 -0500
Received: by mail-io1-f67.google.com with SMTP id e1so16920376iok.1
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 07:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sdMNYWYK1j9emrj7/mBy1mbTlB5+hQgTU083K6cti3Y=;
        b=a1O4ncWROUarCBf+z/xZ8ZuTtyvdGpUMlTgI8GIH9aj0/l1q5+hJ42rg8W6dl7eL84
         1ACmDkjloLfstI7GEUVXKGf2+RrF4aGuIubbGbqNGSsM1O8w7idKVxiWuF7V3BCIj+sT
         7hHDfIQkC+HOllcCzOeOM1J8gG7XCM6aycSJCfY0Ym15K50fdskYe7JPHm4gDUpiQ+G3
         6u3xP+3/SQPkq3+f4JlmmPy7tLWjlMMU7VAQ0HgOdjwI3BVj/3nzYrl4ZC7J70Wag3+Y
         +dnIDB/BuWquk1Vs3xX/KRO7JzsX45Ww0R7Baq7PbUeOyxK5Qd8/AmorIb2TxhlFuXBH
         GmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sdMNYWYK1j9emrj7/mBy1mbTlB5+hQgTU083K6cti3Y=;
        b=nR8I04ycWa428q3QgsTdj/8y6S7qGBpqCJaoUNeS2ZH1tV3ch65/xxcwpsiaMVyPE/
         0NwJHAcn5ynlDalwRl/XblPl+bhKiSjMPQJrVJCdzBIhkZZHKyw7s9pkSUJvflPNdkiL
         JeS0ejXoTzVmGXDpccn5w8TJi+mJZwYFLvBb/HeFw3MNzqZl7lTYLwAB3Hmlb5kpde3I
         OMOizvokoAYzD+9YAaVTGGkt5pAcPge97aWodTAy7RtoHBoJKvAMfmy6yeh9Oe53vSTA
         bdH8dcttNsHGUxBpjxMIcp54QPgJ/AymLQM9VlBhwmpiZDDlf87punNLhVlpd1L1tfF3
         wvUQ==
X-Gm-Message-State: APjAAAU1vx9Y7+69VJ0zQfvp81Z7fquamAE+bLsRM4BFkDKxMAWXs0sJ
        WSrTX2t6MgreO+ngqK4C+/9z4w==
X-Google-Smtp-Source: APXvYqzklb5uMHEoF0ilT4CYmzxD1y1O1bC6yKeJqhoKU8DeFdKIjGXPdXp1qrf5afphMMSEL/JTdA==
X-Received: by 2002:a5e:aa18:: with SMTP id s24mr5697166ioe.151.1551367405639;
        Thu, 28 Feb 2019 07:23:25 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id d139sm2858936itc.44.2019.02.28.07.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:23:24 -0800 (PST)
Subject: Re: [PATCH] block: advance by bvec's length for bio_for_each_bvec
To:     Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190228032421.23161-1-ming.lei@redhat.com>
 <20190228135832.GA3182@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22539865-7c66-2d2d-2304-cd09f2a86064@kernel.dk>
Date:   Thu, 28 Feb 2019 08:23:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228135832.GA3182@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/28/19 6:58 AM, Christoph Hellwig wrote:
> On Thu, Feb 28, 2019 at 11:24:21AM +0800, Ming Lei wrote:
>> bio_for_each_bvec is used in fast path of bio splitting and sg mapping,
>> and what we want to do is to iterate over multi-page bvecs, instead of pages.
>> However, bvec_iter_advance() is invisble for this requirement, and
>> always advance by page size.
>>
>> This way isn't efficient for multipage bvec iterator, also bvec_iter_len()
>> isn't as fast as mp_bvec_iter_len().
>>
>> So advance by multi-page bvec's length instead of page size for bio_for_each_bvec().
>>
>> More than 1% IOPS improvement can be observed in io_uring test on null_blk.
> 
> We've been there before, and I still insist that there is not good
> reason ever to clamp the iteration to page size in bvec_iter_advance.
> Callers that iterate over it already do that in the callers.
> 
> So here is a resurretion and rebase of my patch from back then to
> just do the right thing:

Care to resend as a proper patch?

-- 
Jens Axboe

