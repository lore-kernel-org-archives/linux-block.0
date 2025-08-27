Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB96C274B23
	for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282536; cv=none; b=udj8jrvjECFj8UuWv+ix+ZpmruMIAQfE3AejskHHSR+a6iDtTckcntoB9aLvmkrfOeoLTbP/xHhoS6xylzSLiiPJRMJRWtV8za0JfPx7pmqBoSszpoCs0FSnB7GD4D6dJsSgiKTa+SMYxSzLcAeriPP4l46zfVUMQrAU0hcGpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282536; c=relaxed/simple;
	bh=m9fZPyREP9mMFo5dFbqtZdxitG/UM8cTyXcCwjYqFmA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZwN5kwRHdQpBdFc0bCT/pMgjy+yY+EdP3kGFl8/Rg+AchTDjwzkwM5DehVuaYdVcNrE2ofUq83x/wuFtU3UkENCJliYgn5EHDOkeT+ye5tcHPlweqVLo66+7TCJkZNV5YyxSTvgzsXF9ywRg+YQP3GNqv63nqxhMvCTUuWpJSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ed9502b6b3so33203055ab.3
        for <linux-block@vger.kernel.org>; Wed, 27 Aug 2025 01:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282534; x=1756887334;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k03l+q/FPZAUzkeruzpDHLoZk+YpUT83RQwZwMZ2xes=;
        b=pysBrYIoqzBPNpKxiL5PKyLejNjYyzWK6Vsz+TgcnwVVd/ipUvzYKti8bUCq5/+bQf
         gc3Ncdte1WQMdAxOzwawjTkW2L8rE7um5EQb9CL9fp3FxQE9Ew2R3tPfNdqFzurn56qO
         DTxXUaq6ihjWYXsXZz2rnZS2uLWRGKOA/oRgGBZ/vsQOp02RbauESa/h7EtBl/Zn2oIA
         klJa7QDUwGGBXEZ4iyqY60aVpS7xTPBNABqNt1eixKcOdGplboI/rtHHsFboIoa0PkZI
         SjUakRmbahY31tG67JZtadFnbTGmhsEaT7uW7fb29iTb8gjNDt7mpaaXaQnLs+SyQ2UD
         ZeRA==
X-Gm-Message-State: AOJu0YzrkZTkNRwUW7hopdRdyFqbernUrQbAZNNXSJU1/gS2gPwaZrdM
	bjd2+IMaDdWMNNx0ycg28IuzHET3l21PUOhDD6otYU6jxcGPRpdnfbCKpx7wtw/FDAoWdAwNfMX
	VN9qNd0/dklQNcOz6dBl2RFIFatL/CV8mU/8h5BZ4+bnpdHBGvvxGgLSPvEY=
X-Google-Smtp-Source: AGHT+IGPV1rmArovvxBES9M6nYuG/AQ0qtDQVHQmVeIxOvvA2ISNOPKVqA4rbcbm1J7DmA3RXVNekHGR3ZyEWLZ/ZxmOlNPShute
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e1:b0:3ec:88e3:903b with SMTP id
 e9e14a558f8ab-3ec88e392f1mr150014815ab.24.1756282534104; Wed, 27 Aug 2025
 01:15:34 -0700 (PDT)
Date: Wed, 27 Aug 2025 01:15:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aebea6.a70a0220.3cafd4.0013.GAE@google.com>
Subject: [syzbot] Monthly block report (Aug 2025)
From: syzbot <syzbot+list17848dc1d79bb6dd245d@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 2 new issues were detected and 1 were fixed.
In total, 42 issues are still open and 104 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  44250   Yes   possible deadlock in blk_mq_update_nr_hw_queues
                   https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
<2>  43987   Yes   possible deadlock in __del_gendisk
                   https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
<3>  6788    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<4>  2605    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<5>  2281    No    INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<6>  1685    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<7>  1384    Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<8>  747     Yes   INFO: task hung in sync_bdevs (3)
                   https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
<9>  574     Yes   possible deadlock in elevator_change
                   https://syzkaller.appspot.com/bug?extid=ccae337393ac17091c34
<10> 105     No    KCSAN: data-race in block_uevent / inc_diskseq (2)
                   https://syzkaller.appspot.com/bug?extid=c147f9175ec6cc7bd73b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
