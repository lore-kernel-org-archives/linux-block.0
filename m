Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33914C433EF
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 02:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153B86120E
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 02:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242740AbhKPCnt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Nov 2021 21:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353494AbhKPClf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Nov 2021 21:41:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0D416120E;
        Tue, 16 Nov 2021 02:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637030319;
        bh=gJB5WbN5nWiw+T0RTPCILzHthbXy9EO/5NmxaJV890g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=utTI+2PRwTxwEWhujY2wgCiCqyRTwCElO77Dsrxtx1SwdbGtdLDUrCzsfPu2B9y02
         +pGrvFls0JG1nqfJ32plOLKQbFj4ev8Ghh7alYcAIqeOeM4Xh/77V1/fFADBHTvfxU
         03ItXZkdR+4/1rsoFrhxZODV1e2InlsYhm4bUnbZEQjk39Zr/lUCcRrKgvI8CtnZ2Z
         2z+kj3kqs2kLv8ftCczL9IHaMmXstSmljHUK1npg0CaWDM7bqycTlRlyRZynvm3Zj8
         WqVvk7wlv/1LGC3vB8U5rPR/pRrI7a0FFwgBDxdUCwIeiLserYlcU8HjsdamceVqnI
         oMqYhy6n4/cjA==
Date:   Mon, 15 Nov 2021 19:38:37 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bean Huo <huobean@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH] block: Use REQ_OP_WRITE instead of its integer constant
 1 in op_is_write()
Message-ID: <YZMZrepdF2ppcIba@C02CK6ZVMD6M>
References: <20211115215819.28787-1-huobean@gmail.com>
 <ad266071-4b15-2090-d897-3e1b211b6291@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad266071-4b15-2090-d897-3e1b211b6291@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 16, 2021 at 08:48:56AM +0900, Damien Le Moal wrote:
> On 2021/11/16 6:58, Bean Huo wrote:
> > From: Bean Huo <beanhuo@micron.com>
> > 
> > Use the enums REQ_OP_WRITE in op_is_write() to make it less maintenance
> > requirement and more readable
> > 
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
> > ---
> >  include/linux/blk_types.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > index fe065c394fff..5b5924a7e754 100644
> > --- a/include/linux/blk_types.h
> > +++ b/include/linux/blk_types.h
> > @@ -463,7 +463,7 @@ static inline void bio_set_op_attrs(struct bio *bio, unsigned op,
> >  
> >  static inline bool op_is_write(unsigned int op)
> >  {
> > -	return (op & 1);
> > +	return (op & REQ_OP_WRITE);
> >  }
> 
> See the comment for "enum req_opf":
> 
> /*
>  * Operations and flags common to the bio and request structures.
>  * We use 8 bits for encoding the operation, and the remaining 24 for flags.
>  *
>  * The least significant bit of the operation number indicates the data
>  * transfer direction:
>  *
>  *   - if the least significant bit is set transfers are TO the device
>  *   - if the least significant bit is not set transfers are FROM the device
>  *
>  * If a operation does not transfer data the least significant bit has no
>  * meaning.
>  */
> 
> So using "1" is correct. Using REQ_OP_WRITE is confusing as it seem to imply
> that op_is_write() tests for "op is REQ_OP_WRITE" instead of the intended "op is
> transferring data TO the device". If anything, op_is_write() could be renamed to
> clarify that.

Yeah, REQ_OP_WRITE is a value, not a flag. The op_is_write() tests the data
direction flag, which coincidentally happens to be the same as the current,
somewhat arbitrarily chosen value of REQ_OP_WRITE. The op could just as easily
have been set to 0xff.
