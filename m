Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F21E1B4F3E
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175371; cv=none; b=OdDmUjsL8xn3STcVoPKWsJSaF30F8MFtN4FQX1ps95B2MkvZfp5vlXIwP4NNQzkBKJDUN/CFqSBqzHmqTRgXMEJmh1J0l1p49+WTQqwps875rFeV3mwnb3uszupBlFolpEZyX6LRO7sqq0MHKPa1bWuhX5sSCVedLji4gzvu0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175371; c=relaxed/simple;
	bh=mMyUxO2xfQ7AWglaQtx8v9BzekkDYpB8nHt5Nlx02eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K311TCk7u7OdAYzmX6P7q3WNszTYaXzc2/zbAWAXIGowm2zgbyUAyhuDknLozEkCxEvuqtyHy/QHkzXlrm6M6yuDITJG7P4N0kWVijhinnyZYtghLmHLbS73gGBmJX8cmaIrxwmphKQf/PbrRUZFEnDMHVaYkWIFeMuGyHRy2FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1MfQWMA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1MfQWMA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739175368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IPvVpyD8v3gwhBU9cBbxMFo483+v2xd73qwaib4B24=;
	b=L1MfQWMAqHQxzUJwlTcNOK4a7d5mn5Zzc2R4i7QrSEwxMkHQZBs3lwyA1w/X+/ajL9Xf/u
	bi4oAHddqh7fvVRpBvjm4DOjQH+4PkvUepsLVznC+vhiSXC9YyAzxdPgO0ZAR4DQpN3KzA
	Pc19P2+uwZnCXtdMv6F/1+3OII2N34g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-63XnAp8HNyiNKs3tJ1meXQ-1; Mon,
 10 Feb 2025 03:16:03 -0500
X-MC-Unique: 63XnAp8HNyiNKs3tJ1meXQ-1
X-Mimecast-MFC-AGG-ID: 63XnAp8HNyiNKs3tJ1meXQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B3A1180087F;
	Mon, 10 Feb 2025 08:16:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.149])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E34318004A7;
	Mon, 10 Feb 2025 08:15:55 +0000 (UTC)
Date: Mon, 10 Feb 2025 16:15:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	hch <hch@lst.de>, Ming Lei <minlei@redhat.com>
Subject: Re: [PATCH 7/7] block: don't grab q->debugfs_mutex
Message-ID: <Z6m1tsCORaHP9pr5@fedora>
References: <20250209122035.1327325-1-ming.lei@redhat.com>
 <20250209122035.1327325-8-ming.lei@redhat.com>
 <vc2tk5rrg4xs4vkxwirokp2ugzg6fpbmhlenw7xvjgpndkzere@peyfaxxwefj3>
 <CAFj5m9+-CMU52E1hpNsG+eXC4HsG82Ny7f=iJrdAfGScTFPD4Q@mail.gmail.com>
 <57253c19-1be3-496c-836b-5c56a59788f2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57253c19-1be3-496c-836b-5c56a59788f2@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 10, 2025 at 12:31:19PM +0530, Nilay Shroff wrote:
> 
> 
> On 2/10/25 7:12 AM, Ming Lei wrote:
> > On Mon, Feb 10, 2025 at 8:52 AM Shinichiro Kawasaki
> > <shinichiro.kawasaki@wdc.com> wrote:
> >>
> >> On Feb 09, 2025 / 20:20, Ming Lei wrote:
> >>> All block internal state for dealing adding/removing debugfs entries
> >>> have been removed, and debugfs can sync everything for us in fs level,
> >>> so don't grab q->debugfs_mutex for adding/removing block internal debugfs
> >>> entries.
> >>>
> >>> Now q->debugfs_mutex is only used for blktrace, meantime move creating
> >>> queue debugfs dir code out of q->sysfs_lock. Both the two locks are
> >>> connected with queue freeze IO lock.  Then queue freeze IO lock chain
> >>> with debugfs lock is cut.
> >>>
> >>> The following lockdep report can be fixed:
> >>>
> >>> https://lore.kernel.org/linux-block/ougniadskhks7uyxguxihgeuh2pv4yaqv4q3emo4gwuolgzdt6@brotly74p6bs/
> >>>
> >>> Follows contexts which adds/removes debugfs entries:
> >>>
> >>> - update nr_hw_queues
> >>>
> >>> - add/remove disks
> >>>
> >>> - elevator switch
> >>>
> >>> - blktrace
> >>>
> >>> blktrace only adds entries under disk top directory, so we can ignore it,
> >>> because it can only work iff disk is added. Also nothing overlapped with
> >>> the other two contex, blktrace context is fine.
> >>>
> >>> Elevator switch is only allowed after disk is added, so there isn't race
> >>> with add/remove disk. blk_mq_update_nr_hw_queues() always restores to
> >>> previous elevator, so no race between these two. Elevator switch context
> >>> is fine.
> >>>
> >>> So far blk_mq_update_nr_hw_queues() doesn't hold debugfs lock for
> >>> adding/removing hctx entries, there might be race with add/remove disk,
> >>> which is just fine in reality:
> >>>
> >>> - blk_mq_update_nr_hw_queues() is usually for error recovery, and disk
> >>> won't be added/removed at the same time
> >>>
> >>> - even though there is race between the two contexts, it is just fine,
> >>> since hctx won't be freed until queue is dead
> >>>
> >>> - we never see reports in this area without holding debugfs in
> >>> blk_mq_update_nr_hw_queues()
> >>>
> >>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>
> >> Ming, thank you for this quick action. I applied this series on top of
> >> v6.14-rc1 kernel and ran the block/002 test case. Unfortunately, still if fails
> >> occasionally with the lockdep "WARNING: possible circular locking dependency
> >> detected" below. Now debugfs_mutex is not reported as one of the dependent
> >> locks, then I think this fix is working as expected. Instead, eq->sysfs_lock
> >> creates similar dependency. My mere guess is that this patch avoids one
> >> dependency, but still another dependency is left.
> > 
> > Indeed, this patch cuts dependency on both q->sysfs_lock and q->debugfs_lock,
> Glad to see that with this patch we're able to cut the dependency between
> q->sysfs_lock and q->debugfs_lock.
> 
> > but elevator ->sysfs_lock isn't covered, :-(
> > 
> I believe that shall be fixed with the current effort undergoing here:
> https://lore.kernel.org/all/20250205144506.663819-1-nilay@linux.ibm.com/

I guess it isn't, your patches don't cover elevator_queue->sysfs_lock...


Thanks,
Ming

