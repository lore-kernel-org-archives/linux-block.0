Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71D38DE1
	for <linux-block@vger.kernel.org>; Sat, 16 Nov 2024 23:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731799984; cv=none; b=V7cHMukN49HWZF/qzZEw0y5x7WBFXuUIe6qzUbb7Vbh89W8koScv2aqheJKQc+fAaclAawx6HVhpENiZWUhTuqwHD5MjC4X9vPppS/L+LxG321UMdbsVVOOfQ0yYyfEUouXLn+aG8szeutYDKq1xPGpegN/Yy7JD3bdPjtc5Cgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731799984; c=relaxed/simple;
	bh=ozfUCCvHD7H7cQd7d43iIoXCIgVvNpJ7H82PLjvW++Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iK+ldoP+mBl/HFe56PUZXTwLRkppLZ2EMkZ+LyyjZCyHtFrmstxCbOPOhaZQVxVhQN+5LsfstMVnx521vCTDDBryQQwruYSPolo+IzInb5UoHhcnu7L06YVRWJ2GdqleQ7iZcaQhUWdkEqc3kVhEv9jVtIWFBw49dG2kjxwIHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso40442505ab.0
        for <linux-block@vger.kernel.org>; Sat, 16 Nov 2024 15:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731799982; x=1732404782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pPDlMybPfT5VSrJgcwp4WOC86rQWqblOSy8gJogtjg=;
        b=BeY7BTVDDLeb+ZaqvH/fts/25j511yvoT0fdZTWgD1azWI2pKuGFH1DjT9s4WAq64f
         0l0DzGwulgJI+taZXmkx8Yxoe7rCNxFqNtg2F2idgkcdgVkode8yvv02TMJc8ISHVrL5
         Hyj8rSKcgV3BJlSDoa5AMvsmZVPVeR7A04NvT3RbE8VK5lGvxid7bhik9TioWhTnvtTV
         d1ryqf+8Eepo8BFg4iW4eB7qSsOuzEEZIgvNj9ygQeQ3kht+upeS381Op2H7UXBt9rg/
         9Ys5P3jIQkaMjdH3bUrvZ7a4XclVLeHk/8v89vb/WAu1Aa/Yja0C1M9u0fe8a9nVCdzA
         rCag==
X-Forwarded-Encrypted: i=1; AJvYcCXVhaSV1p3o11mdh8PLl3JnjlrbLU0aCnihofXrcJDaX+GI7PEm9KOed3pHcJgn3AA2WddnmVXC98XDSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1npGER2i0PbcktapRoWg6FdUY+4A69kY7MRhUQ0fE1Wi7ghvD
	Py/xsWk9eym7MnpUSeyurpkMahTZEaNHa16/DkhY9bzDnhIIJUOBiQEWmLYxhiNx4rJLkoOZoca
	w4z4GWNq87FacwlD7PE+v+c/SwJt6qJtJsDwFnK7rtNkZ3NWTjt4lMew=
X-Google-Smtp-Source: AGHT+IHxQ9I2yZYOzjRu/LCFRev0gwqeF6CbR7jTx9glbHmeTnAWQobIRQzimgpPUOzK4oLe2zqzYITldOsYwITjPA3qJEI3bt+k
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b43:b0:3a7:158d:6510 with SMTP id
 e9e14a558f8ab-3a74800e163mr69240285ab.5.1731799981891; Sat, 16 Nov 2024
 15:33:01 -0800 (PST)
Date: Sat, 16 Nov 2024 15:33:01 -0800
In-Reply-To: <67336557.050a0220.a0661.041e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67392bad.050a0220.e1c64.0009.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
From: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129b52c0580000
start commit:   929beafbe7ac Add linux-next specific files for 20241108
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=119b52c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=169b52c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=867b0179d31db9955876
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b520c0580000

Reported-by: syzbot+867b0179d31db9955876@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
