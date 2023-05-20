Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A32C7EE2A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 05:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjETFw7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 01:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETFw6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 01:52:58 -0400
X-Greylist: delayed 16001 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 May 2023 22:52:57 PDT
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7112F128
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 22:52:57 -0700 (PDT)
Date:   Sat, 20 May 2023 01:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684561975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gfOMCDO+EpRcce+Y4fCgA+EpfItFwpyan/mWDxkdEYM=;
        b=DUhavanyxeEQh7S9NTewgrT1L3zfybzlnHNbBSEOS/ABVyFaKwC1oOAF/twoAVoC+F0NCp
        ysKIs8YCQ2e00ythSeGADQjy9yl5qShN8KW5uS3tuX3hMMu0TPXaSeeoTNl16xOW2lliSd
        sl7iTb7QuUAiRxL3URwO7jI8rl0SHZE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v20 29/32] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
Message-ID: <ZGhgMnx6W4272Jiv@moria.home.lan>
References: <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-30-dhowells@redhat.com>
 <ZGghr0/lFRKmaoAX@moria.home.lan>
 <ZGhFCCBdlSWWcG1G@infradead.org>
 <ZGhI/V573cMDhII5@moria.home.lan>
 <ZGhJ526fahFHi4WA@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGhJ526fahFHi4WA@infradead.org>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 19, 2023 at 09:17:43PM -0700, Christoph Hellwig wrote:
> On Sat, May 20, 2023 at 12:13:49AM -0400, Kent Overstreet wrote:
> > I suppose this way setting it can be done in bio_iov_iter_get_pages() -
> > ok yeah, that makes sense.
> > 
> > But it seems like it should be set in bio_iov_iter_get_pages() though,
> > and I'm not seeing that?
> 
> It is set in bio_iov_iter_get_pages in this patch.  The later gets
> replaced with the pinned flag when we bio_iov_iter_get_pages is
> changed to pin pages instead.

Whoops, missed it.

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
