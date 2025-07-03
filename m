Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2E296153
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530024; cv=none; b=MJW2NS4rtkr9dlDg32rO8yZmIkk7gZ89Se36STWly/cXn6mLLuA6+L+m8G9iXPtXvNGXHBEgjN1xjwkwoja8aR8BaHqoeUZIjZQW92Ga5yzO4XgGkvMUAYGxPIsmhUciZV8cilqb4wD8YTX6e66JccVHgcRlLiU/eLoUMXfTsGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530024; c=relaxed/simple;
	bh=6SLDQrtFq2uE49WVnxjLVqjIr3a0GuM7Y4d8VzWInIU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YWOHz1feiFUfbHPMoK0YdKlDmsi5bG7SVeVhwpUbshoFQJs+OPY4IPEDXsjWF3YE/F98G0rFpR5aJ9qB6pfEO1O9o6wguCSziKT9sRtrFBwWlv3uQJqQ0D+nJVs+hDmdfolmgEXUwACrNo3K3wpxvSAryLMwuPwQWO5DEii1BKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86d126265baso764233539f.0
        for <linux-block@vger.kernel.org>; Thu, 03 Jul 2025 01:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530022; x=1752134822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3hKl5Ia/jKC0Yd7lUOzXfYy0UlX85jIR9h7CqoUJHPk=;
        b=u/LK5jf3SVb8xIVL5Cq8lk0ZKX08swsdzQ+fDGKWovoeqMN/BJN9bAV4bzYfF4YAGW
         ddiUHha5CygpKJiuhw/t7p6NFlbFoEB15pdFskB7s6TkFstcU12d3ji42Zh7uwVwz8mP
         zn9Jd4iG2P0ZPDtLaWvc/OF58o52Dfc/6VawuGHGiXxJIfEQFijfrEQ1eUDIHP35wrUe
         HhCo2XDaEzas0otuElRkRmKSeyuJF+JKBqCx5PbGZQDfHixF45hhg9iKN5A00bzcXfY0
         1tkg/Frm5Z0LvxcNkI/gf05W5e3G/djRSgg4pND2/x33hBTdorYWAcqIfgnW+v+MZk6z
         FXkw==
X-Forwarded-Encrypted: i=1; AJvYcCXPu48cfnGzNr32cmZeX/Iq70g5UlRS7++uZxuN5wrr1XyhaKhDRBBhLQ46YGJrIHUTh3WKeJ8go3M+2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZeAUFxFWXxdKqxLVPZpG6NXFptGJzsErDxTl9GRpdO0n4UHJ
	JSjurML4+DY/cZWinHeVQNl+HbQZn4WKK8qt05pooj/lvwnAPj7jeO3WoOiB9s8H+G05bJuCi42
	je0H0+Pxshdv0+d6cyy0DY54uDqPnvhpQhYz1ApkxZv63xFc0ldjplZ5fWto=
X-Google-Smtp-Source: AGHT+IFHEHLjcWpu9j2fzi8xyd5CDP/yiePQGBUZyFCCw6WjHXkwTCzEx5NWZDpvvSAkDH1/M0eUL8oNkp1nB8pYZMSHHsHHN/Lf
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1584:b0:876:c5ff:24d4 with SMTP id
 ca18e2360f4ac-876c6a09d1bmr967003139f.4.1751530022059; Thu, 03 Jul 2025
 01:07:02 -0700 (PDT)
Date: Thu, 03 Jul 2025 01:07:02 -0700
In-Reply-To: <6865e87a.a70a0220.2b31f5.000a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68663a26.a70a0220.5d25f.0856.GAE@google.com>
Subject: Re: [syzbot] [exfat?] kernel BUG in folio_set_bh
From: syzbot <syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hare@suse.de, 
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mcgrof@kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 47dd67532303803a87f43195e088b3b4bcf0454d
Author: Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri Feb 21 22:38:22 2025 +0000

    block/bdev: lift block size restrictions to 64k

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15ec33d4580000
start commit:   50c8770a42fa Add linux-next specific files for 20250702
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17ec33d4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13ec33d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d831c9dfe03f77ec
dashboard link: https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c93770580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1001aebc580000

Reported-by: syzbot+f4f84b57a01d6b8364ad@syzkaller.appspotmail.com
Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
