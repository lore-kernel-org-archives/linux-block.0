Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04A18A6BA
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790906; cv=none; b=Dq/vUy8vVOyoMyB8vp0DkPzvaFEOqZLclr0zOhuu8FltiYFbsviV8Qxspq/LC44ME4QKvaxYcIU0XOi3I6C6xdC04qtJ9ckMnRrMg3NVzNVCAbRhSTMMjMalTIbsqpb2OwsYWnqDrjBPL24MYRECH3P84wQPeUHhn8L8EVMS6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790906; c=relaxed/simple;
	bh=AX0wnbzOVWBFJ0z+wYiz1cnR1V/qBBfEQHs42pi4lsI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O0p8vGoDuDD//wePs3tbC7uJVG/q9o5Lkn6XtjnPCFQRx88PTU/u3sgTTq/ankF+usig2RB66qtYErcMcU0L1vfjb/AsJl3GsCX4/mnFeLsNYLTe4wUbwz0LWpDj2HzWv6DF1Sa9P07tHyW27bkRr1+rfrNDDW9GEHfmcBP6+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6add3a52eso35278695ab.0
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2024 23:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730790904; x=1731395704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udJxfntUylZegD12LXtHmkhlsFp21Pyjgi/GZHXO0Q0=;
        b=WLApq9y0DmdnDJZ2qUxL1MXQASjPkLogRbYwcFjWquXvB5urssDZMSyTkVeMBEtyHZ
         9nzTs4TV4Anl5TQcd5eKVl2vfhKEDUajh16E1isaZZjzplc0TdhISPxKFBCuYLFf1D/R
         S6RHLBHjPmy9dYXZ2LZwunvi6PZauVLPDgOJGM6pMOAEahzFBDKh8sM/J9sEAgtTdDxK
         VAhaDfo/eNvABrhiJyWNbrKe2QMKDQs9UXzyWLLJJpuXhwq42nF2HhBLBxbK0Bcrts1U
         e2bFsCVoMSaTD1/QCwMt/MnblaZ7OC5ZcwgQZhyTUku9a41ZQFJFlSkHu7crKFgGYefl
         SppQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYq7mr/B2CpCZyCe4mOzwT+dFi+BPBnGowNzIOj5ij05pUevGvX9CC39UeyIylgTNSLCymRM/Kv2ylEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yylt7G1NTl20fGZ3OrwnmPQENejUgW7iBl4ePgo7d2VTexfZvYL
	XwvdKgd10NnxzGCUDJT2Zm9JNCK/5azPk9GwLOd9gUWQ/BbhDmXMYFlZr2QujdDRmwA26PvYIoS
	hNKVN6ploIRKX/NdPak/FA7aqMr2GOddcv1OWmwCQObHwGSi9m1UGC1M=
X-Google-Smtp-Source: AGHT+IFENoTKKV4sJFxJHInjEOnTWgVx2bbjvJL+998wFc4aiBPfOT49lkWevLcZGh8gALCc97t8JyVFflWcXBzoaOwhSWirGlcN
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1387:b0:3a0:c8b8:1b0f with SMTP id
 e9e14a558f8ab-3a6afeb07f8mr149769545ab.2.1730790904212; Mon, 04 Nov 2024
 23:15:04 -0800 (PST)
Date: Mon, 04 Nov 2024 23:15:04 -0800
In-Reply-To: <Zym_h_EYRVX18dSw@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729c5f8.050a0220.2edce.1503.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] possible deadlock in blk_trace_ioctl
From: syzbot <syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, ming.lei@redhat.com, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com
Tested-by: syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com

Tested on:

commit:         72697401 block: don't verify IO lock for freeze/unfree..
git tree:       https://github.com/ming1/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e8ed5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfea72efa3e2aef2
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c16289c8c99b02cac1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
