Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECBE1E1C36
	for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753612892; cv=none; b=jl+UTkI359hZ+Rt6PO7RFvbeqsI0VvDnkne76yGj9EtVASGaqIyOfGVy7ULDlrJ80lceE2PtupR58VCHGMe/W/HKMr/LEcKGjq1qw7oHGk1124fy+tuBq9Z9/kQwi2CssD/MfGCn604Gy9cDe25b69TH/TieWpNk+Oni6EH8b1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753612892; c=relaxed/simple;
	bh=4jd+r3D2RcrZO98uB2Ibbu67T7Z08+hjRveOyKEc4P8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RqiOj3uQW7p1z7Nzb5wEaxg0ezs9HpGO7Fft6cRJ/CwQNCLtX9RYtR6eHb5ud8P/oMj033BEq4hW+0bg7jKanYK8++TCDdFtwI8+2f5gJM885NzuF0P717mvndFSfQ16xEMBEbomLnqDI+zFqEwcMGugC0r61sI1TrzdHx9a/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e3d0bcd48fso23417735ab.2
        for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 03:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753612890; x=1754217690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfZ0JwHzGjBpAY4VrTrIkFjFu/w9P7ORWKY3YHrRzN4=;
        b=YaGpIbSCUvjuSdbwOV+XaBbRfMDMxRmYeDoLfhKjeVZFXyCrejV0ZwQzZt0p1feYEQ
         kxvomP/ab5+udNhklTMAZnmlHM9hJ5zXi4w5Pks8uznYwRmboat8yLaewZTzzaJL28JO
         r9keDStZv1zwsNKeJ1BsaL/cx7Ifd/ZGytz9uuKzAPtZLo/kMilZlvshmM6zDoZyrMhS
         LZr8Wb2cRD3kLXcD+uh7L4NX2zyMdzJnfMZqcCbSI40HwZ5GOM07X4AbPzu+sKlDiaiN
         Bx8a9eAoklXMLp11J4MLrr3hP5sxxrTmgWcN9L3GxPcJ5R3H/uKbbRAoJB9W0OmkMSkC
         cmdQ==
X-Gm-Message-State: AOJu0YyvvM7wBc72KxNh/xL13SVBLEPalwIYbFJSr0e+FhKUX24qxLHz
	s9a70mTyLPSHVWK1LBTI6ooAs9d6taElXJ6/E++3FYy9a0sGjzLL1/WeIapkMSMyrAD5jKjYsH/
	L9itsKgBiIP94ldbsiTQG1y9vIBFicz7E8MAO0gTfIYh3SpAZ+IRqdrhmqSI=
X-Google-Smtp-Source: AGHT+IEsRhyeI6yT0gVQGdL9ZNEFieSNilDoo9V2IktQyCbviBuiHgfAiDWLZfgQ1SsjHNQRGvTNXtNYgZZp86S4rGcFxTWWN52y
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e90:b0:3e3:d197:b567 with SMTP id
 e9e14a558f8ab-3e3d197b93bmr48605845ab.9.1753612890129; Sun, 27 Jul 2025
 03:41:30 -0700 (PDT)
Date: Sun, 27 Jul 2025 03:41:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6886025a.a00a0220.b12ec.004f.GAE@google.com>
Subject: [syzbot] Monthly block report (Jul 2025)
From: syzbot <syzbot+listf1e285e4117196663a19@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 0 new issues were detected and 2 were fixed.
In total, 37 issues are still open and 102 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  40868   Yes   possible deadlock in blk_mq_update_nr_hw_queues
                   https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
<2>  40756   Yes   possible deadlock in __del_gendisk
                   https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
<3>  6513    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<4>  2597    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<5>  1681    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<6>  1171    No    INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<7>  1016    Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<8>  521     Yes   possible deadlock in queue_requests_store
                   https://syzkaller.appspot.com/bug?extid=48928935f5008dde0a41
<9>  415     No    INFO: task hung in sync_bdevs (3)
                   https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
<10> 378     Yes   possible deadlock in elevator_change
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
