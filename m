Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B88C397E86
	for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158222; cv=pass; b=ppJD0jETU4ztmxCkQd0AoRDwSCGKOTCCpIlay5p5VoRzhE+BTLWYIgDIQ3ygnuv1n+YuTwPRF4C1jKdyXYaUns5Dfsr8H0TLphjiErGuImCIkyQO3SFPrVQAmooHYbT1onBUGkqmvx8XPSrrwCRmtsBS5ZOIquIIzvSDkbph/Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158222; c=relaxed/simple;
	bh=aZ3QAAiJWKfJPFdOqgfaghwjaxM2wYZxCugoj3b5jMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPkAb/94uLgk4gbGKSDaRZ+Rd+OMDdLEg4DaNPuurwEj1ZPeBJdMNvVb89TrYqHBKVxstHW8HFi/lABZvMpDWtsE8r583CUD2/8lkIAI1uawYSdZxmvkNUM3BKCc+RnvPR5695got8dJ9/1tXiMqful+cEUUaU89Y5bioScHhHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GDcXq3rA; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GDcXq3rA"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4170dc73280so308863fac.0
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2026 08:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773158220; cv=none;
        d=google.com; s=arc-20240605;
        b=f+QVdHOdOxZ8dLwE13K+JXXuDUoiSdKyDJlsELU9QB2TN+EUDszw1utRSPHtJ0Ghi/
         Jnyu6s4gP31eaFSX3/HMnIBHw/Ya2oTRPPUAXOzInLU4WRso9/oECHFSofNdDiV9cBfT
         e2jlt7lN8XNYpSxhYBfmLv2evwb51na3UgN7PRRrnb+tvRhCKwG9vQtBZX+UprvWp2dx
         pcDD6dmqt9Ad4JWkYXCatC8pjkqom7SSf7dpv2bR/QocqIUFI+KIZ4pr7QHxMksj+PWB
         abrnfNYwl6IA8ZHFLMY8BKAsTB9uqry6xjV2inDR1y1oa5hpnnSGVsNRlGLiPmaY4h4s
         MyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k0ZfmdoKETAu32CUc6DaYZn/AQfT5ZtxxhfQJEgADr8=;
        fh=7X9zXuH135AC1R/SMwvjmf1kNRlPJDVJr053UTzP664=;
        b=UQhLbb6jEBTluDuJsTJ42BTH8yJiiuIylD7+VeAHBp1cjnVz38x5jBfkBqcCp+CCj0
         70JJf95PGy1VMVqaEa9OIGYLjiBP2tWrP/1jBtnojr+LQVcSHCT7OP/KZ3+9s0pMGXQF
         3ZzH7i7psM4zfdcMQf16auMB7DswudW8MNaegXEbaU9WRmArbk2RuqccOb6t1rEAptdH
         PgIYs4ILIjpIeeXGZcRQ4k5xVHpH7WnbL0R0ok9JXyTZX4C3PLxH4HchZRnggJhVGcN4
         hqkiFr2Njw2mj45SkjGaQUBUJI+80YZ3Kv2xTl/4BCc4Z4wOm0DYEjYhixLpwB1k4Y/y
         T6eQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773158220; x=1773763020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0ZfmdoKETAu32CUc6DaYZn/AQfT5ZtxxhfQJEgADr8=;
        b=GDcXq3rAFXxU75wmb/baSS7kiq0Izs5ejpXTDlbCCEsFiSK6DqqnEAU29+gk6XyvJN
         JBs7A9dqq5gzucsJqNvHNVQbGnfIIF+KocmycQSy0I5MZCKILwnemDU00m0Ar6BCqyuq
         tGmYt1NEgfI8jCXLIl/ba/3AtU9Xo4zxEg3L0gdRZcGbw3FvaoNK6pspAHnxopkco+bY
         qoCfG56sB2p8qkc2AWoSip5aFK7nSj6mNaktw3/6pC3HO36XgFyO0/3nMx5Phg76syp8
         HzXabqqwOoZ2HxVDyUFdPPzvKY4jImNKwXTh72ab6DjQbq/5uMW5P/gFN6OkVjWRNwQp
         Lvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158220; x=1773763020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k0ZfmdoKETAu32CUc6DaYZn/AQfT5ZtxxhfQJEgADr8=;
        b=AZ0Zih9Tn9UZz9kldfKiPyg92TlS/HOC8ZTKLOvjC2890O1FayixMylHar7sKQuDMN
         cEMTtENZJTN0gxIgqD1YFMPjnStCLsYI2ZOnsnfod6MDh0R5B4yZ+N0lX/siZfsJ0TEO
         9S16x4p3RlU3iaJt7MTJUJtISEwAQVfkDu5M+Snlz8AOhZ4dSgnMolyatHQYctqNU2TO
         RX6WUp6Lg9aNwtP2U/CsneuGr+Ez7Q9XCikTLiy64+yr7PwG8EsXF2/jZyl+ZL/Gj2nJ
         1dbcZ4qo/qFmJhxOCjIwGJEOnkqVjPyuMw58O1QduHHuq3NELb3sAU5+nNdwOIxVnjFu
         eCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa0C/xQjPpPDZKVVZ4uUxLwcg3VjjmleaK3ak+XEPDI6QS0OmpdPQ4FZUaQd6dmop9dj/5K6sa6HJVtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYbdToSWinchiYfrteLJpydFNv7S1zla04p8CbyTSs2Q9E1+N
	5F1LxKR7TUex1DAsjcTy+/gDSwDM1Nt4T0En4X7vlGC5SRmhWedmNimWi3F02uZJ9kKt8E9bLqX
	HsFfeM9PIIa1c4RQkkpu4DkLF+YX37L41TReBmtMDbg==
X-Gm-Gg: ATEYQzxJhgfNkk8JiBIgHAXusfEYRqr9meTacqG3HLvxXq0D9FHfNJZZUm+L1q1mC61
	69+Cr6Gy9EIiSD9NbvF34JPMY1MzTgTqfGPrL8wSkL04gOy8q8AIKoa/439briAvISE0M62a4pi
	wrqzNmiTy1OVP5DhdqWjfqGGRI+c6f1ZMEGJ78SSptsbBj+9XQzdoMb10/5YZUCUwFW7vyB8OlM
	RcBAG20/yCUD/eeTTiztrZ7QDtXWqXKp8ad4EMPvyiKudCOYGPo+Al4oSDKtQPKsiRyjGEpg71S
	UuQVXD8i
X-Received: by 2002:a05:6870:854b:b0:416:3f50:ea2 with SMTP id
 586e51a60fabf-416e45c1dc6mr7199342fac.8.1773158220092; Tue, 10 Mar 2026
 08:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309062840.2937858-2-iam@sung-woo.kim> <CADUfDZorSQCVtQyfjBuaziwG2Jo28yZiiqLKbp9PkFFw-9VgfQ@mail.gmail.com>
 <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
In-Reply-To: <CAJNyHp+i3M_ko7rhgTz=nxP=MZYM3oQf3L-y=7YnhnRyeUxayA@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 10 Mar 2026 08:56:48 -0700
X-Gm-Features: AaiRm52sHfM1lLReXhJ6K_-eQeuNMsoWbyv4AHit6rY5_ursGYcV9eDpU-ihUic
Message-ID: <CADUfDZppWyOOPME0eJbmO1q+qvehxGiCk8Zz_nVxaQk08aukFw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: nvme: Fix general protection fault in nvme_setup_descriptor_pools()
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chao Shi <cshi008@fiu.edu>, 
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 4:55=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wrote=
:
>
> On Mon, Mar 9, 2026 at 11:31=E2=80=AFAM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Sun, Mar 8, 2026 at 11:30=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> =
wrote:
> > >
> > > The numa_node can be < 0 since NUMA_NO_NODE =3D -1. However,
> > > struct blk_mq_hw_ctx{} defines numa_node as unsigned int. As a result=
,
> > > numa_node is set to UINT_MAX for NUMA_NO_NODE in blk_mq_alloc_hctx().
> >
> > The node argument to blk_mq_alloc_hctx() comes from
> > blk_mq_alloc_and_init_hctx(), which is called by
> > blk_mq_alloc_and_init_hctx() with int node =3D blk_mq_get_hctx_node(set=
,
> > i). node =3D NUMA_NO_NODE would suggest that blk_mq_hw_queue_to_node()
> > doesn't find any CPU affinitized to the queue. Is that even possible?
>
> Thanks for your review, Celeb.

While I'm flattered you consider me a celebrity, my name is Caleb :)

>
> blk_mq_hw_queue_to_node() can return NUMA_NO_NODE if the device queues
> exceed the
> number of CPUs. Afterward, it is adjusted on the caller side to
> numa_node =3D set->numa_node.

I thought the NVMe driver capped the number of queues so every queue
is affinitized to some CPU (see nvme_max_io_queues()). What am I
missing?

Best,
Caleb

>
> set->numa_node can still be NUMA_NO_NODE if CONFIG_NUMA=3Dn (trivial) or
> pcibus_to_node() returns NUMA_NO_NODE if ACPI doesn't provide
> proximity information.
> But I'm not sure if this is usual in the real machines. We found the
> crash in QEMU.
>
> > >  static struct nvme_descriptor_pools *
> > > -nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node=
)
> > > +nvme_setup_descriptor_pools(struct nvme_dev *dev, int numa_node)
> > >  {
> > > -       struct nvme_descriptor_pools *pools =3D &dev->descriptor_pool=
s[numa_node];
> > > +       struct nvme_descriptor_pools *pools;
> > >         size_t small_align =3D NVME_SMALL_POOL_SIZE;
> > >
> > > +       if (numa_node =3D=3D NUMA_NO_NODE)
> > > +               pools =3D &dev->descriptor_pools[numa_node_id()];
> > > +       else
> > > +               pools =3D &dev->descriptor_pools[numa_node];
> >
> > Simpler: if (numa_node =3D=3D NUMA_NO_NODE) numa_node =3D numa_node_id(=
);
> >
>
> Thanks, I will modify it in V2.
>
> Sungwoo.
