Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C8129A83
	for <linux-block@vger.kernel.org>; Sat, 25 May 2024 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716678574; cv=none; b=sH2z6hOlGnZV5JWAR/FRbFxyp4wq0/HyCWeOf1LKrvMtVTqOf2nGvbHB0iWeent9ziSd/XQyZuCSaaHs6FrCNi7gamkfEK3g0dFDeVaCJ5v7BhncAA7JycluLJwj3e0E5izGKhtEN1KlqMOvB4EAXju8jSfutmI8BO3ZU2r4IV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716678574; c=relaxed/simple;
	bh=faN9rNSdcMcbjtK47u0oId+ibnqpzDbiA+nKCknSZ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=je0WeQqSEA+xdEVJC/2ffvoy7seAifM1yjYTjtcJ9rwrCzucSkt0Z63XQaf742/K8q11Ljub9Hi+QDclJkMHR6dyYvLWIDLwNdlRjDXfRJsNwWEUt3wNY2bbrXXOUZFqyZmeBoY1teixeOiAw9/Wz+lrBWixkmEVP8TPc3i/lpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=TYAcnYSZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="TYAcnYSZ"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-68197de7400so1731411a12.3
        for <linux-block@vger.kernel.org>; Sat, 25 May 2024 16:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716678571; x=1717283371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Crh6RjgT+TcJb1jq4rCjRtTqJLBvMRyCXUhpelsfOKA=;
        b=TYAcnYSZr305sH9XLnMvStIEDlJaWfuAxeIKJ8RHPQ2FdZChlHVw3WOedEm+oJTNqI
         stTuZ4fQcw6UxiGfRHR90Bp74bwzaixt2GDlsFinFqwsc869LKAliJMxIv9qTmLKte90
         sq9F8bi8bpvUJzN0IUjLPRE9fJjkfjv5gfgmowNLTuqBzw1qcIAMQNDSly1A1w3VVbGl
         8+P7OVtW0gK8XJZGCmv5e1rowLpX51EXhR5iPw/zYbDLRoTZIL2nRgW5TTKIhnQ6151n
         cTidOa1KmAj+ZAT11fKYV1i4bpCfpO+pzVNGRkUDuJnBIDt7bLWMHaeIDv9F1c8BEZf0
         OwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716678571; x=1717283371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crh6RjgT+TcJb1jq4rCjRtTqJLBvMRyCXUhpelsfOKA=;
        b=moiJzmrw9Nm+NoAUiU96+BncfTTUjViYOOl0GtSdiHQnSldyY/eDF7b6+qQvDwlbcI
         Gsfjl08tHQXnJo1jfY395My7wsGN0j/7hDg0faEBxp6+lgMvZjG0rMtu29HO16nfdQm8
         gE6GuY96q2qxv1pZ/jeqEOYFEV2G7gCsldlLH0gnqrv14BqpPf/44PsgdHhZx/tyOjYS
         MEPuEdJOiTG2/n2/LfBtV8ZTCFxhlmVXED/Et0a/5MJbKVOIEelUEeFC29uBGtfjsfVF
         bn39H6DZpEGM62XrkYHkZH1hZPb+I2wVgeUdY6yC9XR8g9Wt51UKLdOaNSiXSM4IuvXB
         Oc3A==
X-Forwarded-Encrypted: i=1; AJvYcCXxKHghFctU8TOLlftTKSAwcct6gTr+cxODHYNYg7TC7O/b5MLNTwOPaMn7985+eVkEPgNduivLwMvDFY2nQv+s44/BjQbNTt6VDko=
X-Gm-Message-State: AOJu0Ywr1aDm2PSq/OTVkH6LzKRHKXC0LRMFX0LyUfXcOqk6XM3TD7Ed
	6moDJFBcl81iPJiJJ/nOPp41wlAnx1Vn+q+ufK/uMjyv8yrJ2d1UqVl0api814I=
X-Google-Smtp-Source: AGHT+IGYciyTBhNiI5PZlCjyMDogB+ANQNNWDCUuYjIsBj+L8eTBYhs5xE8S13XEF72yE6eBkoNGvg==
X-Received: by 2002:a17:902:d50b:b0:1f4:768b:445e with SMTP id d9443c01a7336-1f4768b4768mr21943575ad.24.1716678570642;
        Sat, 25 May 2024 16:09:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9afba1sm34658165ad.246.2024.05.25.16.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 16:09:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sB0Vz-00AUvI-1V;
	Sun, 26 May 2024 09:09:27 +1000
Date: Sun, 26 May 2024 09:09:27 +1000
From: Dave Chinner <david@fromorbit.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 06/12] fs, block: copy_file_range for def_blk_ops for
 direct block device
Message-ID: <ZlJvp47RSFKkbwRJ@dread.disaster.area>
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102929epcas5p2f4456f6fa0005d90769615eb2c2bf273@epcas5p2.samsung.com>
 <20240520102033.9361-7-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-7-nj.shetty@samsung.com>

On Mon, May 20, 2024 at 03:50:19PM +0530, Nitesh Shetty wrote:
> For direct block device opened with O_DIRECT, use blkdev_copy_offload to
> issue device copy offload, or use splice_copy_file_range in case
> device copy offload capability is absent or the device files are not open
> with O_DIRECT.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  block/fops.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 376265935714..5a4bba4f43aa 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -17,6 +17,7 @@
>  #include <linux/fs.h>
>  #include <linux/iomap.h>
>  #include <linux/module.h>
> +#include <linux/splice.h>
>  #include "blk.h"
>  
>  static inline struct inode *bdev_file_inode(struct file *file)
> @@ -754,6 +755,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return ret;
>  }
>  
> +static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
> +				      struct file *file_out, loff_t pos_out,
> +				      size_t len, unsigned int flags)
> +{
> +	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
> +	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
> +	ssize_t copied = 0;
> +
> +	if ((in_bdev == out_bdev) && bdev_max_copy_sectors(in_bdev) &&
> +	    (file_in->f_iocb_flags & IOCB_DIRECT) &&
> +	    (file_out->f_iocb_flags & IOCB_DIRECT)) {
> +		copied = blkdev_copy_offload(in_bdev, pos_in, pos_out, len,
> +					     NULL, NULL, GFP_KERNEL);
> +		if (copied < 0)
> +			copied = 0;
> +	} else {
> +		copied = splice_copy_file_range(file_in, pos_in + copied,
> +						 file_out, pos_out + copied,
> +						 len - copied);
> +	}

This should not fall back to a page cache copy.

We keep being told by application developers that if the fast
hardware/filesystem offload fails, then an error should be returned
so the application can determine what the fallback operation should
be.

It may well be that the application falls back to "copy through the
page cache", but that is an application policy choice, not a
something the kernel offload driver should be making mandatory.

Userspace has to handle copy offload failure anyway, so they a
fallback path regardless of whether copy_file_range() works on block
devices or not...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
