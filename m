Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622814830E
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352385; cv=none; b=fWDFyy9nHLcy97ymec1PfYUtH1iYAbOXl5AKYFToXqFexphlJPHBbkjn9xQz3wb/54omchJKmE0WD53GZTLIcUuim9DIhVJBZomIVrF69QT2Lnt1e1vl92JAkw/latuDgwZdAFWPoclrm41N58cpdKhEd2AzBLao6ioz7UfaatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352385; c=relaxed/simple;
	bh=YNrjmEFhFu/Iht7Oz3AJRns6tt0ZkOEiOuMZxLasMhs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NhVhO9+a9FTN24eYXwBerJ67TwbmUQRrZokQSoYnP9L3d0USRMLah1gozRfFuJeVmhr91dII5SsyL9JpdNMhKybzmSNve9EqSuqqJYIzUtVAIddTMhf+fZjlHTpHczF0zApqwVe5xMDSklVdskd+gGKx/f1yhv/Rl343cK+Khzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e8e2ea7b4bso206494739f.0
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 01:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352383; x=1718957183;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bszOdXEI2aLCj/VanLaXK3I60DKMg8jDA6LBohLrBA=;
        b=Mm52QWja0air3hwn5UlEDXLcJDmq76kwvAHg4lrrL6O/46C0aGbjMCer2dMK0H4sMA
         EFslpPO9aP+AGSlGuJ4F3S4dShUwgQggm2xNCOzyyU/ZAHK9KVzFn8/Dxnq/1KA3BGLh
         5xGpHqlTD+2BHD3TQiKUmkkF7fGutmxiwNFuVi53pYTV7pqfZq0P/97/x2Y2VMNigUF+
         nnTvlksPUc3n8LVYEvEzQMn+P/OSXhjWpvnQ0c0ioCZaoMXkmmu9rr0iGrFbDN8PvefK
         p5OO7wxvSTfZuIAY4Gv3hWT7kS/PCdOiXwdHenRIBFdn1tbCbNys+deY0dnLLHWp54dt
         ynwA==
X-Gm-Message-State: AOJu0YxXx8WvunZX76prqfeMQrRLsIHUyrCdBnFgmk/SFa0W7mbE3PB5
	urp4wrx+cRY8RJ/867fvxOv9ViViwHRbgYoi9SDN8GdB3TSKVcCUmzv9IslyNKlju/t9YNFZ3Ki
	7VfVLNge5DWvMpmR98vXyydGtD7S5Izv+E5KYVwARIXj9bnMYmyIf62A=
X-Google-Smtp-Source: AGHT+IGobcdHzl499NxD1wMwB9yj/YkJ9vCqHaZUDtpsYf2ljE3FvoLxdULYWhOHlHGdKbT8R5CGMLrLl9QiCUEsksL5ENf7xXEl
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1652:b0:4b9:6b78:c7c with SMTP id
 8926c6da1cb9f-4b96b7859ccmr8734173.3.1718352383274; Fri, 14 Jun 2024 01:06:23
 -0700 (PDT)
Date: Fri, 14 Jun 2024 01:06:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000678280061ad51777@google.com>
Subject: [syzbot] Monthly block report (Jun 2024)
From: syzbot <syzbot+listd3b078459793c0b5f92b@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 3 new issues were detected and 0 were fixed.
In total, 28 issues are still open and 92 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2252    Yes   KMSAN: kernel-infoleak in filemap_read
                  https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<2> 669     Yes   INFO: task hung in bdev_release
                  https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<3> 615     Yes   INFO: task hung in blkdev_fallocate
                  https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<4> 76      No    INFO: task hung in bdev_open
                  https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<5> 47      Yes   INFO: rcu detected stall in sys_openat (3)
                  https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5
<6> 35      No    WARNING: locking bug in mempool_init_node
                  https://syzkaller.appspot.com/bug?extid=d24a87174027a66198b8
<7> 6       No    WARNING: locking bug in mempool_alloc_noprof
                  https://syzkaller.appspot.com/bug?extid=c8ae2cacba71e6145314
<8> 5       Yes   INFO: rcu detected stall in aoecmd_cfg (2)
                  https://syzkaller.appspot.com/bug?extid=1e6e0b916b211bee1bd6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
