Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68928C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 18:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ED220850
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 18:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="s2gDyFIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfCYS4h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:56:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43218 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYS4h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 14:56:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so6858154pfd.10
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6h+dhRWO9kT67M/U3jIgsyBvLxyIpqXBgLQ1fSk6HUM=;
        b=s2gDyFISdPWui47w4fZwhAnFNU14SlpNTfb8/EwR3cy8XlzVQDBSDyL77sPhV77Ytl
         7/Sv8uHn9UbKS3d2Y0b+rDoRh6oUqrYf4T082KHreor+/GVro7hSQpExyFPEWBF1dpoJ
         PRVsnsYj4F0DN5P7EMZuLbYzJ+4lo98ZTaQpeJdUKmiIIm6pMNDYxaButAsry+F3Mi0G
         AnvHccrcucjfm34dN/uDe/oad+P70fq2p4lkUy0Fasxtd52EbD3DgXVyciWNSZZ0LCkb
         Otl6Qgkwux44M5Cvc/jfgFzPrTtAjFO9n/fxvdQhVGRZ9pRD9yizwBWeGQDYoTINVSCO
         aJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6h+dhRWO9kT67M/U3jIgsyBvLxyIpqXBgLQ1fSk6HUM=;
        b=eSKkGtKsYg2xVPkaVKip2vFQtbXN3GHgbAaQQMuaDvCTH0QTAiKESUU5sm4gZgsEew
         By4XUS086rYa4plcqPfWh1PriKWM5XVKPEBZtcQmMDI/cVyH/LYGVlg40jMKeZ4E5Em+
         pqaniz0xwNRA3j1dV8/3f0WhzTP0xKxKFTcB9i785mjOwlBinH7rKfGBXgME5etdLwox
         4y8Na5Bx9kpL9dkOCdMxEMOAlcxWXPtqQmoZttZlVBO2Uu8qlmrBEmcCT6Qf5SIVTBYy
         RYqWDgQZwxuy4fjG8UDyJXS/hY/fuDBosH5QN9Mzwl6S3YZ8aAKnNbti+ThPUlqV5MAP
         VrAA==
X-Gm-Message-State: APjAAAUk4JXuWEqlJcqFZa3KYnHAX1bYlQy+B1GH+9DSIgKge7Knwxz/
        bXHGqmCmuUooomYEE2KpMZb60Q==
X-Google-Smtp-Source: APXvYqyy2fKsn/nrQsz0+8QXEd9VAGAEKtBTwXgmu0TMnxyx+gNO/7wrqqnUcVmWNLATWyMBUvk8iA==
X-Received: by 2002:aa7:8518:: with SMTP id v24mr25414059pfn.219.1553540196741;
        Mon, 25 Mar 2019 11:56:36 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:b619])
        by smtp.gmail.com with ESMTPSA id d137sm24446515pfd.133.2019.03.25.11.56.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 11:56:36 -0700 (PDT)
Date:   Mon, 25 Mar 2019 11:56:35 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] blk-mq: fix sbitmap ws_active for shared tags
Message-ID: <20190325185635.GF5826@vader>
References: <c0d3f0c8-a5d7-19dd-7b7f-1d4f860c425b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d3f0c8-a5d7-19dd-7b7f-1d4f860c425b@kernel.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 25, 2019 at 10:22:50AM -0600, Jens Axboe wrote:
> We now wrap sbitmap waitqueues in an active counter, so we can avoid
> iterating wakeups unless we have waiters there. This works as long as
> everyone that's manipulating the waitqueues use the proper helpers. For
> the tag wait case for shared tags, however, we add ourselves to the
> waitqueue without incrementing/decrementing the ->ws_active count. This
> means that wakeups can take a long time to happen.
> 
> Fix this by manually doing the inc/dec as needed for the wait queue
> handling.
> 
> Fixes: 5d2ee7122c73 ("sbitmap: optimize wakeup check")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Can this use the helpers we added in 9f6b7ef6c3eb ("sbitmap: add helpers
for add/del wait queue handling")?
