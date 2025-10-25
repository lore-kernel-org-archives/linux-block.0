Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37F1494C2
	for <linux-block@vger.kernel.org>; Sat, 25 Oct 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761394748; cv=none; b=EXgJ2wmAa5op3v+jUGdoO/nFzeHTyu/iSoQkBp3TozwxGZkmlIc7utcdAqdopeV1IpSCN2GP3Es5sbBWXBMpLHc9JBSm3xUVsHkqxtHyqFaRnzE7Ij3yy4C6QDOR7NstdnMYxSIgGX2Gkh+UmM1T+j7NKWP0lC1jvZabS1OXPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761394748; c=relaxed/simple;
	bh=EVlFebBa6swtthoo3XMik13PZNNqhlB1y4EKOTdvLE8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MHynteD9+qOTM2bGwNltG7EH8NL4W8M1xrK3ipvWpzh9OUM7d6CFmfe2Si29+Kiro8sDF3zEXlnXyParwTFm36f2bX+SZji0XTvCCyZJyH9NU+kJOtnQmdcQq8z5pIcelq4UVHUe00AncVxbBbrF89/wTsQ7ayF8cN7MvqiDlVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430e1a4a129so39484765ab.1
        for <linux-block@vger.kernel.org>; Sat, 25 Oct 2025 05:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761394743; x=1761999543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=detJ0ZqNeJlrOsDrnLZMjTVhzUl3dolYqWJSe5Y+Nq0=;
        b=qPFCOwgiG8sXx7MM7xTsLfMAY8F4df0PbFf+u5ldGumP9vi8harxUH8eY7d0+co5LM
         4zgCIUyE95Tujz3J/W7ng/kGsHZraZzPxNVO3YyArvQ2FEorbjU8BgmZ38SkadMu7gao
         djmSkm9I1G4QltjAuj9CDH5MtNfGOQs+G1cypgoVyJy8/6XpiuZBnw2TuvXAWyR0k9nP
         y2UpN1wzWEwmUfuG91gG9VSLR6vrovdqoADaKjzw+Bf5nZA7BZG8MHOkioneOmZhQHzh
         vgl5Mnkd5U2zyjlHDBCZPqB2VBr/XUbOKqVgDzrSo98rz4FQC699Rquz3HgJ9Tdb5Q7X
         9Luw==
X-Forwarded-Encrypted: i=1; AJvYcCUsMJcLvc5lP1nt7r27Wnm6wU4GL1328vRBucYwS20OT+5i+j5nykyVH9wuYyOWUYo+QhdcP5Im+Z+zTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxovTfBw0V1OmWDActhiEghWN0ggBDDWxyW8T5dCznJdR7njJ5M
	vf0pt0xo6QnefUaj8+wLN9Ghh+G2Z0V878A5rT+1nPV7Y537dtWOu6oEzMdLfCQvQ51DbhQ0VUs
	0JS0Uu5dDTV+3VyunjCCQpgiCF8i1/YQEx+O4h9/ftXjhBPGq9GbLhLuDZeA=
X-Google-Smtp-Source: AGHT+IG0oFMhPB3qHtmC1dmKqk1sRLQIj1ue+TTfk/yvBRc/nkTT76FySFISbYfurl785uiqw6lIns7SAqbjDTDaXjD7xmlkbQv5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f04:b0:430:c49d:750c with SMTP id
 e9e14a558f8ab-431ebed79admr68309205ab.27.1761394742947; Sat, 25 Oct 2025
 05:19:02 -0700 (PDT)
Date: Sat, 25 Oct 2025 05:19:02 -0700
In-Reply-To: <68fc07a0.a70a0220.3bf6c6.01aa.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fcc036.a00a0220.9662e.0017.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] WARNING in __blk_add_trace
From: syzbot <syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com>
To: axboe@kernel.dk, dlemoal@kernel.org, johannes.thumshirn@wdc.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.petersen@oracle.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f9ee38bbf70fb20584625849a253c8652176fa66
Author: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed Oct 22 11:41:12 2025 +0000

    blktrace: add block trace commands for zone operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1750c7e2580000
start commit:   72fb0170ef1f Add linux-next specific files for 20251024
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d0c7e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d0c7e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f02d98016cc9c137
dashboard link: https://syzkaller.appspot.com/bug?extid=153e64c0aa875d7e4c37
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145ae3cd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f58be2580000

Reported-by: syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com
Fixes: f9ee38bbf70f ("blktrace: add block trace commands for zone operations")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
