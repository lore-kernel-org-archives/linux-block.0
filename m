Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4337DC433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 17:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05B564E04
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 17:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhBPRu1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:50:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhBPRuY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 12:50:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27F1164DAF;
        Tue, 16 Feb 2021 17:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613497783;
        bh=Am0sK4KyJqJIoqkuEi2qAp1hjiKCUzGPfH2hUly5C/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IeP94X7d6OJrcHaYE73M40AHIF58RZaC0ufkZ/Y4u2PE91/zeUf9ZIwUmDene2MU3
         UtyA9j/H3bB5fts2CHRlAKZRzS74GRswlL6U5RGHaOfFufwYJMJLiql1uEdWxbt9EU
         RG+KIPdGgkbH61FNnnlaJNlsGS+GuSn8cpUL+2zAe4v5xQWSSIPgnRUYmmR7MqAGu/
         xsJfUIZQIkqqb/qxRaKdAa1jwkXhlwUvHhuCaxJG7ClX8/dRwjcf2ZYzYHXx+lMpsz
         Omm2JlmimqCObhrRLTJvDt8exQ0dU4w1nHYFrxeq+EbGuXv6ixZqD/O7OwF6LiSV7J
         4yLF7x7WKs2gw==
Date:   Tue, 16 Feb 2021 09:49:41 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] Revert "block: Do not discard buffers under a mounted
 filesystem"
Message-ID: <20210216174941.GA2708768@dhcp-10-100-145-180.wdc.com>
References: <20210216133849.8244-1-jack@suse.cz>
 <20210216163606.GA4063489@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216163606.GA4063489@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 16, 2021 at 04:36:06PM +0000, Christoph Hellwig wrote:
> On Tue, Feb 16, 2021 at 02:38:49PM +0100, Jan Kara wrote:
> > Apparently there are several userspace programs that depend on being
> > able to call BLKDISCARD ioctl without the ability to grab bdev
> > exclusively - namely FUSE filesystems have the device open without
> > O_EXCL (the kernel has the bdev open with O_EXCL) so the commit breaks
> > fstrim(8) for such filesystems. Also LVM when shrinking LV opens PV and
> > discards ranges released from LV but that PV may be already open
> > exclusively by someone else (see bugzilla link below for more details).
> > 
> > This reverts commit 384d87ef2c954fc58e6c5fd8253e4a1984f5fe02.
> 
> I think that is a bad idea. We fixed the problem for a reason.
> I think the right fix is to just do nothing if the device hasn't been
> opened with O_EXCL and can't be reopened with it, just don't do anything
> but also don't return an error.  After all discard and thus
> BLKDISCARD is purely advisory.

A discard is advisory, but BLKZEROOUT is not, so something different
should happen there. We were also planning to send a patch using this
same pattern for Zone Reset to fix stale page cache issues after the
reset, but we'll wait to see how this settles before sending that.
