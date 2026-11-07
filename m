Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026021;
	b=lCGSMV2wylEx0FiK6Cr+/vQ61BspK4/TEvBOoP4BN3iGN7ANMDH33W/qSBoTM5b//tup
	 Iic3rofTBvbhLGROkvTtTwdMWUwq68kdrYbE5oOqwLAYOukV+BkToBT0aelC5D7V5ZUWO
	 2qW5vpXGiO5HltrObdZWMA0+cfKK7QPubkXkVETk3f57CtZ1xAte5aQtQq6VZPY2shS+K
	 7tqTO1UUxipfyOVf/RnLT5Kk0MET7TlvjCjDse0cYhf9OyiDizwRJJ2PHeck5ngfVRm5F
	 ciyqTDAgZjXUIkXg7pM9ghuvMNfU0CCwpX+Ma5o1bUe2TTGJ61XG7hmi4VLVzqRIdGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026021;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=7NFle5EcCexVV6wXsp0CMRBUK7BzcYXOnIxO69P4PHU=;
	b=LWwzpTdrgD43B0ocIP44GdUzFl54ESyPO/8EMfzKdSa++Ynj7OAnyOl0jVMR/Ly0jD7r
	 LtHrByGkIqoB7PqRyfX+j4pZZWBYoLMeck+2A5xAEqUHqXE1g8hg2AsoCfnA29vr8WjWM
	 +3N7PTMFKKPYaHAvKNyemaKIW6DtHmahDKrYrJ5B5RYvUMt1ByfoA5sgc6hKaZPVPlNAQ
	 X3Tcw0vBQ3vZq8EGJMsC+VD6WnLjpJYwzMS5T6mP0isjtWpdrMi85xdTvYtmP99q4crrY
	 4YFgxI1MMKtR6Upy8mwtQdLb9QOZD5uzxi1dq31yLnBJpSwc5wIUXp6PXSA1hot2Qgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC5606A32C
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 04:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EEC5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4dc57e2a3f2so1802234b6e.0
        for <linux-block@vger.kernel.org>; Fri, 06 Nov 2026 20:33:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026020; x=1794630820;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NFle5EcCexVV6wXsp0CMRBUK7BzcYXOnIxO69P4PHU=;
        b=uDSFIiTlZNwYBLiY4rrppRYAS62MfOP28wLdolpHijEHlP6mbut1P8L1RP2KHhmHMC
         uP3x86Snm/fwpR+P5w2qLawbp1K8m6JRSbVz7XruZ6LhfbfPAq4rS2M1qbQhqsv2o0v5
         IhmCLUcCBogpqQT3zCBB/NVg5/XzLaCjLVNIT5U538AQ8fxrjcUWyTVf/So2isNQFXyy
         2QGLyYlS+mzNWxPnycjQzAuKXOeGSN2XpkgFWA9lc183iV12puFKrNjwa5C1LgViT/nb
         lmh4ZtJTmoc4rgoQVymmBmCtMFVdcx/Djk77w+/kgoLaHeErme+ug8ScLtyQ6N48mals
         Uhsw==
X-Gm-Message-State: APuU4Z/c8/W0EhTpIGcNIKk3urpREOLPOGHsnUt1jRCErKXIvz1JHY9g
	hX32K3lfn7y3J5ZF+igXRlJ+wJg5C7/EVP3a4RwjrVEzX97rD7CZuCp3D5Bsk45OigjlAOzlWg2
	hw7Jx2QiS2/lOmZ+iEqHMmEaioDBwVzNOGo2KxVrWVtjefuHE71fLgqnwR3o=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b0a:b0:4ec:4c7e:37b5 with SMTP id
 5614622812f47-567e154cc49mr3455968b6e.29.1794026020468; Fri, 06 Nov 2026
 20:33:40 -0800 (PST)
Date: Fri, 06 Nov 2026 20:33:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aeeaa24.1da6ca5c.10a313.0000.GAE@google.com>
Subject: [syzbot] Monthly block report (Nov 2026)
From: syzbot <syzbot+list1913a7ecb8f6c20c529b@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 1 new issues were detected and 2 were fixed.
In total, 30 issues are still open and 124 have already been fixed.
There are also 34 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4342    No    general protection fault in lo_rw_aio
                   https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28
<2>  2419    Yes   possible deadlock in blkg_conf_prep
                   https://syzkaller.appspot.com/bug?extid=144a1c0e22e53a08ef5a
<3>  1749    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<4>  323     Yes   INFO: task hung in __rq_qos_throttle (2)
                   https://syzkaller.appspot.com/bug?extid=53706c567afab5131044
<5>  219     Yes   general protection fault in rtlock_slowlock_locked
                   https://syzkaller.appspot.com/bug?extid=08df3e4c9b304b37cb04
<6>  69      Yes   BUG: unable to handle kernel paging request in blk_mq_complete_request_remote
                   https://syzkaller.appspot.com/bug?extid=2e3bf0bd49acd9b21d4b
<7>  34      No    WARNING in blk_mq_dispatch_rq_list
                   https://syzkaller.appspot.com/bug?extid=49b69d460fb5134ee1d7
<8>  31      Yes   BUG: corrupted list in blk_mq_request_bypass_insert
                   https://syzkaller.appspot.com/bug?extid=f4353e96f7004ae5a09e
<9>  5       Yes   WARNING: lock held when returning to user space in blk_throtl_init
                   https://syzkaller.appspot.com/bug?extid=1eb53c83ab8b0a0302a6
<10> 3348    Yes   WARNING in blk_mq_free_tag_set
                   https://syzkaller.appspot.com/bug?extid=02b37e31e64ea5cb6d29

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
