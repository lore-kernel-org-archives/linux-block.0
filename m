Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAFF1FC7D9
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734597080; cv=none; b=QlS6K3QK3KZHAPjXaQ2SnQyce/s39tjCJobHIbO/fD32O31SHk9dDIPMrSFgP43rQhNb0K9kTEGOS3a/T64wWCEZ6bOj9Gt1zGQFoPD0GQoyXM3xgBi7RVNuwTQjFUOSpjLm4QD7L5MMkWLH2iVtPe22e9BGQRkKZLwsdc+iCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734597080; c=relaxed/simple;
	bh=2IM8Isl/HvcjVPdOdCc+YEyWJcS5dGDRruGLb2kRjFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5+dpCgw7qMAMwRiuTduLEwrL/0r/pEp1sHGTKccubmCCWaoduzrNPlMzGgz6WibRwUug1UM4J+MUues5EWdpLSWm37dnolKGCEazPLNqKkGjcfKsQ0ohnUrWnx0Xbszj2hxHlO9BOR/f/tvCZGsTjo7LqM9czmWnUyuXCbuG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zx4accGI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zx4accGI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734597078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HKgfqq1V/q2Bw/na+eWOMQ9Qre2mVUN/gi9oaR1AL+A=;
	b=Zx4accGIe07HfV0SCAeZZWSgNa9Rjz/OqD2X8vdwSQ0QveNV2l5WGHIzHklgOR/sjwPHp1
	EwFAZJWmiL1E1D2NtCxMQrjmeawEFqlKICDGcVSVsbE9aWORqcj3xP7tx2fIZ+Ix3A2Ydn
	BradhHY7lm/WxFoNdWNya8tnAz+dO7Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-iT9FEf2YMgiJzFifOjHtTA-1; Thu, 19 Dec 2024 03:31:16 -0500
X-MC-Unique: iT9FEf2YMgiJzFifOjHtTA-1
X-Mimecast-MFC-AGG-ID: iT9FEf2YMgiJzFifOjHtTA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43610eba55bso4146015e9.3
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 00:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734597075; x=1735201875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKgfqq1V/q2Bw/na+eWOMQ9Qre2mVUN/gi9oaR1AL+A=;
        b=E9NVGmoorCXBeWB3kDI6e1wPlNBdkbREBweejCUMerPKqiwpR9BpcHqT63gwgJKyAF
         yJY6ULbNxCO2YoAhlDADU4pAGSRnFzfcjuitLktENZx5sqtaBiuGrpMOkvX6MizAT7NF
         qqmPlOxtn4A/KU7bM7AFgZanALGjQfAAumkvdIs3M7UNayzwz/PTTIj8KC3YzcqkDqp9
         idLc9MP1zxsgyvtRDwAdyh8qq68aRh68NF0T48dUbceb49hLf1C9Huz0CkKV6MExgxvz
         AiVT2QsYC9jdkmog+v+T0WWXPruGuMUJkvjkCISWkAQ14gwqUn0HduIcfwXJGQ6vog8f
         3iXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Ljmtmz1NYCsTg4L4ZvYtBg2goGM9O8ZZCIxhpx8U1gzeCFExvCJ9Wh2lxBv+dNvusaFGQs/5Bko/cA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9xAXOMgDSUfRmidCiGnjyGNT+5UjqppFgLdk9td6y+SMpQ2E
	mxdGHlGH+lyKETgFacPs2OMXc34ImUYffLevB8Pwn3mndiXYfPqoGfahJH8WsRQ8kCRSBFGhLCg
	+Qa65+AzeTmZ+Kny3+X4gM6egqQjab7UxUoUKnLL+qP8ESnbNF/ZC5bYW+q5h
X-Gm-Gg: ASbGncvIUfiz2LQQGMCmnh7Asox+kUlw7UgynkP9VeT6rBW3PWR3Brnbp568i8Vvpq7
	kHrrJ7rp60AQdQwCgoud7XKQNMZ/3CWdCXkAm/CjTJGgpWTy2myFNNCZXIWk65xBgUJx3RBOKj5
	6N8OxVh0U3D7rPuangd668KDMnx15nrGWw2rtjDD1/J5pnKrF9DpqzQEhpsMf0B6QjVYrVSimuO
	uHwxQ1UYvSlx6jxtymbQhecEZV2yw09khUvY3vB5weBaHWBLQ==
X-Received: by 2002:a05:600c:4ed2:b0:434:f7ea:fb44 with SMTP id 5b1f17b1804b1-4365535c6a3mr57458825e9.14.1734597075418;
        Thu, 19 Dec 2024 00:31:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmEAGsD3J5lAW4FA+s63y3sWjvKNvfQZ3gFL7w0rvckTj28XiNMSxT5zIucbWC042DWgnKHg==
X-Received: by 2002:a05:600c:4ed2:b0:434:f7ea:fb44 with SMTP id 5b1f17b1804b1-4365535c6a3mr57458095e9.14.1734597074934;
        Thu, 19 Dec 2024 00:31:14 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f6:4834:3deb:8c9:181b:4574])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4432dsm44515275e9.41.2024.12.19.00.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 00:31:14 -0800 (PST)
Date: Thu, 19 Dec 2024 03:31:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Don Brace <don.brace@microchip.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	storagedev@microchip.com, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 6/9] virtio: blk/scsi: use block layer helpers to
 calculate num of queues
Message-ID: <20241219032956-mutt-send-email-mst@kernel.org>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
 <20241217-isolcpus-io-queues-v4-6-5d355fbb1e14@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-isolcpus-io-queues-v4-6-5d355fbb1e14@kernel.org>

On Tue, Dec 17, 2024 at 07:29:40PM +0100, Daniel Wagner wrote:
> Multiqueue devices should only allocate queues for the housekeeping CPUs
> when isolcpus=managed_irq is set. This avoids that the isolated CPUs get
> disturbed with OS workload.
> 
> Use helpers which calculates the correct number of queues which should
> be used when isolcpus is used.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

The subject is misleading, one thinks it is onlu virtio blk.
It's best to just split each driver in a patch by its own.
for the changes in virtio:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c                | 5 ++---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 3 ++-
>  drivers/scsi/virtio_scsi.c                | 1 +
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index ed514ff46dc82acd629ae594cb0fa097bd301a9b..0287ceaaf19972f3a18e81cd2e3252e4d539ba93 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -976,9 +976,8 @@ static int init_vq(struct virtio_blk *vblk)
>  		return -EINVAL;
>  	}
>  
> -	num_vqs = min_t(unsigned int,
> -			min_not_zero(num_request_queues, nr_cpu_ids),
> -			num_vqs);
> +	num_vqs = blk_mq_num_possible_queues(
> +			min_not_zero(num_request_queues, num_vqs));
>  
>  	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
>  
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 59d385e5a917979ae2f61f5db2c3355b9cab7e08..3ff0978b3acb5baf757fee25d9fccf4971976272 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -6236,7 +6236,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
>  		intr_coalescing = (scratch_pad_1 & MR_INTR_COALESCING_SUPPORT_OFFSET) ?
>  								true : false;
>  		if (intr_coalescing &&
> -			(blk_mq_num_online_queues(0) >= MR_HIGH_IOPS_QUEUE_COUNT) &&
> +			(blk_mq_num_online_queues(0) >=
> +			 MR_HIGH_IOPS_QUEUE_COUNT) &&
>  			(instance->msix_vectors == MEGASAS_MAX_MSIX_QUEUES))
>  			instance->perf_mode = MR_BALANCED_PERF_MODE;
>  		else
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 60be1a0c61836ba643adcf9ad8d5b68563a86cb1..46ca0b82f57ce2211c7e2817dd40ee34e65bcbf9 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -919,6 +919,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
>  	/* We need to know how many queues before we allocate. */
>  	num_queues = virtscsi_config_get(vdev, num_queues) ? : 1;
>  	num_queues = min_t(unsigned int, nr_cpu_ids, num_queues);
> +	num_queues = blk_mq_num_possible_queues(num_queues);
>  
>  	num_targets = virtscsi_config_get(vdev, max_target) + 1;
>  
> 
> -- 
> 2.47.1

