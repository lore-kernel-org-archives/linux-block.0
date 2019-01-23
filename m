Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE1CC282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 06:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8A4217F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 06:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548225682;
	bh=w95aomDotNNlRN8BZfBpmxdo3zXnrvA461VFT2+2Xm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=omOu32SKKb0CqOurtf/x1XB9gRtHeFMsnuGvWKMQi6AcAoa+XFcaPIWS5wZoNfc85
	 7Mds0b2/Uj0h6BULDt5tOOJRiKhjIxzXvYSCOaMwVMlx3vFRFIIgsO2N1teMeX4t2b
	 5fgce/CE/7onx5S9yF6smcHGT2eLJ1x1rgWNpLtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfAWGlV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 01:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfAWGlV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 01:41:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238BD21019;
        Wed, 23 Jan 2019 06:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548225680;
        bh=w95aomDotNNlRN8BZfBpmxdo3zXnrvA461VFT2+2Xm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDsTiLUabxMVs5jpfYIqbxroWxaRQpSz7Jqf95YMji67P3UN/ZFUMvl2vgWoYx35+
         cHdEfodg6v1oC4E3Y6jiQbsepmvHwTlFDguFO+ZhFv1wzTM6lnMJIqI3NnVFTXM8GA
         FrunSAwVVEcabO4UQjXxIp8U2bfhMmPzrOa1V7Us=
Date:   Wed, 23 Jan 2019 07:41:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org, "Ed L. Cashin" <ed.cashin@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: aoe: no need to check return value of
 debugfs_create functions
Message-ID: <20190123064118.GC26046@kroah.com>
References: <20190122152151.16139-5-gregkh@linuxfoundation.org>
 <20190122232933.GC5884@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122232933.GC5884@vader>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 22, 2019 at 03:29:33PM -0800, Omar Sandoval wrote:
> On Tue, Jan 22, 2019 at 04:21:04PM +0100, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: "Ed L. Cashin" <ed.cashin@acm.org>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: linux-block@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/block/aoe/aoeblk.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> > index e2c6aae2d636..b602646bfa04 100644
> > --- a/drivers/block/aoe/aoeblk.c
> > +++ b/drivers/block/aoe/aoeblk.c
> > @@ -207,14 +207,7 @@ aoedisk_add_debugfs(struct aoedev *d)
> >  	else
> >  		p++;
> >  	BUG_ON(*p == '\0');
> > -	entry = debugfs_create_file(p, 0444, aoe_debugfs_dir, d,
> > -				    &aoe_debugfs_fops);
> > -	if (IS_ERR_OR_NULL(entry)) {
> > -		pr_info("aoe: cannot create debugfs file for %s\n",
> > -			d->gd->disk_name);
> > -		return;
> > -	}
> > -	BUG_ON(d->debugfs);
> > +	debugfs_create_file(p, 0444, aoe_debugfs_dir, d, &aoe_debugfs_fops);
> >  	d->debugfs = entry;
> 
> Now entry is uninitialized here when we assign it to d->debugfs.

Ah, good catch, I'll go fix this up and post a v2, sorry about that.

greg k-h
