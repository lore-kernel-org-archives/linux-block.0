Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE8433CB
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778865; cv=none; b=D318w12jJIxGVyc+ksHMzPnUJW8xZkNbUyzoSDGGLhR04/6ZSu15Rb4HUhfhIeD+KHaxs9Bt9g4uzrd5AH+K50OyT0G0/JkwzSjFLfaWBB1iFr3Mbm1PTj0yq5SjupkObBZulPM0x9Qu8I6bb1qc8fsAMVD5FNgpWyZ0xgKDgJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778865; c=relaxed/simple;
	bh=AYko1VWOfBVHv9E1RRyYX2hPQcGc735qlsJ419fVcMg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bzN0NKJGKzBLXMiQoYfj/4dwnDoaBaIgzdimb4deMdoxTfBxaeTS9r9cfefD7OOK1yDu+f0DVHeHR0J2EnUR+KxJ0EQ87NLAVI1bIIHkgPx8a7qsGGmQ7ck1X5UjbKh0y/u8+uVFYu/jKK8D4YpTsPdBp0b5+ndW1Gvr+CS8t+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85ed07f832dso210032539f.2
        for <linux-block@vger.kernel.org>; Fri, 04 Apr 2025 08:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743778863; x=1744383663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/l5DxVvZzV/XmdJEnN3NdjGY2wFy/vsojLyqFJVpr58=;
        b=py0wkqtRxGbO4rwLNQ8hhoWhgEzOPAlz7IOU3Lm1SuHMJYtDxppkpZdoGW7ZkS15Eq
         3tVX0rPtXINUPvgUOTVWB43/z+lh9Q2dqIc/pBAc+UaHA5nt+rPzcebiKvkC6gV/FRrC
         AWOnTKs51zH+dgMb2wet8/Ad/VetzrOJolly4d/0coDCjkqKFNJ+P4kIYgHKBFy8NAYX
         V9lQ4rL6AjrTEaVjeWWR2mSYiiZP68UcRdmuebEjIKomrlle0qMUs0hT2LwrdstBCu7d
         Q6mqfmzTdTJk3Jm8q/9Qb2cV2yzJmwjBtF6EpctI/cyRtg7llRyAv68R2ftXH7PJyBN9
         zUIw==
X-Forwarded-Encrypted: i=1; AJvYcCVJlVzViPTR4zu2o7wmWtVlBkYkV5tFfusVu/8tZqrKEtC0lfqcT4BMjPBZikiZONerUb2XsST1LJZ7Ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWeO6+wGLaDESZpx+IF5HtIPV2/PVhdxh6us1w9eNLXeqwRJC
	iSf4U6wIz7FoYyCsBdI1U5NpFb7yhruPC5zG+ouIYn9/YUUGoER6ZgpuMy8N2oetRmlP3QlqEDV
	vsKrNl6It3F7M9Ycuvq+l6IkDR/1+AxZRbWXu0TpwDk07Yk4YkSfdT9w=
X-Google-Smtp-Source: AGHT+IG6eW3ypD/dyFDHuVvisZ3SglKvgxqH17m5/3K5JlVsbmlRsCifJq5LIVx1t3MJHQszTfOAcu1rYMYYpd09FqGjs10n4FyV
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c243:0:b0:3d0:235b:4810 with SMTP id
 e9e14a558f8ab-3d6e3ee191dmr43590305ab.2.1743778863169; Fri, 04 Apr 2025
 08:01:03 -0700 (PDT)
Date: Fri, 04 Apr 2025 08:01:03 -0700
In-Reply-To: <Z-_jtFYt0t0-6A7z@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67eff42f.050a0220.2dd465.0214.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_freeze_queue_nomemsave
From: syzbot <syzbot+9dd7dbb1a4b915dee638@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         665c7e64 loop: replace freezing queue with quiesce & f..
git tree:       https://github.com/ming1/linux.git syzbot-test
console output: https://syzkaller.appspot.com/x/log.txt?x=12321178580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adffebefc9feb9d6
dashboard link: https://syzkaller.appspot.com/bug?extid=9dd7dbb1a4b915dee638
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
