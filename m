Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82104C35257
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 23:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B312206CD
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601683073;
	bh=D69kYhvZhty/rRcWBokfk6DHbfSvto2f9RsRcfYH5dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RxMAgyAPWKVRp0DxHw3aG2Va5/ff++hw4FysAdojE+jcscidsgfZV1pHv79msxnPc
	 /EcCZa4GPQCECuYTC+Xvc+s6+KIiIl15jJW6/ewdl9Fdc5SobEY1mKxPS/WnNCK4ah
	 j5w7teV1bj04dkpH1aTyQFYOiutHTZyma5sWp0+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgJBX5u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 19:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBX5t (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 19:57:49 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC3A0206B7;
        Fri,  2 Oct 2020 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601683069;
        bh=D69kYhvZhty/rRcWBokfk6DHbfSvto2f9RsRcfYH5dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhMNZf3GW4d8DjbjPwhSSeOCla2skLZ5iKfbM6AzAWJrJFyrZd7UmhLS3uIatWNFF
         jeUckbfdf7oIdX7X4E0HjuZXNVPFS5tckNZcY16uUzUvd/2C/60VcZSmcUxqdN4Kbf
         9eQFYpHibNELjiTCG3f9gYUvizFACwMNF0yQBBc4=
Date:   Fri, 2 Oct 2020 19:03:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] block: scsi_ioctl: Avoid the use of one-element
 arrays
Message-ID: <20201003000338.GA13557@embeddedor>
References: <20201002231033.GA6273@embeddedor>
 <ea92a55b-d12c-357e-62b2-879643ae18ce@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea92a55b-d12c-357e-62b2-879643ae18ce@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 02, 2020 at 05:53:05PM -0600, Jens Axboe wrote:
> On 10/2/20 5:10 PM, Gustavo A. R. Silva wrote:
> > diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
> > index 2817230148fd..6c34f6e2f1f7 100644
> > --- a/include/uapi/linux/cdrom.h
> > +++ b/include/uapi/linux/cdrom.h
> > @@ -289,7 +289,10 @@ struct cdrom_generic_command
> >  	unsigned char		data_direction;
> >  	int			quiet;
> >  	int			timeout;
> > -	void			__user *reserved[1];	/* unused, actually */
> > +	union {
> > +		void		__user *reserved[1];	/* unused, actually */
> > +		void            __user *unused;
> > +	};
> 
> What's the point of this union, why not just turn it into
> 
> 	void *			__user *unused;
> 
> ?

I just don't want to take any chances of breaking any user-space
application that, for some reason, may be considering that field.

--
Gustavo
