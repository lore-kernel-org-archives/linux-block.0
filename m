Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5031BDAAF
	for <linux-block@vger.kernel.org>; Tue, 24 Dec 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735044846; cv=none; b=Cf+fCVEvLZr+0Mjlcv+EmEkBRnwBBQsENa1do3GDNAgCnJeQI9H0e5Bp1USa1yplcTBMtJ/6aonne2YVIp0bICDyVjoQ994q/3uNllT6AZnrR6XCgPaVEU6jsCQJw+G3GYFiETqCJjN1q2cAwr3RW7Pw4DOC8+DeTwSQB6YLysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735044846; c=relaxed/simple;
	bh=evKkQ6HRgFCs4qvyPiGUzDaLav0G3Y1QWg/On8rwMgs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ImRkK/VY2o2RQSLxIfzyclNAP61S09kKSeRZWoPFUBNW670RSmMQlrRs04FIeiXQvpMbj5fKr6JO+m+swZ1yQ+gaSMb3F7DZLKoyw/OvMHEG8hzvVjNOMuTrmCoABgTpUdx/aoUHULS2F4mFltg8yRPXG7YAjzmDxd7pQoiSFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so87796465ab.3
        for <linux-block@vger.kernel.org>; Tue, 24 Dec 2024 04:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735044844; x=1735649644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AXNF3HG5kzxLMUq/sCEuz5IDc2syA6hOB1XtzvB2IU=;
        b=mRLVybk3Ei964kbKEw2pp+lV2wCimlSFOhgfo8+AenNGsfDjwo4YPyPuerJt+2BCS0
         9gOj1tD4G3l4fceCV6Dflf1AWy8+a1XO11HT7UCOgXI2EYjsIlwDW/CtS0KX20NaEMPs
         Tl2V7miWF7JJm3Z8NL/PTgzACSoEJkJB+pcassns8ATWdX3PSrryhvlk/m3cP+8rE+Dg
         7lrrPrimbcfW+jcT7Gp+XSuip6Pv4Z4oU5mkUS/7yA5TRaAzw3uIKwlFBq1PLBSg6zQm
         vxJ+KQ64dZvzqVVTRcHamYgb1wBzIgveZ8HX5RWMppLoBjkyuUOzdJmCiJUAaYY1L/c7
         2Fkg==
X-Forwarded-Encrypted: i=1; AJvYcCWJzezkXMp34c9PckeRjCN5JNk8ri9MwLgi73/9qR5IcYi7OlWxFBzJTQJc/qHRZsQfP97mPiBQfszRMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLXzZ9QutQSCNnWj4ohWHwQu9jpAiHe5rNngnGQiEakuNiMOW
	Cz0gQ0/TTMTjTgoJoLoOhaVJuEDhrwx+2J1BLLy2edrWeaseHoqttm7dxDTc5lCAlIPfOtU1SS2
	GLEgZw/t18vp109fFCzglOuNN9QfRCdGlVXiId1X0zjy/y9rjgqqkcj8=
X-Google-Smtp-Source: AGHT+IFjNd65RorbDiw7iPiMhcltosJUGUn7EAB+95J5DOXJQ45jC/wCOMvdSBeDexbbzglCBhMkkC+Z1x7VGvejquji3l3KC5+/
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b85:b0:3a7:8c3f:edce with SMTP id
 e9e14a558f8ab-3c2d14d21a9mr179594035ab.3.1735044843942; Tue, 24 Dec 2024
 04:54:03 -0800 (PST)
Date: Tue, 24 Dec 2024 04:54:03 -0800
In-Reply-To: <672ad716.050a0220.2a847.1a9e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676aaeeb.050a0220.2f3838.01aa.GAE@google.com>
Subject: Re: [syzbot] [usb?] [block?] possible deadlock in blk_mq_alloc_request
From: syzbot <syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fd34c4580000
start commit:   c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17fd34c4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13fd34c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=ca7d7c797fee31d2b474
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1250b630580000

Reported-by: syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
