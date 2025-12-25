Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439551CEAA3
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766662809; cv=none; b=t/jqlaxyqzjZYjoOlhGHbQXKO4vK9zlbw4QInvymXCfdXj1d/mti5MWW+xF/0BXJ+qLiaTmt+Qjk/5Lgwu62GSOIyCKLcUMyr0ZPFlexatLefmlxjBvVs/2iYIOsaCfD7DDGImkV8HKR+2lt6oGn7dEmFRI3Rlp86AJBUFuUfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766662809; c=relaxed/simple;
	bh=cSjw1UYAcOIQX2UupZIRCVtZKmHuWyE1SxemNttGF70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxKbvnUY+s5s/5fzrZUAnxSfhKwZ2v6GFYEbT+nceCvkHDDEE9DA09WwvHfu9bIXy9Tp+lTemaNxKq9jm92oy3jV2aqV0MBPPFwRqSlaqPYACvjRnKKX2y6gju7kl0I9BH0JopWrHPest4tyZXIN5YEsPjrJT1+vrp7PW9IcZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HL2Dleoy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HL2Dleoy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766662806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wl9D9dah+mPX5ztqzgvNJU39WjzVpa9UHfF7SLLNbkk=;
	b=HL2Dleoy1NpWPN2qE0lF4aAii58ysTyFnvhG7e5gEib/1DAOu5T/56OebjPUOKu4+Rq0mF
	tzx5ZcUny8fsUGhWZx0DySF6JRChF8a1LJJdir3h4l6qLpoLBels9Ejp8u3TY3TbTwlQLM
	TQvb2WWR4XDXpiA+pVRwUB+XU7w21vc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-gYy8oxAZPXKg1LD7aSlunw-1; Thu,
 25 Dec 2025 06:40:02 -0500
X-MC-Unique: gYy8oxAZPXKg1LD7aSlunw-1
X-Mimecast-MFC-AGG-ID: gYy8oxAZPXKg1LD7aSlunw_1766662801
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BBC01956088;
	Thu, 25 Dec 2025 11:40:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A66319560A7;
	Thu, 25 Dec 2025 11:39:57 +0000 (UTC)
Date: Thu, 25 Dec 2025 19:39:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: syzbot <syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] WARNING in wbt_init_enable_default
Message-ID: <aU0iiC-4D8qWZMkp@fedora>
References: <694ce8fd.050a0220.35954c.0035.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <694ce8fd.050a0220.35954c.0035.GAE@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Dec 24, 2025 at 11:34:21PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b927546677c8 Merge tag 'dma-mapping-6.19-2025-12-22' of gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11dc8b92580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
> dashboard link: https://syzkaller.appspot.com/bug?extid=71fcf20f7c1e5043d78c
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10515f1a580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b27369f4b013/disk-b9275466.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3b2d81c4be86/vmlinux-b9275466.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/89c2ad4f36b6/bzImage-b9275466.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: block/blk-wbt.c:741 at wbt_init_enable_default+0x4e/0x60 block/blk-wbt.c:741, CPU#0: syz.1.439/7602
> Modules linked in:
> CPU: 0 UID: 0 PID: 7602 Comm: syz.1.439 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:wbt_init_enable_default+0x4e/0x60 block/blk-wbt.c:741

Looks like 'echo > /sys/block/loop0/queue/queue_wb_lat' creates wbt first,
then -EBUSY is triggered.

Seems -EBUSY should be filtered for warn here.

Thanks,
Ming

