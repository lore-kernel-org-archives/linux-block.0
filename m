Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F89C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 07:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4402082E
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 07:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfDKHIV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:08:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKHIV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 03:08:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE89789C36;
        Thu, 11 Apr 2019 07:08:20 +0000 (UTC)
Received: from ming.t460p (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 721505C29A;
        Thu, 11 Apr 2019 07:08:12 +0000 (UTC)
Date:   Thu, 11 Apr 2019 15:08:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        Jens Axboe <axboe@kernel.dk>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Some new bio merging behaviors in __bio_try_merge_page
Message-ID: <20190411070807.GA421@ming.t460p>
References: <85c5fa1a-a506-e26f-c354-1554d47d8b2b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85c5fa1a-a506-e26f-c354-1554d47d8b2b@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 11 Apr 2019 07:08:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Gao Xiang,

On Thu, Apr 11, 2019 at 01:47:49PM +0800, Gao Xiang wrote:
> Hi Ming,
> 
> I found a erofs issue after commit 07173c3ec276
> ("block: enable multipage bvecs") is merged. It seems that
> it tries to merge more physical continuous pages in one iovec.
> 
> However it breaks the current erofs_read_raw_page logic since it uses
> nr_iovecs of bio_alloc to limit the maximum number of physical

I believe you can do the limit outside easily, such as by checking
how many pages have been added to the bio.

> continuous blocks as well. It was practicable since the old
> __bio_try_merge_page only tries to merge in the same page.
> it is a kAPI behavior change which also affects bio_alloc...
> 
> ...
> 231                 err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> 232                 if (unlikely(err))
> 233                         goto err_out;
> ...
> 284                 /* max # of continuous pages */
> 285                 if (nblocks > DIV_ROUND_UP(map.m_plen, PAGE_SIZE))
> 286                         nblocks = DIV_ROUND_UP(map.m_plen, PAGE_SIZE);
> 287                 if (nblocks > BIO_MAX_PAGES)
> 288                         nblocks = BIO_MAX_PAGES;
> 289
> 290                 bio = erofs_grab_bio(sb, blknr, nblocks, sb,
> 291                                      read_endio, false);

Previously this bio is allowed to add at most 'nblocks' pages, however,
now we are allowed to add at most 'nblocks' io vecs, instead of pages.

> 292                 if (IS_ERR(bio)) {
> 293                         err = PTR_ERR(bio);
> 294                         bio = NULL;
> 295                         goto err_out;
> 296                 }
> 297         }
> 298
> 299         err = bio_add_page(bio, page, PAGE_SIZE, 0);
> 300         /* out of the extent or bio is full */
> 301         if (err < PAGE_SIZE)
> 302                 goto submit_bio_retry;
> ...
> 
> After commit 07173c3ec276 ("block: enable multipage bvecs"), erofs could
> read more beyond what erofs_map_blocks assigns, and out-of-bound data could
> be read and it breaks tail-end inline determination.

I don't understand why, could you explain a bit why erofs reads more?

The amount depends on how many pages you added to the bio.

> 
> I can change the logic in erofs. However, out of curiosity, I have no idea
> if some other places also are designed like this.
> 
> IMO, it's better to provide a total count which indicates how many real
> pages have been added in this bio. some thoughts?

As I mentioned, you may count how many pages added to bio, or you still
can get the number via bio_segments(bio).

Thanks,
Ming
