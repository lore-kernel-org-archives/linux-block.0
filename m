Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A8DC433F5
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 11:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A110561131
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 11:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhKIMBw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 07:01:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47288 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhKIMBv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 07:01:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6564221B08;
        Tue,  9 Nov 2021 11:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636459145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWfOoKUSMAxQs7BfFXviialmW/N6MLWRRUypkIbqsfQ=;
        b=Js7uvoCnBi18AlY3u61jvZbDkmh+MNi26trD+kJ0QWimNTdbp9bXzjBrAhMJGAJPJ27+/r
        GLf0w+OjPGAhkBmGYsoJ2Yk0RrTVg0zGv5XlbMjLQtsRjs8kOIvtks4EeXUIXFvuhMjrpT
        vGESrgTrG9+nIl8D/TBSusE+NFw590w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636459145;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kWfOoKUSMAxQs7BfFXviialmW/N6MLWRRUypkIbqsfQ=;
        b=gATf/+brKN/XcYO2iQiFoK34ZjSORlGdlKRsTf3gzur1xYX87ee15Viy62DR0tKWNnnkgg
        loPUj/i4M1u5wFAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 2FB72A3B83;
        Tue,  9 Nov 2021 11:59:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BC3191E14ED; Tue,  9 Nov 2021 12:59:04 +0100 (CET)
Date:   Tue, 9 Nov 2021 12:59:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] block: Fix stale page cache of discard or zero out
 ioctl
Message-ID: <20211109115904.GC5955@quack2.suse.cz>
References: <20211109104723.835533-1-shinichiro.kawasaki@wdc.com>
 <YYpWbnPK+K1kQ3Z4@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYpWbnPK+K1kQ3Z4@T590>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 09-11-21 19:07:26, Ming Lei wrote:
> On Tue, Nov 09, 2021 at 07:47:21PM +0900, Shin'ichiro Kawasaki wrote:
> > When BLKDISCARD or BLKZEROOUT ioctl race with data read, stale page cache is
> > left. This patch series have two fox patches for the stale page cache. Same
> > fix approach was used as blkdev_fallocate() [1].
> > 
> > [1] https://marc.info/?l=linux-block&m=163236463716836
> > 
> > Shin'ichiro Kawasaki (2):
> >   block: Hold invalidate_lock in BLKDISCARD ioctl
> >   block: Hold invalidate_lock in BLKZEROOUT ioctl
> > 
> >  block/ioctl.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> Yeah, the discard ioctl needs such fixes too, seems it isn't triggered
> in the test disk of my test VM when running block/009.
> 
> BTW, BLKRESETZONE may need the fix too.

Yeah, it seems like that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
