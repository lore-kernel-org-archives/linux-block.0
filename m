Return-Path: <SRS0=8nL5=DK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1A3C46466
	for <linux-block@archiver.kernel.org>; Sat,  3 Oct 2020 00:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997AC206DC
	for <linux-block@archiver.kernel.org>; Sat,  3 Oct 2020 00:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601683320;
	bh=YarLC7J+uN1jSYC1aDZSX885mquzRD1NzzjMUASoJ7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zXW0lnIcpOtb9eWcfErW5Qqnq+6ANhnx5W+zR9BM6r6AgomWlu6nhnkWKjxe/pM6A
	 s3glpfonEd6hUw5xiF0YKnejoPqkhL2x7GAGBBe0v3g/KiJDqcppOJG6d+GtF3DnzL
	 uRhxaSGPg1Eg7iziVlDQ7PJ6/o984/ovLdASO60E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgJCACA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 20:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJCAB7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 20:01:59 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEEA5206DB;
        Sat,  3 Oct 2020 00:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601683319;
        bh=YarLC7J+uN1jSYC1aDZSX885mquzRD1NzzjMUASoJ7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kg4snDc1gpLzKh+ReaG+iKy3IPg5KJiK/YD1x3IDWjC8loKB2qKN1BxoN3ybnXYtO
         6C55n9psbbELbqSRFSacLtCBgQ+GdTCrRbVc/Q0HQ7GzH5uG6+v2qJSuVCrnSgE0FZ
         rbWsjjtaE8EDKhYlHWRz0hMsGrHVH/s4SMG1qSUM=
Date:   Fri, 2 Oct 2020 19:07:48 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] block: scsi_ioctl: Avoid the use of one-element
 arrays
Message-ID: <20201003000748.GB13557@embeddedor>
References: <20201002231033.GA6273@embeddedor>
 <ea92a55b-d12c-357e-62b2-879643ae18ce@kernel.dk>
 <20201003000338.GA13557@embeddedor>
 <c06da705-3151-0902-066a-92d2e7c558bd@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06da705-3151-0902-066a-92d2e7c558bd@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 02, 2020 at 05:58:33PM -0600, Jens Axboe wrote:
> >>> -	void			__user *reserved[1];	/* unused, actually */
> >>> +	union {
> >>> +		void		__user *reserved[1];	/* unused, actually */
> >>> +		void            __user *unused;
> >>> +	};
> >>
> >> What's the point of this union, why not just turn it into
> >>
> >> 	void *			__user *unused;
> >>
> >> ?
> > 
> > I just don't want to take any chances of breaking any user-space
> > application that, for some reason, may be considering that field.
> 
> I guess that's a valid concern, who knows what applications are doing
> to an ignored field.
> 
> I'll apply it, thanks.

Awesome. :)

Thanks.
--
Gustavo
