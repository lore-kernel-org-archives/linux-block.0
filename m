Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F56524C7
	for <linux-block@vger.kernel.org>; Mon, 25 Dec 2023 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="De5DCPHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703514062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A0EmpWvfAdSPJE8+m/XWO8c/I1sa1OMFa170YYbDYsc=;
	b=De5DCPHizJ2efEu6XMai9SQWkK3r//Ao2J/JTl8JPx7vDmXcUWnvyRPQz1BQjxcYOB3fP4
	tWDWTpINys4LCVukYq/bZ0WCbXpK4l871EACSZdxHzG1yA2qeBa+eOBAg818DY20YdEYz9
	0PGXu9U2LgzwLwZSfji+G1m2MnCo1EU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-siTLhWPLPb6Z12S7TXxWaw-1; Mon, 25 Dec 2023 09:21:00 -0500
X-MC-Unique: siTLhWPLPb6Z12S7TXxWaw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40d37517936so38392465e9.2
        for <linux-block@vger.kernel.org>; Mon, 25 Dec 2023 06:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703514059; x=1704118859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0EmpWvfAdSPJE8+m/XWO8c/I1sa1OMFa170YYbDYsc=;
        b=wrExdfcF+8bFbPvc5/ktydl6routHIQEnPFqJZ4zgb3baOX0QCC1kF/Or2tGfp05dN
         dMfakj6lgBE5OYqaiTZ0w1dIbzSB8EkI18nzrkWXNj1ukJrjRQYqrozasEjTI+kMIK7R
         IwglHWj5/CeSrcSvuFh41jU4LdSwN7hY2VhP1WIERVE4adqOw3BEdNX5A4uQme63Xaxq
         U1lFsRHqv9xVYab4iCCK0APl2LN3PPu28+HjuRFqMxI0XlbiGJEDUHPgHucayTttwE3v
         SUe0h6fBOt7Uq7b8luk85g9VEulFSFp7oYOeILh6XQKw7kxrxsEujtYShZxnc90UkkNj
         Yb4Q==
X-Gm-Message-State: AOJu0Yxybw+0U0USFp9G4YmUhNIjak2xA+Cv4Su/T/939A470k7uRm/0
	8h2+G/VnKIGehqToqanQdBskTtGPQ1iAUoq6YNf+Z0MLGPOUYEe12S6qa3Pt1CayqrKU9QSlSh/
	T6sxIkf6TtwlmQOV+zK8Mkq64e7VOyWw=
X-Received: by 2002:a05:600c:1f18:b0:40d:5691:c79b with SMTP id bd24-20020a05600c1f1800b0040d5691c79bmr665887wmb.161.1703514059722;
        Mon, 25 Dec 2023 06:20:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE8e5P/wgQQYi0Z/keqL4AEB+Av4CdVoK8jSIR0wDYo70sScwXW6JKxyKYm5R3s7NwLZBf7A==
X-Received: by 2002:a05:600c:1f18:b0:40d:5691:c79b with SMTP id bd24-20020a05600c1f1800b0040d5691c79bmr665876wmb.161.1703514059325;
        Mon, 25 Dec 2023 06:20:59 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c450300b0040c4acaa4bfsm25205840wmo.19.2023.12.25.06.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 06:20:58 -0800 (PST)
Date: Mon, 25 Dec 2023 09:20:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231225092010-mutt-send-email-mst@kernel.org>
References: <20231207043118.118158-1-fengli@smartx.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207043118.118158-1-fengli@smartx.com>

On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
> virtio-blk is generally used in cloud computing scenarios, where the
> performance of virtual disks is very important. The mq-deadline scheduler
> has a big performance drop compared to none with single queue. In my tests,
> mq-deadline 4k readread iops were 270k compared to 450k for none. So here
> the default scheduler of virtio-blk is set to "none".
> 
> Signed-off-by: Li Feng <fengli@smartx.com>

I dropped this for now, pls try to address comments by Christoph/Paolo
if it's still needed

> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index d53d6aa8ee69..5183ec8e00be 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1367,7 +1367,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	vblk->tag_set.ops = &virtio_mq_ops;
>  	vblk->tag_set.queue_depth = queue_depth;
>  	vblk->tag_set.numa_node = NUMA_NO_NODE;
> -	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> +	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_NO_SCHED_BY_DEFAULT;
>  	vblk->tag_set.cmd_size =
>  		sizeof(struct virtblk_req) +
>  		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
> -- 
> 2.42.0

