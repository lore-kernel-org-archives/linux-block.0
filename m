Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37043C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 14:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345676AbiCPOkN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbiCPOkN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 10:40:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7D126EC
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 07:38:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 39E9E210E4;
        Wed, 16 Mar 2022 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647441536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U3DYS1wra3HteONxbt5axsZebUsobHCA1ZdjrX+inLY=;
        b=YvZ2kLZpwY1X+5nDwfp+fDxeL7bmxTOpRyle/CvqYlkk+nxxC54BK3VBmUsSej7q/JVvOX
        4DPOKPx+HSWLUJ0inbQ8Mkjh9NO96FLO7qIvGRQIsqfv6XtZCziT87mQAuGaIfhWZJmoBS
        Yfi1QE2hiLunZ6/wDhG+vAi7xJIKxNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647441536;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U3DYS1wra3HteONxbt5axsZebUsobHCA1ZdjrX+inLY=;
        b=xavZ6otUSRPKPE7ZbwF6dCNF3WXMI+rR3CXpTs+032lP/mUifVw3tDE6u1YACcbSn/PZki
        pQR94OpHvYHRwlCg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1D785A3B93;
        Wed, 16 Mar 2022 14:38:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8A199A0615; Wed, 16 Mar 2022 15:38:55 +0100 (CET)
Date:   Wed, 16 Mar 2022 15:38:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 7/8] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220316143855.sqm2dk77rbvxtxh7@quack3.lan>
References: <20220316084519.2850118-1-hch@lst.de>
 <20220316084519.2850118-8-hch@lst.de>
 <20220316112258.6hjksrv7yqiqcncu@quack3.lan>
 <26f0d3da-d45e-72aa-de2f-62ead4d2c25b@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f0d3da-d45e-72aa-de2f-62ead4d2c25b@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 16-03-22 22:14:50, Tetsuo Handa wrote:
> On 2022/03/16 20:22, Jan Kara wrote:
> >> @@ -1244,7 +1244,7 @@ static int loop_clr_fd(struct loop_device *lo)
> >>  	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
> >>  	 * command to fail with EBUSY.
> >>  	 */
> >> -	if (atomic_read(&lo->lo_refcnt) > 1) {
> >> +	if (lo->lo_disk->part0->bd_openers > 1) {
> > 
> > But bd_openers can be read safely only under disk->open_mutex. So for this
> > to be safe against compiler playing nasty tricks with optimizations, we
> > need to either make bd_openers atomic_t or use READ_ONCE / WRITE_ONCE when
> > accessing it.
> 
> Use of READ_ONCE() / WRITE_ONCE() are not for avoiding races but for making
> sure that memory access happens only once. It is data_race() which is needed
> for tolerating and annotating races. For example, data_race(lo->lo_state) is
> needed when accessing lo->lo_state without lo->lo_mutex held.

Well, but another effect of READ_ONCE() / WRITE_ONCE() is that it
effectively forces the compiler to not store any intermediate value in
bd_openers. If you have code like bdev->bd_openers++, and bd_openers has
value say 1, the compiler is fully within its rights if unlocked reader
sees values, 1, 0, 3, 2. It would have to be a vicious compiler but the C
standard allows that and some of the optimizations compilers end up doing
result in code which is not far from this (read more about KCSAN and the
motivation behind it for details). So data_race() annotation is *not*
enough for unlocked bd_openers usage.

> Use of atomic_t for lo->lo_disk->part0->bd_openers does not help, for
> currently lo->lo_mutex is held in order to avoid races. That is, it is
> disk->open_mutex which loop_clr_fd() needs to hold when accessing
> lo->lo_disk->part0->bd_openers.

It does help because with atomic_t, seeing any intermediate values is not
possible even for unlocked readers.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
