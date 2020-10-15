Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEE1C433DF
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 21:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96F42076A
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 21:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFCkhlAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgJOVzk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 17:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgJOVzk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 17:55:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4BAC0613CF
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 14:55:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l18so153648pgg.0
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2020 14:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mp0fFCaPEBpQGNEbuV9IgZPXZ47zhWeprp5HxFaRp04=;
        b=wFCkhlAYm/QEhKkK6Ma2sXLBVRZbAk1HDW8YSC0qUO2cQPVCSZb9D4YwWZT07c4j1D
         7FndbErn3dLyTVrYVcSSQZfWI8dkvJGaogQ/UtijAHbKNtdswZMTc+HpxSrT+jELb0eT
         i9uK0yNCPv0duyegRAj/bsAneOnbDFYM1nUMzea8n8vqCiDNpZ14N4GxJ1an2cBs+bpX
         CWUUTUrvCY3OhGR0IYV1zqigeBFQzl+xwr950qPZwMDIkPhF1/yff8CAGT8AYqCH1oN9
         CtgJRTdViZY9cMHeI7X4jyUrqYaOTvIo+YXxst32itDqkU+inAjqEGESOa346szaOR0Q
         AWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mp0fFCaPEBpQGNEbuV9IgZPXZ47zhWeprp5HxFaRp04=;
        b=HTbMkxq9NV6ZcBRG6HKEcxXSw+7yCJXA58aURzCT+HNC/h/h/PtkCCQsGzss9Vknc/
         ZdSE3EmrnKrwA9rM4hoJAM13ZlPYB/QpneSZqYN4k8i1/4a8qvSvb4Er5HF3ST6a7+hX
         29WXTuW+GmazUsnAD+yj6Z1xxt+vtvSS8CJvMwtIg9ZitAxaTFxkVy1P5Zn47buX+Tti
         28Fshfn8QaR0A2PgKJ29xjDHn1qDhnVhwUMsjKqrltndpV++6hvvIomyiBiGLJi2rIJG
         4oJE2UONuta/4nklUXSbKYhJbXelEiTIwScI7mm9Qfzdg839BJUf951cfcR8Y61FsKoD
         qhdA==
X-Gm-Message-State: AOAM5339FGUJz/8tCF0BEgwoKfHfWFlP3qq2nWQ4zN9W49nFt4aZaSQx
        PYOx/cV1e96s4cMbO+qw2uyiHw==
X-Google-Smtp-Source: ABdhPJxLXVcVr8KojpvEjCXdEZ6KAspUKoe2F0+QMs61OvnoBOXCEoHxSWNtaR7ijwwz2xclViQPrQ==
X-Received: by 2002:a62:7b11:0:b029:156:3610:7e25 with SMTP id w17-20020a627b110000b029015636107e25mr614898pfc.53.1602798939559;
        Thu, 15 Oct 2020 14:55:39 -0700 (PDT)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id js21sm303276pjb.14.2020.10.15.14.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 14:55:38 -0700 (PDT)
Date:   Thu, 15 Oct 2020 21:55:35 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20201015215535.GA48329@google.com>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-3-satyat@google.com>
 <20200924012103.GE10500@redhat.com>
 <20200924074810.GB1894729@google.com>
 <20200924134021.GA13849@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924134021.GA13849@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 24, 2020 at 09:40:22AM -0400, Mike Snitzer wrote:
> On Thu, Sep 24 2020 at  3:48am -0400,
> Satya Tangirala <satyat@google.com> wrote:
> 
> > On Wed, Sep 23, 2020 at 09:21:03PM -0400, Mike Snitzer wrote:
> > > On Wed, Sep 09 2020 at  7:44pm -0400,
> > > Satya Tangirala <satyat@google.com> wrote:
> > > 
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Update the device-mapper core to support exposing the inline crypto
> > > > support of the underlying device(s) through the device-mapper device.
> > > > 
> > > > This works by creating a "passthrough keyslot manager" for the dm
> > > > device, which declares support for encryption settings which all
> > > > underlying devices support.  When a supported setting is used, the bio
> > > > cloning code handles cloning the crypto context to the bios for all the
> > > > underlying devices.  When an unsupported setting is used, the blk-crypto
> > > > fallback is used as usual.
> > > > 
> > > > Crypto support on each underlying device is ignored unless the
> > > > corresponding dm target opts into exposing it.  This is needed because
> > > > for inline crypto to semantically operate on the original bio, the data
> > > > must not be transformed by the dm target.  Thus, targets like dm-linear
> > > > can expose crypto support of the underlying device, but targets like
> > > > dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> > > > 
> > > > When a key is evicted from the dm device, it is evicted from all
> > > > underlying devices.
> > > > 
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > Co-developed-by: Satya Tangirala <satyat@google.com>
> > > > Signed-off-by: Satya Tangirala <satyat@google.com>
> > > > ---
> > > >  block/blk-crypto.c              |  1 +
> > > >  block/keyslot-manager.c         | 34 ++++++++++++
> > > >  drivers/md/dm-core.h            |  4 ++
> > > >  drivers/md/dm-table.c           | 52 +++++++++++++++++++
> > > >  drivers/md/dm.c                 | 92 ++++++++++++++++++++++++++++++++-
> > > >  include/linux/device-mapper.h   |  6 +++
> > > >  include/linux/keyslot-manager.h |  7 +++
> > > >  7 files changed, 195 insertions(+), 1 deletion(-)
> > > > 
> 
> > > > diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> > > > index c4ef1fceead6..4542050eebfc 100644
> > > > --- a/drivers/md/dm-core.h
> > > > +++ b/drivers/md/dm-core.h
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/kthread.h>
> > > >  #include <linux/ktime.h>
> > > >  #include <linux/blk-mq.h>
> > > > +#include <linux/keyslot-manager.h>
> > > >  
> > > >  #include <trace/events/block.h>
> > > >  
> > > > @@ -49,6 +50,9 @@ struct mapped_device {
> > > >  
> > > >  	int numa_node_id;
> > > >  	struct request_queue *queue;
> > > > +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> > > > +	struct blk_keyslot_manager ksm;
> > > > +#endif
> > > >  
> > > >  	atomic_t holders;
> > > >  	atomic_t open_count;
> > > 
> > > Any reason you placed the ksm member where you did?
> >
> > As in, any reason why it's placed right after the struct request_queue
> > *queue? The ksm is going to be set up in the request_queue and is a part
> > of the request_queue is some sense, so it seemed reasonable to me to
> > group them together....but I don't think there's any reason it *has* to
> > be there, if you think it should be put elsewhere (or maybe I'm
> > misunderstanding your question :) ).
> 
> Placing the full struct where you did is highly disruptive to the prior
> care taken to tune alignment of struct members within mapped_device.
> 
Ah I see - sorry about that! I ended up removing it entirely in the next
version of this series while trying to address this and your other
comments :). The next version is at

https://lore.kernel.org/linux-block/20201015214632.41951-5-satyat@google.com/

> Switching to a pointer will be less so, but even still it might be best
> to either find a hole in the struct (not looked recently, but there may
> not be one) or simply put it at the end of the structure.
> 
> The pahole utility is very useful for this kind of struct member
> placement, etc.  But it is increasingly unavailable in modern Linux
> distros...
> 
> Mike
> 
