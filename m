Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A3482DD
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401319; cv=none; b=E1v6Z1sT34+lj7FpEpPIwTsvoAZ4l6IYStOSG1UZUE4TGCMdvIFDoS5B6bwqfhT6R1OuU0h1tz6KaMcSmiwuZ3RrmuRHdq36oFE6Sq40KXT8D+0dl7lih1MAzyDcU8lb84pgJc4u0UOyXhT+GGMlP8GqYu1N3OmiQ5ymQJ5RpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401319; c=relaxed/simple;
	bh=uPuIiUbsfbaVY8C1ARkHWtTdlRSDUTpdWk9CZsPNLcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsQSSyRtvphwfzTsatjwtd1scVc6ZVlun9tFLlDKUeHfnuL1SgzJ6ZtemGPKEfL793jNc7rcYZKuwIxanrfosDM9KyayK0SA5n62w2Jg/aIfn9l/oFWd/EtqNO10dr3iMo3AZkBsLzkTRKgfsWA7/LMJhKW0ZMI6286SW7sx+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFvvBJy/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFvvBJy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734401316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BC3XHS0g1+Pm5jNP82Vf/B/xxujhL2pP6iO6VJ0dVao=;
	b=dFvvBJy/BWEEq7e8hqQ2K5JdYKs7Z6raK5gIzw6698PR1eP/YDUspdih/TreseTEt62Lof
	wNBG5ixGCmvE6yxV3frE36Xp7WZQapGXz9nJaOLNQvYvHV4EWLDbr03y6AXqN0Rdniogq6
	AAuxombK/GtK7QtcfJqBU+RlBbzz+eg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-4s6gwpdXOJC2H4a1D7C6wQ-1; Mon, 16 Dec 2024 21:08:34 -0500
X-MC-Unique: 4s6gwpdXOJC2H4a1D7C6wQ-1
X-Mimecast-MFC-AGG-ID: 4s6gwpdXOJC2H4a1D7C6wQ
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7fcd2430636so3193440a12.2
        for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 18:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734401314; x=1735006114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BC3XHS0g1+Pm5jNP82Vf/B/xxujhL2pP6iO6VJ0dVao=;
        b=vye69v3q2fZOciJknn9wQOtsibJLsGO2+El5mq18rJJwnQVqX/Dbs1jPemY0bO1YV7
         0Yl0HHnya0vOSS4R18/5ypNgLLtuP4q9Vh1zErLQa+YQPskaYoCzLYtkThyxZSnElIit
         nbq96Da/84XssVfcawJYvmiAZUDN9YscrSCQvZbbWdd8aKiFPL9oCKQQKeEqiXioVlAm
         uspTN4JzpzsV+rIHYMziavYS9oxX9SuIDGAQjsCUOU5i+Dy2WcxgiqAu3xWeDhM3y/p2
         /Z4gSlSOmf0lXU/X44/2T+t1fZkWfQWYVm9/n8wIfNYZJLDIU9S7OPwVi4KU/I9W/f2x
         RPrg==
X-Forwarded-Encrypted: i=1; AJvYcCXqkoe+Q40MogCV4LrEvKKy/BRBRwWMXtMH6iySIXHSTqq9cQViUZLngGCLFJ3+r0f15jORghpCtOWmCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ElkBDRGzemsAIf/IZFATa90pNPXXbM4d0j6TrQM+n83ZiaH8
	42dKsXhiqY2mdi6g1juv9zJRkXfraUDXuJWwNDBex4q6GuX5QQQWCh4zQdeBNqEM30uj8hxuN/0
	XqsC7iDbxrf5ceabh8dL8s4A+IXigvt/rmjeBf5aQXM5vgsJFK6aLBoCwCeIactwuJgSP4RCIxY
	8+YUZYytrz1P2/Qcg5hWyDh7D4LZm87aDo/+k=
X-Gm-Gg: ASbGnctD9Wu/zItv7ka7pdUdckBRnwpjuLoC0+/MKnfNhWD45eNvd+T/gVwLBWQEvFf
	wihYWeoWHEIIDiuQnM24oCes5p73XZZNBEn7F1lE=
X-Received: by 2002:a17:90b:184f:b0:2ee:964e:67ce with SMTP id 98e67ed59e1d1-2f28fa54f41mr20682458a91.3.1734401313826;
        Mon, 16 Dec 2024 18:08:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfMpqPFGAQFMOheaP9Yc1CtnnOl4j6a294K7HSySSXs4dpUWZNqPIp6FbuAeM2HZd4FWrBbt/h0vjti8cfQ+U=
X-Received: by 2002:a17:90b:184f:b0:2ee:964e:67ce with SMTP id
 98e67ed59e1d1-2f28fa54f41mr20682422a91.3.1734401313332; Mon, 16 Dec 2024
 18:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203121424.19887-1-mengferry@linux.alibaba.com>
 <2d4ad724-f9da-4502-9079-432935f5719d@linux.alibaba.com> <CACGkMEuAgAcCDrCMhNHr7gcRB6NtMPPLdSFAOGdt4dXGoQr4Yg@mail.gmail.com>
 <60fd6f1a-ddf5-4b53-8353-18dcd8f6f93c@linux.alibaba.com>
In-Reply-To: <60fd6f1a-ddf5-4b53-8353-18dcd8f6f93c@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Dec 2024 10:08:21 +0800
Message-ID: <CACGkMEu4=nt0R1pmTauuK_vcc_fbObmyWqe0TO0HhuexmZWHJQ@mail.gmail.com>
Subject: Re: [PATCH 0/3][RFC] virtio-blk: add io_uring passthrough support for virtio-blk
To: Ferry Meng <mengferry@linux.alibaba.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 8:07=E2=80=AFPM Ferry Meng <mengferry@linux.alibaba=
.com> wrote:
>
>
> On 12/16/24 3:38 PM, Jason Wang wrote:
> > On Mon, Dec 16, 2024 at 10:01=E2=80=AFAM Ferry Meng <mengferry@linux.al=
ibaba.com> wrote:
> >>
> >> On 12/3/24 8:14 PM, Ferry Meng wrote:
> >>> We seek to develop a more flexible way to use virtio-blk and bypass t=
he block
> >>> layer logic in order to accomplish certain performance optimizations.=
 As a
> >>> result, we referred to the implementation of io_uring passthrough in =
NVMe
> >>> and implemented it in the virtio-blk driver. This patch series adds i=
o_uring
> >>> passthrough support for virtio-blk devices, resulting in lower submit=
 latency
> >>> and increased flexibility when utilizing virtio-blk.
> >>>
> >>> To test this patch series, I changed fio's code:
> >>> 1. Added virtio-blk support to engines/io_uring.c.
> >>> 2. Added virtio-blk support to the t/io_uring.c testing tool.
> >>> Link: https://github.com/jdmfr/fio
> >>>
> >>> Using t/io_uring-vblk, the performance of virtio-blk based on uring-c=
md
> >>> scales better than block device access. (such as below, Virtio-Blk wi=
th QEMU,
> >>> 1-depth fio)
> >>> (passthru) read: IOPS=3D17.2k, BW=3D67.4MiB/s (70.6MB/s)
> >>> slat (nsec): min=3D2907, max=3D43592, avg=3D3981.87, stdev=3D595.10
> >>> clat (usec): min=3D38, max=3D285,avg=3D53.47, stdev=3D 8.28
> >>> lat (usec): min=3D44, max=3D288, avg=3D57.45, stdev=3D 8.28
> >>> (block) read: IOPS=3D15.3k, BW=3D59.8MiB/s (62.7MB/s)
> >>> slat (nsec): min=3D3408, max=3D35366, avg=3D5102.17, stdev=3D790.79
> >>> clat (usec): min=3D35, max=3D343, avg=3D59.63, stdev=3D10.26
> >>> lat (usec): min=3D43, max=3D349, avg=3D64.73, stdev=3D10.21
> >>>
> >>> Testing the virtio-blk device with fio using 'engines=3Dio_uring_cmd'
> >>> and 'engines=3Dio_uring' also demonstrates improvements in submit lat=
ency.
> >>> (passthru) taskset -c 0 t/io_uring-vblk -b4096 -d8 -c4 -s4 -p0 -F1 -B=
0 -O0 -n1 -u1 /dev/vdcc0
> >>> IOPS=3D189.80K, BW=3D741MiB/s, IOS/call=3D4/3
> >>> IOPS=3D187.68K, BW=3D733MiB/s, IOS/call=3D4/3
> >>> (block) taskset -c 0 t/io_uring-vblk -b4096 -d8 -c4 -s4 -p0 -F1 -B0 -=
O0 -n1 -u0 /dev/vdc
> >>> IOPS=3D101.51K, BW=3D396MiB/s, IOS/call=3D4/3
> >>> IOPS=3D100.01K, BW=3D390MiB/s, IOS/call=3D4/4
> >>>
> >>> The performance overhead of submitting IO can be decreased by 25% ove=
rall
> >>> with this patch series. The implementation primarily references 'nvme=
 io_uring
> >>> passthrough', supporting io_uring_cmd through a separate character in=
terface
> >>> (temporarily named /dev/vdXc0). Since this is an early version, many
> >>> details need to be taken into account and redesigned, like:
> >>> =E2=97=8F Currently, it only considers READ/WRITE scenarios, some mor=
e complex operations
> >>> not included like discard or zone ops.(Normal sqe64 is sufficient, in=
 my opinion;
> >>> following upgrades, sqe128 and cqe32 might not be needed).
> >>> =E2=97=8F ......
> >>>
> >>> I would appreciate any useful recommendations.
> >>>
> >>> Ferry Meng (3):
> >>>     virtio-blk: add virtio-blk chardev support.
> >>>     virtio-blk: add uring_cmd support for I/O passthru on chardev.
> >>>     virtio-blk: add uring_cmd iopoll support.
> >>>
> >>>    drivers/block/virtio_blk.c      | 325 ++++++++++++++++++++++++++++=
+++-
> >>>    include/uapi/linux/virtio_blk.h |  16 ++
> >>>    2 files changed, 336 insertions(+), 5 deletions(-)
> >> Hi, Micheal & Jason :
> >>
> >> What about yours' opinion? As virtio-blk maintainer. Looking forward t=
o
> >> your reply.
> >>
> >> Thanks
> > If I understand this correctly, this proposal wants to make io_uring a
> > transport of the virito-blk command. So the application doesn't need
> > to worry about compatibility etc. This seems to be fine.
> >
> > But I wonder what's the security consideration, for example do we
> > allow all virtio-blk commands to be passthroughs and why.
>
> About 'security consideration', the generic char-dev belongs to root, so
> only root can use this passthrough path.

This seems like a restriction. A lot of applications want to be run
without privilege to be safe.

>
> On the other hand, to what I know, virtio-blk commands are all related
> to 'I/O operations', so we can support all those opcodes with bypassing
> vfs&block layer (if we want). I just realized the most  basic read/write
> in this RFC patch series, others will be considered later.
>
> > Thanks
> >
>

Thanks

