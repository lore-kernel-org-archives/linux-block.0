Return-Path: <SRS0=923v=WB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B90C433FF
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 03:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC8B217D9
	for <linux-block@archiver.kernel.org>; Mon,  5 Aug 2019 03:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IXcfai26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfHEDoa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:44:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43620 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfHEDo0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 4 Aug 2019 23:44:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id r26so3005847pgl.10
        for <linux-block@vger.kernel.org>; Sun, 04 Aug 2019 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qaevOKKBkx9wzczWsPhokAptJGi+7DJxhR9knuVBhIc=;
        b=IXcfai26P/X8GzjqUOtmAH/Jo83R/2UjSztaety4x290UiwGJr62Nqbed+2gcSQnQq
         dqrgQtS9ocweR9XW2Mm9pHhrHFFRMBaxYLcm1pzOCTxIROUS9hvQ0qWmtamBqxPLZnOT
         EhjWLNHhSgeW0KfvyTB5RDtd5Dx9aJd7gcu2qMZsycPbBk5FRPwlnfzs1JqQpV41O2NT
         TPWPxUu0Sy5kUJDKrSn5SMTtpXqbO/vsBlmx8w9Dg1h8usHVPrStDNgIQeda0jezkGNQ
         kPsX+LoS4FBe/97ALO78rYF45eRlRbbdHtywIrV0PhhVjh1e7t5mswweENmRPEKXbsYl
         gxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qaevOKKBkx9wzczWsPhokAptJGi+7DJxhR9knuVBhIc=;
        b=su2S8pjdvyV7shxvvz3vHCPUqHIPTYGC/SMNbIzPa3wdiwdrEyFRmyb1yygBgsUIcC
         q3H8vEJza4uD9I0kMe/29bv5IsXARD4MK57wRi1XWmwtaz/YxIhxbqqId1Ws/476XdFS
         CcsCcAtbQdEPn5rnjdQg/Dv4YRMoz4Y1O4j21sYx+77mo89CdAJqSERp9evjumxU9dyF
         bbnKzFzLoLtLO4PeknP/JFDpdc4+YyodRvENuETUhGY9clBMl2HyMiZR8HL+PALwabMk
         yNZ9ERfSskchsE1lWHnzqN5KEA3rG5ncdD/Ee3A+hJELSMbAlkgBWKpbJG4vkbure2/3
         PCVw==
X-Gm-Message-State: APjAAAVOb6IMiZ6sCznq0z0WAdHkaKAG39PL+zyALFI/KZB9PFsNCfoO
        s/Dc4X7EO9i9QuZauURNOFQ1I5fxidA=
X-Google-Smtp-Source: APXvYqy4lnuT+Nq4f5lxPk3nmqptozGkTW1Nn0qcFMewuAbFZKOxXjof5Tv5YsVkUmYJ47dOKqH08g==
X-Received: by 2002:a17:90a:376f:: with SMTP id u102mr16333110pjb.5.1564976665920;
        Sun, 04 Aug 2019 20:44:25 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:61e6:1197:7c18:827e? ([2605:e000:100e:83a1:61e6:1197:7c18:827e])
        by smtp.gmail.com with ESMTPSA id t8sm13977229pji.24.2019.08.04.20.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 20:44:25 -0700 (PDT)
Subject: Re: [PATCH] fs/io_uring.c: convert put_page() to put_user_page*()
To:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org
References: <20190805023206.8831-1-jhubbard@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe0b9303-fce0-e7a8-a27d-af8e3903f097@kernel.dk>
Date:   Sun, 4 Aug 2019 20:44:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805023206.8831-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/19 7:32 PM, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> For pages that were retained via get_user_pages*(), release those pages
> via the new put_user_page*() routines, instead of via put_page() or
> release_pages().
> 
> This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
> ("mm: introduce put_user_page*(), placeholder versions").

Applied for 5.4, thanks.

-- 
Jens Axboe

