Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77A2E414
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581293; cv=none; b=HrDmAgJDhpsH8ki1W9mDd/qp9s3KM7qmy8Uw2lV3XpekRvd3Ut8PoVFpAu6FZT1G6ZBBUOiqVhyfKlCdfieQ15ynqqEj4XpwWG1U0pIb7JKOvRITQ/IhoSkYx0/qPXhSk5buupJ2H4uP20uddxedn1lk6fRkpYmsQBxQ09Ww8dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581293; c=relaxed/simple;
	bh=a4jsSf9/zcK4lMtzskmM4vLtLev8Uf6YL2J6VGiRvJQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HqeKBWWTPctcPvg8VRNj+s8ryDhgYeJIS5UefTewKm+YYbr/C4vxWHKEAqx6H/FgxD2dA/t7jnWrpjE6fDQoZpDIz9B4fTBIdz3Un4RJvPu/lPAOrG1eGZI5nBJNpn81i3CoxxVhPCs62PrCzjop68ESRNAY0bpgRrpDwlWkERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-409e0cc22c6so15852272fac.0
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 15:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772581291; x=1773186091;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iYARrIoAHKBy7RJsKSiKC2LMqIKd/Bl1wyP2i2TH4+U=;
        b=oqWRBBqPm7DJz2lhXQgKT+oFNjGsWnQVmIAw0eauv4nmxSJif7T+DU+JW3doeg8fSW
         PaR5TLqWGFnZIxUe5LKQB4AbatJfKgLGu8Q5Ae8D7Fkh55A0nW78+lcDCcwa+sb03qF4
         yynFBzXe19Nlxcwpvh3NtdYdJ1cnCM5APZW9AGru/x7su6b5rOub0Vfhichjvk/TZto7
         jvpRkpswcNnjV3XbQkyfPEYkKhmGrNo78KIxtGN0KTrHFrDXjAefaYiebejvOEQ78HC1
         xFwKzmBium+DutO0S9ZOfSSKQT+fQthA3njipLP33anlVwA6o2IQ0Keb+Svx0Ztlbdf2
         kn6w==
X-Gm-Message-State: AOJu0YxHQr5i0zp/oCmksCxEc9yJ1RH/mk6V9yq5un59vJdcs/2BhaPe
	JvmUKkdNpWg77R7fU/adudwb9uEB12Aiz0SzSJ9clkr67xyXO6VTRdstlDVmv/o2gpVKMppEkBV
	IfUziVXbAFE05WS3+SUvM5U+tlVaolnpQFgHoBoFiv6UazjDMUteA5rzhJQc=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d43:b0:679:c749:f92e with SMTP id
 006d021491bc7-67a1da0f33emr2257020eaf.8.1772581291118; Tue, 03 Mar 2026
 15:41:31 -0800 (PST)
Date: Tue, 03 Mar 2026 15:41:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a771ab.a70a0220.b118c.0016.GAE@google.com>
Subject: [syzbot] Monthly block report (Mar 2026)
From: syzbot <syzbot+list9b4af07fe4f5b4a71b50@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 0 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 110 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  36206   Yes   INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<2>  8511    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<3>  4263    Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<4>  4032    Yes   INFO: task hung in sync_bdevs (3)
                   https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
<5>  2645    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<6>  1702    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<7>  812     No    INFO: task hung in queue_limits_commit_update_frozen
                   https://syzkaller.appspot.com/bug?extid=f272bbfbf8498ddadea5
<8>  731     Yes   possible deadlock in elevator_change
                   https://syzkaller.appspot.com/bug?extid=ccae337393ac17091c34
<9>  253     Yes   WARNING in wbt_init_enable_default
                   https://syzkaller.appspot.com/bug?extid=71fcf20f7c1e5043d78c
<10> 156     Yes   general protection fault in rtlock_slowlock_locked
                   https://syzkaller.appspot.com/bug?extid=08df3e4c9b304b37cb04

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
