Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22CBA4A
	for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046685; cv=none; b=KrtsrVKk5FetukPyKxWIahuoVpFRaYvrFd8+rf6XFzks92Vj5ObsY05JVPe4bo7i0EN+zrjPRvaIx/Tw1tvlKOWNNwwTFe+drVhCrkz5O4onNlUt5NX8M8USC/VXn03+j7HzKLXwJlPHeBxHtjHJwIaLiOhHuhkEj7JxQ0EPvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046685; c=relaxed/simple;
	bh=1RAPhH4ssAlkZF8L2GU4Z2iMnCjOWlqH4PSc3IELGmA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aURlwQIFI6OmhEeXWTM15/VnMsITjtjXZlIVBc/9Tl6xiVX7ZOsiDE05IfI6bGMbNwAAQ55lrK8zs2MaYEVNVMxzN6XR5i15cw93FhW96It673jbO0U61lk3KM1VIVOzgdi46M/SS6PwMSfOoKsZldOrRlxma7OAdridJCwTvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-887ee7475faso1240996539f.0
        for <linux-block@vger.kernel.org>; Tue, 16 Sep 2025 11:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758046683; x=1758651483;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rU37PJG/RwAlClhGWIfSNoA2jBYu7p5oZH2qtNCwBE=;
        b=BK3jobbLbOHBLVOmHupfF7qafR2KxgqXoGcY45qeE7m0cecirEHEoEN1i5JwAj+Rh9
         xqC8Xj6NMm1dMxfL77aZpsRZLgQYYBXZRYcUXpz5FMeOml8gF7UHmKDXAAjYlxmfb7h0
         zxS//LP5x2vGkcEAgSMM/G/v8Klo/4Dd78tK4LcATBHQ+BtZGrJHDGHlCyDIj5GxAPoz
         dIQySqysTBBw7ECHoxDOcCBud9INax5/5fuNFBct6zeNhpnPJZCUFqF6XjYyCvf4A6S2
         suU73Z5BP5PNNlWlGHB1knfcGR2NPKmPKEGhvYPCscpn2epzSYc4WBbec8iviN/CRsp9
         uYrg==
X-Forwarded-Encrypted: i=1; AJvYcCXrpJbj+Rj5er3yyGE4QO+6I6/XO2EQioxO39/7sGCMkScc1WnLN9u9+WtwwMU5UDnME8Ds0enNp8XMvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+O8iT40gTH1EMG5zmyoEgePbNT95QPjCa5y5BrLn1LKv7j/a
	L+0gVlKt2Ztsu9xX3ebCebRwKdWP0/WgrweFxdv4bU3r5OgOphIlRkduoP+2HoHfj8Gcsm6yL/o
	dGHfwdEwc0BiU70JHD0X/juH4S8ccRQ3OrrmEyE7WsPONljN7T/uVkEgajkQ=
X-Google-Smtp-Source: AGHT+IEE0JCQta35npizPSVTe6sFCWoRUEX9n1n3GCeKWgrL2bjN/I2LJfLEexYuxkFPCyOkGkU33NMtalVInu1mss5FMlOrx++e
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:406:7c54:9f6c with SMTP id
 e9e14a558f8ab-4209d31bb8emr150067625ab.7.1758046683445; Tue, 16 Sep 2025
 11:18:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:18:03 -0700
In-Reply-To: <686aa557.a00a0220.c7b3.005d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9a9db.050a0220.2ff435.040b.GAE@google.com>
Subject: Re: [syzbot] [nbd?] possible deadlock in nbd_queue_rq
From: syzbot <syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com>
To: axboe@kernel.dk, bvanassche@acm.org, hdanton@sina.com, 
	josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, nbd@other.debian.org, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com, 
	thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit ffa1e7ada456087c2402b37cd6b2863ced29aff0
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Date:   Tue Mar 18 09:55:48 2025 +0000

    block: Make request_queue lockdep splats show up earlier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11eef7625800=
00
start commit:   f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D13eef7625800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D15eef762580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8f01d8629880e62=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D3dbc6142c85cc77ea=
f04
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1009bb6258000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14833b12580000

Reported-by: syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com
Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up earl=
ier")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n
