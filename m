Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04676FA8
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714093811; cv=none; b=gmVgB2KtupXUmdWKTDHqrNIRnTdqZcHsLA4j+10T4JkGOpmkaRzMvA2fOgFEsSYCdDtA7I4GPBP3uY3YkkqwUAPgKY9IfGS784GkkGpEYoHJBw+I6jPG8iEtthHGxIT3ddpEnrQnL2W6TiQuew/PNpcLzkdkRGWsQRvrBhYQkkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714093811; c=relaxed/simple;
	bh=PRvUmOVRZi+gT17s6TtQpkOyxX0WV7G4DYr36r04TJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJhSQaJ3Feo86cTvciFOmn5RhOwM/y7/ldDjLgGsteBLFc6uBmcv/2E94v6XSC8P674B4oCLs9L7r4HSGjwBysYWpjBrt2X38A8iVNG7W60pcsD5HLQLlXK76kEsDPLxOyfCtoOr0iby6z8HU2djnfmjHMZJJDFwniw3QiGx8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pds8qYTw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pds8qYTw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714093807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFZTvPt7J7qdhC763ZbrqlmaiMn4TAxswO3mR8BsFwo=;
	b=Pds8qYTwUOSykNosNnZm1O9lJHfjPbyjWfgjhRoPH8gceESSt1ESZrrzU3u2hMDekiJ8u7
	BtVRcvyqVFiGwuuQ3yU4gKtokPtVAhfyOmQAb8Fs1i9UytuJCu8/mZqAc5sXzvVNHretp3
	UP8oYtvfFSbCpOQqAOLIMNlLZ9wi5vw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-jdZwS-R9PDe1lo4qmV0nnw-1; Thu,
 25 Apr 2024 21:10:05 -0400
X-MC-Unique: jdZwS-R9PDe1lo4qmV0nnw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52B851C068C5
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 01:10:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EB5A5AE081;
	Fri, 26 Apr 2024 01:10:01 +0000 (UTC)
Date: Fri, 26 Apr 2024 09:09:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Guangwu Zhang <guazhang@redhat.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [bug report] Format FS failed with ublk device
Message-ID: <Zir+5VZOgip+HiFU@fedora>
References: <CAGS2=YobBtv0JnQJSYcu9x57y_VqS7-4NemWjsFdaPcpLLVm1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGS2=YobBtv0JnQJSYcu9x57y_VqS7-4NemWjsFdaPcpLLVm1Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hi Guangwu,

Thanks for the report!

On Thu, Apr 25, 2024 at 09:54:04AM +0800, Guangwu Zhang wrote:
> Hi,
> the format FS command will hung up  with ublk device.
> 
> # ublk --version
> ublksrv 1.1-7-gf01c509
> 
> kerne: 6.9.0-rc4.kasan
> 
> 
> nvme0n1                     259:1    0   1.5T  0 disk
> └─nvme0n1p1                 259:2    0     5G  0 part
> # ublk add -t loop -f /dev/nvme0n1p1
> dev id 0: nr_hw_queues 1 queue_depth 128 block size 4096 dev_capacity 10485760
> max rq size 524288 daemon pid 3227 flags 0x42 state LIVE
> ublkc: 245:0 ublkb: 259:3 owner: 0:0
> queue 0: tid 3228 affinity(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
> 18 19 20 21 22 23 24 25 26 27 28 29 30 31 )
> target {"backing_file":"/dev/nvme0n1p1","dev_size":5368709120,"direct_io":1,"name":"loop","type":1}
> 
> # mkfs.xfs -f /dev/ublkb0    << can not finish,  pid 3239
> meta-data=/dev/ublkb0            isize=512    agcount=4, agsize=327680 blks
>          =                       sectsz=4096  attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=1, rmapbt=0
>          =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
> data     =                       bsize=4096   blocks=1310720, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> log      =internal log           bsize=4096   blocks=16384, version=2
>          =                       sectsz=4096  sunit=1 blks, lazy-count=1
> realtime =none                   extsz=4096   blocks=0, rtextents=0
> 
> # cat /proc/3239/stack
> [<0>] rq_qos_wait+0x12a/0x1f0
> [<0>] wbt_wait+0x11a/0x240
> [<0>] __rq_qos_throttle+0x49/0x90
> [<0>] blk_mq_submit_bio+0x58c/0x19d0
> [<0>] submit_bio_noacct_nocheck+0x40d/0x780
> [<0>] blk_next_bio+0x41/0x50
> [<0>] __blkdev_issue_zero_pages+0x1ba/0x370
> [<0>] blkdev_issue_zeroout+0x1a7/0x390
> [<0>] blkdev_fallocate+0x264/0x3d0
> [<0>] vfs_fallocate+0x2b0/0xad0
> [<0>] __x64_sys_fallocate+0xb4/0x100
> [<0>] do_syscall_64+0x7b/0x160
> [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [  862.171377] INFO: task mkfs.xfs:3239 blocked for more than 122 seconds.
> [  862.178073]       Not tainted 6.9.0-rc4.kasan+ #1
> [  862.182820] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.

Looks it might be one blk-wbt issue, and ublk-loop doesn't setup
write_zero_max_bytes and it may take a bit long for __blkdev_issue_zero_pages
to complete, but it shouldn't hang.

Can you collect the following bpftrace by starting it before running mkfs?
And I can't reproduce it in my environment.

#!/usr/bin/bpftrace
kretfunc:vfs_fallocate
{
	printf("vfs_fallocate on %s ret %d (%x %lx %u)\n",
		str(args->file->f_path.dentry->d_name.name),
		retval, args->mode, args->offset, args->len);
}


Thanks,
Ming

