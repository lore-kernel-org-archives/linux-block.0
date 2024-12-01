Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23ED625
	for <linux-block@vger.kernel.org>; Sun,  1 Dec 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733011865; cv=none; b=X+lh3u03zzOQrcRQvddzUx/r03//VBvsVKHUXuT0xJpfKfs5rPgFXISjH8YRAesmJaFIC8gbUy/vNECy1Y/RUvek6AraHEkIkjkWPF+p3/jf4B20wbgr/RREBIUuRWIn9zXshHtSrr3u/3raFgUIOxSjGNdfwbFEZbo7S3qvm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733011865; c=relaxed/simple;
	bh=UnACCVA7tlVE0+snJs6hfFSd9q31mo6Bh2V0d/9WTZY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TkGgFVaS+zcky364twpQ9seqMzxzbKgardTbTZSjRoKAqkCqADp6iO3kF3N+0KXHKNxHgYFhmkzs4rSkGvVZ2xracLCC6Zf0xL3OmgC5T4dWoeCJBvys3CrogWMpNJJ1jZxS+xnLXwCFb0q3hRpFq4mNX96Z84N91qN66+Liy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so10926075ab.0
        for <linux-block@vger.kernel.org>; Sat, 30 Nov 2024 16:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733011863; x=1733616663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LIUUZTeJmZPeG8SX0991wAnoGzqpU1DgWIAyiJ4/+4Q=;
        b=v5lS1t2uE2JCyiJxR+H04zKgOS8Q4CdbkQ721FgLqGJTCmgjpxMEJvsRfp47frP1sh
         s09wFR+B01tNbs9LqAtv9MGp5T7+WNpCvsemXfjLILWqrTZnE9CliTC7T03nR46F12dU
         eJ4Tli1/eGNwOlmssRoYMg7xRbd/Xk2NDeUU99bk9qTpVDCAReZii1/Z39v6lNQ1Pa4k
         zAitgn0cwfEBrPcjX1Us7o0XF08eWZF3ik+6QpzOJ/BfDUASFovhq1Fql1gbxf5jQbAX
         iGTpUq2AVG99pw2gEQ+HsL9M2PS9JGYg0jgLEB2pUULApxcP9VTEjgV7x3sPPf498Ysp
         NvSw==
X-Forwarded-Encrypted: i=1; AJvYcCUl1hfT44teAVqjKe79Aq8+9FW0fvY1aWgg3fPgdfJunNw8arzzn7nsC7ZhZAGol6+RLPk3XgaLfB2MSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YySecW2eMoKssCb22GvSUH1dXhgNexM//PUDjaq4IVBrFJH1qJT
	k6jxdFA48mCstQgWltJVgTgNFtvqib3g8KmW9Pp/+eEcxcAubqfpnM1b/P7M0tanijciMvjzO52
	ttSLqL559pby26L3EVwCH5MEIJyWFfWs92e8L46PXQeLc70jwByQCPlc=
X-Google-Smtp-Source: AGHT+IG13qg4YGnamlxKBNo4M0YAZ13YlT7S2DJYFqwTqU+6UUSxHU9xeLnGlTqgpnCs3Zo680wJlcaOZX3SmT9ezGeM/8L/4Vcz
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190c:b0:3a7:6a98:3fdf with SMTP id
 e9e14a558f8ab-3a7c5580ea4mr170467365ab.14.1733011863168; Sat, 30 Nov 2024
 16:11:03 -0800 (PST)
Date: Sat, 30 Nov 2024 16:11:03 -0800
In-Reply-To: <20241130231432.2296-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674ba997.050a0220.48a03.0000.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
From: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+867b0179d31db9955876@syzkaller.appspotmail.com
Tested-by: syzbot+867b0179d31db9955876@syzkaller.appspotmail.com

Tested on:

commit:         98c00f3a blktrace: move copy_[to|from]_user() out of -..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-6.14/block
console output: https://syzkaller.appspot.com/x/log.txt?x=121205e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=131aa7b77993ec3e
dashboard link: https://syzkaller.appspot.com/bug?extid=867b0179d31db9955876
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
