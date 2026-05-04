Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B74C97
	for <linux-block@vger.kernel.org>; Mon,  4 May 2026 04:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777869157; cv=none; b=AckxYtFZK9d1JrXuaJD5WTvpiMNakk8eQzY8LM3wOe9VLDtuyRrjKTZ17VGWe2JWVgvBfs5nhBaNJWyAl5vV7mKGrBxukgPgoCsI3mkVkRWCAUSaYBLOydBIZ2hp/fr816S6VJT20OkvhSLOCrmXQjTnOzNKmzzKCLC48uyCKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777869157; c=relaxed/simple;
	bh=BugRg/d+Jtjkx1+xJ8CqYJ9pH2UHimNasVFUDTIpO1U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d5W1xsoqemFkOnMHgbRIf2V8+yyZb8mdB98PBivR+F/Okh3MaCCM7zRbCKUIKyeF+OA/2pKvwxzAsTwj8MCz9ZdPCbCpgyBhsMSjWLmq73jhRtGwy7fFmVqLpj/8KdrIlZ6UJiu9mvxFEorxyx7LXGmqgFHSDlQIgRIqBGZQAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-40ad1c724daso5356760fac.3
        for <linux-block@vger.kernel.org>; Sun, 03 May 2026 21:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777869155; x=1778473955;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FNCybhQ3WGFOLDqa4oQGDlGDYTbVmDQn/QrBslUlWU=;
        b=Xtptc7aC5EoEtkVz26steIB1qgvNJ6VPKqpaJRp6EpSGkuiMab0XwQha1ZmtSC0Xok
         na+LMsL+AV4Qwlmmm+PL1yVzmg6zjv5zY5DNnck6hVQ7w7O8pLXSt3H00J5nTqkYPYF8
         Fxj7TktAyExKC3lZnaMMZosQB+fMnZ5KmPlN4fsCqo7INoDV1YNNrZOhgSPdM68jo5+z
         6oiiIpz7Vim4bG8TQ9rsfuRzow/TUrU9+eRT2oPJShupEbujFOiwQ3ztQ/g1R6l/uNT0
         qBeJKkBru9yjMkuuB/CGFJX10DqpSuiBRt1rd7gYGTVPyVI1JRGJgRppcmsQwDikdnIH
         +TCA==
X-Gm-Message-State: AOJu0YyQV9kGRQDNZO5mcq745e1kwM1QP6U1faUrO5r9XxzvAnFxCd0o
	UpTfNlaNmMwndrW9KxtvsPkzqrSHR8g3DK0m2XSL4Jo3lH7cbvjJFq11ArIdBX4hnrBaomq2ey7
	q8nmOuTDI6cnGL2ZmOHiwgDETEPw+TBLzTKf2hYJYVxlK4w8JU4sYHTR7fHc=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:61e:b0:696:786c:94e with SMTP id
 006d021491bc7-69697d6a0a5mr4249067eaf.46.1777869154842; Sun, 03 May 2026
 21:32:34 -0700 (PDT)
Date: Sun, 03 May 2026 21:32:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f82162.170a0220.13cc2.0001.GAE@google.com>
Subject: [syzbot] Monthly block report (May 2026)
From: syzbot <syzbot+list9edbf03fa44f1a3a8b1b@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 2 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 112 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  60717   Yes   possible deadlock in __submit_bio
                   https://syzkaller.appspot.com/bug?extid=949ae54e95a2fab4cbb4
<2>  54118   Yes   INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<3>  10964   Yes   possible deadlock in elevator_change
                   https://syzkaller.appspot.com/bug?extid=ccae337393ac17091c34
<4>  8886    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<5>  5009    Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<6>  4770    Yes   INFO: task hung in sync_bdevs (3)
                   https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
<7>  2650    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<8>  1706    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<9>  1191    Yes   INFO: task hung in queue_limits_commit_update_frozen
                   https://syzkaller.appspot.com/bug?extid=f272bbfbf8498ddadea5
<10> 440     No    possible deadlock in __synchronize_srcu (3)
                   https://syzkaller.appspot.com/bug?extid=13d361cfb0c0d33ff8dd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
