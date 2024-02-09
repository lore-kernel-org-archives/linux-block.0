Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8148F78
	for <linux-block@vger.kernel.org>; Fri,  9 Feb 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512246; cv=none; b=l8c6pUrelYcUzoBF3K2SQ8LooIEsUS8ezVwk8fMu9WYl0H91hhivXbnKyvzg96wds6kRmOzvbksKxT+1UN+xXvGDAI3jy+miDJaGHkcF/eH7KqakYpXxRjt7tR2+wsm8pCqCDTsAFFILkJnZzrEuEYh2BKvhGTzCju4az20WIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512246; c=relaxed/simple;
	bh=XAE7ATL/jegVfgrR8lbA/aRxSZgGXPCm/xE1Ed3s4EM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O2d450Gn/dI8Jp1GwgSaagrnhyvlchy4oLypUKpeBBkiawbuKJ4PS7TBYhbwDDh+Y0LUXyiYYUKp4QJlcitk2Fk2NLcgh6G8+rHUcYZJLjSSwjCGJ93mj61PPAkehFKoWcncMlMjCO9l1KddA2w/1eayVUH5lF+fQ+Oh6merlXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bff2d672a5so120818139f.0
        for <linux-block@vger.kernel.org>; Fri, 09 Feb 2024 12:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512244; x=1708117044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKvqImy8cw1LhvsNR3nEHucJbZLhRfd1laFEvsobuqo=;
        b=JnCHDfqPYSWqbElTavgau/B+E2RXIWR+kwAYYkboUrs9uyQapJSKMgt9DUMITInAlb
         2FVAXPZf7D2Ptq66US5Ofa1h7g/ddIxCz2qHgVbOp6HqIad33fTFZRRwsvAZ/FH4R2rq
         J4T5wSaSPsZkGAVIdavSUDaQLbIbdR7EOfx6D3sAaJI3kTPXfBhC7hyCWU/UPGzr+VxR
         /ZcL4iV+krnHLztulLJtIBMLtb+vXPgZCD/o5UQ32MnGo5AokHLFnsfZ99afYIKwoeWP
         hy2KMvgOWj1u8rDXlv+aVRZQn1lWXwcA4h/OjE01bx5NoFzq9vHDLgy5YOu95191aOnA
         FoFg==
X-Gm-Message-State: AOJu0YyIiz29WJH3rVltZV2AiWc63EshgqaA2Sd4iQz0ERgxx3hlXvvT
	ah11f5x2xfrqsUIyXvXVJ3tMdrrWXfRaG1wKq7PqLsF5YSuS9hW4at6JfBK18haTITOWOphLU7N
	CDF/92AESSwvJv+tz1NIiMiv3uDlegMI/i0ZhiI//u0h/z0X5IIn0JQwdVA==
X-Google-Smtp-Source: AGHT+IHjBL6Pjlu61pfLjoD6/MIvHJCk9lDR0TqrxCAXXPbzCvRe1dhyglslSkJ0rdZImVayHu0FazZRI04/ACErCgkx7HLxvc1O
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c8:b0:363:8f57:27e1 with SMTP id
 r8-20020a056e0219c800b003638f5727e1mr20973ill.2.1707512244024; Fri, 09 Feb
 2024 12:57:24 -0800 (PST)
Date: Fri, 09 Feb 2024 12:57:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c13e840610f92c96@google.com>
Subject: [syzbot] Monthly block report (Feb 2024)
From: syzbot <syzbot+list577ce3954401a176ebb2@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 3 new issues were detected and 4 were fixed.
In total, 19 issues are still open and 92 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1291    Yes   KMSAN: kernel-infoleak in filemap_read
                  https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<2> 486     Yes   INFO: task hung in blkdev_put (4)
                  https://syzkaller.appspot.com/bug?extid=9a29d5e745bd7523c851
<3> 182     Yes   INFO: task hung in blkdev_fallocate
                  https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<4> 70      Yes   INFO: task hung in bdev_release
                  https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<5> 32      Yes   INFO: task hung in blkdev_get_by_dev (5)
                  https://syzkaller.appspot.com/bug?extid=6229476844294775319e
<6> 26      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<7> 13      Yes   INFO: task hung in truncate_inode_pages
                  https://syzkaller.appspot.com/bug?extid=bae3c73c7bf2fe3a740b
<8> 6       Yes   INFO: task hung in blkdev_flush_mapping
                  https://syzkaller.appspot.com/bug?extid=20e9a5e0dd424a875f55
<9> 1       Yes   kernel BUG in set_blocksize
                  https://syzkaller.appspot.com/bug?extid=4bfc572b93963675a662

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
