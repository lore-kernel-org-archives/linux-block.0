Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7F1DF982
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 03:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752463752; cv=none; b=FJ7c+mPPPJIK3VZPhNRJUk68nzKDDSVC+f+Vv1MigSfGujDzeUbvOeOG9UMo2PpdNn6sDoteVDqwA0ok2b5Za+ls4N58Lu3mtjAQPoReBqOvsF9YXhs34qeE6cAtI0gcqmCNseeQnk78JY8f09CS11/QcVTqTv5553xfZgqBezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752463752; c=relaxed/simple;
	bh=cn680N+Lbe1YOLdllxDrT4jSd2RORFRplVpLq6vJcBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQwV4uM1gMrU07JcaGkeZ48MUL5iXvwaZ+M2nabSO1dxXtl/NYbK+BRZKgiD0yJm8zXQd2AFfH0R/tnKFxMLotOn3S6yfGs75uGz1mBy7cPG498FQIeIycJx1RXSlzFVXYR4WepVWFghdPbqe0I136DXrZxwnEVSnVQfSiMWarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aqb8lVH3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aqb8lVH3"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so3004106a12.1
        for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 20:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752463750; x=1753068550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AuFfMb94T1QlI5VB+hGYMUtffHMe70rkO85YQAjY0iE=;
        b=aqb8lVH3MxA5ju5G0Ymm/qyM/EJ6vTB+J0PSUxIrfLipd0jJaLLg9QU4ruY6YztKIF
         7gac8KyQPnXQYIPa/8qv1WEEhEVVVULw8kR5DOWzqPQiVrozsS5la87osoL3BJv3sF3a
         S6u6EzVDZLA5fKoGh0rx32dsnxVyTAO5e7kxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752463750; x=1753068550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuFfMb94T1QlI5VB+hGYMUtffHMe70rkO85YQAjY0iE=;
        b=n/ytJP3t/qD3ahTL4u1GM1kfACeZpGJzjj0HVQROKRsqLy+zLQdq5wW1uquAYeUr35
         2VFw5kUbVhT0lZ0ExWMsepM99y/7QgKn19bJYClxKM6BimaZr9capgL8eGuzr6YoDC0/
         vgL7H7Ui63G/GFsJkfwfZIDoXywKOeAnWZ3zmuLOTgAhskrQBfb06Qv89w/hoSKXE5B7
         mdYkJgwtnLmV8GiuLp9/YySVOPbhR2I8OPa/d4DG4Jw6dNe1jfwzvJG2NK+xgHD3jSC1
         yM/hr5MBGKDtATHcwYap7Dll+9DasWTFHGNKGgvY/tJGJK+kSO6eJr+1yCL7SJ5bjYdM
         FnEg==
X-Forwarded-Encrypted: i=1; AJvYcCUvB4pA68TGV1hVEeZ3Eu5XCZaWq1+lOcN8d6oHPtjLnUBwbwxHrB47QG5a8nx6dOQTSX9r7/wgpoVTiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUF3te1WaHMXjhNUx5F35e5zgQQpsGGbHRcEftNmBMjFISz27
	kaxqUg0VcQNo15lxTy1EX+qghCfhstqZtkE2kCQANzdw6z9wQz6+matWBz/RqCSstg==
X-Gm-Gg: ASbGncujWzyfvV8aKlC9mfVrDbgydnzInIzHAPTFUqNYeUAtJhTuuyddgJ29AJmnOPH
	jIhD3scj0evHyYzmNX9ZEt0RU/XUaHkFyR/gtaqStsXlR2rA6FX8EwWskPI1BFdRJIIvw4QG8D9
	0yuxdY2khXNSaDg0jdjRe4dQDfHAJA2UPLfSt9Al58VaYz8ooRKcTliLVw2KHsN90DQoY27KJH5
	oKfo2los9jM+Dz9o8X7LRwrRlYYfiu/SgwISGxiGyi75PXFCB6Usq0YB7a60MG1feFW/cfb2KjU
	4lM7ryXQVLGsOQbXc9JyqTHkHLtGEve9ISissVgWK+T0sAVStU9AkJJ/yeki4IUleX7XpwJO7gr
	QcaKFKrm8mfz3vkwBN+OksKkY1w==
X-Google-Smtp-Source: AGHT+IGFvP2mdH1afPSE7DmUb8WifMmqbuLptsjHv9YDI67dI175Nw5rSwYCLwFWOxdl9topoJcN8Q==
X-Received: by 2002:a05:6a21:f119:b0:232:ac34:70f1 with SMTP id adf61e73a8af0-232ac3472a1mr10402898637.30.1752463749673;
        Sun, 13 Jul 2025 20:29:09 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d84e:323a:598d:f849])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f7fa50sm9322801b3a.145.2025.07.13.20.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 20:29:09 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:29:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <fcoixqhllcn4cjycwse253zeyg27bghyrsablmlw6cdz7c27xj@3tzfom227xrq>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
 <7kbmle3wlpeqcnfieelypkxzypfxoh7bqmuqn2d3hbjgbcm7mt@cze3mv7htbeg>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7kbmle3wlpeqcnfieelypkxzypfxoh7bqmuqn2d3hbjgbcm7mt@cze3mv7htbeg>

On (25/07/14 12:10), Sergey Senozhatsky wrote:
> Date: Mon, 14 Jul 2025 12:10:16 +0900
> From: Sergey Senozhatsky <senozhatsky@chromium.org>
> To: Phillip Potter <phil@philpotter.co.uk>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,  Jens Axboe
>  <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,  Chris Rankin
>  <rankincj@gmail.com>, linux-kernel@vger.kernel.org,
>  linux-block@vger.kernel.org
> Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
> Message-ID: <7kbmle3wlpeqcnfieelypkxzypfxoh7bqmuqn2d3hbjgbcm7mt@cze3mv7htbeg>
> 
> On (25/07/11 21:46), Phillip Potter wrote:
> > > <1>[335443.339244] BUG: kernel NULL pointer dereference, address: 0000000000000010
> > > <4>[335443.339301] RIP: 0010:blk_queue_enter+0x5a/0x250
[..]
> > > <4>[335443.339439] blk_mq_alloc_request+0x16a/0x220
> > > <4>[335443.339450] scsi_execute_cmd+0x65/0x240
> > > <4>[335443.339458] sr_do_ioctl+0xe3/0x210 [sr_mod (HASH:ab3e 2)]
> > > <4>[335443.339471] sr_packet+0x3d/0x50 [sr_mod (HASH:ab3e 2)]
> > > <4>[335443.339482] cdrom_mrw_exit+0xc1/0x240 [cdrom (HASH:9d9a 3)]
> > > <4>[335443.339497] sr_free_disk+0x45/0x60 [sr_mod (HASH:ab3e 2)]
> > > <4>[335443.339506] disk_release+0xc8/0xe0
> > > <4>[335443.339515] device_release+0x39/0x90
> > > <4>[335443.339523] kobject_release+0x49/0xb0
> > > <4>[335443.339533] bdev_release+0x19/0x30
> > > <4>[335443.339540] deactivate_locked_super+0x3b/0x100
> > > <4>[335443.339548] cleanup_mnt+0xaa/0x160
> > > <4>[335443.339557] task_work_run+0x6c/0xb0
> > > <4>[335443.339563] exit_to_user_mode_prepare+0x102/0x120
> > > <4>[335443.339571] syscall_exit_to_user_mode+0x1a/0x30
> > > <4>[335443.339577] do_syscall_64+0x7e/0xa0
> > > <4>[335443.339582] ? exit_to_user_mode_prepare+0x44/0x120
> > > <4>[335443.339588] entry_SYSCALL_64_after_hwframe+0x55/0xbf
> > > <4>[335443.339595] RIP: 0033:0x7d52bea41f07
> > > 
[..]
> The device is detached already, I assume there isn't much that
> cdrom_mrw_exit() can do at that point.

If I read it correctly

<4>[335443.339482] cdrom_mrw_exit+0xc1/0x240 [cdrom (HASH:9d9a 3)]
<4>[335443.339497] sr_free_disk+0x45/0x60 [sr_mod (HASH:ab3e 2)]
<4>[335443.339506] disk_release+0xc8/0xe0
<4>[335443.339515] device_release+0x39/0x90

device_release() calls dev->type->release() before dev->class->dev_release().
dev->type->release() probably should be scsi_device_dev_release() which, among
other things, does sdev->request_queue = NULL, so dev->class->dev_release()
is called too late to execute any scsi commands.
