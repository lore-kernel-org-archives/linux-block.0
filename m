Return-Path: <SRS0=JLuE=3D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E1BC33C9E
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 21:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AF924670
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579038771;
	bh=ADmuG+8TueSxoUloNtkKFy+ooo54PCPEldX1LT6pn30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mYbZe2uhxdz6y+xiq+a/HlSZ71kLuQ/Y4ltA5zmKO0stdb+yJMCIt4ag2P6yJzLmP
	 C4BlArxkYAsrhX7rUTF9MBBqBwSrjz4OXDv9DprXPgLiKd4tvdvg3Vr59J6QEGBZ3C
	 sUJv6uAnCi804Ap1pWz5i1nLRdqYLT6tU6cPc2s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANVwv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANVwv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jan 2020 16:52:51 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 683F524658;
        Tue, 14 Jan 2020 21:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579038770;
        bh=ADmuG+8TueSxoUloNtkKFy+ooo54PCPEldX1LT6pn30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYGlYmYB/Rvb3YVPs4ANkYjVHMK/hvse2YTpP/bsaDg7Yuu6nHDogWDSfmz47te/k
         nbhZQRex3i0KiklagvHgoV+ZQAV1LjChZXqSh1RcL9LbvSaR8MF0Fkf7ZFfI3tjtHH
         4efhorDfy5ubD4LTgMpIDjQ1/vKqtRyjZ7t+zKYI=
Date:   Tue, 14 Jan 2020 13:52:48 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     LVM2 development <lvm-devel@redhat.com>, markus.schade@gmail.com,
        ejt@redhat.com, linux-block@vger.kernel.org, dm-devel@redhat.com,
        joe.thornber@gmail.com, dm-devel@lists.ewheeler.net
Subject: Re: kernel BUG at drivers/md/persistent-data/dm-space-map-disk.c:178
Message-ID: <20200114215248.GK41220@gmail.com>
References: <alpine.LRH.2.11.1909251814220.15810@mx.ewheeler.net>
 <alpine.LRH.2.11.1912201829300.26683@mx.ewheeler.net>
 <alpine.LRH.2.11.1912270137420.26683@mx.ewheeler.net>
 <alpine.LRH.2.11.1912271946380.26683@mx.ewheeler.net>
 <20200107103546.asf4tmlfdmk6xsub@reti>
 <20200107104627.plviq37qhok2igt4@reti>
 <20200107122825.qr7o5d6dpwa6kv62@reti>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107122825.qr7o5d6dpwa6kv62@reti>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 07, 2020 at 12:28:25PM +0000, Joe Thornber wrote:
> On Tue, Jan 07, 2020 at 10:46:27AM +0000, Joe Thornber wrote:
> > I'll get a patch to you later today.
> 
> Eric,
> 
> Patch below.  I've run it through a bunch of tests in the dm test suite.  But
> obviously I have never hit your issue.  Will do more testing today.
> 
> - Joe
> 
> 
> 
> Author: Joe Thornber <ejt@redhat.com>
> Date:   Tue Jan 7 11:58:42 2020 +0000
> 
>     [dm-thin, dm-cache] Fix bug in space-maps.
>     
>     The space-maps track the reference counts for disk blocks.  There are variants
>     for tracking metadata blocks, and data blocks.
>     
>     We implement transactionality by never touching blocks from the previous
>     transaction, so we can rollback in the event of a crash.
>     
>     When allocating a new block we need to ensure the block is free (has reference
>     count of 0) in both the current and previous transaction.  Prior to this patch we
>     were doing this by searching for a free block in the previous transaction, and
>     relying on a 'begin' counter to track where the last allocation in the current
>     transaction was.  This 'begin' field was not being updated in all code paths (eg,
>     increment of a data block reference count due to breaking sharing of a neighbour
>     block in the same btree leaf).
>     
>     This patch keeps the 'begin' field, but now it's just a hint to speed up the search.
>     Instead we search the current transaction for a free block, and then double check
>     it's free in the old transaction.  Much simpler.
> 

I happened to notice this patch is on the linux-dm/for-next branch
(https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=for-next&id=2137c0dcc04b24efb4c38d4b46b7194575718dd5)
and it has:

	Reported-by: Eric Biggers <ebiggers@google.com>

This is wrong, I didn't report this.  I think you meant to put:

	Reported-by: Eric Wheeler <dm-devel@lists.ewheeler.net>

- Eric (the other one)
