Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537D19413B
	for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926307; cv=none; b=Hy/4TZV2P60X5gpbpkcRYrZwcc5As+BsyOLK0V6rRVzaRm0E0q0GVWyTqrt3vGWMslMWlG/5S6vS35CpmtaO7Zh7iwY7zPpJlcUW1CTQAz2+ZUPmc2zSsCl0CAXy8fi9tQqJsh9yqRCfeIxGSgmLzbITqvf9ovZfMPA6fW+OKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926307; c=relaxed/simple;
	bh=lyEVHi7boa6+42JktJuQBxCtcIyTYbecolg2zsmnpRs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XlQ7hbdIbYx4yKjXzr0boxBBe0Nd5SP+dShPlyuSH5Exq4qw2uU7DjhDOaqwVB0TLC9WGXQ6JQNHAesm6u1t8UOBJkBCnrI4KWYpM/Px6M3R5mlBgxi3uinNF/7PUVlGY4v3uej43EN93r2KlZOqVyibDT9ECpMBSEgSyUbp8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83e5889d61aso340222539f.1
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2024 02:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926304; x=1732531104;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08ogtEKcqzDtfuYA/LvivOvA8KPOKZ6Im/TfPJizZOo=;
        b=IF/ZcyRHdLuLXT30ouYgjL13kKyJEgHFkeB+Nj2wUrF8/IjRIsRvHqW8EM4nceQcU5
         9RVvpb4jLJuPx+eCRS8Pqrah+WMzdfhnPzf7ve8765eLQHS5yCZtzODjKoZoH93qqMqF
         MnrwJ8MknpeU+63YZdUd50soQD7lFj4z3vZqzZfD3InFMnq/xZrVC4D/N6wlJ4yFzDDm
         IQxmV3s2wa+36M7XZJ8RHHCAAolwCJb5FPPT7y0qt9bT1qRWHk+d1c4LCoCF+89DPPns
         JJMuaZ/BvXA9oFqtZlRowWnmCqUFA/v7oEux0Oy79mY/rimNgiEQx+/qwvROQJJWa2Py
         gm5Q==
X-Gm-Message-State: AOJu0YyTEoGwrs3YB+9AAxuZoMGT963eFcZng60M6Xxj/wr0pJD6Z09c
	UnIAY5bpfFJ1HJQ5c61X2vkGH0bIxfMY2gLxtl78Z1KtNd2RnuNR6No7sm1ydB4/mx2A95CiefB
	Ulluk7jYDLb1YsZnPmVTjbjb7q+vsV9hYBPXS5dm1EoPruNynjZuZJBc=
X-Google-Smtp-Source: AGHT+IGkXnSzslqF7o0Dwg6YQ1iCwJF428jfkHy2lNlrgQToSRr0lemrPXX9zOz/8nQjZMDxI/UyYAOG7Dv3RCcBQmoyfMDzsd+5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:b0:3a0:4d1f:519c with SMTP id
 e9e14a558f8ab-3a747ff8c92mr119140425ab.3.1731926304717; Mon, 18 Nov 2024
 02:38:24 -0800 (PST)
Date: Mon, 18 Nov 2024 02:38:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b1920.050a0220.87769.002c.GAE@google.com>
Subject: [syzbot] Monthly block report (Nov 2024)
From: syzbot <syzbot+list462fc37593d30c75df84@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 8 new issues were detected and 0 were fixed.
In total, 33 issues are still open and 94 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4450    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<2>  2406    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<3>  1643    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<4>  587     No    INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<5>  335     Yes   KASAN: slab-use-after-free Read in percpu_ref_put (2)
                   https://syzkaller.appspot.com/bug?extid=905d719acdbd213bf67e
<6>  287     Yes   possible deadlock in blk_trace_setup
                   https://syzkaller.appspot.com/bug?extid=0d8542c90a512dc95185
<7>  40      No    INFO: task hung in set_blocksize
                   https://syzkaller.appspot.com/bug?extid=3c0a6dfa116ca1e1ad1c
<8>  37      Yes   INFO: task hung in nbd_add_socket (2)
                   https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
<9>  35      Yes   INFO: task hung in blk_trace_ioctl (4)
                   https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<10> 28      Yes   WARNING in blk_register_tracepoints
                   https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
