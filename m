Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432437160
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579922586
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 13:18:05 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1e1a878ef40so121643fac.1
        for <linux-block@vger.kernel.org>; Wed, 08 Nov 2023 13:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699478284; x=1700083084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyxXCXobhEYeqpQPjkfj5+53V53lG5RGnqEZ8F4ZUTk=;
        b=YFxgsnzOFPaYXI/rBOOcuRDS/QAWQRTCHT5ceTSc2233sYZR3oOlhxOZB28DxNxn8h
         tJelsWBhvY/f8Dux+YnUoqi84dr6rRLmyuUVXfw/EQp+TD2DmVXwSudCVeB2RZ+S9vhh
         cAtrMARSg7a6zvU6opU3dcIeetJc8bFZNrA2yZqQiSZMnSa2zKrGcbEq4AyeviwiV9xI
         k28MZ2iDdFihMwkWOY/hl0TP239moyU+DYd87mCfdG2LT2O3O8/TMezBwHrw9PBN6UJp
         YYlLdPqfkiUO7Ly+aj8Wma3RxlyORA6dCqd4SFulbr0PudbmS7+WMQqIekrK52PgnNsx
         mCoQ==
X-Gm-Message-State: AOJu0Yy9ZGbnRyezkm/WAr0Q4XSgtTqo66cuXLSpv6r0R3lon26cjkPo
	Yg3KRlxEccAld00iFYiX39g1lIIDZwLH3DzpvJT9/gQETOCU
X-Google-Smtp-Source: AGHT+IGNtPzOriGiQQk7C01UsTOUwMEx/R9olkgDecyABABOSJUkhpMGjCF50m4CvqCl1wqpICz9K4DJVTFk0TtNdTvT70tl+t4y
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:1d2:b0:1dc:34ea:1a6a with SMTP id
 n18-20020a05687001d200b001dc34ea1a6amr1308277oad.6.1699478284780; Wed, 08 Nov
 2023 13:18:04 -0800 (PST)
Date: Wed, 08 Nov 2023 13:18:04 -0800
In-Reply-To: <0000000000000014460609997fa2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077ca930609aa9f86@google.com>
Subject: Re: [syzbot] [block?] WARNING in blk_mq_start_request
From: syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>
To: axboe@kernel.dk, bvanassche@acm.org, chaitanyak@nvidia.com, eadavis@qq.com, 
	hch@infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com, 
	zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d78bfa1346ab1fe04d20aa45a0678d1fc866f37c
Author: Chengming Zhou <zhouchengming@bytedance.com>
Date:   Wed Sep 13 15:16:16 2023 +0000

    block/null_blk: add queue_rqs() support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106414a8e80000
start commit:   13d88ac54ddd Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=126414a8e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=146414a8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc47ba2476570cbbeb0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1465bb08e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e7881f680000

Reported-by: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
Fixes: d78bfa1346ab ("block/null_blk: add queue_rqs() support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
