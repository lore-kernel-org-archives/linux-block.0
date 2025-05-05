Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457E1C5D59
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746426604; cv=none; b=NUucmDzpFcW+DFP6JWnNtbH9OIFO7r1iKevmThQHUNl8KzRixajcke/UEFErqCHR1QGeIG/Ox6HCvS7AU7ASubH0V9GgVr+ABLujuhWh37xbVQ2ZWjr3FeEjNy8WPO2qYH7zm9oUxH0VNII+C6H1/EaVKExiP2boiH2/YR0jpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746426604; c=relaxed/simple;
	bh=Z5DlCtoqGdG9S3ngXaBO0GE6VCFWbg5Pq3K78HGiinM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRlJZfHTHGdcXvSJyfjQgVoIDfDjEqzae4Bk3tBDMtUy7F9EhGvXWqSeQsFGpTHvfxZx2lIqcM2XvukXu0RVCEMdWflyF+LlB1rS1hkIyTvXoVatjZLzJzCOQf0LftzGrz7AieKKbTrge4NYxSEwYYr7jHLMcvpx54B9vCDJR0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UaMPkvsL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UaMPkvsL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Dx1pm3mqh8gkP2UJ1fTbbX+hsGsoe8oFKQcDyDVV6og=; b=UaMPkvsLEuL+xHgqUOXTW3hg4p
	rEU11fG59dpAaQPdjf6QxqiJMVI73lCI4ekCy+oslMF90JPJnE/yPHzXshwve8bk4Ldi2wgpP3cyS
	UsGN1UXmaKeVizte9echDmSUsIgXLm0mEwvlp+TFXGLMGV7/Z3dNWaieRbswizTvnY7ByUjFSyGFi
	+Ltz6nzXpvvZzar2k3HLcoZpvSN/2Ul725bF0ZIIBg61UlGGSE7xfZwYvnSVzXer/VjUbxirgQK4B
	NqmO/jPVFOq1SmoA1gjodrvheRPMPMKNINSVHhsz0N3f3QBD60pxt/SRPTGQ4VgmZkGQuXp6cPOLO
	ApJkslEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBpKz-00000006WnP-3xLJ;
	Mon, 05 May 2025 06:30:01 +0000
Date: Sun, 4 May 2025 23:30:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH V5] loop: Add sanity check for read/write_iter
Message-ID: <aBha6QnS6lrPNnow@infradead.org>
References: <aA-QB7Iu6u9PdgHg@infradead.org>
 <20250428143626.3318717-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428143626.3318717-1-lizhi.xu@windriver.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Can you pick this one up?

On Mon, Apr 28, 2025 at 10:36:26PM +0800, Lizhi Xu wrote:
> Some file systems do not support read_iter/write_iter, such as selinuxfs
> in this issue.
> So before calling them, first confirm that the interface is supported and
> then call it.
> 
> It is releavant in that vfs_iter_read/write have the check, and removal
> of their used caused szybot to be able to hit this issue.
> 
> Fixes: f2fed441c69b ("loop: stop using vfs_iter__{read,write} for buffered I/O")
> Reported-by: syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=6af973a3b8dfd2faefdc
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> V1 -> V2: move check to loop_configure and loop_change_fd
> V2 -> V3: using helper for this check
> V3 -> V4: remove input parameters change and mode
> V4 -> V5: remove braces around !file->f_op->write_iter
> 
>  drivers/block/loop.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 46cba261075f..655d33e63cb9 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -505,6 +505,17 @@ static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
>  	lo->lo_min_dio_size = loop_query_min_dio_size(lo);
>  }
>  
> +static int loop_check_backing_file(struct file *file)
> +{
> +	if (!file->f_op->read_iter)
> +		return -EINVAL;
> +
> +	if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  /*
>   * loop_change_fd switched the backing store of a loopback device to
>   * a new file. This is useful for operating system installers to free up
> @@ -526,6 +537,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	if (!file)
>  		return -EBADF;
>  
> +	error = loop_check_backing_file(file);
> +	if (error)
> +		return error;
> +
>  	/* suppress uevents while reconfiguring the device */
>  	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
>  
> @@ -963,6 +978,14 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>  
>  	if (!file)
>  		return -EBADF;
> +
> +	if ((mode & BLK_OPEN_WRITE) && !file->f_op->write_iter)
> +		return -EINVAL;
> +
> +	error = loop_check_backing_file(file);
> +	if (error)
> +		return error;
> +
>  	is_loop = is_loop_device(file);
>  
>  	/* This is safe, since we have a reference from open(). */
> -- 
> 2.43.0
> 
> 
---end quoted text---
