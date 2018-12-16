Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEF0C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CAF206BA
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbeLPQhi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:37:38 -0500
Received: from verein.lst.de ([213.95.11.211]:57914 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbeLPQhi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:37:38 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C915668DD3; Sun, 16 Dec 2018 17:37:36 +0100 (CET)
Date:   Sun, 16 Dec 2018 17:37:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH 16/26] fs: add fget_many() and fput_many()
Message-ID: <20181216163736.GB13234@lst.de>
References: <20181213175645.22181-1-axboe@kernel.dk> <20181213175645.22181-17-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213175645.22181-17-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[adding Al, I think we really want him to review anything fget
 related]

On Thu, Dec 13, 2018 at 10:56:35AM -0700, Jens Axboe wrote:
> Some uses cases repeatedly get and put references to the same file, but
> the only exposed interface is doing these one at the time. As each of
> these entail an atomic inc or dec on a shared structure, that cost can
> add up.
> 
> Add fget_many(), which works just like fget(), except it takes an
> argument for how many references to get on the file. Ditto fput_many(),
> which can drop an arbitrary number of references to a file.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  fs/file.c            | 15 ++++++++++-----
>  fs/file_table.c      | 10 ++++++++--
>  include/linux/file.h |  2 ++
>  include/linux/fs.h   |  3 ++-
>  4 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 7ffd6e9d103d..ad9870edfd51 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -676,7 +676,7 @@ void do_close_on_exec(struct files_struct *files)
>  	spin_unlock(&files->file_lock);
>  }
>  
> -static struct file *__fget(unsigned int fd, fmode_t mask)
> +static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
>  {
>  	struct files_struct *files = current->files;
>  	struct file *file;
> @@ -691,7 +691,7 @@ static struct file *__fget(unsigned int fd, fmode_t mask)
>  		 */
>  		if (file->f_mode & mask)
>  			file = NULL;
> -		else if (!get_file_rcu(file))
> +		else if (!get_file_rcu_many(file, refs))
>  			goto loop;
>  	}
>  	rcu_read_unlock();
> @@ -699,15 +699,20 @@ static struct file *__fget(unsigned int fd, fmode_t mask)
>  	return file;
>  }
>  
> +struct file *fget_many(unsigned int fd, unsigned int refs)
> +{
> +	return __fget(fd, FMODE_PATH, refs);
> +}
> +
>  struct file *fget(unsigned int fd)
>  {
> -	return __fget(fd, FMODE_PATH);
> +	return fget_many(fd, 1);

Can we just call __fget directly here?  That is a little easier
to follow, and might actually generate better code if the compiler
is inliner challenged (which they often seem to be).

> +void fput(struct file *file)
> +{
> +	fput_many(file, 1);
> +}
> +
> +

Double empty line here.

> +#define get_file_rcu_many(x, cnt) atomic_long_add_unless(&(x)->f_count, (cnt), 0)

This could use a line break to be easier readable and not spill over
80 chars.  Otherwise this looks fine to me.
