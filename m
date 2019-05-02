Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862EFC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 20:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531EC2081C
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 20:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEBUvP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 16:51:15 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40504 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEBUvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 16:51:15 -0400
Received: by mail-it1-f194.google.com with SMTP id k64so5817433itb.5
        for <linux-block@vger.kernel.org>; Thu, 02 May 2019 13:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1edXRnaHapw6mxE7Ykg3KcGAB9chZQflPCtktoyCU8=;
        b=AjxEx0eiegDADIeJPeZcNaRJQw8gO08xfl5UlhZ07MBujcvf2TZfqwuTACeaetlpAW
         Qpvqz4ZgwnOa8pgNanRrpyGh194ga8JMDgTocINwt28b7N9/qjSKXQb6kpwzkvg7lxFu
         vZB2125HVFubYZ/EkjpbPr/mCdx/EGdd0jctO1WOn+7hjJmvEMwK6rBFHgqrCL1RAiOX
         US2m6Q4VW9Yu4Fs6E3Z93N5QG8lwneUZpy+3rcSLo8VfhMaiZoVSaYzNUDfDUxnVs0Ss
         Pw7uJt3uZGXD4dgJvad29bjQIzSLMycTydr0A1I13/jmY1wCAZsSnMkK5K9x92zhn4hC
         go/A==
X-Gm-Message-State: APjAAAWFaIcMirxccbQQ1sFhdn9QyF5MZqlCwyvak30IF18PmEPV0oEY
        lkCLDwvR82xSk7OmfpIqc0WN0A==
X-Google-Smtp-Source: APXvYqxY3bbewIYdpEdGd5JduuJsViERFz23XFvOvbPKbKEcb4Fbg2s3YHrMMnptBzjqS1iAYgJNhA==
X-Received: by 2002:a24:7f8f:: with SMTP id r137mr4240374itc.56.1556830274495;
        Thu, 02 May 2019 13:51:14 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id t196sm5385675ita.4.2019.05.02.13.51.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 02 May 2019 13:51:13 -0700 (PDT)
Date:   Thu, 2 May 2019 14:51:09 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix function name in comment
Message-ID: <20190502205109.GA103782@google.com>
References: <20190502194811.200677-1-rrangel@chromium.org>
 <1556829225.12970.10.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556829225.12970.10.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 02, 2019 at 01:33:45PM -0700, Bart Van Assche wrote:
> On Thu, 2019-05-02 at 13:48 -0600, Raul E Rangel wrote:
> > The comment was out of date.
> > 
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> > 
> >  block/blk-mq.c | 2 +
> >  1 file changed, 1 insertion(), 1 deletion(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 9516304a38ee..0e467ff440a2 100644
> > --- a/block/blk-mq.c
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 9516304a38ee..0e467ff440a2 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -2062,7 +2062,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> >                 list_del_init(&page->lru);
> >                 /*
> >                  * Remove kmemleak object previously allocated in
> > -                * blk_mq_init_rq_map().
> > +                * blk_mq_alloc_rqs().
> >                  */
> >                 kmemleak_free(page_address(page));
> >                 __free_pages(page, page->private);
> 
> Does the entire comment fit on a single 80 column line? In other words, can
> the comment that is spread over four lines be reduced to a single line?
No, it would put it at 91 characters long.

Raul
> 
> Thanks,
> 
> Bart.
