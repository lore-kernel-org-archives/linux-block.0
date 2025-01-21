Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA74431
	for <linux-block@vger.kernel.org>; Tue, 21 Jan 2025 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737418925; cv=none; b=YpaKEUxPBgJ9XZ1Nn4CS3KO7Tf/RhhZyyaE7e5HZGlS0DsToH0Uf2I6pdW9UbfeVWo5SvMX0SqLZ4pxGY6Z38Y+UU2x+6DRgM1nUrln5O7FZIWIgXlflM/awnwNWmuRxpgtIev8YytFdfm4LAOErPGf1Bc9qSXTugYnlTfGBiN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737418925; c=relaxed/simple;
	bh=WL7kVONYOnYb/d0AwrJ7ZVkNR8l5qThVKfPiGQXAwT4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xj7FaBf+EgxeKG+HKhVvP52GjcsNK2KN8sHb2VRoHW2bGo77CxML9/KC1RVAls6gHEU1FRne8DJyJDKbnrOfW6kJYRcSPPualxdP2CawhBytlvVkZKUZRpXuUK07sBzu8/6GkNlXLpM4Z3Whc0uiAVTN7vWjQ/OvD5+v5BzPbCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3cf64584097so35535915ab.2
        for <linux-block@vger.kernel.org>; Mon, 20 Jan 2025 16:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737418923; x=1738023723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36qHq6gozf7sLUVzS3bPWA3bTw43MXGseEmnjbcELI8=;
        b=Z+T0Z2qhChAuJai9j23NAfsTjKF8VdHxjc8DFH1SgCwRlt5mv7vxAYDQWfsZqo7ZcA
         jbzOl1JYgCVoVWiFXYoJvt0J9rx2MA2NDaZSviTI0WSXzlD4rYWI+8ySJ+dQKmO3I0ee
         c/AiCI0NFlWNh00wXmgZQHgS3xSBVmmTBFrTqK9EicYVgxctEBllfcl6TKVAloWEdt4H
         TIJkh0q4lphAuO1k7VzxLUwGEhGX2sX8CG4FvtZv+nc6FBQwhsqA2VH4SmDN9Us6U/XO
         MpTyca9tqRVO302MjlJHA0ALkeGt1aWWa19jtzYMgLSc3j1urGWGH1XlY+CaSxnGYb1V
         Pxbw==
X-Forwarded-Encrypted: i=1; AJvYcCXxyDsqQYpmBc4XBWKTkrW70RStRIx+J2j3zZoMY45nz2ZqreGfY48SEAYc8hrdAIjm6KzOYPrkRATh2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sjYmrmwTznYuSpfOrQxJF/P+XiSu8gc7Fpao3pLOgdikUD7B
	sNxxITCH3h1TpRJNV3aVmSSjf3rndi3/QhwKNUrhA4IXO5/o7z+ZsujpvZWVMsnG5Ue9NLzHYH3
	dXLaki6zzw8e8zAbwE2H5ZbPd4ogzgmqTtEJMxvg/1FPLxqX+Yj70LcE=
X-Google-Smtp-Source: AGHT+IHScxHtVEwxDPrO/GQeFULuN5IbwiJwn9SoI3wAiiRKJh80ar0G96GQHtpq5KVQ3rJG/08ttf904YCfEVaXHqjkhXX5+fUi
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c5:b0:3ce:c87e:8d8b with SMTP id
 e9e14a558f8ab-3cf7447c9d6mr98326465ab.16.1737418923002; Mon, 20 Jan 2025
 16:22:03 -0800 (PST)
Date: Mon, 20 Jan 2025 16:22:02 -0800
In-Reply-To: <672751ef.050a0220.35b515.0199.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678ee8aa.050a0220.15cac.0002.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] possible deadlock in blk_trace_setup
From: syzbot <syzbot+0d8542c90a512dc95185@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, ming.lei@redhat.com, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1536b9df980000
start commit:   5b913f5d7d7f Add linux-next specific files for 20241106
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1736b9df980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1336b9df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27aeebbe9ce2cea
dashboard link: https://syzkaller.appspot.com/bug?extid=0d8542c90a512dc95185
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167b3d5f980000

Reported-by: syzbot+0d8542c90a512dc95185@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
