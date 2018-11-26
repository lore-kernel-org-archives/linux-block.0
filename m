Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17755C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 22:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D101D21104
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 22:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="G5nYVwhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D101D21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeK0JYb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:24:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37493 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeK0JYb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Nov 2018 04:24:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so14570207plr.4
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 14:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jUSs4ckCjR9nbJ3Ppxh214PQhf/aIJ1YkwiBrz9ToYk=;
        b=G5nYVwhTZmU8k9iaYdyr3FJk9b25IGGnt7vBKR7NpcxrnwXUZeVvBmkzIRcirVTiUD
         LtdCdH6wZVQuvlI8rW0vtEFCJndMVlz+wNscLWSq2ThuEIxqqVh6zC97TRK+mmSN5HvS
         qvdzb1yWV2UXCgNzCNGI9Md9SFAcXFxR+dLg168ZipwnS4ln31yCLmI5dV64z944ZYOH
         AtLKWVCGFtEUl6den9ggO8hSMpacZkcawMz0lM5DORzpnOxUBf3hMUrOIUhjkIHb9e5Y
         GS4S7wQ0qo/9Kfdx/SjSKFslDNEuQTi1XncuR1Cgk2mZW12136jn5lmS/lNg836FZysg
         YbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jUSs4ckCjR9nbJ3Ppxh214PQhf/aIJ1YkwiBrz9ToYk=;
        b=BJTIqhYgWf9hamuygamYgaFGmnA5wrm1Lxie7+3ICYOv/78c6eXGzB3Pp82pQjejO6
         UKaoCZLigGRLamaYAHyYadivf6X+AdMsXWtIlCalfxnxGgBUM0DDAHKCW37NaphDuwbd
         hs3zoEJCm5x+WHtKk2Cx3+Ji3D1zC4HvkbF5G0v4CpistLgzeltNKnwMlVyO0nHHr0n+
         nHeblsd3b3A0nhZItrlda0BXd14g6qK39ymKpCbFRXrU2tAMozQUfHBJn2lijDylOTrD
         kModw55DYhU1higGLQXfuF2HcWqHqGcHHlycNGvipeAgDc4rf/nl/ees2JbimzBmyb+n
         juwA==
X-Gm-Message-State: AA+aEWZRX3Mnh9WSQylLWHCZRQUkSYRLb6F3kcJyTSQ/I/Lvy7Y30q7O
        0YSpIZdAfSR6stO+/GyeOlILQg==
X-Google-Smtp-Source: AFSGD/U17V504za3OODVszR4Tl8as+3HIh5YPoWjdb8pe13CCGOfNoZpatAgSYvx7ivCLpBWHvN1YQ==
X-Received: by 2002:a17:902:4d46:: with SMTP id o6mr28515395plh.302.1543271333739;
        Mon, 26 Nov 2018 14:28:53 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id p67sm1986816pfg.44.2018.11.26.14.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 14:28:52 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:28:51 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>, Omar Sandoval <osandov@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Dave Chinner <dchinner@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
        Boaz Harrosh <ooo@electrozaur.com>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com
Subject: Re: [PATCH V12 01/20] btrfs: remove various bio_offset arguments
Message-ID: <20181126222851.GH30411@vader>
References: <20181126021720.19471-1-ming.lei@redhat.com>
 <20181126021720.19471-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126021720.19471-2-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 10:17:01AM +0800, Ming Lei wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> The btrfs write path passes a bio_offset argument through some deep
> callchains including async offloading.  In the end this is easily
> calculatable using page_offset plus the bvec offset for the first
> page in the bio, and only actually used by by a single function.
> Just move the calculation of the offset there.
> 
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/disk-io.c   | 21 +++++----------------
>  fs/btrfs/disk-io.h   |  2 +-
>  fs/btrfs/extent_io.c |  9 ++-------
>  fs/btrfs/extent_io.h |  5 ++---
>  fs/btrfs/inode.c     | 17 ++++++++---------
>  5 files changed, 18 insertions(+), 36 deletions(-)

[snip]

> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 9ea4c6f0352f..c576b3fcaea7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1920,8 +1920,7 @@ int btrfs_merge_bio_hook(struct page *page, unsigned long offset,
>   * At IO completion time the cums attached on the ordered extent record
>   * are inserted into the btree
>   */
> -static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
> -				    u64 bio_offset)
> +static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio)
>  {
>  	struct inode *inode = private_data;
>  	blk_status_t ret = 0;
> @@ -1973,8 +1972,7 @@ blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
>   *    c-3) otherwise:			async submit
>   */
>  static blk_status_t btrfs_submit_bio_hook(void *private_data, struct bio *bio,
> -				 int mirror_num, unsigned long bio_flags,
> -				 u64 bio_offset)
> +				 int mirror_num, unsigned long bio_flags)
>  {
>  	struct inode *inode = private_data;
>  	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> @@ -2011,8 +2009,7 @@ static blk_status_t btrfs_submit_bio_hook(void *private_data, struct bio *bio,
>  			goto mapit;
>  		/* we're doing a write, do the async checksumming */
>  		ret = btrfs_wq_submit_bio(fs_info, bio, mirror_num, bio_flags,
> -					  bio_offset, inode,
> -					  btrfs_submit_bio_start);
> +					  inode, btrfs_submit_bio_start);
>  		goto out;
>  	} else if (!skip_sum) {
>  		ret = btrfs_csum_one_bio(inode, bio, 0, 0);
> @@ -8123,10 +8120,13 @@ static void btrfs_endio_direct_write(struct bio *bio)
>  }
>  
>  static blk_status_t btrfs_submit_bio_start_direct_io(void *private_data,
> -				    struct bio *bio, u64 offset)
> +				    struct bio *bio)
>  {
>  	struct inode *inode = private_data;
> +	struct bio_vec *bvec = bio_first_bvec_all(bio);
> +	u64 offset = page_offset(bvec->bv_page) + bvec->bv_offset;

Hm, but for direct I/O, these will be user pages (or the zero page), so
page_offset() won't be valid?

>  	blk_status_t ret;
> +
>  	ret = btrfs_csum_one_bio(inode, bio, offset, 1);
>  	BUG_ON(ret); /* -ENOMEM */
>  	return 0;
