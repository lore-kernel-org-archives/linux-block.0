Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740661632F2
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518527; cv=none; b=Lfsj0rhtm7sVUhBsYommB4rfxpg+uVUxzhyVBxO6BiExFxYt5ULG0EnOs12CmKHasd2Ow0f5mXzGdPFmGFyw5yjQakKiBP5nqD04buHEv/gTaGpA5LefcOhSWViEh4pH7//dZ+MhbeBal9KSzvI4J91GABrQPRVOizv9CWZFAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518527; c=relaxed/simple;
	bh=Z2yvubv1C3jHp6QXvOC/+j9/4t0h3OAD2jGZoHdUtJo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=POxvbsKHTKOeIXIAjWOKMBSV8cQ7BDcVesKDqybU/NleS+nIvpD9qpq9KPrCPQFu5oqNeMIq/AiqM6eozLVbLKSaeUX3nYhP/BTLrLvCkQrqTvym9bLmX8SaEStDXBfbQQBEsphk5pHTGoDIE8KU1bokOEmSdPJTNjfqRkKc1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ac0354401so877987239f.3
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 09:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731518524; x=1732123324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnOf36aP94RKBx0LKLDwa8vZa06z4Rk+yvwFlv0FEFc=;
        b=s46V8AupFIi4jO8DSD3qNpsYDZiLi3wkyZGYdpmdaaFZOWeLFjQFaWazz27gUm893E
         4va1AT1ysWxMAE7guHbT9KqqJ+INJOXGjFxWWcG7mPPl+8T2hx63RhyHy8DASPP/3vFP
         Dcpc8eU9gLkPcvn3P7fWOVv2y8qHJYP+fQwsz3QzH+VQjzUTQvrea3QKI93xzeB6iMvo
         7fLbquDtEMbEey5ViP4C27mo9swcygkR5t/heFfKc0d0FIaGZPs1zs9yUb9VeI5kpZXZ
         iIwTP59mfH9bdg/wp3n3y6kuvKG2Zwmb7Mv9YSbveXXSPBfoqCAp5YEFUkEeXWKGRY9T
         fIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbhDObDVMYqsZWk3OOU8msto8P9N7DDLYbSi7fIWwfAjkTAqhfJENSVERIyf6k1o0tFCPRyOtXo5glyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDrMk0FIq/cElub6Evs08eFX1L1MEgCvHWTbuF3QZEHDRLNlO8
	+HPR+VfxBRz1ffMmGMnTRcdfOj4YCP10rkV3wNWHabrnbF45AQFFt/EdaQx+kiAOzkDQ/seNUO2
	a0KG1aMW6mwN+Rns2pVJguqwS7kAa4J1OiLoKbITNEeeZDxOSp68jxOA=
X-Google-Smtp-Source: AGHT+IEgQtmLGOHg1sQ01VClhxTRs9K7Qj21K5aCs/Tm8TEIqRm/Hmmz09IzpN/8iP4SWCVdpKm4EOH9JWYpabOweVUk1mKlM+KS
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3082:b0:3a7:1de2:1d9f with SMTP id
 e9e14a558f8ab-3a71de21df7mr2684235ab.13.1731518524539; Wed, 13 Nov 2024
 09:22:04 -0800 (PST)
Date: Wed, 13 Nov 2024 09:22:04 -0800
In-Reply-To: <0000000000002b1fc7060fca3adf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734e03c.050a0220.2a2fcc.0045.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andreyknvl@gmail.com, axboe@kernel.dk, 
	dvyukov@google.com, eadavis@qq.com, elver@google.com, glider@google.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, pengfei.xu@intel.com, peterz@infradead.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ae94b263f5f69c180347e795fbefa051b65aacc3
Author: Dmitry Vyukov <dvyukov@google.com>
Date:   Tue Jun 11 07:50:33 2024 +0000

    x86: Ignore stack unwinding in KCOV

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=174bc1a7980000
start commit:   7a396820222d Merge tag 'v6.8-rc-part2-smb-client' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4059ab9bf06b6ceb
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14669c6fe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d23ae3e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: x86: Ignore stack unwinding in KCOV

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
