Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C8B27E7DA
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764364891; cv=none; b=Kg6/kI7PpwgmhZYUfK6d8shaRTVUHBmcWw2bllUk0yp4PdvexZkI1dOGPvB05Ixz5FRA7Lid8ZnYz/GjX/BSqI94KExLZlG6OH3jgaoESpEnlIC/XpkdNTa9XiSM1F6+xA3gCmof13y+YKaIBBi6Xvw6BpbDqI0mfrQ3WSCt+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764364891; c=relaxed/simple;
	bh=+1YWrD8pC2hntLaATQy27tuKtBXcG3lRmimS3LwvTKc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fykAelZkgPOfBO52j2uyA6VXEyj8mpU13XBm2ecuNpsP2aOT6rjySrVlS9CbENnJqWmO3pzF57eCmmm3LiJjfAj3r6ZiJfUV7KlI0rabqE3ejpKNCrUwTHTLem+OtFH1FYTcmS7aJZ1xykhKVnf6xgBSRtntH1yOPQyNscYQ6Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9486f0954daso111097639f.0
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 13:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764364889; x=1764969689;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxOH3j5WMMLzYDZCUCFbnamKyZDKYf5WCQO7SYniTQg=;
        b=UC6jglO8tZl7olPk4vCjxKpYdH+P6j1bbj+bkV9JYrOlN7QVw8Jaf7WrQttm8Rd6jF
         D4C5fmBk42FD8NfbcftAqSmcsK4fcs3LN8zIEih5GLp7QxxXzLaCBq58qMuoH2eEBjKq
         n07J+sJHAwSUF48hwcYphQVmCvct1KuPFNHEwKOiZNTa9UOHFfljdURgkJmUj9vwxkMl
         v/CBHLxnUwzcI33Haz3apPnMClmY5TVquvDa+DHARydmDRW2vFJpigN5MKjzRFUeCOO0
         3X2EU2u2TTTtJRTAxLNAqJERK0V4p7zn6X+K0k0VSF4xGsB1kpcipO4bLIKBjG+DzMqr
         SlGA==
X-Gm-Message-State: AOJu0YzUu5VPcm5/YeJ6i3zS5ex+fRrEbsofSRGwDf4VSYH91xKZ4xKD
	dsfBTi4K1L4l9c4OUIIHwDGxwq7zclL3gbrpG3K33pyFt8KsnXNWEwHMywON38FExBN08p9yJpj
	DVwJK+Qw8nkvp+5Yt8If+b7wNfz98vZETwbsGeOxOs8ETSWPn727+IA35Bq8=
X-Google-Smtp-Source: AGHT+IHbs9mQNKUAXSYdZXsI/GCOTQlbzZaHiczhooqSbNHSoZqnyOV0hlqK4O04t/5EVryzb1/ho1ixlhURgig2JFziH/rDBy1p
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:435:9247:12d5 with SMTP id
 e9e14a558f8ab-435b8e864famr292501825ab.33.1764364889019; Fri, 28 Nov 2025
 13:21:29 -0800 (PST)
Date: Fri, 28 Nov 2025 13:21:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692a1259.a70a0220.d98e3.014c.GAE@google.com>
Subject: [syzbot] Monthly block report (Nov 2025)
From: syzbot <syzbot+listf4192d0e34ab0efda345@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 1 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 105 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6246    No    INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<2>  2620    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<3>  2474    Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<4>  1931    Yes   INFO: task hung in sync_bdevs (3)
                   https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
<5>  1692    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<6>  636     Yes   possible deadlock in elevator_change
                   https://syzkaller.appspot.com/bug?extid=ccae337393ac17091c34
<7>  237     No    INFO: task hung in queue_limits_commit_update_frozen
                   https://syzkaller.appspot.com/bug?extid=f272bbfbf8498ddadea5
<8>  87      Yes   WARNING in blk_register_tracepoints
                   https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<9>  44      Yes   INFO: rcu detected stall in wb_workfn (4)
                   https://syzkaller.appspot.com/bug?extid=5b4f4f81240931b16844
<10> 31      Yes   general protection fault in rtlock_slowlock_locked
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
