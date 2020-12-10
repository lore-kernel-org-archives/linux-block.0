Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DA4C4167B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 13:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4A223E1B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 13:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgLJNVO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 08:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgLJNVO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 08:21:14 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C4C0613CF
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 05:20:33 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id n26so7275534eju.6
        for <linux-block@vger.kernel.org>; Thu, 10 Dec 2020 05:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+a+IKuLlT7a0Ojki7GtQuvVQoDHa5yJ9iQrlaZvaAzw=;
        b=wfg17YN3G6woIHOnnCAtPghTLfkskroiY/gxnJh/Jb7IQOqTe3hZZ+V0C33BegdN+s
         v+Vu1OtV0ahGr5R8Rhnpj+pe3F/UWc8Kitmiu1rlub4sd0f5fIbdZPAgDT9viS7J/a6M
         nlEPk0PWMVHWmp2llTi5dq1oJwzgAOztm4M09i/fJVyO5cI8Wu5j1E1mDA0nrh6bUZYI
         AQ+GxgXZWCeNLKXIpIDYysv7cUV/61TOPmxyu/6CkmAiX7cJfmKKhebY13fttH1rt+C5
         XuCTE1zgv4v68Y7F80DCvZiN9Iz5WlUq8lFz1YrxGMfiBA0AePnM6DtxZaW98e1+sS3Q
         yVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+a+IKuLlT7a0Ojki7GtQuvVQoDHa5yJ9iQrlaZvaAzw=;
        b=VpSV7COnAkAWqOK503lfkp99rrwqcvR8n1DHazHeRHtT0lMk54QNZLfvLrk/crvb30
         j95N7AnO/4YhEfwf8dGk9nJbj9ULNosAEAUEky1LJgWU9DmpYtbtlHKs0OGNR6bcDKYp
         m1MKowG3APEpuSkSJg+zZCqGcHdA61bARwNnWvR6iy+vf7fGLbO/0EFdAoFjExnhFDOI
         cAbLR8KtCH5MwMGUffRVizlQMueQw+LwiZ0+jiUOS8ul80zSodSWrunJI6MXY6Yul/Ok
         HdpLn2cPueUg5F6GOf25e/EXp5hKnksCMgER6BZFMWUfTUbvThtg7DC2cnIDjLMuJpDj
         HpEg==
X-Gm-Message-State: AOAM531QZnmD5kdauW8Z8FkgmWvgiyF+bdHyyGvAnSR/rLprP6D7pg09
        juhmWhztuQrobkC5NaL/ssqWtg==
X-Google-Smtp-Source: ABdhPJwBD9MTxsg5KJ415LUVRsW3qxbg+Z4hZKj2Zc6CofAjgYRyre5Blsjv6mMjzrrpOi4Nla54MQ==
X-Received: by 2002:a17:906:4d8d:: with SMTP id s13mr6443955eju.305.1607606432239;
        Thu, 10 Dec 2020 05:20:32 -0800 (PST)
Received: from localhost ([163.114.131.1])
        by smtp.gmail.com with ESMTPSA id i8sm4661801eds.72.2020.12.10.05.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 05:20:31 -0800 (PST)
Date:   Thu, 10 Dec 2020 08:18:26 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <20201210131826.GC264602@cmpxchg.org>
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
 <20201201125936.GA25111@infradead.org>
 <fdbfe981-0251-9641-6ed8-db034c0f0148@gmail.com>
 <20201201133226.GA26472@infradead.org>
 <20201203223607.GB53708@cmpxchg.org>
 <20201204124849.GA8768@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204124849.GA8768@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sorry, I'm only now getting back to this.

On Fri, Dec 04, 2020 at 12:48:49PM +0000, Christoph Hellwig wrote:
> On Thu, Dec 03, 2020 at 05:36:07PM -0500, Johannes Weiner wrote:
> > Correct, it's only interesting for pages under LRU management - page
> > cache and swap pages. It should not matter for direct IO.
> > 
> > The VM uses the page flag to tell the difference between cold faults
> > (empty cache startup e.g.), and thrashing pages which are being read
> > back not long after they have been reclaimed. This influences reclaim
> > behavior, but can also indicate a general lack of memory.
> 
> I really wonder if we should move setting the flag out of bio_add_page
> and into the writeback code, as it will do the wrong things for
> non-writeback I/O, that is direct I/O or its in-kernel equivalents.

Good point. When somebody does direct IO reads into a user page that
happens to have the flag set, we misattribute submission delays.

There is some background discussion from when I first submitted the
patch, which did the annotations on the writeback/page cache side:

https://lore.kernel.org/lkml/20190722201337.19180-1-hannes@cmpxchg.org/

Fragility is a concern, as this is part of the writeback code that is
spread out over several fs-specific implementations, and it's somewhat
easy to get the annotation wrong.

Some possible options I can think of:

1 open-coding the submit_bio() annotations in writeback code, like the original patch
  pros: no bio layer involvement at all - no BIO_WORKINGSET flag
  cons: lots of copy-paste code & comments

2 open-coding if (PageWorkingset()) bio_set_flag(BIO_WORKINGSET) in writeback code
  pros: slightly less complex callsite code, eliminates read check in submit_bio()
  cons: still somewhat copy-pasty (but the surrounding code is as well)

3 adding a bio_add_page_memstall() as per Dave in the original patch thread
  pros: minimal churn and self-documenting (may need a better name)
  cons: easy to incorrectly use raw bio_add_page() in writeback code

4 writeback & direct-io versions for bio_add_page()
  pros: hard to misuse
  cons: awkward interface/layering

5 flag bio itself as writeback or direct-io (BIO_BUFFERED?)
  pros: single version of bio_add_page()
  cons: easy to miss setting the flag, similar to 3

Personally, I'm torn between 2 and 5. What do you think?
