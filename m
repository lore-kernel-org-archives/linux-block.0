Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BDDC4332B
	for <linux-block@archiver.kernel.org>; Wed,  3 Mar 2021 16:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBEB764E74
	for <linux-block@archiver.kernel.org>; Wed,  3 Mar 2021 16:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377475AbhCCQjc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Mar 2021 11:39:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:36652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231768AbhCCPsA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Mar 2021 10:48:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614786413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eItB/OW8zK7jJR07Cs8xBdphkt5Qij7fbxg+T8AEzVY=;
        b=OtxuuN/BZeM+elMePOkzXDWBWt7q3ekdCmcm02GVM/N5R1vw/RnlY8InHlfW38IhIkZyNu
        RgwX1a9YCMU8RH2L8owf6kj+0GiIKSHm+TgOpk80edUWLkVQ+WTsoSDSvMupAhh58Ickgg
        BH+94Gwn1ZUj3EvgtRAAYYkxLM2hJbk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB641AD29;
        Wed,  3 Mar 2021 15:46:51 +0000 (UTC)
Date:   Wed, 3 Mar 2021 16:46:45 +0100
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org
Subject: Re: [PATCH] swap: fix swapfile read/write offset
Message-ID: <YD+vZW2bJsmpCGn5@technoir>
References: <6f9da9c6-c6c5-08fe-95ea-940954456c40@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f9da9c6-c6c5-08fe-95ea-940954456c40@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 02, 2021 at 03:36:19PM -0700, Jens Axboe wrote:
> We're not factoring in the start of the file for where to write and
> read the swapfile, which leads to very unfortunate side effects of
> writing where we should not be...
> 
> Fixes: 48d15436fde6 ("mm: remove get_swap_bio")

Presumably the usage of swap_page_sector was already affecting swap on
blockdevs that implement rw_page (currently brd, zram, btt, pmem), so it
may worth adding:

Fixes: dd6bd0d9c7db ("swap: use bdev_read_page() / bdev_write_page()")
Cc: <stable@vger.kernel.org> # v3.16+

for backporting, since it also affects stable.
