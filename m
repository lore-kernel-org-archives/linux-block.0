Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8CFEB64DD
	for <linux-block@archiver.kernel.org>; Mon,  7 Aug 2023 11:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjHGLqC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Aug 2023 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjHGLpt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Aug 2023 07:45:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DDB10FE
        for <linux-block@vger.kernel.org>; Mon,  7 Aug 2023 04:44:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686b879f605so2936968b3a.1
        for <linux-block@vger.kernel.org>; Mon, 07 Aug 2023 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691408668; x=1692013468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOkIol4hR/7Xp5+ZchryLNdE6H11vBt5X3cu3NIuMdw=;
        b=FZAQ6U1Y1GJmYiveH7OoBA/d7SuG2Q4mQa2C8A1p3nqxsUUDi2IaX+mreRbkwecRrX
         mpP9EjkIjcP2hq912NLJVLbR9VXO95Hi8xZACAHBwHdzzqKz2TP5YGL8FyHeflnoBits
         AVcu07vz4ZL/ic0U+wtaGmULdMLRNZf6uu7zc7M3nnGoZafTulK0YVm3C2WytdT+VFN0
         ZUUuS56gkObDy7l8rYRQWv50WoGQep0LUDw3Kk81Z1WR1qT8NbB3D+g9cMlkzSyvHpFF
         6q19Xh/FpWgJXoEAwXFFMb09rsveZujIWSEtwhrWZJcVFvgh+Y252O04PsVGtQITuev5
         8EtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691408668; x=1692013468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOkIol4hR/7Xp5+ZchryLNdE6H11vBt5X3cu3NIuMdw=;
        b=Bb8ANhY41wZdvSZSV1eUKgoq1DWp1bMKNgJw98SnfaqU0BAFIgWZ6TkVgxdmbaDDxq
         F3suaX/WLkvQBIRSTO+pyvfnorFzm6WGLw5m+sx14vYBzz+m3fgdME07C0qbsOjWzAyC
         Vu/2ATYaS6ySH4+vgydnRRxrJVyQ0rLdpW0VOHg7WpYmeYEOecVx5gyWAxEcti8Z4Pvl
         w5nDdVFV3UCt+09sPN+u+D1B+xDrysaWbF/5ICa1dBhMO0d4fhODqBzHyfyeIxP1gk3K
         exBL9UoeeFAnJVq/+CU7jKhbro2A5iL5+UoFfiwqQtJa6z1psgwICtYQTnU26dFfgQO9
         2EOA==
X-Gm-Message-State: AOJu0YyHX5tAc/NqsY8omFj1gNflKsmhlg2+Y9Bvf6W2ZG7bfWlvR8Vl
        jrfFim99BP/sTBiw35zBMrA/uGWVczc=
X-Google-Smtp-Source: AGHT+IG4wOGScrDd781Ew8BOJkUd67naeJwhj+rXjQM3v/SE7uDYrg2SNYLgg04stiJNcFMGbZ/jMw==
X-Received: by 2002:a05:6a00:24c4:b0:682:4b93:a4d3 with SMTP id d4-20020a056a0024c400b006824b93a4d3mr9204926pfv.1.1691408667970;
        Mon, 07 Aug 2023 04:44:27 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:58e9:4d3a:892b:8e74:8cec])
        by smtp.gmail.com with ESMTPSA id z22-20020aa791d6000000b006875493da1fsm6193034pfa.10.2023.08.07.04.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:44:27 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:14:20 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        nbd@other.debian.org
Subject: Re: [PATCH v1] drivers: block: Updates return value check
Message-ID: <20230807114420.GA5826@atom0118>
References: <20230806122351.157168-1-atulpant.linux@gmail.com>
 <2023080600-pretext-corporal-61e3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023080600-pretext-corporal-61e3@gregkh>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 06, 2023 at 03:36:18PM +0200, Greg KH wrote:
> On Sun, Aug 06, 2023 at 05:53:51PM +0530, Atul Kumar Pant wrote:
> > Updating the check of return value from debugfs_create_dir
> > to use IS_ERR.
> 
> Why?
> 
> > 
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> >  drivers/block/nbd.c     | 4 ++--
> >  drivers/block/pktcdvd.c | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 9c35c958f2c8..65ecde3e2a5b 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -1666,7 +1666,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
> >  		return -EIO;
> >  
> >  	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
> > -	if (!dir) {
> > +	if (IS_ERR(dir)) {
> >  		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
> >  			nbd_name(nbd));
> >  		return -EIO;
> 
> This isn't correct, sorry.  Please do not make this change.
> 
> > @@ -1692,7 +1692,7 @@ static int nbd_dbg_init(void)
> >  	struct dentry *dbg_dir;
> >  
> >  	dbg_dir = debugfs_create_dir("nbd", NULL);
> > -	if (!dbg_dir)
> > +	if (IS_ERR(dbg_dir))
> >  		return -EIO;
> 
> Again, not corrct.
> 
> >  	nbd_dbg_dir = dbg_dir;
> > diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
> > index d5d7884cedd4..69e5a100b3cf 100644
> > --- a/drivers/block/pktcdvd.c
> > +++ b/drivers/block/pktcdvd.c
> > @@ -451,7 +451,7 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
> >  	if (!pkt_debugfs_root)
> >  		return;
> >  	pd->dfs_d_root = debugfs_create_dir(pd->name, pkt_debugfs_root);
> > -	if (!pd->dfs_d_root)
> > +	if (IS_ERR(pd->dfs_d_root))
> >  		return;
> 
> Also not correct.
> 
> Why check the return value at all?  As this check has always been wrong,
> why are you wanting to keep it?

    I'll check the code again. I was not aware that this check is wrong,
    so just tried to fix this based on return value of
    debugfs_create_dir.

> 
> Also, you never responded to our previous review comments, why not?  To
> ignore people is not generally considered a good idea :(

    I might have missed seeing your comments hence I did not reply back.
    Please accept my sincere apologies for this.
    I have one confusion though, regarding the comments that you are
    referring to. Are you mentioning about this patch? Re: [PATCH v5] selftests: rtc: Improve rtctest error handling
    Here I got the following response from your email bot -
    Patch submitter, please ignore Markus's suggestion; you do not need to follow it at all.

    Maybe I misunderstood this comment and hence did not reply/do
    anything in response to Markus's comments.
    If you were referring to some other patch then if possible, can you please tell me the
    suject of the patch? I will reply to your comments and will make the
    fixes accordingly.

> 
> greg k-h
