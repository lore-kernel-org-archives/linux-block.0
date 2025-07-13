Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A1E54654
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752409206; cv=none; b=FaTZNFfHMaF4lRRQfkFP5hrYJuiTLCWV7Sy2HRvL1wz2hxTxylUKGNk+YuN1YAks30EWQqx5CXUCdEtw4QoPN3qgLduI7p3QvBWVjOhTIkwV/VjazxUEzsljM4IuVapPqY1dcgIhRsh3nxdOm1ZDr2o5pJ+kYk/fpK/1z0jO87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752409206; c=relaxed/simple;
	bh=4TLGo6GK4QSP+WPahMdSl6hUqJJNrHr+VZrospIkjj0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mlMxtqqaQfT++hlZAyNJ31gXlilGRu+6OekgPbxVz+B/xNsro0aQrK1OfE1yE5dn/VtNe2HE/6HKPLsavE0H2xX2vf9/pa6GJiDaFvoKEPyByev4iN+7n2Px0FCAPi9jYCP6utJix9wZCoYxxhZY/WGCdnPFs/f12Ks+6TuoVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e05997f731so82348155ab.3
        for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 05:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752409204; x=1753014004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHfZZYwlltX3cnWzSRwgx2BtUxjdDvi1oy+Wb8i2L5c=;
        b=mrUSujfaWUw/1t9fTjTwwG1m2YSxhVNOIz8Jek5Hic1KgEWUq0cxKCHe/qYjBamizY
         tx2XJqNpGLuW80df7r6cWmHqPaMxqCQv1NJwPOEldRXV1tXx2nuhf2T1xjnl8cQ61XNF
         YhxQHNpNPR6SMuKHduV0tJJig+jI7rKWoc1OfaL6LK7si6ibCbpMy0HQvIs20E+KrDuZ
         ISps1okmOs/zeUW1Dyub9dmCQaq7VeR5ekYcMpbPqnvrZF1R5uRJtwGG36FaReTdmBKH
         K7hJjW1Cc9pce5EH6tQv37tcLJpcr4m8tHEZqhFt3g046ZWFatZtPZu3ix5Th3dpFynQ
         pMjA==
X-Forwarded-Encrypted: i=1; AJvYcCUBidubjt0+q+qBaJ8WIW+06C9HbsFhto0mODmi9edvyyy950qjkpXPHzcFNfpxUheKV/A8xLrNL5ZgAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwidjlRK6r4YTYA3+C5fa7wQ/DZpE31ijTuZYpLnengOaf5lEY2
	SDAe8fEhWdFLVC/GEB88cPIa9I03Hasllk1jKaoF8XcrfTfUnwaWZjWjVgQ+N0BBG4apfle2VLS
	dubK+x0l9+pEjvSza/Yue3kOcdaf3fZMYMpmsgr6Xax38FF1nuAxX2dGjeJk=
X-Google-Smtp-Source: AGHT+IF2Exx2IUNfv7fdIrV5sTW8rBytOis0b7TGzJm4zo9XvFCq3New/6Dkvq4Mr7o0fywQcedS34O/GhHp43TJvQ62c0w91YUL
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b85:b0:3df:399d:39c9 with SMTP id
 e9e14a558f8ab-3e2542e803amr113121025ab.2.1752409203286; Sun, 13 Jul 2025
 05:20:03 -0700 (PDT)
Date: Sun, 13 Jul 2025 05:20:03 -0700
In-Reply-To: <6743b30d.050a0220.1cc393.004e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6873a473.a70a0220.3b380f.0031.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_update_nr_hw_queues
From: syzbot <syzbot+6279b273d888c2017726@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ea5d82580000
start commit:   a52f9f0d77f2 Merge tag 'batadv-next-pullrequest-20250710' ..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ea5d82580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ea5d82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8235fb7e74dd7f6
dashboard link: https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14321d82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179590f0580000

Reported-by: syzbot+6279b273d888c2017726@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
