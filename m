Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214112B95
	for <linux-block@vger.kernel.org>; Sat, 16 Dec 2023 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7a772c238so136207839f.1
        for <linux-block@vger.kernel.org>; Fri, 15 Dec 2023 23:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702710066; x=1703314866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2symkoABZo9KBUb95detvKFvty4ZqZmJTKfJJWUeVe4=;
        b=SuN6PZ0vdTZ0HWKmD94E1hXSdAjBanZ37l3bgxbVF0Nww83r5oPS6HBqktnG6kBGdn
         xn7Zajz6HLkifQ9FWUNMKtb3iJeozRLj2jJolF6bYMVUksFio54CY/8eFp+a4k1V+1RW
         bo6neeT3idqsWAYUAWutSZG9DfrEL9uwpdcJc5xZNOTsXzwiRpHipYelnLSifi5Z+xnf
         /LCmBWQPC0kCfeRx3WzNR5wAaBYKPWhrwAbmEV9q77bW0git9k2LP3Q08VVirOcHfKbS
         LzXoM3TsXhm/2hE9kalgi/IGFboQ8rEWhLsHkVyWtva7nU3CISIJbSH0b9m9rtfcTIbe
         FYUA==
X-Gm-Message-State: AOJu0Yyc4bakrYcVwibJPQHocgUJbvYZocJPyCd723dLCKSvMFrQXwB/
	3b00hMrqufr4AFyLoPUv73HSCPaDR/fVzG5M7vygd+NLIVPF
X-Google-Smtp-Source: AGHT+IFDTQZKM8MkHiZbvf0PQPwG878U6Op6VjeV1G7vEM2O82OXpfqWxu9PwWziMfQLTHa6denV+V1mAwM2FEohUxsiGZldDCox
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1445:b0:469:2635:fd19 with SMTP id
 l5-20020a056638144500b004692635fd19mr526208jad.0.1702710066544; Fri, 15 Dec
 2023 23:01:06 -0800 (PST)
Date: Fri, 15 Dec 2023 23:01:06 -0800
In-Reply-To: <ZX07SsSqIQ2TYwEi@casper.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac07c2060c9b1453@google.com>
Subject: Re: [syzbot] [block?] general protection fault in bio_first_folio
From: syzbot <syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com

Tested on:

commit:         abb240f7 Add linux-next specific files for 20231212
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13d005c6e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc2485c21b49ddc4
dashboard link: https://syzkaller.appspot.com/bug?extid=8b23309d5788a79d3eea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d24771e80000

Note: testing is done by a robot and is best-effort only.
