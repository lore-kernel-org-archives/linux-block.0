Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E66382F0C
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436017; cv=none; b=aVJzJ7URSYIphfZEenuypkhzFkCltxYCWJR3tXmy/+KTFYdOcj8bR4M9eoRmFhOZA6Zj94220gILgDJT4JJSNSNQj6FFU+C8VNxCJqVQ09yQqq2wLT6rvG8V1+bHfwVU3oPKQRsvLdBed+4AnM7mRr8VibPk0sc+F6xMvI7bek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436017; c=relaxed/simple;
	bh=cfKk5FoxDTMqLNBEB4oPfs+wb8JELser8oC7VI8XvkQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H3lugme7yLhpRcIWCDGIMCzneyj0j9BtfZrsLIsuT2/fxGmWC66HdgApIoZxMeErqC8HY8yn6PJo9x62lvT3wEVVNLXsTjMbg+mah6lfVczTbf40DGGKzrYcXfbjJSaTPfeh/nU0KK5tPt9W3V0lZQch/Wkiw4UKYfapn6NnjrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f2.google.com with SMTP id 006d021491bc7-6bd3ee01a0dso1489899eaf.0
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 18:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789436013; x=1790040813;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y1RMj3nj6Oa60Do6JMC79RJ4/ktrXyj0vc2+aB9ZeLw=;
        b=IYePbBLOzLpr25NeTgohRLVPF4fCZ+jzwb6y9rDoWRhmp79FwiQ7tm1h8oZ2EKETrC
         fxCGWh83R1dafZqX2cubgUu/jG51gbjG6v5H2QvtrRsmBXocBGlnuxHvQP3qxhduNjxg
         Zhh2In3XKZxXwTTKpBFfO380C5tUrWITCSzvkOyXj9EjGDm+d3yEZzUamHBhn84mRX0Z
         UGS261oeB2DBrFrsuLiGDLUNofMx18ZiDkWIcdyOsB8d1Dm88j4JmJ0IBRl+FDypMCHQ
         31aSMZqagZfeXq32x2bvo6unlX78+G04T+q3JwJTDAIQX76FPQto77y939ab0nwwsccb
         gaVg==
X-Forwarded-Encrypted: i=1; AKwUvBy5KgaKlL3B0fr07Ouy0UIKGLf/fBZtrPiArludhoqXI/ywifAU3l0SA8QnBKSz/uq6qgZPhF5zR0QDJw==@vger.kernel.org
X-Gm-Message-State: AFuF++mHlPy8XQ80LWR0fJsUgbJZ6rhZNrwfxLc8ZCANFybXB9VPpsuF
	truinNL80xP55AD5CTLECHzw0f8LwDxsTbLDCYDTibGb15NbClTE0a/VrKLj2UizKvJ/84QNEOT
	JaT0pESHGlaSN9B652cpCsqwf0CTwjH+eXhDnqaRoGw1pb/BfotbrOMTB8VM=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c99:b0:6b7:83c5:fde9 with SMTP id
 006d021491bc7-6c5447a22b4mr2757507eaf.42.1789436013716; Mon, 14 Sep 2026
 18:33:33 -0700 (PDT)
Date: Mon, 14 Sep 2026 18:33:33 -0700
In-Reply-To: <6a926eaf.1d9ded08.62e62.0102.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa8a06d.4c28b7d0.c1bba.0027.GAE@google.com>
Subject: Re: [syzbot] [block?] BUG: corrupted list in blk_mq_request_bypass_insert
From: syzbot <syzbot+f4353e96f7004ae5a09e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, bvanassche@acm.org, hch@lst.de, kbusch@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5445d6419962 arm64: Don't read GMID_EL1 when MTE is disabled
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=121f2115580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56ed23170c168d4c
dashboard link: https://syzkaller.appspot.com/bug?extid=f4353e96f7004ae5a09e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161f2115580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110a75f9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8b70e3bd109/disk-5445d641.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e5227e56ac93/vmlinux-5445d641.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54905f78be59/Image-5445d641.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f4353e96f7004ae5a09e@syzkaller.appspotmail.com

 non-slab/vmalloc memory
list_add corruption. prev->next should be next (ffff0000c7fc2840), but was ffff0000c83b0048. (prev=ffff0000c83b0048).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:34!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 4354 Comm: kworker/0:1H Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
Workqueue: kblockd blk_mq_requeue_work
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __list_add_valid_or_report+0x144/0x148 lib/list_debug.c:32
lr : __list_add_valid_or_report+0x144/0x148 lib/list_debug.c:32
sp : ffff800094547a10
x29: ffff800094547a10 x28: ffff800094547ac8 x27: ffff800094547ac0
x26: 1fffe00018ff8509 x25: ffff0000c7fc2840 x24: ffff0000c7fc2848
x23: 1fffe00019076009 x22: dfff800000000000 x21: ffff0000c83b0048
x20: ffff0000c83b0048 x19: ffff0000c7fc2840 x18: 1fffe00035b9ec28
x17: 3034383263663763 x16: 3030303066666666 x15: 28207478656e2065
x14: 6220646c756f6873 x13: 0000000000000001 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000000002 x9 : 1fe110670cc49300
x8 : 1fe110670cc49300 x7 : ffff80008048e314 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080498f8c
x2 : 0000000100000001 x1 : ffff0000d6353b00 x0 : 0000000000000075
Call trace:
 __list_add_valid_or_report+0x144/0x148 lib/list_debug.c:32 (P)
 __list_add_valid include/linux/list.h:104 [inline]
 __list_add include/linux/list.h:169 [inline]
 list_add_tail include/linux/list.h:206 [inline]
 blk_mq_request_bypass_insert+0x130/0x1cc block/blk-mq.c:2551
 blk_mq_requeue_work+0x3a4/0x52c block/blk-mq.c:1560
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0x91c/0x1250 kernel/workqueue.c:3470
 worker_thread+0x798/0xbd0 kernel/workqueue.c:3551
 kthread+0x304/0x3d4 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:838
Code: 91170000 aa1303e1 aa1403e3 979ab1d1 (d4210000) 
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
