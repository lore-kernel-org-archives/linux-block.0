Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D09207DF5
	for <linux-block@vger.kernel.org>; Thu,  5 Dec 2024 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392748; cv=none; b=Qol2etx+q7qX5vKPAEYf5kUOVtFar2JYTTbO06m/Im9gnkC9uQ1U6pXVDy8vi6TVeutUxdGmqvQ+ZBk0ad5hyfGCRDaUKNUwZWd132rSUCwYoNwb23HWNwEsj8CzCJKnpou1aeehLYAAmxvoRWBF8+fFAD9iXfaWRo1lbIM0JJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392748; c=relaxed/simple;
	bh=SgIHS645a0AYFH1ctRSGEAJTKS9pLtbEIGoGYT5Xrx0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IDvORc3TMgxMPCpD+V1rVEYBFb7/yt/5l35t+7WL6ofbH9nQIee4g/2Traxl9yeaz6mu1Nx/0AuCuKuFdwUMX//0JBs09/P26B1OjPJ466CRpUbcpcZYirSqxrVCL2OmLpmYBmCn54Azbuqu2DcyIYXkAK1kaqOFsy+rrtn1KT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7c8259214so7879265ab.2
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2024 01:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733392743; x=1733997543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lNUCqqMwNBH1sfFW4omgrn6scda2dAGbmRIbTAv4L0=;
        b=MS0MMtT5EOEbfzi8HCAkzuMISx0+o3pA10Whz6llHs7cHzK1XFyRL0Fp1e6hV/we6X
         uqKKofmOFlqwX6Qxigi6zPSIao3ElJ+0R7H0IeSQ0pNfZg0PS6lXzvMqDLFEJx/QdDQ+
         /9rh5GhJdyAWXrMw7Bb0GrXYDkGjGLosxDwcLqPvST2Lzn5G/red5WHa5GNA8cKFuhju
         PfhGuVglcYoN9j9QB225lUDYL3TtauNfOHPDEZTIp9Sivwf6RkSOpmPIFRnszKAOEWP2
         G+fKKkCcBLiyzOjdFdlF042Xw+hhgiwWMo6jhEKHIE38rpYgEqBsq/SOc1B3C8pz8z4m
         agkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe+9A3bXPgoAw0YeDytWz0HhicmZES6p2UCwULjL0miixtF91kPsT2Lx7Shp3WxpiPGQizye6nwgamGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF6oeY/uZntnYZHJEhA+qpuUjaH9Ri7F10+1w1ZtqxJV6e8Tj7
	UG0wOtgjl1wwMJxv+zCWRSK6a11tX3x/VejpjZoKgnDfARGxOy0/IujLdKTKf7UWOc/kPPr0J23
	ejhsRppjkp2SVWBlTjsCovFvfHxk8RcUVR7dMyY0H1ybcHEVrPJGoSCE=
X-Google-Smtp-Source: AGHT+IFavLHBVe3EenRxLgzvIaeEkVCw6c2tXhFegXn7cdD53cnvfTiRuE/EybIckxER921OESEtcxvmumxOeN/nu4vsVhRDpbeN
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54f:0:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3a7f9a36198mr111101565ab.1.1733392743713; Thu, 05 Dec 2024
 01:59:03 -0800 (PST)
Date: Thu, 05 Dec 2024 01:59:03 -0800
In-Reply-To: <1757419.1733391531@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67517967.050a0220.17bd51.0099.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: axboe@kernel.dk, dhowells@redhat.com, jlayton@kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Tested-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com

Tested on:

commit:         c018ec9d block: rnull: Initialize the module in place
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-6.14/block
console output: https://syzkaller.appspot.com/x/log.txt?x=159ca8df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58639d2215ba9a07
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b910f8580000

Note: testing is done by a robot and is best-effort only.
