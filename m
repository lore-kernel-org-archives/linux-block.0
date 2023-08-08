Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCF3C04A94
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 17:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjHHR5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjHHR4o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 13:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596CFBF579
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 09:25:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A45146242D
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 08:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF0FC433C7;
        Tue,  8 Aug 2023 08:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691482139;
        bh=01W2hqms8ZqWd00aCRj2aWotAjT/HqjOmCQ8l6gmh14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRL9wCGrwqWzwHC2s/LKjqv3DIXoaU1m1eE2ZfUKy5RP6HxhtgKGbkeEm992lG7y6
         Sa2vW/koBPgfvyTvEwx1rfxzzVrvU8cQwwcwt109Am4XzNo0qTpaxfXVtA6c6lCxqb
         2Xb37oJySVLIYEvtEMLb07T2TVeN24n4/helYTDY=
Date:   Tue, 8 Aug 2023 10:08:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        nbd@other.debian.org
Subject: Re: [PATCH v1] drivers: block: Updates return value check
Message-ID: <2023080841-preacher-lunchroom-7c8c@gregkh>
References: <20230806122351.157168-1-atulpant.linux@gmail.com>
 <2023080600-pretext-corporal-61e3@gregkh>
 <20230807114420.GA5826@atom0118>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807114420.GA5826@atom0118>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 07, 2023 at 05:14:20PM +0530, Atul Kumar Pant wrote:
> On Sun, Aug 06, 2023 at 03:36:18PM +0200, Greg KH wrote:
> > On Sun, Aug 06, 2023 at 05:53:51PM +0530, Atul Kumar Pant wrote:
> > > Updating the check of return value from debugfs_create_dir
> > > to use IS_ERR.
> > 
> > Why?
> > 
> > > 
> > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > ---
> > >  drivers/block/nbd.c     | 4 ++--
> > >  drivers/block/pktcdvd.c | 2 +-
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > > index 9c35c958f2c8..65ecde3e2a5b 100644
> > > --- a/drivers/block/nbd.c
> > > +++ b/drivers/block/nbd.c
> > > @@ -1666,7 +1666,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
> > >  		return -EIO;
> > >  
> > >  	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
> > > -	if (!dir) {
> > > +	if (IS_ERR(dir)) {
> > >  		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
> > >  			nbd_name(nbd));
> > >  		return -EIO;
> > 
> > This isn't correct, sorry.  Please do not make this change.
> > 
> > > @@ -1692,7 +1692,7 @@ static int nbd_dbg_init(void)
> > >  	struct dentry *dbg_dir;
> > >  
> > >  	dbg_dir = debugfs_create_dir("nbd", NULL);
> > > -	if (!dbg_dir)
> > > +	if (IS_ERR(dbg_dir))
> > >  		return -EIO;
> > 
> > Again, not corrct.
> > 
> > >  	nbd_dbg_dir = dbg_dir;
> > > diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> > > index d5d7884cedd4..69e5a100b3cf 100644
> > > --- a/drivers/block/pktcdvd.c
> > > +++ b/drivers/block/pktcdvd.c
> > > @@ -451,7 +451,7 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
> > >  	if (!pkt_debugfs_root)
> > >  		return;
> > >  	pd->dfs_d_root = debugfs_create_dir(pd->name, pkt_debugfs_root);
> > > -	if (!pd->dfs_d_root)
> > > +	if (IS_ERR(pd->dfs_d_root))
> > >  		return;
> > 
> > Also not correct.
> > 
> > Why check the return value at all?  As this check has always been wrong,
> > why are you wanting to keep it?
> 
>     I'll check the code again. I was not aware that this check is wrong,
>     so just tried to fix this based on return value of
>     debugfs_create_dir.

The return value of debugfs_create_dir() should never need to be checked
at all.  The value passed in can be later used in any debugfs call
safely, be it an error or success.  The kernel logic should NOT change
based on if debugfs is working properly or not.

So for stuff like this, where the check is obviously wrong (i.e. it's
never caught an error, it's even more of a good idea to remove the
check.

> > 
> > Also, you never responded to our previous review comments, why not?  To
> > ignore people is not generally considered a good idea :(
> 
>     I might have missed seeing your comments hence I did not reply back.
>     Please accept my sincere apologies for this.

Oops, nope, my apologies, this was my fault.  I got you confused with a
different developer sending patches to the kernel-mentees mailing list
with the same first name.  I should have checked better, again my fault,
sorry.

So all is good with your responses, but you should fix these up to NOT
check the return value at all.

thanks,

greg k-h
