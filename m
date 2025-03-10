Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CE42628C
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594564; cv=none; b=Em+dWAoBZ1+Kp9MdArYjEi5+RaYoeJMiMhx0lBNPRCIrBKCSlp01fiZ4H4WMCHOaUcnrjmtyxTIs0qE7u9b2Q6RjdBscmCTCXO9BRihpUmJmGTPXORqQ5alFf53+7dCMXiV+uLKqA2/c89bLkoQ1fuz/H12g4j/sHCeNzUSHL3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594564; c=relaxed/simple;
	bh=JTF1lZEOEkNPM9MrYB2hrKVjp4XeMgvXRmaOZv8Jd8Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=agzwP4ZxLXNx6KsL0fYIQVNYWwDf7qgrE4zKCwqVi5R3TJUKPRB+yqd7O26Q0f7ZFd6hezHSDGQ0FeJxAods38CGaYOxObq5jSvbiGdWSdHe+Z88hj5f6JzAT86UqaHGw4BCEIxEHiXoHLqSPmq2zrJHwZcSE3aKKbFupFjQTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b3827969dso119326539f.1
        for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 01:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741594562; x=1742199362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22y5blgPG/7lHh8Yv1Qxh3X8BqbkqE0oG9zwwdSyRpc=;
        b=a9FZzo3X6ZdagpCb2d7Fb/ShH7nyQzMl2Ddx+ikSL4R74e4pRycrngsD0Q1KyQqRdo
         mtCOUYdVQORtqL0pXr5VrIrgdd2quctxe0Wj/ZmxklCHkEnoQ2g0ccm83zymVlcklykf
         CQnmEtmDEwpknfwR8GBKrOP4KiOSWPWHH7dZ4hS58OtbJDqAIImT6afOPm8n8hA1alds
         9pa9+ekTzi+TJzaSOe15JoYO1gEXdNLFkMTJefAKrQqiCzogVxN1IBWLHbSOwrDaBStn
         ygViL4qa0DnUpLHjNLXULy/+3nFAzyKAw1dxmkymG0DUfz5IHDI52+b+w1eEqFdBikus
         IC/w==
X-Forwarded-Encrypted: i=1; AJvYcCVo1RcFeqqylBcMiTkC3OFrZvkWouMCmm4bprxCTosz7spSl5sOg2zwHvM84mv2IyAI7P5AW006DWq+9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HulLfPvJJH4PJwhzCI9xV7SwMitw6Iqr/QS0Nrtq1jFVCA3h
	/ywH53okv+BR/7yEK4mpgDkqFp6eVDvUlk5U9dasCj5WsmHpdXjnkopCCDjq/Ptxja+arP8T6+7
	48Qcr2Mv+WyQgfwwbpvAk5i0kB0webx0mC02+9gEvdLHYmML2AhCAz9s=
X-Google-Smtp-Source: AGHT+IFN0yQHYbThJi2b8lhndx403095CWT60RxPFOrDTXJSjATNNhBCFXSWA7A8o55d1zQEIdoDw1HchtFAFGxO9e6Nl+uQ3feh
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b07:b0:3d4:36da:19a9 with SMTP id
 e9e14a558f8ab-3d44196ffc2mr143152735ab.15.1741594562162; Mon, 10 Mar 2025
 01:16:02 -0700 (PDT)
Date: Mon, 10 Mar 2025 01:16:02 -0700
In-Reply-To: <67b1f949.050a0220.173698.000c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ce9fc2.050a0220.e1a89.01f2.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in get_partial_node (2)
From: syzbot <syzbot+725322cc4ff5c53abfac@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, axboe@kernel.dk, frederic@kernel.org, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1688a7a8580000
start commit:   b7c90e3e717a Merge tag 'x86-urgent-2025-03-08' of git://gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1588a7a8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1188a7a8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=725322cc4ff5c53abfac
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137c1fa0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e0fa54580000

Reported-by: syzbot+725322cc4ff5c53abfac@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
