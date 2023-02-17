Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BBEC05027
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 16:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBQQof (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 11:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBQQoe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 11:44:34 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8774C10AA3
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 08:43:37 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id t8so1183539qtp.9
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 08:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3uS6l7R4NN6xpTILsvB1VqvWC13/kbkjpwhQ4oxzsc=;
        b=bzNQI1lTX91qau6JA46+Mz6ULw7qBr1UtdLDROjsPDqk8E/nb38hRM60dOP98yM/lf
         w+d6zTZqk30S+IHNqhwYujkgJsOVDRsmeTIlKGbEkUMDpzD01aHn/X1carPh+kLI67l1
         7ZoA66FPmmhhg533a8J07VtujtNdOkBhweLXvZP50a7IdwhsTlsWeOSOA+a33sZHgH9x
         Q7KQYjxa1fU5ZbRpYmzyiIRf1A+4tb1PIAcZbb9UYfaV8Yua5JBTwLwAg71ui3gxo3z4
         JcGg81Q7I2Ipp34stELXBFKHkVB4UT50NLd4fPgcrGhDo44W/iq2oDPBDXraaecbsKKA
         sDCg==
X-Gm-Message-State: AO0yUKUKeToxqGQFVqSn7enragkwUjT7wLtO27+gqSYVcCHcxiyIZ5rN
        LPXRFQn0YwXofD5jOtPEANKt
X-Google-Smtp-Source: AK7set9gWGn6W9xaTLmOYlMZhybnyp39F0bJY6EI6xONfoBZQJ+IZm4+inBu0UdqBkTMUHpdf4x7bw==
X-Received: by 2002:a05:622a:81:b0:3b9:bc8c:c20c with SMTP id o1-20020a05622a008100b003b9bc8cc20cmr9573603qtw.23.1676652216569;
        Fri, 17 Feb 2023 08:43:36 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id i129-20020a37b887000000b007068b49b8absm3482600qkf.62.2023.02.17.08.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 08:43:36 -0800 (PST)
Date:   Fri, 17 Feb 2023 11:43:34 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Uday Shankar <ushankar@purestorage.com>,
        Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <Y++utrkJXuUsD0K4@redhat.com>
References: <20230215201507.494152-1-ushankar@purestorage.com>
 <Y+3IoOd02iFGNLnC@infradead.org>
 <20230216192702.GA801590@dev-ushankar.dev.purestorage.com>
 <Y++oTz0ck9OGE4Se@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y++oTz0ck9OGE4Se@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 17 2023 at 11:16P -0500,
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Feb 16, 2023 at 12:27:02PM -0700, Uday Shankar wrote:
> >  * Description:
> >  *    @rq may have been made based on weaker limitations of upper-level queues
> >  *    in request stacking drivers, and it may violate the limitation of @q.
> >  *    Since the block layer and the underlying device driver trust @rq
> >  *    after it is inserted to @q, it should be checked against @q before
> >  *    the insertion using this generic function.
> >  *
> >  *    Request stacking drivers like request-based dm may change the queue
> >  *    limits when retrying requests on other queues. Those requests need
> >  *    to be checked against the new queue limits again during dispatch.
> >  */.
> > 
> > Is this concern no longer relevant?
> 
> The concern is still valid, but it does not refer to the debug check.
> It refers to recalculating nr_phys_segments using
> blk_recalc_rq_segments, and the fact that any driver using this
> interface needs to stack its limits properly.

It is a negative check that you're calling a debug check.

Much easier to address a bug in a driver when seeing this message than
figuring it out after more elaborate hunting. Not seeing the downside
of preserving/fixing given it is a quick limit check. *shrug*
