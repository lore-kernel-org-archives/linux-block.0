Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060225;
	b=fNwdV/jZfPk5r9v0KucqAhkTXzRxbwce+Zk6jyIOA6i8BNO4qN7g3xxH67zh/SFAuri0
	 SSMqYszCyuadFurqeCeQciEbIKwEpCu1I3Ycb0mBGU/MhCHp8LBoXUXlgwvOKrZ5xxtyS
	 GxN5o9mlUSG99oWD2/ZXuuJrrEqXpoUCbjjWprIIUChzDB8Xl/PEBBRbSSJKXaORZ/B7T
	 JHN028+I20WQtjbKz6j7G3fHjpkr687625vsNMA1V/SJnZe+Ow+clbSk1XBGJ0el6TX3O
	 RWBh4SW9TX/iGN4A4gAT1QneByb9GIaJ2AUH1YjgnyAYOjAxMrIYesjw0Z3snWCsnmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060225;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=6x9+N/COr+6pNBpUPwwvKfGBRH2EOtY9PmyW7dZS2UA=;
	b=Roba3XFtQz/1t8Kw/AgaNUi0ypmN95pL2aS1Alq3MGbeBfz09dfC5lvdqQ1U82Tbfl8l
	 yxqA/oe0aN7VIXsD3QvY3AGLhC2E08eRYMjU8u0yM1SYjQpRc5+zuJjxvlPhNr3Lj+7R1
	 CQ6tFMuBO0hZrCpvr7qTtfOojEJl5f+tcN9JotJl3v2tngZNm87+X7pgyMhwR9blUw8zz
	 DzJvo5GQQrnD7mfAAWQKa2NE4tcAQE0qi4LMVhn0gqgJ9b1957iGmHgh4GfKd+qXD9N2Y
	 1ZAC+wSCABdEqVJzLuYKK4Sl43a6EldVT6gZ1yu61xGb3TQetIuFVHhhUWZN3HybbiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B9606A32D
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 00:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 242B9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4cc89e86e4dso5801356b6e.2
        for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 17:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793060224; x=1793665024;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6x9+N/COr+6pNBpUPwwvKfGBRH2EOtY9PmyW7dZS2UA=;
        b=YqeRYPBXEkvCbTr+lbMyiEQ0Qp56DChDdQkxU473Bqd+8G3FbdULgts6nry5PPSWZ1
         qgSjwXA2xMhtLbzW3rxM2OHwQi1G1QVZyA4JU93SA+232vBJh2dbQJRakVSyV8LkH7jP
         LQW9JOl/n15hHiSpQ9DWSwIeQi4FhbGk5yQgj2Lf4EgGnuIwRdjYmVsSsardD+S9RCHF
         WFYeRMyu3bgwQ8qXOz9LCizJu0vXyaorA1icSphkUw62C0QrHws1siN6XrLW3cJ7pHnG
         +0DxdNJlHzInoLbUjv8+6Cy/CoIf4LDv14bF6dFLmGxAOgFqqfSeVBR75mFDhwk75W49
         g7FQ==
X-Forwarded-Encrypted: i=1; AKwUvByymGR38U9fY7N40Ty9iGRExlNyR4YhgP5kaSNdirHO9lmK/n/OWZjnt6EC2lPOv4BjnMTbdlGY+VLqWQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLFxyWxlqPg5jV1exg3bbasjyJOXD0C0HkEUSGJZkT4UaH13lk5
	kKkIbAKcrXxroASljcpnqR30NFDojCGFdSW0L4rkgic5uHepIUAIu7H+2X2UaFMcnec9NTJEfFQ
	UFNTql8LZ76Aje5msASAS4M2R6AeDFWs7YWil9OK9Zt8xp6/eLcBu9ex/fGg=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:10ce:b0:4e6:db9c:9a7c with SMTP id
 5614622812f47-55c002ec88bmr4875116b6e.63.1793060224091; Mon, 26 Oct 2026
 17:17:04 -0700 (PDT)
Date: Mon, 26 Oct 2026 17:17:04 -0700
In-Reply-To: <6ad78978.b5bd089a.6b57.008d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6adfed80.6200f071.51519.0efd.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blkdev_buffered_write
From: syzbot <syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, bvanassche@acm.org, hch@lst.de, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mzx199711@gmail.com, sunjunchao@bytedance.com, 
	syzkaller-bugs@googlegroups.com, tz2294@columbia.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1b1be9ea4e34ccede1e7cf9ff2b6317328a5b6ad
Author: Julian Sun <sunjunchao@bytedance.com>
Date:   Thu Oct 15 09:11:05 2026 +0000

    block: take the inode lock for buffered write fallback

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165121e1580000
start commit:   21a7f44fd076 Merge tag 'devicetree-for-7.4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=155121e1580000
console output: https://syzkaller.appspot.com/x/log.txt?x=115121e1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb217ea80b9f9fe
dashboard link: https://syzkaller.appspot.com/bug?extid=bd975ef54294bec73f0e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1634b469580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108dd695580000

Reported-by: syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com
Fixes: 1b1be9ea4e34 ("block: take the inode lock for buffered write fallback")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
