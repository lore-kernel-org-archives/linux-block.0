Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145969950
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432513; cv=none; b=saQ1bYZi2IAoUyZTYje0mrtOBjfwBNZ5/VeMwjbzhMR1okHr1c5jz7+1yNucnlqF8Bp/0Jkq7EYSXQGfEmM7Q+dLy7rzEqSyfA87cd9IayB8ydIOLfAobgKjNceSGoV1PPKHJYGR/funM5qyi3Mc00IK2jpMKwBVLLXBT9kntdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432513; c=relaxed/simple;
	bh=h+q/ncsKUPSTDgGsTrD6JWuvc1QgCpOneDBjC49bjAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfsvrBxeI3bJ5h/5BefH5LIzc6cDKt1j172KF5xR4UCsirkPDLtME9och7dCIcpPO+cMuOjw0rw0sZJ5nec90CIhRnhNuxyNq7E8OxMX6jL+Jm8dJDnIh785w1BH9Pze+XoMRGom8x24nFhOm5WYZaXzgtESZsd5zuY02etKXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=VZ8cwNIE; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="VZ8cwNIE"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512a9ae6c02so3316323e87.2
        for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 04:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1708432509; x=1709037309; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SqpBys1GZlBb1wU68c/Qfm1otX0q/1l9PzfK4bmChbs=;
        b=VZ8cwNIEgXEQlxs6maanauewmJTyB50KI1mhINGpVnROXKwx3XboNISlDCCps6x+3N
         orFQ6O7MawwH0/oPwf6Dkcj26GQBJNggjq42vqIkM8gSrqQHr5TLO73TtWU7ubq5qW9x
         Pw1Z86PfIhpR6YJvwtl0JZmAmzGv831NEOiOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708432509; x=1709037309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqpBys1GZlBb1wU68c/Qfm1otX0q/1l9PzfK4bmChbs=;
        b=Kv5EKhoJoinr5K/yOutZEB6pRipdoTdJDdUjvNe2bNKMLf9ytOM93huHFQq/9b8Qp7
         8+QgMc3a0SQoW4atMCli7Nuy9DfD699TY5oKlq/vGdz/OewGY7XJqZ/K7Ko6ZBDkOs1S
         yDHcT5MuPLYbsArod3855Y/iH8grs9Hi7NsH9xig8+AkQfZpYhF7hr4dlhmJFy1MT5Nf
         X6H7SAQ0/j7qXEK4DbFhfLnuxI9lm2bIZbaFr7WutvgQ9qwv3D02bxkKnaSumgLKFunV
         ARxYHiEHE2geZTzUviOknDeuodU7RpnCeShnNRC5D0hrp4GXf5yxkveib212t9jt7UtF
         pMqw==
X-Forwarded-Encrypted: i=1; AJvYcCWRl+o16jvPYfSoTLIksFbs5J4YYtKk2ThhpjKt2BENidoMjblvrVqGif2Q2bANqb32yCFhrXb5I3bVnTr9x32ZFnrVLYMgvMGwF0g=
X-Gm-Message-State: AOJu0YxoudT3bgNernZyPeDX9Qc9tyYUbvWbI6khFh6MZrcWQd2fcmpa
	bYH40DVm6ZJ1wxRmA+Hajlidro0tnTB7DV6ZSAm+QMEpbdgKroNCuJW5G9olgSE=
X-Google-Smtp-Source: AGHT+IHCfgVrtMYa0fp+z+iiNFStJsXuBsufUna6l982EcnnfOw5X+iFOo070cXM6N0JdfXwfRyDiA==
X-Received: by 2002:a05:6512:3d16:b0:512:c1e7:185 with SMTP id d22-20020a0565123d1600b00512c1e70185mr1640093lfv.61.1708432509503;
        Tue, 20 Feb 2024 04:35:09 -0800 (PST)
Received: from localhost ([213.195.118.74])
        by smtp.gmail.com with ESMTPSA id c14-20020ac8110e000000b0042be1092915sm3362420qtj.10.2024.02.20.04.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 04:35:09 -0800 (PST)
Date: Tue, 20 Feb 2024 13:35:07 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] xen-blkfront: atomically update queue limits
Message-ID: <ZdScey8AJvBykWa8@macbook>
References: <20240220084935.3282351-1-hch@lst.de>
 <20240220084935.3282351-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220084935.3282351-5-hch@lst.de>

On Tue, Feb 20, 2024 at 09:49:35AM +0100, Christoph Hellwig wrote:
> Pass the initial queue limits to blk_mq_alloc_disk and use the
> blkif_set_queue_limits API to update the limits on reconnect.

Allocating queue_limits on the stack might be a bit risky, as I fear
this struct is likely to grow?

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Roger Pau Monné <roger.pau@citrix.com>

Just one addition while you are already modifying a line.

> ---
>  drivers/block/xen-blkfront.c | 41 ++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 7664638a0abbfa..b77707ca2c5aa6 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -941,37 +941,35 @@ static const struct blk_mq_ops blkfront_mq_ops = {
>  	.complete = blkif_complete_rq,
>  };
>  
> -static void blkif_set_queue_limits(struct blkfront_info *info)
> +static void blkif_set_queue_limits(struct blkfront_info *info,

While there, could you also constify info?

Thanks, Roger.
