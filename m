Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF8240251
	for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 05:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736832544; cv=none; b=W+vR2q8f598dr1Irn42LLYajyD6nRXsp5TdJQ2rDsSn1LPdj8JXF8LaVcI9fWzlqnHPS3xjYW5xvsP7U4l1s/3RA+jGBZMbdyb+FqNs+d0gB4Id5YdAAg9HQb65sCVew/LjmJ50luX+TNsX02tLk1K+0Mc73GQDNbwycgatn48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736832544; c=relaxed/simple;
	bh=LDRMMtXvgsntrYQ2Qu24Cu/iG0KTxdHiuwg0pl/FNf0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fAuh689BbowL73zhxISU9LVpitnBy7RSbuazUSK4lhjJv+UEeNykZ3vojps7NLqJmnbJJiptgmpIepCUsSkivHC9T+Pq/GevhEGkaVFq3xXmtpIk14ut4SGZI4jVRXE17K5/oy3euMUdkwbLVl59m69BYFHZUzDFmjATEw8KPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce3a416d71so76722125ab.3
        for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 21:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736832542; x=1737437342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hxQFVKSIwGXs2LzOEZtXj+PR7j/N4G8a+YA/vW/pZ0=;
        b=HCU9bMX/9GOKcInAZPU0p6XPYOPd4BE83UbHyG3kBN713Hq4uQ6LYlOm1IopnHhQIJ
         FViTAEXupO2YO5rKGROSnEQ2mSJAsrh5OuUN3sr9wfYab7JT2jqjbi2rgoN5ufwJMVgu
         eAE8mnNy89rhEUn/kgeM2dR9vAUoOmlLHJJB8Yvn0hnYFi8SAQE9mM28L+MFpHbPQ2rq
         TlbElvsxXRsjeaK/YyFB4jJF1R0yIbgwaXzpgA5EjuZQLbpwUPbABFlR+95ncf+H4vs5
         24+DGtzq1YX7rK0RE4n4Bgwyyvw0SyIcf6HGz9WyDkzirKfi6EsNoENiG1jE6J2dWlBr
         fMQg==
X-Forwarded-Encrypted: i=1; AJvYcCUrpCYo0EHgQLl13XwKFoTu2C86WejKnRLT39HbuPPn/Cc71MpbjNHzv3JhK8DACIx9uVdwVBuHAS/ZbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSvaxGJgIfwHKNjio8PqNdO3h6fan6vLZinh/LG6KlwSI1Azl
	XYdJlSvaAXVZl8dHi7kdFxl7x85mh4xwJjejLk7uHULZqFXPZvtU7J90rrSTbFM7cxFsHlEPlbN
	vSJw6p/6dwMNBFsO8TiMFn4BMPRt49Qxox0yGC043hTfAv20OFUONAiE=
X-Google-Smtp-Source: AGHT+IHjyCs7x87VFFckXm5IMn7n1CzKc5yRv5/luW1oR564FtWguuc1H2me5LX+2w+HkSvZOD1SY7WljfKsiUSi8Q8tiw5pcLVN
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1445:b0:3a7:c072:c69a with SMTP id
 e9e14a558f8ab-3ce3a9a4ad1mr200728775ab.3.1736832542661; Mon, 13 Jan 2025
 21:29:02 -0800 (PST)
Date: Mon, 13 Jan 2025 21:29:02 -0800
In-Reply-To: <67841058.050a0220.216c54.0034.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6785f61e.050a0220.216c54.0068.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: global-out-of-bounds Read in number
From: syzbot <syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com>
To: adobriyan@gmail.com, akpm@linux-foundation.org, 
	andriy.shevchenko@linux.intel.com, axboe@kernel.dk, brauner@kernel.org, 
	eadavis@qq.com, kirill.shutemov@linux.intel.com, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@rasmusvillemoes.dk, pmladek@suse.com, rick.p.edgecombe@intel.com, 
	rostedt@goodmis.org, senozhatsky@chromium.org, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk, zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 8d4826cc8a8aca01a3b5e95438dfc0eb3bd589ab
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Dec 19 21:52:53 2024 +0000

    vsnprintf: collapse the number format state into one single state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16342a18580000
start commit:   7b4b9bf203da Add linux-next specific files for 20250107
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15342a18580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11342a18580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63fa2c9d5e12faef
dashboard link: https://syzkaller.appspot.com/bug?extid=fcee6b76cf2e261c51a4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174f0a18580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=168aecb0580000

Reported-by: syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com
Fixes: 8d4826cc8a8a ("vsnprintf: collapse the number format state into one single state")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
