Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A26C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BF6208E7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 19:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BF6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeLFTQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:16:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFTQk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 14:16:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 219066CE;
        Thu,  6 Dec 2018 19:16:40 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A11560E3F;
        Thu,  6 Dec 2018 19:16:39 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
Subject: Re: [PATCH 01/26] fs: add an iopoll method to struct file_operations
References: <20181204233729.26776-1-axboe@kernel.dk>
        <20181204233729.26776-2-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 06 Dec 2018 14:16:38 -0500
In-Reply-To: <20181204233729.26776-2-axboe@kernel.dk> (Jens Axboe's message of
        "Tue, 4 Dec 2018 16:37:04 -0700")
Message-ID: <x495zw6h3e1.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 06 Dec 2018 19:16:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> From: Christoph Hellwig <hch@lst.de>
>
> This new methods is used to explicitly poll for I/O completion for an
> iocb.  It must be called for any iocb submitted asynchronously (that
> is with a non-null ki_complete) which has the IOCB_HIPRI flag set.
>
> The method is assisted by a new ki_cookie field in struct iocb to store
> the polling cookie.
>
> TODO: we can probably union ki_cookie with the existing hint and I/O
> priority fields to avoid struct kiocb growth.

Please document return values.

Thanks,
Jeff

>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  Documentation/filesystems/vfs.txt | 3 +++
>  include/linux/fs.h                | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
> index 5f71a252e2e0..d9dc5e4d82b9 100644
> --- a/Documentation/filesystems/vfs.txt
> +++ b/Documentation/filesystems/vfs.txt
> @@ -857,6 +857,7 @@ struct file_operations {
>  	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
>  	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
>  	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
> +	int (*iopoll)(struct kiocb *kiocb, bool spin);
>  	int (*iterate) (struct file *, struct dir_context *);
>  	int (*iterate_shared) (struct file *, struct dir_context *);
>  	__poll_t (*poll) (struct file *, struct poll_table_struct *);
> @@ -902,6 +903,8 @@ otherwise noted.
>  
>    write_iter: possibly asynchronous write with iov_iter as source
>  
> +  iopoll: called when aio wants to poll for completions on HIPRI iocbs
> +
>    iterate: called when the VFS needs to read the directory contents
>  
>    iterate_shared: called when the VFS needs to read the directory contents
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a1ab233e6469..6a5f71f8ae06 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -310,6 +310,7 @@ struct kiocb {
>  	int			ki_flags;
>  	u16			ki_hint;
>  	u16			ki_ioprio; /* See linux/ioprio.h */
> +	unsigned int		ki_cookie; /* for ->iopoll */
>  } __randomize_layout;
>  
>  static inline bool is_sync_kiocb(struct kiocb *kiocb)
> @@ -1781,6 +1782,7 @@ struct file_operations {
>  	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
>  	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
>  	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
> +	int (*iopoll)(struct kiocb *kiocb, bool spin);
>  	int (*iterate) (struct file *, struct dir_context *);
>  	int (*iterate_shared) (struct file *, struct dir_context *);
>  	__poll_t (*poll) (struct file *, struct poll_table_struct *);
