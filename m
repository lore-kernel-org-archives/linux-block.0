Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915820ADD8
	for <linux-block@vger.kernel.org>; Wed,  4 Dec 2024 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323634; cv=none; b=qfWgxhcqC7zheeDC6iBHvi7cRT7gB881zfprG4el6eytH+hEeGsn0JzcKytCmA3W0Ea1BlkrvSmwH2e/B/2kOD0MVEcFCDzC3FWlVDXpRrX9g3b6QPpX+P2I9MeRO0AnDYjbQ4tlPFkVSjW/RoEN+BxDPziSzTCqXgu3R4sATIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323634; c=relaxed/simple;
	bh=stDgp3NjNxB+ipJU7jpeP/b0oLjB5nXpVyrvO2pyKd4=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=IRWtucNc7DhQKib7kJeTDz9lajK9BOCkqwVNPi58IoN97SrpsLJdvoZaFKw0m2/4xDhQMJlr2t73w1Q9c4P3+/OoqshgthMe6OPhaf5tybTWVBC/HfjutbYOfpMOOmkC043T4f1MHgoPTQDrxTb7ArpKFXcKROqoE74nUZrkJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXH+V0lK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXH+V0lK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733323631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qbFHMtJeJAPxmucmDIajqyTFkq1dinLHsQ21uiZDOig=;
	b=iXH+V0lK0m4jGf923N8KFHqyMKey+eGPPxj7QxG5cIb3Twz8GwHt/lQ+Tkmm5VMJP8QvAv
	66K0xbjVLPKjH/ADj5sq4zuGlTfX2OKzxtVC92nBAhpG2MVDfGa/QPS69uV/Cn2wVHvW2z
	5pjcexPA6N2UE2YQl1SOXO9rw+30KMM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-KAV5G3CrPmuIMQwa8ZUG8w-1; Wed,
 04 Dec 2024 09:47:09 -0500
X-MC-Unique: KAV5G3CrPmuIMQwa8ZUG8w-1
X-Mimecast-MFC-AGG-ID: KAV5G3CrPmuIMQwa8ZUG8w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6478195608B;
	Wed,  4 Dec 2024 14:47:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE90A3000197;
	Wed,  4 Dec 2024 14:47:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
Subject: Possible locking bug in the block layer [was syzbot: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)]
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: Wed, 04 Dec 2024 14:47:05 +0000
Message-ID: <1225307.1733323625@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

--=-=-=
Content-Type: text/plain


Hi Jens,

Whilst testing my netfslib patch, syzbot seems to have found an unrelated
deadlock bug in the block layer, if you could take a look?

https://lore.kernel.org/linux-fsdevel/1203250.1733323398@warthog.procyon.org.uk/T/#mc15e733720bedf2664b4347a823469a03b635132

David


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline; filename=40954
Content-Description: forwarded message

Replied: Wed, 04 Dec 2024 14:43:18 +0000
Replied: "syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com> dhowells@redhat.com, jlayton@kernel.org,
Replied: linux-fsdevel@vger.kernel.org,
Replied: linux-kernel@vger.kernel.org,
Replied: netfs@lists.linux.dev,
Replied: syzkaller-bugs@googlegroups.com"
From dhowells  Wed Dec  4 14:39:29 2024
Delivered-To: dhowells@gapps.redhat.com
Received: from imap.gmail.com [108.177.15.108]
	by warthog.procyon.org.uk with IMAP (fetchmail-7.0.0-alpha9)
	for <dhowells@localhost> (single-drop); Wed, 04 Dec 2024 14:39:29 +0000 (GMT)
Received: by 2002:a0c:cd08:0:b0:6cb:dd0e:ba1d with SMTP id b8csp281696qvm;
 Wed, 4 Dec 2024 06:39:10 -0800 (PST)
X-Forwarded-Encrypted: i=2;
 AJvYcCVSpJwIpK/ctrxWjHCniGoSNlknsUO7+wAhnkqhtU0Ezr2pz+TeJB/GUM90mqaMl2UlsPTfGFURwQ==@gapps.redhat.com
X-Google-Smtp-Source: AGHT+IHmMWnqlSuQZf6Qmg25+l8RnU2is44SpzNfy32Ti/GjkmEbC+xuD6iUjk4zH1YWLmrk4Gxu
X-Received: by 2002:a05:620a:3907:b0:7b6:7970:6522 with SMTP id
 af79cd13be357-7b6abb773a2mr587308585a.40.1733323149908; Wed, 04 Dec 2024
 06:39:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1733323149; cv=none; d=google.com;
 s=arc-20240605;
 b=dnEIqIB5s5MSM68yVmvmqQRThK2Z2BfHgBIF6ni9OhFa01YtfDzaBP10jk2IQ8WiIu
 WKNt0hGdC1Lu6UDWeyiMFVJYOP1XGd9dlweZH+vaEnGXQ40Uo8KxfFMz4F3AsoGzewyx
 n4nDZatqH7mVVcAglXVhhJ2MaVPUvos0sEHKPXqVBDyaiKM3HgDeg6FS25+5AjW5ZZr3
 ycwr6IjCkVpoKVrM0f2/0dTVyMGRhX+1NveCVT2PPGlAm/5UQ+Xu7jo9QOwgLUitj4Ej
 D6oFcSB00Yt+DcByN8BFSGjnU3aqUbbIqFlHI3LTHoKYgdxMUGVcetGkDCsRZQi0e0in c6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; h=to:from:subject:message-id:in-reply-to:date:mime-version
 :delivered-to; bh=i8eUeYyXPY5DE2a4Z351/KxDabP2x7UZlSYonRpg5JM=;
 fh=xndGejRaolZSVR6PvMo2tPHsCWOTLOTTOAiwZJ3Jxy8=;
 b=CAY9LVQd5yzafRqhaXFrAhbsY6w4GF+e+tT4Ji9EXNiTr6l24k9szNAzxaiC1EoFks
 ulGab/ym6kJpbdtXWW6GE1BDKF7m7NVbX1rQqulWlqd+Qt5ksmEK4MaL2Ymiu1ayTlsM
 EKr7vByezWCgsJHlxLXjCJtZ7yO+30t8KkTWR58RK0GwhmbQpdSwkZdb9+HfYDlzfVGn
 NmWBVfTxhl2PxNxs/jOcbfpxRUKngxxKubRt0u50FAPEdUVGV7h0RjiE4En5Zyrfubst
 G/cq2Xru3BEgb0o0TCtwukM+1e3yqG/mu2OGO21NcUiLd6HfRdleOgSDuKZT5zqLnrZZ 5PPg==;
 dara=google.com
ARC-Authentication-Results: i=1; mx.google.com; spf=pass (google.com: domain
 of
 3h2lqzwkbanwqwxi8jjcp8nngb.emmejcsqcpamlrclr.amk@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 designates 209.85.166.200 as permitted sender)
 smtp.mailfrom=3h2lqzwkbanwqwxi8jjcp8nngb.emmejcsqcpamlrclr.amk@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Return-Path: <3h2lqzwkbanwqwxi8jjcp8nngb.emmejcsqcpamlrclr.amk@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com>
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com. [170.10.128.131]) by mx.google.com with
 ESMTPS id af79cd13be357-7b6849c1247si320724085a.389.2024.12.04.06.39.09 for
 <dhowells@gapps.redhat.com> (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384
 bits=256/256); Wed, 04 Dec 2024 06:39:09 -0800 (PST)
Received-SPF: pass (google.com: domain of
 3h2lqzwkbanwqwxi8jjcp8nngb.emmejcsqcpamlrclr.amk@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 designates 209.85.166.200 as permitted sender) client-ip=209.85.166.200;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of
 3h2lqzwkbanwqwxi8jjcp8nngb.emmejcsqcpamlrclr.amk@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
 designates 209.85.166.200 as permitted sender)
 smtp.mailfrom=3h2lqzwkbanwqwxi8jjcp8nngb.emmejcsqcpamlrclr.amk@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-hLcX3n32NiS6luucaHH2og-1; Wed, 04
 Dec 2024 09:39:07 -0500
X-MC-Unique: hLcX3n32NiS6luucaHH2og-1
X-Mimecast-MFC-AGG-ID: hLcX3n32NiS6luucaHH2og
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40]) (using
 TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519
 server-signature RSA-PSS (2048 bits) server-digest SHA256) (No client
 certificate requested) by
 mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id
 7805F1955DAF for <dhowells@gapps.redhat.com>; Wed,  4 Dec 2024 14:39:06 +0000
 (UTC)
Received: by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix)
 id 72A0E1954202; Wed,  4 Dec 2024 14:39:06 +0000 (UTC)
Delivered-To: dhowells@redhat.com
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.46]) by
 mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FCE61954200 for <dhowells@redhat.com>; Wed,  4 Dec 2024 14:39:06 +0000
 (UTC)
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-inbound-delivery-1.mimecast.com [170.10.128.131]) (using TLSv1.3
 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519
 server-signature RSA-PSS (2048 bits) server-digest SHA256) (No client
 certificate requested) by
 mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id
 0D5901956086 for <dhowells@redhat.com>; Wed,  4 Dec 2024 14:39:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-umLgZpoZPjCxAph2QbSPTA-1; Wed, 04 Dec 2024 09:39:04 -0500
X-MC-Unique: umLgZpoZPjCxAph2QbSPTA-1
X-Mimecast-MFC-AGG-ID: umLgZpoZPjCxAph2QbSPTA
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a7cf41b54eso133583785ab.2 for <dhowells@redhat.com>; Wed, 04
 Dec 2024 06:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1e100.net;
 s=20230601; t=1733323143; x=1733927943;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i8eUeYyXPY5DE2a4Z351/KxDabP2x7UZlSYonRpg5JM=;
 b=t68LcgVjfsdNXMtDWtyZJZAGLk9rjTTWGbXElVKQ6HzJVDAS74n7rGKc5yQS5dFufK
 lwBdLRcD68WugPUv8rrWe3gt9TdOYl9w3VJWM15KxMHO/ZXFXhp5ZxM7CpJKCBH5y58B
 1vhO1X1Jezc2Xxx0mTXXb3ifh/UrirHjfQfC/8nB9YY4qOAG14uqLYcGCr0DrjgunOA6
 y8062dODNwwPSsQqx5iCZZKT4kS+zFqA9kn9mhu5RMY+lrh7RL7ycfEq5efhLrnOpmfd
 u2OE6pkeUQcu4n5pvydlmjt4BmFZAWynZ8BcvMyLSAeQ8nDNm82TOUh1g0kmgd1fIhm+ wk5Q==
X-Gm-Message-State: AOJu0YwkfplA0ZdqjySuINvgccNyL8rqbDbvFB9tzoMKJHlJWEY2nWVZ
 3ZWCIvRzpIdSyZSSqOFNuafPVWMNI+19Pht7iEnvpZV4VJkgK0rQHclIJP5Oha0t4HZvHWGkjBG
 5t8WqfMCMLE+OIdlxSUdgwdcREF5qK8qKgJwUvRGw5sFOkn+E5wTrNSc=
MIME-Version: 1.0
X-Received: by 2002:a92:c56a:0:b0:3a7:dfe4:bd33 with SMTP id
 e9e14a558f8ab-3a7fecc82b3mr58583675ab.6.1733323143026; Wed, 04 Dec 2024
 06:39:03 -0800 (PST)
Date: Wed, 04 Dec 2024 06:39:03 -0800
In-Reply-To: <1129891.1733321485@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67506987.050a0220.17bd51.006f.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
 syzkaller-bugs@googlegroups.com
X-Mimecast-MFC-PROC-ID: 9kYbmhbvili9zgfRBCrAPvG-zJK_uRzUiSGdwcHtJ1s_1733323143
X-Mimecast-Impersonation-Protect: Policy=CLT - Impersonation Protection
 Definition;Similar Internal Domain=false;Similar Monitored External
 Domain=false;Custom External Domain=false;Mimecast External
 Domain=false;Newly Observed Domain=false;Internal User Name=false;Custom
 Display Name List=false;Reply-to Address Mismatch=false;Targeted Threat
 Dictionary=false;Mimecast Threat Dictionary=false;Custom Threat
 Dictionary=false
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: 0zEWP24HtOzMl4wqPsfEujCmWN25yBpPd9zY0V_7x8Y_1733323146
X-Mimecast-Originator: syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in __submit_bio

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc1-syzkaller-dirty #0 Not tainted
------------------------------------------------------
kswapd0/75 is trying to acquire lock:
ffff888034c41438 (&q->q_usage_counter(io)#37){++++}-{0:0}, at: __submit_bio+0x2c6/0x560 block/blk-core.c:629

but task is already holding lock:
ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6864 [inline]
ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x36f0 mm/vmscan.c:7246

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3865
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4055 [inline]
       slab_alloc_node mm/slub.c:4133 [inline]
       __do_kmalloc_node mm/slub.c:4282 [inline]
       __kmalloc_node_noprof+0xb2/0x4d0 mm/slub.c:4289
       __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
       sbitmap_init_node+0x2d4/0x670 lib/sbitmap.c:132
       scsi_realloc_sdev_budget_map+0x2a7/0x460 drivers/scsi/scsi_scan.c:246
       scsi_add_lun drivers/scsi/scsi_scan.c:1106 [inline]
       scsi_probe_and_add_lun+0x3173/0x4bd0 drivers/scsi/scsi_scan.c:1287
       __scsi_add_device+0x228/0x2f0 drivers/scsi/scsi_scan.c:1622
       ata_scsi_scan_host+0x236/0x740 drivers/ata/libata-scsi.c:4575
       async_run_entry_fn+0xa8/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&q->q_usage_counter(io)#37){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3091
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       swap_writepage_bdev_async mm/page_io.c:451 [inline]
       __swap_writepage+0x5fc/0x1400 mm/page_io.c:474
       swap_writepage+0x8f4/0x1170 mm/page_io.c:289
       pageout mm/vmscan.c:689 [inline]
       shrink_folio_list+0x3c0e/0x8cb0 mm/vmscan.c:1367
       evict_folios+0x5568/0x7be0 mm/vmscan.c:4593
       try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
       shrink_one+0x3b9/0x850 mm/vmscan.c:4834
       shrink_many mm/vmscan.c:4897 [inline]
       lru_gen_shrink_node mm/vmscan.c:4975 [inline]
       shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
       kswapd_shrink_node mm/vmscan.c:6785 [inline]
       balance_pgdat mm/vmscan.c:6977 [inline]
       kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#37);
                               lock(fs_reclaim);
  rlock(&q->q_usage_counter(io)#37);

 *** DEADLOCK ***

1 lock held by kswapd0/75:
 #0: ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6864 [inline]
 #0: ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x36f0 mm/vmscan.c:7246

stack backtrace:
CPU: 0 UID: 0 PID: 75 Comm: kswapd0 Not tainted 6.13.0-rc1-syzkaller-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 bio_queue_enter block/blk.h:75 [inline]
 blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3091
 __submit_bio+0x2c6/0x560 block/blk-core.c:629
 __submit_bio_noacct_mq block/blk-core.c:710 [inline]
 submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
 swap_writepage_bdev_async mm/page_io.c:451 [inline]
 __swap_writepage+0x5fc/0x1400 mm/page_io.c:474
 swap_writepage+0x8f4/0x1170 mm/page_io.c:289
 pageout mm/vmscan.c:689 [inline]
 shrink_folio_list+0x3c0e/0x8cb0 mm/vmscan.c:1367
 evict_folios+0x5568/0x7be0 mm/vmscan.c:4593
 try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
 shrink_one+0x3b9/0x850 mm/vmscan.c:4834
 shrink_many mm/vmscan.c:4897 [inline]
 lru_gen_shrink_node mm/vmscan.c:4975 [inline]
 shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
 kswapd_shrink_node mm/vmscan.c:6785 [inline]
 balance_pgdat mm/vmscan.c:6977 [inline]
 kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         40384c84 Linux 6.13-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.13-rc1
console output: https://syzkaller.appspot.com/x/log.txt?x=101560f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58639d2215ba9a07
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138c4de8580000


--=-=-=--

