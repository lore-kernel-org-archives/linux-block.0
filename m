Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F782F46
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728450369; cv=none; b=LUP0/drOBWgMIs2e82qHSHgY21xHuAOToA4EBWEPCUZsPjpnMobsIUSz2nujNLun9OGlQOm4Q160BasH/+sy2/HkQYF4DpzdYFOnoFLdf66XofQmU48udCduFR/BudVuX+UHUD4fL6lz52uDIJZwvvEUXdCvkWzNKC6GsSCtuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728450369; c=relaxed/simple;
	bh=LtTRoLjBN5de1yNineLhxeHl0ImxxlAsP7ElmICP7Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoDi1b+Ulq9F/nVeB4wFOq/5ieaYjqM2i2hxeLiWWkwJ9GgBXsSlvgtjjjI8xNz4CZtq7PIFVLr4GHYhq9U5MPX/YVxup7xmu/036LUL8uESCKNh3K4gp3//8fd8H7uaLOoRF//vKl5KjiSuv5pAF6wMnzQHkdVwMZHEaqdhckQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bjb9+MIE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bjb9+MIE"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71dfc250001so2652555b3a.2
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2024 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728450367; x=1729055167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1q42scKZixvrwqo5FxuJITizjV0bPHhZJvUEcyKv03k=;
        b=bjb9+MIEfh2T7+mP1OwQp1rYj1EGUXaXjyXRr5oUIqKTpVBlw/vnxUW1m/F4pq1gyC
         lWbXSqwyOC8QekKO6VGCVtOPx2v8NPX8+I5WeRtHqR/h1wXbPIpajmN9vM+apMp5iYuT
         OtN6yULEgFBPxacL/JfOa5BpsaCNfN2pgiPmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728450367; x=1729055167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q42scKZixvrwqo5FxuJITizjV0bPHhZJvUEcyKv03k=;
        b=EtjeMqBS7P+CEFOMJ2hi7GZ7KtYV1VJdudsRbLuB7DtTor1FNeYTl6nRpeBo4aXLlg
         5xn7y0lAuSRXP1ovuRrsWPDYhM+mEMwz16DaHvuYSqRuqifF14QHlfG6riyt/xTyyrD8
         BKo7f8HOr8x7zU0dlN20aE1c0UDAfffOhTXwHrL8N3Urd8QoDVwKAIojyfFe5y+wh7/8
         lLcf+wzkXJVsGJTADN6dYmuvthaozA2FHymU3gwQ4rov0rYfSlN4wpxCwFoaSTxsHJQp
         sVn22X4emmydqv6tLGglcDmnI2t2pfOZutaFEfglM/FtAHWZetOQwdk0+cgP3OMbtr4/
         lOJA==
X-Forwarded-Encrypted: i=1; AJvYcCV0pATmjqUUNX5/oF+EVK9nAhWJoizXoy6kiT0HIIzZTkivQzy+Pi8l+JksZKVsUD3m0Ruy98NhqhxXvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5o3uxmvoux+38cgf2yx+C6NoyUqzQHA5I+G46viLmQiw/wY7
	JM8a0MHM4V5ggIc273+IZ+LflizZpGgvww5W0j/67G8jjlF+jFzs0h6tm2NnpQ==
X-Google-Smtp-Source: AGHT+IGBxCmunnCSgUVdI+0JKD4M/IrRjWQnL/ElFgOvVohD6jAavF7/lamsx6ck+rC/QgneMZmLYQ==
X-Received: by 2002:a05:6a00:98a:b0:718:da06:a4bf with SMTP id d2e1a72fcca58-71e1db65a47mr1820836b3a.2.1728450367020;
        Tue, 08 Oct 2024 22:06:07 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cab:8c3d:935:cbd2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d18asm6942149b3a.203.2024.10.08.22.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 22:06:06 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:06:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241009050602.GC565009@google.com>
References: <20241008115756.355936-1-hch@lst.de>
 <20241008115756.355936-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008115756.355936-2-hch@lst.de>

On (24/10/08 13:57), Christoph Hellwig wrote:
> When del_gendisk shuts down access to a gendisk, it could lead to a
> deadlock with sd or, which try to submit passthrough SCSI commands from
> their ->release method under open_mutex.  The submission can be blocked
> in blk_enter_queue while del_gendisk can't get to actually telling them
> top stop and wake them up.
> 
> As the disk is going away there is no real point in sending these
> commands, but we have no really good way to distinguish between the
> cases.  For now mark even standalone (aka SCSI queues) as dying in
> del_gendisk to avoid this deadlock, but the real fix will be to split
> freeing a disk from freezing a queue for not disk associated requests.
> 
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

FWIW
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

[..]

>  	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
> +		if (test_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags))
> +			clear_bit(QUEUE_FLAG_DYING, &q->queue_flags);

Don't know if we also want to clear QUEUE_FLAG_RESURRECT here, just in
case.

>  		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
>  		__blk_mq_unfreeze_queue(q, true);
>  	} else {
