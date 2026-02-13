Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDF5611E
	for <linux-block@vger.kernel.org>; Fri, 13 Feb 2026 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770953447; cv=none; b=C5TdWc0BJZF7gSO/P0VRDJYdkNC3b62V3XN99CfmqbE7NTCUTYfmgLl12XV5PcTMJny1DVQxKR8f/eoTTJcn1NZfXJPWVVuecHEhBPHr4PR9GizoJ8RQn6EdP3oR1YbdUjiXmJQbdxUZkmDN1sZDRpPPgPG+A/Q0C90ZhtW88Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770953447; c=relaxed/simple;
	bh=5/xsuK1J8ymjNXTozkIC1Nkncc9Y8vOTcA3GiRJXtIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHZ43C5AWGs4WgUD9N56A8sUevNB02IUvPnewLe62Waysy7e1cvKGLsfpcGsI6FfN5FNx3/Ie4cexRZN+rOTGNwRVUj/QiC/ROCMPbpYsNhDUFTpbYayyYhPanKZR5O5WrabCAx0RwRzpFXRordZNyKaECQ8ANjYc+aD73BaOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDiFBY7f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDiFBY7f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770953444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzDTxl6CTj0ch3WNTkNRK3YKSKr4uu0bS+u453hqKz0=;
	b=BDiFBY7fvRtGlcFanLVYqaqc88ebDgK8OySY6mioERtQmaWrDanKXHsagQh+WyjCGsGq1m
	zEOPGp795AiuMXgpFEISx62n5zecZAxuO8U/MYLNcvsRG/3dfhNtohAXEhHtn1zDZY9waF
	nYNqmN4xeO+nl4rvww5nJ/YmlD07p2Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-OuEFIWPJNkicneJWn95Zzg-1; Thu,
 12 Feb 2026 22:30:40 -0500
X-MC-Unique: OuEFIWPJNkicneJWn95Zzg-1
X-Mimecast-MFC-AGG-ID: OuEFIWPJNkicneJWn95Zzg_1770953439
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3791918004BB;
	Fri, 13 Feb 2026 03:30:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.140])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F109019560B9;
	Fri, 13 Feb 2026 03:30:32 +0000 (UTC)
Date: Fri, 13 Feb 2026 11:30:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: syzbot <syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] WARNING in wbt_init_enable_default
Message-ID: <aY6a08ZYRJfjB0p-@fedora>
References: <694ce8fd.050a0220.35954c.0035.GAE@google.com>
 <698e3afa.a70a0220.2c38d7.00a2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698e3afa.a70a0220.2c38d7.00a2.GAE@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Feb 12, 2026 at 12:41:30PM -0800, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14342c02580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a512b4a06724b76a
> dashboard link: https://syzkaller.appspot.com/bug?extid=71fcf20f7c1e5043d78c
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ffbdb2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11542eef980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0dedaafff2ad/disk-37a93dd5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/aa7fae081497/vmlinux-37a93dd5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9096b39b53e1/bzImage-37a93dd5.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+71fcf20f7c1e5043d78c@syzkaller.appspotmail.com
> 
> 0x000000000001-0x000000020000 : ""
> ftl_cs: FTL header corrupt!
> "mq-deadline" elevator initialization, failed -12, falling back to "none"
> ------------[ cut here ]------------
> !rwb
> WARNING: block/blk-wbt.c:784 at wbt_init_enable_default+0xcb/0x120 block/blk-wbt.c:784, CPU#0: syz.0.23/6066

The warning is expected given -ENOMEM is triggered from wbt_alloc(), either
kmalloc or percpu allocator.


Thanks,
Ming

