Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79366186284
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789278; cv=none; b=tfh+QAcd+YwBMK3VYcHOUufOqCG0hUZpx94s51bKh3THBx2DeF6lOXPFFYgu+EE7haIrfHIH7fMiuXemR/V0NvDiSZ3pNPGiu/n4zKge7A/gQhwtAypFAYbzSa2NrLODy4yRK/GFgHKI2ir5hFDNwk3s0bkvsgtw1g6/bHv8SAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789278; c=relaxed/simple;
	bh=4OSZ+Dr/HYpgzBe5gCu5KbSQJAbV4zx4N9uOqpFpgBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cegSLJ2SRCz5KsLjvPrk3GTF4uIjLO0U+MfzZ7nc46AFiEuC04iAu6vX2coJqIPXjJ34r08Efgco3pP7m+aq6RbhCP1C3pDZsWgnkYZ1QFRZWkuDQyJoaWcnfe3rhpD/2YzuizMsNXC2wy79Lzn2rIOJAqB0nSYPgDq7J3QlrX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6xslsmW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6xslsmW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730789274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OSSiISjBEV9S7jAitSAByWMNKJbvVYBfy3jJPVgWuvQ=;
	b=d6xslsmWd/MQBpwMzgOlrts30lUYFHnnW9T3MoLNtKA5W+7+8qMGx3AMak3R1GtxMiVQ+b
	x6qhDPM1jsMZoxWy9RKCS5L8Fab8cJlF0I27NC9ecrFfIHB5O9+TIhl3Oea9+vrRoB5dkB
	HMAe4iVPG2IvgLK6izCkNpXZT/m2aW4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-UWolMrigNN-kY1t1Lc4-Xw-1; Tue,
 05 Nov 2024 01:47:51 -0500
X-MC-Unique: UWolMrigNN-kY1t1Lc4-Xw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C4A11955F54;
	Tue,  5 Nov 2024 06:47:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA2E919560A2;
	Tue,  5 Nov 2024 06:47:41 +0000 (UTC)
Date: Tue, 5 Nov 2024 14:47:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: syzbot <syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] possible deadlock in blk_trace_ioctl
Message-ID: <Zym_h_EYRVX18dSw@fedora>
References: <67251e01.050a0220.529b6.0161.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67251e01.050a0220.529b6.0161.GAE@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Nov 01, 2024 at 11:29:21AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10016630580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
> dashboard link: https://syzkaller.appspot.com/bug?extid=a3c16289c8c99b02cac1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125a9340580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com
> 

...

> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: https://github.com/ming1/linux.git for-next

Thanks,
Ming

