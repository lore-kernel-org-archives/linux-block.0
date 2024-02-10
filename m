Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829CE33CE7
	for <linux-block@vger.kernel.org>; Sat, 10 Feb 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707556985; cv=none; b=qTLt2Boz/C5LcqVqb0Rj0eUpN+SjWx8PI1NwnEOn721l0BE0la1u9Vg8fbu8vT/8928dqsLm9UJFFeoRrGPhbOCZRH8gtO4YSS/1RlKpUI16ajvz8sepydbh8AV7LfbsACkd+JTzVagStZ31Cm9vVYrZe4nXbM6taRNZqQTWLww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707556985; c=relaxed/simple;
	bh=3r3XMRsm9E2/82rvdkdZixYcLy7dHpfiFRvdLE6tp1Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UezKEWuNHyReDZxt9h6Kl8TSeCJ7MJmh0QK8a6cVgXIZe9EhUPXwoW0BjnLUSSeP7n3Q+ETc/cbGYIBvrAcLGkx7xERGpMkzQ/QhzJwMMN6azqojcaEpISkLGOiEdMCaWARiVLgVq1rwLjTEX+geLHvJl6ui4Lglo4KHyuyTxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bbb3de4dcbso213627839f.1
        for <linux-block@vger.kernel.org>; Sat, 10 Feb 2024 01:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707556983; x=1708161783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqCsyr+HbbKsXAANM7RDwJf0XiYCIX6FiahqV8RdlFI=;
        b=FXF6zTeqHbeH/IE/sYureJW+XcQ8lalFS6ouMvxJ/v/EJUPb6i4k7ODnzgcps6GMAW
         JL60ATQ+Sp+uWdKcJPGiNE5TJzISrguQBGCdAFL+uPqwFvTSTHiFhWEex0Zg7x4EqYv/
         FmIsOpjU1DffzoOAluHNOZ/vtBEwLiBQnK0EaffcHpzk/1cHIiSISKF+XKxaWDH50Eyq
         K7Vhyf9z4CXbCcGGXcZnME1uyum6UMz01BlfICJ5WTCerBv8o3fy2Daq9ynS9jcYPKnz
         P/5eDA/weDngWZS0vyCH1u0cIrb5dKyCHCl6vVadATJ0AxvH0QsjtaxJ2ZtnmP6rTFVt
         4rZg==
X-Gm-Message-State: AOJu0YxyBsfLukwe3tFC0GHJKUq7tvN6BFXPcN40ay9wr27va/zBUd5N
	xGlktlruPb8ie2YEYwIYryolU20IpS8LZt7sWxsgCH/e/rkcchAcPo+lrfZerQKhjCjUld3CGLq
	xU4EWHyqelLDMBCP5dfA1lOd6ger6WKaos/Nkh5xOdWmlmZoslyI5CLE=
X-Google-Smtp-Source: AGHT+IEENhUIL8V8bhMbxxhXr1L245/BaAsWAlkUA6s3NzTp92+K8tCQ31DYFl7ZNlJoeeFvGQKJSr5nsX7yo3j+A1LYCCvpyHpA
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:363:c288:f8d5 with SMTP id
 q14-20020a056e0220ee00b00363c288f8d5mr127626ilv.3.1707556983767; Sat, 10 Feb
 2024 01:23:03 -0800 (PST)
Date: Sat, 10 Feb 2024 01:23:03 -0800
In-Reply-To: <20240210-bekunden-glasvitrine-9c43d2672a55@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000738b7906110397e8@google.com>
Subject: Re: [syzbot] [block?] WARNING in bdev_file_open_by_dev
From: syzbot <syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+96f61f1ad84e33cee93e@syzkaller.appspotmail.com

Tested on:

commit:         672cf418 Merge series 'Open block devices as files' of..
git tree:       https://gitlab.com/brauner/linux vfs.super
console output: https://syzkaller.appspot.com/x/log.txt?x=157f9cec180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ee6536d236103ff
dashboard link: https://syzkaller.appspot.com/bug?extid=96f61f1ad84e33cee93e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
