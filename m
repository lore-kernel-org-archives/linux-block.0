Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3FCC636CE
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 19:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E43613EE
	for <linux-block@archiver.kernel.org>; Thu, 15 Jul 2021 19:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbhGOTLq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:11:46 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:40707 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbhGOTK1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jul 2021 15:10:27 -0400
Received: by mail-pl1-f179.google.com with SMTP id j3so3911257plx.7;
        Thu, 15 Jul 2021 12:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xe/jJ28/jZ0fzl37xAFp+ffR7wdRGJxUNet9cHVI4ZQ=;
        b=JPlQuJd0h2wL8FxhScBbCAjMZDZOhEPurbNG7wzncRM2JfaKZtLxnBnn+N407zJwde
         edQazwMDq4atRCDOb4rxJxlTh10i72lmjVwQPChpS7H0M+fS/+yivnCWMJxPBHNwq9PO
         NcpQe6BnmzHvGjY4qyILocpeU/sTiXK5tvu6R4E2HiknrDa+kGfd9lSh9t0+Nm+es+se
         f6ccQu/S2vUMmEkEeFAaTLDBAui0PlwgfKAn6wbZtT2PgW2PCb8f58+nZIrwuCaQzsMH
         Jlur0cYoVvRaZeTqJP+10gJezCbLU2Mb78E9knIBL9nfq4hFlcDMG3yNKm50W+VIHeh9
         8yfA==
X-Gm-Message-State: AOAM5329FuC89RcyfcekBIKs943o5aPwd4oExNQ6Jqx0P+EFtLzVH83J
        PQwdU0odbbrh1U1TgMC/da4=
X-Google-Smtp-Source: ABdhPJyqZsVie7Az+tmYzhtw0u7uwr/sCCYJfTULhzEdBZyF3UBkrQ7vEgcy0yWjgIdoAqZuXnjx0Q==
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr5526164pjs.133.1626376050305;
        Thu, 15 Jul 2021 12:07:30 -0700 (PDT)
Received: from garbanzo ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id u8sm10013024pjf.20.2021.07.15.12.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 12:07:29 -0700 (PDT)
Date:   Thu, 15 Jul 2021 12:07:26 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] block: skip queue if NULL on blk_cleanup_queue()
Message-ID: <20210715190726.xlukndxddvph4fx6@garbanzo>
References: <20210715045531.420201-1-mcgrof@kernel.org>
 <20210715045531.420201-7-mcgrof@kernel.org>
 <YO/fvbe5LeAP2Mtq@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO/fvbe5LeAP2Mtq@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 15, 2021 at 08:11:57AM +0100, Christoph Hellwig wrote:
> On Wed, Jul 14, 2021 at 09:55:31PM -0700, Luis Chamberlain wrote:
> > Now that error handling for add_disk*() calls is added, we must
> > accept a common form for when errors are detected on the the
> > add_disk*() calls, and that is to call blk_cleanup_disk() on
> > error always. One of the corner cases possible is a driver bug
> > where the queue is already gone and we cannot blk_get_queue(),
> > and so may be NULL. When blk_cleanup_disk() is called in this
> > case blk_cleanup_queue() will crash with a null dereference.
> > 
> > Make this an accepted condition and just skip it. This allows us
> > to also test for it safely with error injection.
> 
> So you plan to call blk_cleanup_disk when add_disk fails?

Yes, they can open code things if they wish as well, but when possible yes.

> For all drivers using blk_alloc_disk/blk_mq_alloc_disk there should
> always be a queue.  The others ones aren't ready to handle errors
> from add_disk yet in any way I think (and I plan to fix this up
> ASAP).

Have an example in mind?

  Luis
