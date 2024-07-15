Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE435189F5E
	for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044289; cv=none; b=X/VICJCDZjPwjb0iKxwhAueKGjPg+CTgsi6ZUgLnJyU5M0f564J8I4eFtgoPOgoSmt6jfpodQv8tj/DPyxuP5ZLFleQWkh6ft96ru4deXPEypStDK5o/65+hon37661ME9xR6Fv9fRDU6hfteWuSZGAujMGPSJUXMl+O0zGVxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044289; c=relaxed/simple;
	bh=70APk2vup2aHyqBd4lj4d+RNYSh3+IZ/TMN9NL5v7N0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VsA0KE+YDak5/h6r1IoYEvwemiv+c4d9rl4p+EoURAdNNHe+JfJQjEXJOPo7s7mMATMxZVC2CnL+JUuIeRhG6OlZiaizupCHncigPZxeaczKyUgz8TEEiv0A2PIgws8XprW20ZSGjPfiZgc0dwEFe9L2MaS5hSjRIvnl9MHr3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-389cc381cdfso35983455ab.1
        for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 04:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721044287; x=1721649087;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MS0q14/CC5LEx5UrysUIC6G0ZW/iY8eAsqkG0XIzx2k=;
        b=GjLw0QdLfue+/HRUuEMI42tZ8FUVmZSE4roFHnR1Tw9pDzboBGzMwusq/4r0vnzB9T
         MKSPGZw4NNjsJXbOojN5akeNDrBMnx4OEBznMUr/plyM5FFN5YXcBfLwFxzB5voRUS2K
         MYW6LWo3Y1toyteKH2QS/A+PrBEohwjgdEgfQm9TMj/GGhQqR2ppQDpBH7asofnLUh/y
         4ZMmrakSvN7zfcDFff/hF+pLZPUVrP74hv7HRzObeKkY9LxhG+aAhUgZdMZB5X1iUpQ8
         a2OxLvJcTTU4o7Ov565sCViHR9guVVl/dRxqxupaMkHX6M+brnazR0qy91jR7QiCniER
         ovsQ==
X-Gm-Message-State: AOJu0Yxee+kWL3CzCoGzCNEoL51W2d+w+V8yDb2e9pXazA5fktLkKHQq
	DyexsoCAfT1RjunYAjmJkCLYi2Uw7UOLyLhpiWRQS7zOWE7O/LgcJSBHWEkMe7tFtUZToWD+w68
	zZ4cXjCAgXF5hVuM5UlxZG2pk05awy4YHDkoUEkNWcXiri0vwsSoWbO4=
X-Google-Smtp-Source: AGHT+IFxGMUdmYwcDaF97K7JOQraDIdqZoCsALLxxX7csz2iErGbhBm0S2j0iJe5X6hEvvAQLbJdDjVd9RQlT12chqoyENeSwsRx
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:b0:381:37d6:e590 with SMTP id
 e9e14a558f8ab-38e617d58eamr10704675ab.2.1721044286880; Mon, 15 Jul 2024
 04:51:26 -0700 (PDT)
Date: Mon, 15 Jul 2024 04:51:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005cccb5061d47d942@google.com>
Subject: [syzbot] Monthly block report (Jul 2024)
From: syzbot <syzbot+listd7ef59b4c72526c29e94@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 1 new issues were detected and 0 were fixed.
In total, 29 issues are still open and 92 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1363    Yes   INFO: task hung in bdev_release
                  https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<2> 746     Yes   INFO: task hung in blkdev_fallocate
                  https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<3> 299     No    INFO: task hung in bdev_open
                  https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<4> 36      Yes   INFO: task hung in nbd_add_socket (2)
                  https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
<5> 28      Yes   INFO: rcu detected stall in schedule (7)
                  https://syzkaller.appspot.com/bug?extid=005409b89b9a9675cb2a
<6> 26      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<7> 7       Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<8> 3       No    KCSAN: data-race in block_uevent / inc_diskseq (2)
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
