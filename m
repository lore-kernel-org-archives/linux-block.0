Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BB9C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39762218D2
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 09:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfBIJpS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:45:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:54162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726058AbfBIJpS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 9 Feb 2019 04:45:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59ECCAFC5;
        Sat,  9 Feb 2019 09:45:17 +0000 (UTC)
Subject: Re: [PATCH 11/19] block: implement bio helper to add iter bvec pages
 to bio
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-12-axboe@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <837729ed-38ff-c3ef-f0de-01e488b28b57@suse.de>
Date:   Sat, 9 Feb 2019 10:45:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190208173423.27014-12-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 6:34 PM, Jens Axboe wrote:
> For an ITER_BVEC, we can just iterate the iov and add the pages
> to the bio directly. This requires that the caller doesn't releases
> the pages on IO completion, we add a BIO_NO_PAGE_REF flag for that.
> 
> The current two callers of bio_iov_iter_get_pages() are updated to
> check if they need to release pages on completion. This makes them
> work with bvecs that contain kernel mapped pages already.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/bio.c               | 59 ++++++++++++++++++++++++++++++++-------
>   fs/block_dev.c            |  5 ++--
>   fs/iomap.c                |  5 ++--
>   include/linux/blk_types.h |  1 +
>   4 files changed, 56 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes


