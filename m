Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F9A1D7E4A
	for <linux-block@vger.kernel.org>; Sat, 27 Sep 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005813; cv=none; b=O8xZtfBHHyrbiFyBYqMlUT1Bl3lx27RGiZ0rTI3Gdl6r7wEZiaQ1Ypsugri3CdyYEr1+9RGirpewJzieaKUbxTVow/0s04fRO5kBp5KZSeqHVq9QNb3RP1SD4CQlpwNK312Kq5mpNwPdtYlvSdrXdNyJISqX1Itx6NXdPkAhdZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005813; c=relaxed/simple;
	bh=VF9+/08UrQyGYkSmyG+Qk1tbK6/TiYCHA02wWiFDAbE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JnUbTg426tYJjTMD6xQfKIhthtkHKtUFz5tdudCXkGSbCiYO6ZxpMXbA1hsHYh8UpMzLsq5ly4cXY/Cof/ATwCNebtvalH42xkWlbx1tc/SRjme6jeH0JfnJtH3UdY0l1blxLBNwCbkJZydQcrzX6A+e/iTUoDuKgaQREk50eR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-887ee7475faso853337339f.0
        for <linux-block@vger.kernel.org>; Sat, 27 Sep 2025 13:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005811; x=1759610611;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnbVeuxyJuDhtaz+8EpGwocy6j6R3G98UG3mDObVIjg=;
        b=N+wEOVArjOZjgnKL76gGHtYQGdTfpRwynGrmv9hfDNfUfwXtB76NxP6BNyyEX3dU5h
         TWeVIYoV13NTcVnxDZvg/rR6II7LYo8TPMtJ4IedLgaq3lyk7PL3PEHf+ZFq7VbkQ2EW
         ts0DKqVhTKtVCmkkRghoDzbtVHTa+VoyflNYki950p2URkGKh/6fHpE3enqSy4piffbU
         WqyBd8LvcOa6+ac+206i8LgIjQjueczqRqP3trGeegJeJW55KbGMGob5K/ktDjoDiIdk
         PNXBeQMz/480erjyPPdLAAZHJE2lJMsYcxkbfQ7S6CHUGiGqgqThMm880bKHzOhO1wog
         UnAA==
X-Gm-Message-State: AOJu0YyKrk0NX7DhdzypG4R6OAHhIWfsSjxc5c5rvrZDzsLnB2rhKytQ
	dcMF46NRTkEZGntzKSGSyx0fAEyAT1dfAnyFibIN5cZDyiNbnWkm/Ozokh6NYJdc36JgNVZt1ty
	TEM/RYvQEJOE9CfzaYnVB0MDWcSO3oam16IZiroyL5QQKIk7m/q2E5Bh6/9k=
X-Google-Smtp-Source: AGHT+IEgAb6RUoUuUU6+VNUs0Cd19ohLNg0qyy6d4iLZhugK2w+73jMiz73PKLRfta/zoGVthLjHt3qE5iSNH5xXM3eJhiT2yG+r
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e93:b0:418:3b13:d810 with SMTP id
 e9e14a558f8ab-425955fb6a0mr178031145ab.9.1759005811598; Sat, 27 Sep 2025
 13:43:31 -0700 (PDT)
Date: Sat, 27 Sep 2025 13:43:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d84c73.a00a0220.102ee.001a.GAE@google.com>
Subject: [syzbot] Monthly block report (Sep 2025)
From: syzbot <syzbot+liste73e8cca2b92b2455106@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 1 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 104 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  44250   Yes   possible deadlock in blk_mq_update_nr_hw_queues
                   https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
<2>  43987   Yes   possible deadlock in __del_gendisk
                   https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
<3>  7133    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<4>  3286    No    INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<5>  2746    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<6>  2614    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<7>  1688    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<8>  1586    Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<9>  1007    Yes   INFO: task hung in sync_bdevs (3)
                   https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
<10> 606     Yes   possible deadlock in elevator_change
                   https://syzkaller.appspot.com/bug?extid=ccae337393ac17091c34

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
