Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3303C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 08:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiCNIG0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 04:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbiCNIEv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 04:04:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C54338E;
        Mon, 14 Mar 2022 01:02:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF0DB68AFE; Mon, 14 Mar 2022 09:02:09 +0100 (CET)
Date:   Mon, 14 Mar 2022 09:02:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: remove fs.f_write_hint
Message-ID: <20220314080209.GC4921@lst.de>
References: <20220307104701.607750-1-hch@lst.de> <20220307104701.607750-3-hch@lst.de> <Yi1Dc0x9j5bPAlQz@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi1Dc0x9j5bPAlQz@zeniv-ca.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 13, 2022 at 01:05:55AM +0000, Al Viro wrote:
> On Mon, Mar 07, 2022 at 11:47:01AM +0100, Christoph Hellwig wrote:
> > The value is now completely unused except for reporting it back through
> > the F_GET_FILE_RW_HINT ioctl, so remove the value and the two ioctls
> > for it.
> 
> Obvious question - which userland code issues these ioctls?  I obviously
> like the series, but...

The only places I've ever found are fio and ceph.  Despite all the noise
about Android, the google code search for Android does not actually find
a user there.
