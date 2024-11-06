Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E54318C00E
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 04:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730867947; cv=none; b=mwx+2XLRahIt75sVMyGxdL23Arax+3GXvjiPoNq6xVwXO7xM/mroLyfoB68ccdNbgE4He9FUtOa+nLuUBwobEesj5c04Yo4Y7NYV/3faJlI43oL5yas1pSdrv+LIK1wjrf/mDCrEEN/a6pD/bjnSn4gaYAsFRC3IEe15x2mlvn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730867947; c=relaxed/simple;
	bh=rm1UBE0CqeZHg1Jk4aoaflriHOdb4zRQAcypzSQsKFc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KcYeJZJb4KtXMzkViUP4TpEMe4uww0ldm67wvmSPE4KgTHtgymGvF/o/LhEGdTquQhF4QlhtHWqQRpxqvGgt0FhX9xfJZdskOccTqvjfKpIBd4UvlpAvSQPb0BrNeO3XJHzTSCGFNbdrdir1yw3UyivIKBxORSJoAL9kaN5SdUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83b567c78c3so45866639f.1
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2024 20:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730867943; x=1731472743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcZnI7H/Pxr0UqsUJcun+RXdk/Sg3hZT78LKpGEaC0k=;
        b=FcVX0KlMCBtKXiRKOwUInYRMgqSGmaMsuEzC8J9ceEwf8pzhs03oBovUB1KR0m2vze
         IbEPGUDBtmp0IrrKVWSupGM0gDFClO5d9Yse4heKfKEZRqrelBPtWrSULGbU2P607+dj
         V4JD7OnZMAthHo6uqBux6D/bjWwcC288Hksj1LlJgEjWnNPL8H/1K1ZkLseFSS8u0WFA
         lZvvrTYqF/nOWg9ju0Mlp8Y0ynExtIRWfp05Hy4vUkc+vj7DS208WbYvYsrcEFk67Cqy
         hKfapWminC/OSgZyVfIdNa12WVn1NVX+QAGHaNN7lZ3ilyzcuFVxAXlQcqmlqxeA4teY
         n9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXT7taoF+Hh7acvEfVfaxUbd5A0yhY6pMn8AS+/AL1S7+Tt8xLMHJvBAyLU8FsZbRSgO1hjYK+oQCaO+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0JQACn2jYKq/uoLqS4GYmsM4Xm64XR/1t8+GPM5a+hH1GCGS
	xcQUqkEbCn/eLlzoicWB/ECBjUu3WGc8jZFdgrlK+fiX3qq98bnwy11+Ti02tM7N0rjx5GSb542
	SqSQfYyKG54oFakb1FHCK0qS6NX2a7Ewr70ABVLKeGYBdhkvlpdWNSVw=
X-Google-Smtp-Source: AGHT+IG4XL9G/ifuAc5sYaDmLvA6D8ZYi4XBYf/FQ5JB1IfTP9XmdheFWB/itY7y28HmblSWCLXzrxyQM6JxrgNj/8hvVYfpnpxC
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e1:b0:3a6:c000:4490 with SMTP id
 e9e14a558f8ab-3a6e2a15bf7mr11210695ab.1.1730867943519; Tue, 05 Nov 2024
 20:39:03 -0800 (PST)
Date: Tue, 05 Nov 2024 20:39:03 -0800
In-Reply-To: <CAFj5m9+1dZtWufO0xzGgWPyMjD1NZ_a-kfeW+Q3ujH_rnR09hg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672af2e7.050a0220.2a847.1b38.GAE@google.com>
Subject: Re: [syzbot] [block?] [usb?] WARNING: bad unlock balance in blk_mq_update_tag_set_shared
From: syzbot <syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com
Tested-by: syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com

Tested on:

commit:         72697401 block: don't verify IO lock for freeze/unfree..
git tree:       https://github.com/ming1/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=109436a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfea72efa3e2aef2
dashboard link: https://syzkaller.appspot.com/bug?extid=5007209c85ecdb50b5da
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
