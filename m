Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FCE3EA96
	for <linux-block@vger.kernel.org>; Sun, 28 Apr 2024 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714299012; cv=none; b=BePSxjaf6k8Y2008tVxMl/xahy4rbdrZ8fT7It5wV1EWw37RY/advh3OjjCDitO6sfU0ybkhIU7Qw/y3Pe1q+5la3XGzSMT5FuPjNCs6Sf9kUQLV/Ezz8k3Gk0gyVxEDlm2Z/cG/UE6cilaXdQAnf2vQJMV2YP7fPD5GQW9xZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714299012; c=relaxed/simple;
	bh=l3cCD109BVBiaVEb0tzORruFQyzUbGBplhhybkO1Jj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYEaVNs+Bd4irErFAHGDzXtHWfVOOOnG59Zzfqafg1dsOFCtgLiEJGTq+rb+xn6nagxADUvn9FajjcZK1xkwnkhmBi9ZA+6uZQk4m3JaWxrHu0cocl8bZ5pp8LAaQ2L7BsGlL87pifQMfeTa/MxA/x+7wWV2aG4obMx0rGKFVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5WxM7zQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5WxM7zQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714299008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXJOhH7CVRCRiVspfeQqSxTG96s55mVoNwkdLYoGsTs=;
	b=h5WxM7zQhqyWm6+ykp0RzolX7E7eTPAZweqqtJdkiqPKfQdPitGytQWrqmPNKmjOuhSZBz
	GvEff8Fnh8SGDs0G0RyrA7z5L+Apg/PV3ky9VgxybuIZE4mWsxDc2Xw1M6Rp7M1QZR2tmr
	DXSPy3GMOCSlPY5cw5tbmudN+huGDdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-ZVSzzsC5PNSDHVcsZcHcyg-1; Sun, 28 Apr 2024 06:10:06 -0400
X-MC-Unique: ZVSzzsC5PNSDHVcsZcHcyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00FC918065AA
	for <linux-block@vger.kernel.org>; Sun, 28 Apr 2024 10:10:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7069B1C060D0;
	Sun, 28 Apr 2024 10:10:03 +0000 (UTC)
Date: Sun, 28 Apr 2024 18:09:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Guangwu Zhang <guazhang@redhat.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [bug report] Format FS failed with ublk device
Message-ID: <Zi4gdxplmOFyE464@fedora>
References: <CAGS2=YobBtv0JnQJSYcu9x57y_VqS7-4NemWjsFdaPcpLLVm1Q@mail.gmail.com>
 <Zir+5VZOgip+HiFU@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zir+5VZOgip+HiFU@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Fri, Apr 26, 2024 at 09:09:57AM +0800, Ming Lei wrote:
> Hi Guangwu,
> 
> Thanks for the report!
> 
> On Thu, Apr 25, 2024 at 09:54:04AM +0800, Guangwu Zhang wrote:
> > Hi,
> > the format FS command will hung up  with ublk device.
> > 
> > # ublk --version
> > ublksrv 1.1-7-gf01c509
> > 
> > kerne: 6.9.0-rc4.kasan
> > 
> > 
> > nvme0n1                     259:1    0   1.5T  0 disk
> > └─nvme0n1p1                 259:2    0     5G  0 part
> > # ublk add -t loop -f /dev/nvme0n1p1
> > dev id 0: nr_hw_queues 1 queue_depth 128 block size 4096 dev_capacity 10485760
> > max rq size 524288 daemon pid 3227 flags 0x42 state LIVE
> > ublkc: 245:0 ublkb: 259:3 owner: 0:0
> > queue 0: tid 3228 affinity(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
> > 18 19 20 21 22 23 24 25 26 27 28 29 30 31 )
> > target {"backing_file":"/dev/nvme0n1p1","dev_size":5368709120,"direct_io":1,"name":"loop","type":1}
> > 
> > # mkfs.xfs -f /dev/ublkb0    << can not finish,  pid 3239
> > meta-data=/dev/ublkb0            isize=512    agcount=4, agsize=327680 blks
> >          =                       sectsz=4096  attr=2, projid32bit=1
> >          =                       crc=1        finobt=1, sparse=1, rmapbt=0
> >          =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
> > data     =                       bsize=4096   blocks=1310720, imaxpct=25
> >          =                       sunit=0      swidth=0 blks
> > naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> > log      =internal log           bsize=4096   blocks=16384, version=2
> >          =                       sectsz=4096  sunit=1 blks, lazy-count=1
> > realtime =none                   extsz=4096   blocks=0, rtextents=0
> > 
> > # cat /proc/3239/stack
> > [<0>] rq_qos_wait+0x12a/0x1f0
> > [<0>] wbt_wait+0x11a/0x240
> > [<0>] __rq_qos_throttle+0x49/0x90
> > [<0>] blk_mq_submit_bio+0x58c/0x19d0
> > [<0>] submit_bio_noacct_nocheck+0x40d/0x780
> > [<0>] blk_next_bio+0x41/0x50
> > [<0>] __blkdev_issue_zero_pages+0x1ba/0x370
> > [<0>] blkdev_issue_zeroout+0x1a7/0x390
> > [<0>] blkdev_fallocate+0x264/0x3d0
> > [<0>] vfs_fallocate+0x2b0/0xad0
> > [<0>] __x64_sys_fallocate+0xb4/0x100
> > [<0>] do_syscall_64+0x7b/0x160
> > [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > 
> > [  862.171377] INFO: task mkfs.xfs:3239 blocked for more than 122 seconds.
> > [  862.178073]       Not tainted 6.9.0-rc4.kasan+ #1
> > [  862.182820] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> 
> Looks it might be one blk-wbt issue, and ublk-loop doesn't setup
> write_zero_max_bytes and it may take a bit long for __blkdev_issue_zero_pages
> to complete, but it shouldn't hang.
> 
> Can you collect the following bpftrace by starting it before running mkfs?
> And I can't reproduce it in my environment.
> 
> #!/usr/bin/bpftrace
> kretfunc:vfs_fallocate
> {
> 	printf("vfs_fallocate on %s ret %d (%x %lx %u)\n",
> 		str(args->file->f_path.dentry->d_name.name),
> 		retval, args->mode, args->offset, args->len);
> }

After co-working with Guangwu, the issue is now root-caused:

1) vfs_fallocate() can't translate block DISCARD into real discard, and
'FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE'
is supposed to be capable of doing that, but vfs doesn't allow
FALLOC_FL_NO_HIDE_STALE

2) so ublk discard is actually converted to write-zeroes because ublksrv
converts discard into fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE),
and that is the reason why mkfs.xfs takes too long, and Guangwu confirmed
that zeroing out is in-progress actually, not hang.

Does FALLOC_FL_PUNCH_HOLE have to imply zeroing out for block device?

3) now fix is pushed to ublksrv by translating ublk discard into
ioctl(DISCARD) for block device

And same issue exists on kernel loop driver too.

Thanks,
Ming

