Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28977F2C
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235768; cv=none; b=i8n5a4pcPD6PYfwNIK75wSffuQirdoiQy3zQeprGVK8CYOuhwWX//kk/H+afU2EgrsyiDj9X4XUgagvM5jCtgGlttjIBojJnKft+8Q767+jND1md2UERAUA+bpwD8lSfCkCE+/yaxAsQMGxFbP+NMCj6N+IUxae4NR5byeKKkyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235768; c=relaxed/simple;
	bh=rYq86n4aSltdWkghyEQZIjMtzHsZukkIeQWmm+cJOVM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SpIK5vw6ul3UZ1Y06AJuF9QyGOJM2jSWk0GMXkyQZKWDntSupyNIvLPVZUB9Bt063kpRt2XmyqCVFmFGc1UHKBqMS1PPifPD0MHeGRaoXNkGixkDAA9ABjUEWQIt4TqOs/LPzPvIwi1Rh+zLGSoo0101JMviN+v8iXBM4gdE5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3666b68cb8bso6456615ab.3
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 02:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710235766; x=1710840566;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foa/fkZpyNNxK1QmPCBWGG7EaH0Gz4iQPJ4QMpJAVeg=;
        b=cd5s3V7MaQCoiBzNT+KjO9WQtF/MFvRMKt7QlTKTa5SEwVCSlkI0jxDTVWm4CjI83n
         MdM2NQamuokppaQT2NyD9x45WYmagj09oBW/ppdrx+nOKX+w3qOK3NIFrh88qFvu310f
         1wZ+KGBNPPcCe1h8XvtO8yVZWrQGM8HHm3BEk5bDZ8RYJExrTliPApk+XHVe6wpmC8QB
         UYwHIlqM3tyPHFtccGGXXekmdSTchlWZ2MqEOn0zf+baJ5vletZIdrRzN8U8PojIRlsq
         s/9sBLxb2kHaC4ECuU3ZGHp66XpZEE8q/6oNlvNALPlWoGNZ/L7jWm7wFSdfX9pCnQ6w
         Ljxw==
X-Gm-Message-State: AOJu0YzuQcEpBLpnXRn57k4deaqr7YRb5zVskhYlDZMzNUadDPWH2Ou/
	UPRrLWx2MUTz1PdrqljPQbZqwcRt61TMRcrBP3IF80WI7VRt9Buwc2XiWbU7Ejv0STNXeMEPWap
	dQu96lbk9ubRo4Y3gYY9Z+7rJF+ZqDJYshXGvATA2wsm++Lva/aLhSALPMw==
X-Google-Smtp-Source: AGHT+IFxKRLD8elVvCV8GYO6lSQWjfUyp9RrUr9NJN/2v48yg1Zxz/6/nnZNBj2YyMUL0e/qzmz7HpIjTaUqUFVbypVOGAHzLfsN
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:366:2f1c:2b87 with SMTP id
 i11-20020a056e021d0b00b003662f1c2b87mr271796ila.1.1710235766316; Tue, 12 Mar
 2024 02:29:26 -0700 (PDT)
Date: Tue, 12 Mar 2024 02:29:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005570bc0613734b42@google.com>
Subject: [syzbot] Monthly block report (Mar 2024)
From: syzbot <syzbot+listcaaffe0cc9b9e6b9b16d@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 1 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 92 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1396    Yes   KMSAN: kernel-infoleak in filemap_read
                  https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<2> 201     Yes   INFO: task hung in blkdev_fallocate
                  https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<3> 130     Yes   INFO: task hung in bdev_release
                  https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<4> 49      Yes   KASAN: use-after-free Read in __dev_queue_xmit (5)
                  https://syzkaller.appspot.com/bug?extid=b7be9429f37d15205470
<5> 35      Yes   INFO: task hung in nbd_add_socket (2)
                  https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
<6> 15      Yes   INFO: task hung in truncate_inode_pages
                  https://syzkaller.appspot.com/bug?extid=bae3c73c7bf2fe3a740b
<7> 7       Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<8> 4       Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
<9> 1       No    possible deadlock in mempool_free
                  https://syzkaller.appspot.com/bug?extid=03a410b5470dc0d57748

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
