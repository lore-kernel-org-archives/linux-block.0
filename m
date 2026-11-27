Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795816653;
	b=AQbi1lYMWkeWgaoXM9Hj98YbYO8LrFPIY4o0+T8m8uGent16KOJMwc8dd9AfMf1h+bSA
	 UpD4fu3Z3bZZddDSS9GtYNYNymKtEX5T6oQ9DNKOe7yrDHba3kPkKc/hhb3KtTEiz/q/n
	 zzzKD1HHmWKxXmfh6XNMfvvI5dKCRI6jGUd5OSNwB2b/kFkz40e+MRrhLgmAsTZ+tS1Te
	 Ws2T7MnVwdV1JwGgxczQHAKm8RhQQB4BGy58OVanTNC9jQSCZb2cQ1sgskNhsnhudkhV9
	 p1LrQc3aBmXXE7N18tUyPHFOwWlBYWkSmkhOnznfCEdThi/1g3Oxyfw4FwON7HKcMCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795816653;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=6h2Be5vq4BhohYg0FpSh9pBi8qTo4Axywk+YvYQQYPk=;
	b=TESANnPzcsmv4KXOH9ZN7+Xgem6+FdNqYZnts6PuE1Kp3poIELmRrikdrJGNPEAySLRc
	 kV4KkqgEYdFRVlSuMEKXF6dySyXylbncPD1h1l8TJRuQ14/PBBWrTPBywHM5J34oFzu8n
	 23zsx7BSHD6eGePCqNMbyC4BiottkqMxoZEgEKXdBD1A65aaVxqEyTIyyJoGfZAB+/9zP
	 l8kTV75iTppBiQ/uo4tryVK2LfFreNXvFPG5U2mYbqUnN5WPYatMJD1/lpx1TMphhOGEY
	 YHK2dkPPEvcSYxqflpMrx1N4S5j69tgWv1G3tnAwsxb/bXqd47SQq+e2cLtgEFmkTjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B0606A31C
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 21:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 750B0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4fb73e868aaso9074672b6e.0
        for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 13:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795816652; x=1796421452;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6h2Be5vq4BhohYg0FpSh9pBi8qTo4Axywk+YvYQQYPk=;
        b=dtcseavChLRSQU7TW90ILg14ZXd1ZZG3lCGbLWVBhyH9I/D3Nz4z+kFOjTQp8SJ4AS
         CEhz83VJvVKsI3mQR9lHFUUliTJ0Augj5/5FfoRWDf/dzu2VNJpIQ09ZWEgle3VZmzoi
         LjOgbs5UrDVNPEEe9HCrbHo4Xx4wUWolRV4tcspf5Ey6kkZ0uYgzkI8yYPycTc4Yz1CH
         nfL8KNhh/4Em6jpOAyrlsy4untPfmFPrNwIbySEjkAg840RQfn+OCGU5gpS2qnCgdBAC
         cF7+yHaNnjEHjeRWnKvifpmsllM5OTr9ZcWTpdpUgMjATXhJcIctry6kdDUdYp5o3OEQ
         EiAg==
X-Forwarded-Encrypted: i=1; AL+hErFZl8YI67Yye7A2723aLFJBLGGhZIfVQRIFDQWQslGey7OFSrQecZ+OmFTX48KlSq8zgblbi3+9Cqcicw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8bVgFhsF0o2gBdYOvaUWiac/f2iaq/IPcB49Wnc0akOAidmNIB
	p7zqeZ3vaAIx3QEkLz9m/xtsVOepof0uSkK8RsyvTi+IWL+CN1z7/Vg0o6IdCgOi70m/EXLSlIM
	b7JSML4FW74UOFMaa1oym1tsNCZJm9wJxyV0RIhLAnFD5LqdKiw4tCT4GekE=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1911:b0:4df:5cd0:89c1 with SMTP id
 5614622812f47-57a095040ffmr27187642b6e.23.1795816652578; Fri, 27 Nov 2026
 13:57:32 -0800 (PST)
Date: Fri, 27 Nov 2026 13:57:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b09fccc.15291bde.1a1328.0230.GAE@google.com>
Subject: [syzbot] [block?] WARNING: lock held when returning to user space in blk_mq_freeze_queue_nomemsave
From: syzbot <syzbot+0c1cc7a4dd90af186bc8@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    822ba3a89c78 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f77865580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=284ed4d28353a6ff
dashboard link: https://syzkaller.appspot.com/bug?extid=0c1cc7a4dd90af186bc8
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113c81bd580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98fce4d0b21b/non_bootable_disk-822ba3a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69ce5f1e81fa/vmlinux-822ba3a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21de7918f654/bzImage-822ba3a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c1cc7a4dd90af186bc8@syzkaller.appspotmail.com

device-mapper: ioctl: device has been removed from the dev hash table.
================================================
WARNING: lock held when returning to user space!
syzkaller #0 Not tainted
------------------------------------------------
syz.3.98/6416 is leaving the kernel with locks still held!
locks held by syz.3.98/6416: 1, on CPU#1:
 #0: ffff8880587709e8 (&q->q_usage_counter(queue)#59){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:206


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
