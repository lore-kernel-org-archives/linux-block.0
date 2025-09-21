Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3DE24CEE8
	for <linux-block@vger.kernel.org>; Sun, 21 Sep 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461465; cv=none; b=hefIkIU4GwejP8T+Q4GdOq9zGnkXJUmwspgrxjkWS5rvfWhlAq6eU4qZ0xpcDV2jIgrymbVny5NpgcX/Du1INvxtpNAwnQaoBOKAJjxsoCOtnE7qUE8GrmcZmuRaEAvcdHLr27nn1siU/LMphpVML8t1tgthn7vxzipSGIhE+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461465; c=relaxed/simple;
	bh=WtrS07d7+cKxJcvuS+5QoQ6PIOvYu0pVJLWpuP+Tf1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JviT9ygwwvslijhnLXVnQFxoODQmTLvJVc7Vz8VMh+MzxM/XSyp4eMXrInJm1xP0jB2wHLSvhY3l9m2D0ZVziVSqd666ZiOrQUld1iCxslveVoqj7R3WXYiELFEwAeRbgyMyB50HA7rre0BuwqFD6RZPAtm6kCeLs+3/CS7JnJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42570f91d66so18138575ab.2
        for <linux-block@vger.kernel.org>; Sun, 21 Sep 2025 06:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758461463; x=1759066263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiQRdYcXrpiVf19CCztsidu+S4PHDmYt4POx785FwlY=;
        b=azFghxfo8PY0LioBr9lAiBUH1zpEAMI0riT2fUMglW1syWYL65R6K2+ocU2F8PgCJk
         +aXkntMw+GYa6K2shFglPEoQKZsHbo0Ibqh6g9iE4IcdaZf3MlMQPtfOp8m6SkD6ia70
         YRL2QsXMf8IZAKDky1xX5G/4Kqg4WmjoWf7IuaEJIPPr/ZoKgnUn/tLWeIFjPF04ar+k
         YrPMSj98aEtq6jhuZDwDrUQAs2k7dpQGaQUkPuQzak1r8izUdkH0uVwnoAgBjlee3aPy
         HjZmckqgOJ96gRDHwwooaizWRebbLg6V20PVOa5vwtnIriisDPdvTbNS7iLneRUVwg3R
         DT1w==
X-Forwarded-Encrypted: i=1; AJvYcCXtYhfIa++upHryj3XHletLH02q4cyNWO7hb0iNIAXzyWd2F8Y2M80MvzTaCpVd6ZVWZ6zk0RhmTwrM8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YznPX7ulGOBHF9SNa0lqn5VElv5J/FwJmyed51wiw9a+AmrRpTV
	nuakOFWzjgOQ+aSNkYGIr/msFt0k8B6s8SH3wAsnLUq8T+ChMiBFiv7O71TvGYNJ2lPcI/tk8eX
	q+crcf1u6EymZ9SIlqCdLlIUfbYeKXDi0Ugpfg0/3aJjnVLa5CUAwwGdUIZs=
X-Google-Smtp-Source: AGHT+IEGkrIO9udB5nrXdVzkfiVIL/hcTyXlJ1peYFPQ7nDbEh6eWcUemHnCxcKw1j2N5V2c1NDHpUBCeLMWjFFu7P87V5ZxCe3u
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:425:7539:bc39 with SMTP id
 e9e14a558f8ab-4257539bf4cmr17571985ab.10.1758461463162; Sun, 21 Sep 2025
 06:31:03 -0700 (PDT)
Date: Sun, 21 Sep 2025 06:31:03 -0700
In-Reply-To: <68ce15c0.050a0220.13cd81.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cffe17.050a0220.13cd81.0036.GAE@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in __bread_gfp (7)
From: syzbot <syzbot+4b12286339fe4c2700c1@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, jack@suse.com, 
	jfs-discussion@lists.sourceforge.net, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113248e2580000
start commit:   097a6c336d00 Merge tag 'trace-rv-v6.17-rc5' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=133248e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=153248e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=4b12286339fe4c2700c1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116310e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1430b0e2580000

Reported-by: syzbot+4b12286339fe4c2700c1@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
