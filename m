Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD436CDEB
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769776531; cv=none; b=tB4GrdxlukxUnToU4d0hLBD6YSLhYeJuGuxBIXXupi2g4cmh4SI92P8mrpPSeKr5or9WLN3HdODkKRBOaoKoBrTQ7jgFBsS+6hr3k6FVF5Ugh9MfYJ28WmP+CRWO0F9nINymUg+fyjCmZMnSLhVlbZp86lRgRuIjTwkA7THpabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769776531; c=relaxed/simple;
	bh=E6Ym4Q6E2Nk5tZ4hGeZ85+h+V1SwK4jeyBBx4YjJmmQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sLDWudW3eYKREUliv85qOqcmdvlJrEgI9IGCuwyhfCTNlUpucp5q5qtkVebXrENp6BOrJd0rNqEPCSIVsqEAyPjr+v+H+3TrY0cVEmYuiMtM/gAbEdQeWd9Lo6G5hsbdz9Ai1teword5goNqeQa3Qt+PKNcd+eO2SzcJBlOTsow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-66314e79f6cso742521eaf.2
        for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 04:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769776529; x=1770381329;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dHQ2gYlVwBCbmrP5aNeBe8IwPY4dK+Q628znig2cnq4=;
        b=n5igB0SfMkqEmWup8O6zGupeUxbHoBYSSf9wdzBKCZ/u2POpgM4pGymj0OWdUEH6ci
         Fp88Xa/rKrcd/aisa9y1ruWj+LRooe0yZWhUKNbtRpGxn1qbJxFCzeGn8uZVArYPYpmv
         PWpr0w6XULjKFsfoi8hPI05tNrQxuobl9kp4U7+JW26JvwoKOzFXtenIdjjP/V+oXBDF
         iYHnnuX53BPNeanJ+VI3MuRM0o7i2UFluf8fc1VcAUaZQHvSI0B+UoVl8CUymVdUdZ8H
         n2+Su36WxTqhJS8WUFkjPJnvRrDNkYapwgB+wPASiakYOjkHTcb8Bs36Q8x+qVzOPTht
         1mRA==
X-Gm-Message-State: AOJu0Yw12KtOWSYIggjD3yt5tvE8jn0Cp9pb25IG709dukE6uCGrSOdy
	Ga3d5+VKRaHwbJMGiG+jeMq73BED6R0UUFL/oKk62/CWAz0syCypRQmbRoRCras7N4542Ufe2iD
	BX5dz/i0jfHtfIxQN/p0j7L/HXqxabPAYZHLDc+xWvNJOrGPtNxwmBb+u6C0=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f08:b0:65b:250c:70e9 with SMTP id
 006d021491bc7-6630f02d377mr1235092eaf.27.1769776528833; Fri, 30 Jan 2026
 04:35:28 -0800 (PST)
Date: Fri, 30 Jan 2026 04:35:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697ca590.a70a0220.6f39b.0240.GAE@google.com>
Subject: [syzbot] Monthly block report (Jan 2026)
From: syzbot <syzbot+listf4d018cab1259bab4bbd@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 0 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 108 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  18846   Yes   INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<2>  8181    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<3>  3789    Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<4>  3483    Yes   INFO: task hung in sync_bdevs (3)
                   https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
<5>  2632    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<6>  1696    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<7>  682     Yes   possible deadlock in elevator_change
                   https://syzkaller.appspot.com/bug?extid=ccae337393ac17091c34
<8>  512     No    INFO: task hung in queue_limits_commit_update_frozen
                   https://syzkaller.appspot.com/bug?extid=f272bbfbf8498ddadea5
<9>  139     No    KCSAN: data-race in block_uevent / inc_diskseq (2)
                   https://syzkaller.appspot.com/bug?extid=c147f9175ec6cc7bd73b
<10> 135     Yes   general protection fault in rtlock_slowlock_locked
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
