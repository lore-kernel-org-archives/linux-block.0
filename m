Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08EDC433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 12:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJCMwg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 08:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiJCMwe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 08:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BBA3B946
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 05:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664801538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LWI5T1sagJQQtT9F8e+DNVpGWonAVpt6zwpHx5ib+Ck=;
        b=dsi5oN8UX0a5Up/2VW9+GAJtwKP/tkF+y6MoUKHm6rq3yJEW8RyArWjet91E1sVACTH/aX
        M1NnhQBhNHAL744O0rdCFi69o2aRBefkK3emtOmLIAnJGn1PDzB3DSPh5cPU6f7lNJZ1bn
        84RZ4XDu4tVOHPwKVFeRMnEeQ2wlteA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-259-dUYEr_wdMXOKWDQqzTaM_Q-1; Mon, 03 Oct 2022 08:52:17 -0400
X-MC-Unique: dUYEr_wdMXOKWDQqzTaM_Q-1
Received: by mail-qv1-f71.google.com with SMTP id em2-20020ad44f82000000b004af5338777cso6812080qvb.4
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 05:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LWI5T1sagJQQtT9F8e+DNVpGWonAVpt6zwpHx5ib+Ck=;
        b=ukKm7FS6G7Lx5zmxlFM5xZS5edIr/D8WmoQyX1iw7X7vYhQ+Zy8UNPZuK6+Iuv7R15
         iMnj7zj6d+BwNG2Vx6H56ZxKaHuYStjZESwULTLW2js/MwcXkZMEl4SOr95LgbQFG583
         C1HpkvU02NkrprEXLppHLn+2P2ANkMKHGTWiEgpN8+Fx2g74julLHhX57DpUOMt+9yyA
         8l77k/XvfpVsojwuBwBAhPDdtMClTbF5gsVISP5AsdfDPHRaUtFDx/phwtY/xIT3rVxf
         2vohtP75fc1HYcihFIIztmA5sk+OOYQAzxsz2QCxd6kPOYGRD078RVyxv9AEBk7FVEHi
         ECrQ==
X-Gm-Message-State: ACrzQf3/47Mp0ysMsSbmilYOMfJB1ij1nUsCF0FFjBXThwV63w0xvJn8
        wX83har1LS6fChe2H9N9tfgEJfW2IXrUeuIFt3tQz3p9hwYisEIMvD1NSsbPr1na1T4s6BlQcuR
        fUh1qsRexZD2wpfbvxIHFrNk=
X-Received: by 2002:ac8:5f48:0:b0:35d:1b11:6ae5 with SMTP id y8-20020ac85f48000000b0035d1b116ae5mr15866580qta.247.1664801536604;
        Mon, 03 Oct 2022 05:52:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6W9kp8Pz+Wo9CRSIYVIQDHWRVzW5lvdk95YrX7f9CkHRpn284zpUCFot5EYE7MfO7vNzxpQg==
X-Received: by 2002:ac8:5f48:0:b0:35d:1b11:6ae5 with SMTP id y8-20020ac85f48000000b0035d1b116ae5mr15866570qta.247.1664801536340;
        Mon, 03 Oct 2022 05:52:16 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id u27-20020a05622a199b00b0034305a91aaesm10089689qtc.83.2022.10.03.05.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 05:52:15 -0700 (PDT)
Date:   Mon, 3 Oct 2022 08:52:13 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Nico Pache <npache@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH] block: avoid sign extend problem with default queue
 flags mask
Message-ID: <Yzra/TsOxX5JCIlf@bfoster>
References: <20220930150345.854021-1-bfoster@redhat.com>
 <5b7798a8-c9e1-530d-3926-856294f779d1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7798a8-c9e1-530d-3926-856294f779d1@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 30, 2022 at 03:33:29PM -0600, Jens Axboe wrote:
> On 9/30/22 9:03 AM, Brian Foster wrote:
> > request_queue->queue_flags is an 8-byte field. Most queue flag
> > modifications occur through bit field helpers, but default flags can
> > be logically OR'd via the QUEUE_FLAG_MQ_DEFAULT mask. If this mask
> > happens to include bit 31, the assignment can sign extend the field
> > and set all upper 32 bits.
> > 
> > This exact problem has been observed on a downstream kernel that
> > happens to use bit 31 for QUEUE_FLAG_NOWAIT. This is not an
> > immediate problem for current upstream because bit 31 is not
> > included in the default flag assignment (and is not used at all,
> > actually). Regardless, fix up the QUEUE_FLAG_MQ_DEFAULT mask
> > definition to avoid the landmine in the future.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > Just to elaborate, I ran a quick test to change QUEUE_FLAG_NOWAIT to use
> > bit 31. With that change but without this patch, I see the following
> > queue state:
> > 
> > # cat /sys/kernel/debug/block/vda/state
> > SAME_COMP|IO_STAT|INIT_DONE|WC|STATS|REGISTERED|30|NOWAIT|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63
> > 
> > And then with the patch applied:
> > 
> > # cat /sys/kernel/debug/block/vda/state
> > SAME_COMP|IO_STAT|INIT_DONE|WC|STATS|REGISTERED|30|NOWAIT
> > 
> > Thanks.
> > 
> > Brian
> > 
> >  include/linux/blkdev.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index 84b13fdd34a7..28c3037cb25c 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -580,9 +580,9 @@ struct request_queue {
> >  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> >  #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
> >  
> > -#define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
> > -				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> > -				 (1 << QUEUE_FLAG_NOWAIT))
> > +#define QUEUE_FLAG_MQ_DEFAULT	((1ULL << QUEUE_FLAG_IO_STAT) |		\
> > +				 (1ULL << QUEUE_FLAG_SAME_COMP) |	\
> > +				 (1ULL << QUEUE_FLAG_NOWAIT))
> 
> Shouldn't this just be 1UL << foo? The queue_flags are not 8-bytes,
> they are unsigned long. That happens to be 8-bytes on 64-bit archs,
> but it's 4-bytes on 32-bit archs.
> 

Oops.. yes, that makes sense. I guess that means we shouldn't really
expect to see anything use the upper 32 bits. The extension still makes
the state output look wonky in the (1 << 31) case, so I'll send a v2
with that fixed..

Brian

> -- 
> Jens Axboe
> 
> 

