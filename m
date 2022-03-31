Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B913C433EF
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 04:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiCaElo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 00:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCaEln (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 00:41:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9964760ABA
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 21:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+kzcd75UwIvzeY7dMF4oACnVi1yKIIr5AJRiQnzZefY=; b=HNGbhmnl08LbMMrPoo86wp8GI4
        tNzulIpQYwRQJh7fQnTPMlKGZp0fmM10cAkFD9w78pB1dHQloTbMeWsX1wlRxMcPGAoW7mxDOSg6S
        H0TZV50JhzaUTah8ET9mr2Xm9jWM8eASFWSkehRWQan3C28uFhZ5o54w79a2/1rzmn/KgMGesOION
        Yk5gNf+nua+DnMtUDCfH6sOun5dSm7cuDYyeraF9RWR0YI4GTU2LZVFNg2aboBZGHxg8boNqu4iHU
        byVnRTDhx1V2WnqvSxTq+un/kp5xmUxWVnkAuyZ/eJoo/WM4ytDPvGDTNURT23HBKzAssS0aV/MmA
        rOBwUPWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZmbD-000dqJ-EG; Thu, 31 Mar 2022 04:39:55 +0000
Date:   Wed, 30 Mar 2022 21:39:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Mike Snitzer <snitzer@kernel.org>, tj@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: can we reduce bio_set_dev overhead due to bio_associate_blkg?
Message-ID: <YkUwmyrIqnRGIOHm@infradead.org>
References: <YkSK6mU1fja2OykG@redhat.com>
 <YkRM7Iyp8m6A1BCl@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRM7Iyp8m6A1BCl@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 30, 2022 at 08:28:28AM -0400, Dennis Zhou wrote:
> I think cloning is a special case that I might have gotten wrong. If
> there is a bio_set_dev() call after each clone(), then the
> bio_clone_blkg_association() is excess work. We'd need to audit how
> bio_alloc_clone() is being used to be safe. Alternatively, we could opt
> for a bio_alloc_clone_noblkg(), but that's a little bit uglier.

As of Linux 5.18, the cloning interfaces have changed and take
a block devie that the clone is intended to be used for, and bio_set_dev
is mostly (there is a few more sports to be cleaned up in
dm/md/bcache/btrfs) only used for remapping to a new device.

That being said I've eyed the code in bio_associate_blkg a bit and
I've been wondering about some of how it is implemented as well.

Is recursive throttling really a thing?  i.e. we can have cgroup
policies on the upper (e.g. dm) device and then again on the lower
(e.g. nvme device)?  I think the code currently supports that, and
if we want to keep that I don't really see much of a way to avoid
the lookup, but maybe we cn make it faster.
