Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D28C433F5
	for <linux-block@archiver.kernel.org>; Sat, 19 Feb 2022 19:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiBSTFz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Feb 2022 14:05:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243082AbiBSTFp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Feb 2022 14:05:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA501D0ED
        for <linux-block@vger.kernel.org>; Sat, 19 Feb 2022 11:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uLko/dZ0Rf98FNQFHv/d9+wEAkeVq/RFZGjyQwagef4=; b=LXWBS3Azg/nlgtrwOidYHihPGV
        BFdFo7504ZM5tZrJ6GVyt5tn8ptpA7ukMpiRoYlLBY8Ae8k1tn8jui30vjhfSft7pXstk3iT38leD
        e8VOqEhjWd8w9sgJX1AN3diihHgMaDMih/tGworJTjYMBaevA/6zI/WCzkRGstzd7vQWApl9jUQsq
        SDycxm8jtcZ7W7OgCF/HvpM27Fk+jdH+ayBtwsT3tNm1SCZHiDOnOC0WNxklSya/4RDaQW/u1QNDP
        e95CrW3l168vUP46RoBHv2Gm2Qo3/vnpsrTL2XKiePLpvi1OgAkjhFFRQ64dj8zF8qB7I03ITyvR4
        imNhQWIA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLV2p-00Hb4B-Gk; Sat, 19 Feb 2022 19:05:23 +0000
Date:   Sat, 19 Feb 2022 11:05:23 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        Pankaj Raghav <pankydev8@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: block loopback driver possible regression since next-20220211
Message-ID: <YhE/c0K0FN9j8LFE@bombadil.infradead.org>
References: <YhBfsIqCNsi7D/st@bombadil.infradead.org>
 <cfce5ca9-e845-4b56-e33d-283fee37c3aa@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfce5ca9-e845-4b56-e33d-283fee37c3aa@kernel.dk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 19, 2022 at 09:18:58AM -0700, Jens Axboe wrote:
> On 2/18/22 8:10 PM, Luis Chamberlain wrote:
> > I noticed that since next-20220211 losetup fails at something stupid
> > simple:
> > 
> > losetup $LOOPDEV $DISK
> > 
> > I can't see how the changes on drivers/block/loop.c would cause this,
> > I even tried to revert what I thought would be the only commit which
> > would seem to do a functional change "loop: revert "make autoclear
> > operation asynchronous" but that didn't fix it.
> > 
> > I proceeded to bisecting... but I did this on today's linux-next,
> > and well today's linux-next is hosed even at boot. My bisection then
> > was completley inconclusive since linux-next is pure poop today.
> > 
> > Any ideas though?
> > 
> > Fortunately Linus' tree is fine.
> > 
> > I'm quit afraid that we wouldn't have caught this issue. Seems pretty
> > straight forward. It would seem we don't have such a basic thing on
> > blktests, so I'll go add that...
> 
> My guess would be that it's:
> 
> commit fbdee71bb5d8d054e1bdb5af4c540f2cb86fe296
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Tue Jan 4 08:16:47 2022 +0100
> 
>     block: deprecate autoloading based on dev_t
> 

Indeed. The issue is that dropping that also does not allow the
association of extra custom higher number loop block nodes created manually
even if you *do* load a respective module before use. That is by design
by the commit, since we're stuffing the nasty old probe logic now under the new
CONFIG_BLOCK_LEGACY_AUTOLOAD. Subtle difference, but same deprecation
effect.

I agree with the approach to stuff all this nasty cruft under
BLOCK_LEGACY_AUTOLOAD however I suspect v5.19 might be too soon to tell if we
can nuke it safely by then though.

I'd go so far as to say that we should sadly make
BLOCK_LEGACY_AUTOLOAD=y for a while before going with an axe to kill it.
I think we have a few hidden gems we'll soon discover might need a bit
more time to adjust.

FWIW below is a simple test, which now fails to explain what I mean with
the above.

root@kdevops ~ # cat loop-high-devs.sh 
#!/bin/bash

NUM="8"
LOOPDEV="/dev/loop${NUM}"

modprobe loop
sleep 2

if [[ ! -e $LOOPDEV ]]; then
	mknod $LOOPDEV b 7 $NUM
fi

losetup -d $LOOPDEV 2>/dev/null

DISK="test_loop_${NUM}.img"
rm -f $DISK
truncate -s 10M $DISK
losetup $LOOPDEV $DISK
if [ $? -eq 0 ]; then
	echo "$LOOPDEV ready"
else
	echo "$LOOPDEV failed"
fi

  Luis
