Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3A2475CB
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671644; cv=none; b=ETGJe3qyj/xKnWvfvV4rSxfT/I/gCkc8hmEUG8sW8vfrtEO6itnzsEZSC03uL/BsnDcQb4vvjvrKIuYkj0FPZlXiEFQeHeBq0udfbWOcxucFelPEg4zECuQ0eS5YfOL+keKEQswl0ALQZ1OmoaA4ifst5UNlGeL2EzNmcfKXPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671644; c=relaxed/simple;
	bh=FNN5XLRQy6ZI9NxgfK4P2RIRbDN+NNSU+L30sMsC5+g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hZ0vqWMbOOuFa9/W/pZ33Kj+wNOB7/ze/79E2CcR2J6ahY4SitD5Ok8yI6lRNQLv5aIcNQq2mrvZgKa6iqgtwiEVh+JezFwCylrDoWTkXsdSIM96fxqgN/9ZMxpgacOq2d0YxNS0BQnPbwRCNMX7X9impbfXnU73TAoEabG8CXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7c673f5f4b6so11273048a34.1
        for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 02:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764671642; x=1765276442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfN8gxpF4JwaNq3vwCM0IdsjKuymriFs1Gt/fEnKDNA=;
        b=VLmAryR0M9Ujdpeub3yMNbSwVUEnWFRT+/uBx4URrhopRZd/VlhPK/aQsR/8xPWSC6
         jiQOI27Ap5/ShZIKS8K9ubmkj2s/OOdyGBT0Ym7VeY+3czYZq/olwcpBN+5ECrHDO80r
         HjzZi64R0yYQllo6UoITy91OR3PL/TFDmgYVU5JWO528d/bk8MpDitbSOwgjVfjMFnXo
         oJgaM3DFN2iuUEgVCeiYtrX6++MKFiE6+zDkrGxb6zrD9HN0DLTN9FBVlUTT4rHo9Dpc
         xGc6VU21WQ46kOx/4Jw7arG2yCWzUH4twksty7L+qWjylbJiwsGgY9oY7pEkzibJ7UtJ
         Umhw==
X-Forwarded-Encrypted: i=1; AJvYcCWKlYXjf7cIRcr89i5yzQpx+Qa83Edl4/lPj5cRGVLvhLq9VntHdy7IpzXkln5lSt637JfehZErJj7+lA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFl2/0rGhkv70eRUYQ4gm9v6Gmo7Xx/ROrt1WAnr7tYKGdnTnI
	yywzpcq20u6JLcA5anQlnPcTIfGuB5IRgD3+UouQg9HUlBSd9Sbq19D7Bsw28+aTJw3yLndlp+G
	Kd5rp67vvLQNDLbHQJZwzi1nm9/jwQ52hUlOh9Zht4Xv7mZRrxMVSMSRee08=
X-Google-Smtp-Source: AGHT+IFVyTV8gUu/dXx11GwznuGJ1ta4TZwhtyWteyov52sy/DWthwn2StePtK2U5WLbB956bK5YiC8bXoCRqDF2vj/pfLG6iXtf
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2225:b0:43d:6a69:7752 with SMTP id
 5614622812f47-4514e5f9427mr14895193b6e.2.1764671642291; Tue, 02 Dec 2025
 02:34:02 -0800 (PST)
Date: Tue, 02 Dec 2025 02:34:02 -0800
In-Reply-To: <688b0ef3.a00a0220.26d0e1.0038.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692ec09a.a70a0220.d98e3.019a.GAE@google.com>
Subject: Re: [syzbot] [udf?] WARNING in __getblk_slow
From: syzbot <syzbot+89fa933c2012e808890e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, edumazet@google.com, jack@suse.com, josef@toxicpanda.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nbd@other.debian.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 9f7c02e031570e8291a63162c6c046dc15ff85b0
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Sep 9 13:22:43 2025 +0000

    nbd: restrict sockets to TCP and UDP

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a5e512580000
start commit:   ced1b9e0392d Merge tag 'ata-6.17-rc1' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6d3e67bfa86ec9a
dashboard link: https://syzkaller.appspot.com/bug?extid=89fa933c2012e808890e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11da74a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12af8cf0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: nbd: restrict sockets to TCP and UDP

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
