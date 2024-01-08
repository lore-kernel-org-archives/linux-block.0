Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4447179D8
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="j2/melVy"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28c0d8dd88bso668133a91.2
        for <linux-block@vger.kernel.org>; Sun, 07 Jan 2024 21:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704692272; x=1705297072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3O4WHGwG6ZPIr29rTx2TRQGekh8I//FNRPEnTrmWa+c=;
        b=j2/melVy9IEg1+9pCmQMvjKsQI4RnmxO9s6oMs6kIbZ1MwoJ9LlWkiArpm4gHnP1IC
         9Nn9yPz/dwmU+dpi4GrD56I8J8Gl9Pp2HQtPG5T9FKv4vm75/sgxo09xGzbYojLlO75q
         RUCAzxlYFFbGoYYK9xx9EP+Lhp/ka+qHmhxIgi69yWU4Oc+QBGiXcb33c0rPncWzfJjp
         vuiXLShy6FdUoXAURbMhMFjWS1FuRoxTwTMsF0RddsyhemIyvAQJefS7p5SCYpdsJbSp
         OZ+i0G13VK6z1Y6R+Vi20LyrfbSDYRxS2s+DEXAKxVWHTIFDrnP6wzVPvgglygOciwfi
         L9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704692272; x=1705297072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O4WHGwG6ZPIr29rTx2TRQGekh8I//FNRPEnTrmWa+c=;
        b=FZKkUrL1+IrBO8CBnInHXI6vXJMxVVeLvztDHwOO17Wi/CbWGBODpvAShwpBR4pmdH
         FsKGLg9HP5mTs6uef7XN+J83RGieUqJUwMVB2a3LmNLhkzr8laf8QmeoAbNKpU4+Y729
         nkeeQkV3ln2fB3EOK3FZl75bdtw3eq6YppZFz6/fFqCCyB+7Bsf1YBI8MboCyWYJU0u2
         6gjXCk/m2qLkw3bqBSi4jNnFTHxsVlAHOxMxMoTIfdfEJrlFUGNP/bjnaUcjn0fSxxfi
         oEFgkEgzBzK5nbBfdPXLKuqEnAaKoFv5WhSWm15GTt4kQxG0539HL22xZ32BWFYgwpLF
         fd5Q==
X-Gm-Message-State: AOJu0YxGsiIegtmwEK06AJPCSAd4KEet1YL9BbJ+40bKq81+CUb0/ALW
	ZtgHmllcBDNGsVo7MsilwGAgBYfpdqOQbg==
X-Google-Smtp-Source: AGHT+IGaBzF3KXZrJQgwwl1pkij7k2ARii/iQ2ROhQFs+q98FAa4BaSsDGvxEfFSmz0Nbs30f6UcOQ==
X-Received: by 2002:a17:90a:890d:b0:28c:91d5:c417 with SMTP id u13-20020a17090a890d00b0028c91d5c417mr633929pjn.65.1704692272568;
        Sun, 07 Jan 2024 21:37:52 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b001d08e08003esm5312895plh.174.2024.01.07.21.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 21:37:52 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rMiKb-007VZm-2t;
	Mon, 08 Jan 2024 16:37:49 +1100
Date: Mon, 8 Jan 2024 16:37:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 01/34] bdev: open block device as files
Message-ID: <ZZuKLRpFr9pVZ2pa@dread.disaster.area>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
 <20240103-vfs-bdev-file-v1-1-6c8ee55fb6ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-vfs-bdev-file-v1-1-6c8ee55fb6ef@kernel.org>

On Wed, Jan 03, 2024 at 01:54:59PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8e0d77f9464e..b0a5e94e8c3a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1227,8 +1227,8 @@ struct super_block {
>  #endif
>  	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
>  	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
> -	struct block_device	*s_bdev;
> -	struct bdev_handle	*s_bdev_handle;
> +	struct block_device	*s_bdev;	/* can go away once we use an accessor for @s_f_bdev */
> +	struct file		*s_f_bdev;

	struct file		*s_bdev_file;

Because then the reader knows exactly what the object type
and what it refers to is when they read "sb->s_bdev_file" in the
code.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
