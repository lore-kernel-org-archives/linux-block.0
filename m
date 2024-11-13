Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BDF1F80A6
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491707; cv=none; b=UbcHfj7OLofJDjIRJuR7D6B7LjPApijzkfWkFAOfn8wYLDDXkLm/HiDPaoSeuXPRlhJ2+EwpGBL8IVMNeYohu3S6UIj8V/da3lOaPSa3dO8NdPzC5VlxN/RIRazMi5CYLIXg+Nn2flxIkvNaq+G/pWetY3IfefnJ6JX+JEeqq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491707; c=relaxed/simple;
	bh=p/U33DStNbGxmGap1B1YFe1j3MFsLDaLtWL3WRosyzY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XhnTrygtT/t9LwWTsbJzQoc9YV8c8r1Zihapb8Qby5qt7iD3u3o/W/LHGc9idWqo6kpDFNwwSqNH+lxgyeA9DAJUS84wLJbXS1M0dzci0J1VNRwOtc75NWzPPnIiNn2z3HKOcbQwZZMtWvgJ1GspNkpsTmJPbBhCOd7Qc6zWP+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abf9b6bfaso720452439f.2
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 01:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731491704; x=1732096504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=La6p7LDFTDd20P9Ap5B5ZW0+Q1G46jQaAsRpKQVub5U=;
        b=QCasMU7NXYaRhCE5+VKknfyrlu2TVwmXCGq0NALsear9cUTYGOHbCNig3sxcAwL7Io
         MuMKbcWPD2cIk3pOqQMpgBs7g6oxANwxUB/rGw8QMrAXUl7s4eqAicZU2cKNs4L7WspR
         ZBITQ+1eaVNqEj6n+dlvQTHGanpGCJi+SpjTfSRQB8uT2niRTC6+mb0uhQXC5Edxx0zm
         RdFBfka+aM6zdU8CO99/GU2gwYO+hS0SqRYqliQb1OeV4TVvZvccJZY74HMeF3kwuYWW
         RCBHsdtP5B9shWKirvpir62g8YMECySkVLwKuMmpPm0BpUq97DzBcJDi+1Y9K9q9oP0z
         SJYA==
X-Forwarded-Encrypted: i=1; AJvYcCUpUi/xqexejPItwA0XnzbJLQbIflkJFtqH2qWx9Hr2+2Jv74XDflM4U8Kir8IdO/EZSotoIzNNRbQdSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQAEKf3fHBk8bv1+ekJUfkt2kKB2/iy5YbsminCnjOqtHnnOG
	a3aplTCLjWrPY1Ff8SnXfcju8VElTXyqqpJSLOq/chj5MBjPrvNPyOL6HiY5zsYqEoCXbtRqxgU
	Q+IsYuJ2iHb7lOfB4XbrYAOYFl+N/OLpoANZ5WdVTXW0YsLq+4DgP1Ks=
X-Google-Smtp-Source: AGHT+IFsfEUMQL1mZoWQN39J627bxb6mJ5re6byZtSmb+hK9QxIgcOD6z5h6xMDBkfPWZ3Gh1tpqOPLKWi/vH24BMdNnJ1sNMRxd
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:3a6:ac17:13e5 with SMTP id
 e9e14a558f8ab-3a6f1a1ed84mr204243095ab.11.1731491704296; Wed, 13 Nov 2024
 01:55:04 -0800 (PST)
Date: Wed, 13 Nov 2024 01:55:04 -0800
In-Reply-To: <CAFj5m9+GAv4JPX=ABgwUo7RSSZ4zNsBKpiJOfuxmmwg+GDP3wA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67347778.050a0220.2a2fcc.0006.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
From: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

security/apparmor/domain.c:695:3: error: expected expression
security/apparmor/domain.c:697:3: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:699:8: error: use of undeclared identifier 'new_profile'
security/apparmor/domain.c:704:11: error: use of undeclared identifier 'new_profile'


Tested on:

commit:         6d59cab0 Add linux-next specific files for 20241111
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20241111
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=867b0179d31db9955876
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
