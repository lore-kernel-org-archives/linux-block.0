Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22263495F0
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125511; cv=none; b=X7iC0OqKERtEVLXvKwjnyr69fegwfZ6e270fzEwY3EqMvJKQR0+Y3lCfsOTIXgb7fhJEK+XoD4L6MeawyjCZVlTejw9pGBfd8GtVYcXQAxBmL8NYmEpRH/R6Iw4hLDVAhR2QiSieWvPyYN8qa23OB623Rn1MlvfOhiSzegB3SVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125511; c=relaxed/simple;
	bh=HUX2UE6OUGhe1StMdwKrw10OCob/4PdtbKM/9Lktg8M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g7TCdK0nFjKg9dXa0VlcDZDaymtw6CKgaMLxT7M25VGOz+hJYw1ffTH0RcWE0JGVgh2YiUE1nvR/gEOaNKrtE56vyD6nUk+G0tyzwmwFPd9MVFSv0x56pO2HafRMf5Z/p/AI4dC5q6Mlr9frorQzMpuzsJg7kR3k/WniRKGFmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZ+6c8tW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZ+6c8tW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711125509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=t2DP0YMaPQMLrkALP2vh1iAvL56ROOMX7isL57XrmW4=;
	b=JZ+6c8tW8PZpNUAyFYI0+OeA5BnvzyGZ07qgvMN/N287Pp7UwwSoDsC6b7NniTOB33DLY2
	giHw9AEH+mB+0dkpivo59I/1qtErWcqysMEW5h4ziFIzMDE0iTc7FmSJ+Ol4EkJjzxgJkb
	8+4nzn+7sJIv/Vu4GQStc6hBSg1md5A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-3gIBOxnoP8CaTCRHTH5P4Q-1; Fri,
 22 Mar 2024 12:38:27 -0400
X-MC-Unique: 3gIBOxnoP8CaTCRHTH5P4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29DEA3C02767
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 16:38:27 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A440111E404
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 16:38:27 +0000 (UTC)
Date: Fri, 22 Mar 2024 12:40:21 -0400
From: Brian Foster <bfoster@redhat.com>
To: linux-block@vger.kernel.org
Subject: pktcdvd ->open_mutex lockdep splat
Message-ID: <Zf20dfwIdayItxsO@bfoster>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi all,

I noticed the splat below on one of my test VMs when running latest
upstream with lockdep enabled. I'm not really sure why this occurs
because I'm not actually using this device for anything I'm aware of. I
suppose it's possible this has a busted userspace or kvm config, as this
is just one of a handful of scratch VMs I have around for development
purposes. I'm happy to try and dig further into it or just expunge it if
this is of little interest.

FWIW, the splat itself reproduces back before ->open_mutex was created
from bd_mutex by commit a8698707a183 ("block: move bd_mutex to struct
gendisk"). I went as far back as v5.10 and still observed it.

Brian

--- 8< ---

[   11.667694] block (null): writer mapped to sr0

[   11.677407] ============================================
[   11.680650] WARNING: possible recursive locking detected
[   11.683581] 6.8.0+ #346 Tainted: G            E     
[   11.686246] --------------------------------------------
[   11.689075] systemd-udevd/1438 is trying to acquire lock:
[   11.690607] ffff8bb78f553cc8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0x60/0x3e0
[   11.692504] 
               but task is already holding lock:
[   11.693921] ffff8bb786b39cc8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0x239/0x3e0
[   11.695806] 
               other info that might help us debug this:
[   11.697362]  Possible unsafe locking scenario:

[   11.698779]        CPU0
[   11.699397]        ----
[   11.699994]   lock(&disk->open_mutex);
[   11.700923]   lock(&disk->open_mutex);
[   11.701849] 
                *** DEADLOCK ***

[   11.703273]  May be due to missing lock nesting notation

[   11.704878] 3 locks held by systemd-udevd/1438:
[   11.705967]  #0: ffff8bb786b39cc8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0x239/0x3e0
[   11.707966]  #1: ffffffffc085c768 (pktcdvd_mutex){+.+.}-{3:3}, at: pkt_open+0x2b/0x630 [pktcdvd]
[   11.710080]  #2: ffffffffc085d868 (&ctl_mutex#2){+.+.}-{3:3}, at: pkt_open+0x39/0x630 [pktcdvd]
[   11.712164] 
               stack backtrace:
[   11.713200] CPU: 3 PID: 1438 Comm: systemd-udevd Tainted: G            E      6.8.0+ #346
[   11.715122] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
[   11.717123] Call Trace:
[   11.717741]  <TASK>
[   11.718271]  dump_stack_lvl+0x79/0xb0
[   11.719194]  __lock_acquire+0x1228/0x2170
[   11.720172]  lock_acquire+0xbb/0x2c0
[   11.721030]  ? bdev_open+0x60/0x3e0
[   11.721869]  __mutex_lock+0x77/0xd40
[   11.722724]  ? bdev_open+0x60/0x3e0
[   11.723558]  ? find_held_lock+0x2b/0x80
[   11.724470]  ? bdev_open+0x56/0x3e0
[   11.725324]  ? bdev_open+0x60/0x3e0
[   11.726173]  ? bdev_open+0x60/0x3e0
[   11.727031]  bdev_open+0x60/0x3e0
[   11.727844]  bdev_file_open_by_dev+0xbf/0x120
[   11.728909]  pkt_open+0x10e/0x630 [pktcdvd]
[   11.729944]  ? bdev_open+0x22f/0x3e0
[   11.730815]  ? lock_release+0xb8/0x270
[   11.731729]  ? bdev_open+0x239/0x3e0
[   11.732605]  blkdev_get_whole+0x25/0x90
[   11.733544]  bdev_open+0x29f/0x3e0
[   11.734380]  ? iput.part.0+0x34/0x260
[   11.735277]  ? __pfx_blkdev_open+0x10/0x10
[   11.736282]  blkdev_open+0x8b/0xc0
[   11.737090]  do_dentry_open+0x172/0x580
[   11.738002]  path_openat+0x3a9/0xa30
[   11.738864]  do_filp_open+0xa1/0x130
[   11.739731]  ? _raw_spin_unlock+0x23/0x40
[   11.740700]  do_sys_openat2+0x82/0xb0
[   11.741596]  __x64_sys_openat+0x49/0x80
[   11.742529]  do_syscall_64+0x7c/0x190
[   11.743406]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
[   11.744599] RIP: 0033:0x7f30e4afd70b
[   11.745450] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14 25
[   11.749817] RSP: 002b:00007ffdafd13250 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[   11.751633] RAX: ffffffffffffffda RBX: 0000000000006000 RCX: 00007f30e4afd70b
[   11.753306] RDX: 0000000000080900 RSI: 00007ffdafd132d0 RDI: 00000000ffffff9c
[   11.754966] RBP: 00007ffdafd132d0 R08: 0000000000000000 R09: 00007ffdafd13160
[   11.756624] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080900
[   11.758311] R13: 0000000000080900 R14: 0000000000000006 R15: 00007ffdafd13470
[   11.760041]  </TASK>

