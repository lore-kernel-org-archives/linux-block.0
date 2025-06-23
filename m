Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC51C3C08
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 04:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651205; cv=none; b=fshCkcBp67Va5brsNVFPqPG1IwK+Wj6av31Xp4HcRjayPivCdphVUqccTstxlVULj/hrz0/rreOwpCN5ufW2nExpc9QAIehI+QMJWp2yRaV2IKcjKVVxt4yXoUeCSXhQSgRXiBnIujgNLPARPCFDK41q2L7END9VksPBa0GSn/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651205; c=relaxed/simple;
	bh=pPylR7SsFpH7/9lpOqaCWDfdB08fmgj3mQjIVObOh7M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dCpIYELDQpe0S5MYdHnyyRZqPw257NbYnyXYBiRfmjGYX6FBJ5EVqU8umf/mNnO26vI1MNlueEWSA0K9RtcEqMcTHXiw7Ir+b1LZDg6iTIROCwg+Hus8DTpuObeNBMfMcyvCa12R5SIdL4sMAUw6YUu+ZW5aEiN8HTMx0qemQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddafe52d04so123563845ab.1
        for <linux-block@vger.kernel.org>; Sun, 22 Jun 2025 21:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750651202; x=1751256002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tp5owW5nwFpu5Jnkrm8smrXMQm3hRvUBzgn0oCSlZLE=;
        b=TEbwrlsf9Tnzm8dIkqG97BU5CddDOtTz9lkANxKJBxOrrByz+ObS2nzM+SOTkTOgSn
         vO7HgYvc5Z096gWv4zr4gln3OAEWvV5RfaIZbndI6bDEdlNj5h3NrpiGjqyy0fQyvy30
         nCL1Hn2Sb/zpltpWWHVtmcEMq+m+uZSWGg6IWocpHrhQxtASTev92fwbeMfsLKin1ED0
         EzsTRIuLLWZZaYp743eYQG6l+YysvWE9mzAIDFaF3wpUJOcWMyvii7o+rr/2okM6kbAj
         BvdglRJxi6QIZOTCh6OA+NbLvtY9si+3TgjaIApUFgOwi2L7wc7qtxtvzCUNIfcC5enE
         IFAg==
X-Forwarded-Encrypted: i=1; AJvYcCV8Jbt5ztUdMTXXHWNqA67AdpljhfilRSWwWAGaUYpUGTZNaIwKI5LpQ+TLulEnHVdWDs7fnrEEQZZHtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOaCw0Fvk1ideriNqNb7A3SBnA424Be5avDdpt5yyDOHv//Gtm
	E1VVEcJ5HF0cFLaHWC64U9yg2Ujmfnsor1pnkN9b19ktxVZ7h8c8I0ygX1XYnbKPh5HuB49boVH
	fPJe3pk8ljI//TNlhJwTXAfVbr8r4fEQv/GH6/wi42aEgx6l9gcXmxdhTrr0=
X-Google-Smtp-Source: AGHT+IGzI3eiBVL0NMFR35KWAlUrxUfo0LV4hyzVNWz6hxCoaIHFjj6zXT0kapv92iCI4EFb+pZdLBWvpe4EvqMzAC+zavsATS4M
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:308f:b0:3dc:8667:3426 with SMTP id
 e9e14a558f8ab-3de38cca231mr119111035ab.17.1750651202731; Sun, 22 Jun 2025
 21:00:02 -0700 (PDT)
Date: Sun, 22 Jun 2025 21:00:02 -0700
In-Reply-To: <6834671a.a70a0220.253bc2.0098.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6858d142.a00a0220.2e5631.0004.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in __del_gendisk
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, hdanton@sina.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1024db0c580000
start commit:   e0fca6f2cebf net: mana: Record doorbell physical address i..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1224db0c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1424db0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d11f52d3049c3790
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132f8dd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14aac182580000

Reported-by: syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
