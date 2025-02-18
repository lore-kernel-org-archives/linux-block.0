Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B31F189B84
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 03:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739849615; cv=none; b=QZ0FYRfncD5Wz0dNWN16G7BhntpOvMcy7SCuiS+i5Ze91odHgKS/wD54dtyyJbByDm31bx7qFo2T9XyvNXYLEXR5YOBTqFPv9wgKb8cKa4+95Uzltdq4J05z2CpGnvnDa+7EZeJ5rdxZeLK3e1DuLwBwJ7kcSNXztGqep1LwrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739849615; c=relaxed/simple;
	bh=olk7paXU4nOWgLs6rL4qNd27H0bU3veOSCvr0Gq4bzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNTI//+asOEmsUs3CsTZxlqbDUVrY/P6M/3dqOBLSKX3y/FRBVu/9KfCfzCGxPh/E3g71K9SLt7LSGWEuOvmTfSV+y7onHC5OehCvSJABGI1DonWMJoOjyDVLj1vjUFcVMzVc4rUwEkg9+8/2QEz69j/Y9YPHDIzg0kgvRSbmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2/AhSJs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2/AhSJs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739849611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PqYbvYIVpNJaoQl4neS5lrP+Dqq4hXdmS297QcEciNg=;
	b=E2/AhSJslxbWIAZK7jSrAUDc5t5/H6K+k8eEoFoVLi5GOcIPfQYdvlReIp9QP3Ecqy9qlK
	1yykOnXWbu2elc4t5tVzfyjZXM07hdXjCthkjoHoWKNlFZw7f26bCfxhvkc1tLHGMRU3oa
	fTkxzNzyY1I+46Rqev7zwK9WdCC298c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-U99SID0aMYWnU5lMx7_Aqg-1; Mon,
 17 Feb 2025 22:33:27 -0500
X-MC-Unique: U99SID0aMYWnU5lMx7_Aqg-1
X-Mimecast-MFC-AGG-ID: U99SID0aMYWnU5lMx7_Aqg_1739849606
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2130180036F;
	Tue, 18 Feb 2025 03:33:25 +0000 (UTC)
Received: from fedora (unknown [10.72.120.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 781DE1800366;
	Tue, 18 Feb 2025 03:33:21 +0000 (UTC)
Date: Tue, 18 Feb 2025 11:33:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: syzbot <syzbot+c104904eeb2c0edbdb06@syzkaller.appspotmail.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: reply: [syzbot] [block?] BUG: corrupted list in loop_process_work
Message-ID: <Z7P_ezl4qVmASrwH@fedora>
References: <67afa060.050a0220.21dd3.0051.GAE@google.com>
 <1739771872662.83054@unisoc.com>
 <CAGWkznFFN-wBXFc4ReCdEpFFNuc_m_EXDDopfQzZtTHt2t-wKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznFFN-wBXFc4ReCdEpFFNuc_m_EXDDopfQzZtTHt2t-wKw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Zhaoyang,

On Tue, Feb 18, 2025 at 10:49:04AM +0800, Zhaoyang Huang wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    c674aa7c289e Add linux-next specific files for 20250212
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=125063f8580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a0fd539126ae5541
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c104904eeb2c0edbdb06
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158a3bdf980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e18aa4580000
>  #syz test
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 68c943a77e41..354d77f9228b 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1972,7 +1972,8 @@ static void loop_process_work(struct loop_worker *worker,
>          * *and* the worker will not run again which ensures that it
>          * is safe to free any worker on the idle list
>          */
> -       if (worker && !work_pending(&worker->work)) {
> +       if (worker && !work_pending(&worker->work)
> +               && list_empty(&worker->idle_list)) {
>                 worker->last_ran_at = jiffies;
>                 list_add_tail(&worker->idle_list, &lo->idle_worker_list);
>                 loop_set_timer(lo);

The `work` to be queued may originate from RB tree or lo->rootcg_work, so it may
be freed during queuing without the lock.

I think you may need to revert the patch.


Thanks,
Ming

