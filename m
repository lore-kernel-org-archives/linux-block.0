Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7F2D5416
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767088350; cv=none; b=f3hoK7UjzWVuejJPcdu+jqJ8dL8eP7OquerlFY6XRva+Essf+Kv7pUBcA4+eRcFRYxEIYUM+gZ0hsX5+1Je+dW7pivq2wkFCrVFCBwK4b7KS+4yhClIiPVgeooFVPT/f0pHSpeBsGUuxwhZkpZUcjk3nipFO/9y9FdSzzPQ0rko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767088350; c=relaxed/simple;
	bh=RiW1unDnv8u6+802ldD2QN+Gyks7gkE0r1Lyx3H4elk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oROv9a4fYDE3AhkjVm5pjcgkdCvVuy61WGmSLrXq5iL/wcAIHnoCgBdDE0t4bU2XlO/Y/vt1xT/li/IQKFJt7LuC1hCo6//x2xjKdsQoujHBLe1CZ3b3olD4zy7yxDErHOwhyfki5iAsPY6ltlHLQKUvQzn4XZq04BYQKJv9Erg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65b31ec93e7so17613043eaf.3
        for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 01:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767088348; x=1767693148;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkM8rPYKtwUhzVjSZKbIQ51CP1k4z6NoUeqakqK/fTw=;
        b=PnKYSvnRF0+NOYMorQ+kC+Bbpu39UCkj7UpmpBo2tCyUiBrRB6hTD82nqm74xNNBzB
         b4vnoU8j11iG2VMmEpN8BQt5jCHC2GOVpyEVd6ozTdepvP68FC+TfkSXCEHyJrWPgqaW
         lLtTHRyPIEXHlUUwGOTRnRuz0OEDCjIKbOeQBA8w4ruvcSSWQenLExgqnqyqkJT1x2v7
         5YJovOmXA6IhClrJeK0hc9raDYmd+InBWQYqowYOUxCcoc+9UjJmTbxvp5TgCVeLN5d+
         hinAPk8LjzExIMT5JKmi3ev+Z7w8lh71L0O3Co1CId8UuDbZpUHNR3L1pHJh0j/gtnSq
         +3yA==
X-Gm-Message-State: AOJu0Yw7ylIOfYfYZlaaPLAQxFoeJpz16mwGUZkoFWElIWXAtzar3U0g
	/4tes3z3b/fOa70iwlHtQPpF9ppAQlvsOD2DtO/r9FNiWD1UY+134T4vLRgPf85d7DjFK+MOUJl
	SEV6SXBYruIss14cJ3Kfrynd1vN5b9TbyRfwaThiAFak+TlvpHLx5l/Lop30=
X-Google-Smtp-Source: AGHT+IG4IMY0eCHDnQenlqNMJPwuMfqrJUf6dWUd05MtV9ZZtBXYk7i67M3H7wFGsuHQ6tixSx+i2DoJAhLHad6BrCJ0SdUdHUUz
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:808:b0:65d:95d:2de2 with SMTP id
 006d021491bc7-65d0e99d251mr14805499eaf.25.1767088348429; Tue, 30 Dec 2025
 01:52:28 -0800 (PST)
Date: Tue, 30 Dec 2025 01:52:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6953a0dc.050a0220.329c0f.056f.GAE@google.com>
Subject: [syzbot] Monthly block report (Dec 2025)
From: syzbot <syzbot+list55d44ccb73da1c14b834@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 1 new issues were detected and 1 were fixed.
In total, 41 issues are still open and 108 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10004   Yes   INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<2>  8144    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<3>  3127    Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<4>  2746    Yes   INFO: task hung in sync_bdevs (3)
                   https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
<5>  2628    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<6>  1696    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<7>  667     Yes   possible deadlock in elevator_change
                   https://syzkaller.appspot.com/bug?extid=ccae337393ac17091c34
<8>  282     No    INFO: task hung in queue_limits_commit_update_frozen
                   https://syzkaller.appspot.com/bug?extid=f272bbfbf8498ddadea5
<9>  124     No    KCSAN: data-race in block_uevent / inc_diskseq (2)
                   https://syzkaller.appspot.com/bug?extid=c147f9175ec6cc7bd73b
<10> 101     Yes   WARNING in blk_register_tracepoints
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
