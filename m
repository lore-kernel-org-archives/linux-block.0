Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C817BA5
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750916191; cv=none; b=eilKKweMKTZtLd98erINGmFeg67gS/adtMtHJsER1mAPCxSfLiYElMuM8v6WZrzg0tBRxMA698DqrMEfAPFxh8NchLf4YWYQzyKa2um0j/yRjONo0xgefRp0Tow1RPS2EBbce+xU3pjrBBJECU31P2OOC1QvR+9WAT02Whzkz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750916191; c=relaxed/simple;
	bh=SB0aCxZEkQPQMxy0FYNQie/P1fKIEqVxMwPo3lSHFQ8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tfOqU9sn70riLwbWIDVMc8yjyPPYu7lTwstnYhofFsLqEqCDw5eDkfkLjCYLWQYUFKyQg9KKMr3G2K1tkCWRFHlrnwpzkCFIEjZo1lHXzdSXICc/FO92UJXmqIF8dbCdraxNZvGWQabY3nyCLniKsO1I5fb1+WeOnPMG74yN6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86cf9bad8e9so59003439f.2
        for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 22:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750916189; x=1751520989;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hgiMPVVOUz8NHgqcS3EA5gzhtzDKtqRYZI0hl7KfCs=;
        b=D38G2SKE7BWF7LxwfShFSOl07qndI8fKY++R07/mEKt084Div7XohlOYfp0nxKh95B
         zWNWBqgWyYSFxPGmdHB6VJuTVFaDl1EDeRFnv2+WqjKZpvjUr1BKzBiVyZcxMsctM1Ur
         /c7e6CnT4bB2F71S7F0V65gAqsqw3Y/rGIk1RNEyRdmURhTl11TZyfkXCDMiK45mLFEM
         ZfxiBU89Minr4dBLQ1BNg80wvvw78+PnAtyFOhho7dcSGmM8IR4+agNEER8ZPF9xD5Z1
         3FrOqUdfpv7313Od13kZO9OHlJtYclQXjSQ1ZERScgR6RzldVp987eUsNUmwJsilS57f
         J6FQ==
X-Gm-Message-State: AOJu0YwBPcFExpJbd5Oy5xRbCY17JB/g8QKIWZHRWkak/yTM0fNIHVu4
	EZChv0xELGkuATnPYjB3vLGSuVJNphgyn8rgd0LqyEfcRtgn0sx9ICiewaBqBwOT4EJgptFH0E1
	YZ27t1IY1uM+lGiTVFZTIyqbkNtC1kzhmGze3eMda7aGwVKrfgyhYRSFqXIU=
X-Google-Smtp-Source: AGHT+IF3eFIQQ2sokjQq+A9vuimSTEeE3t/M/PknQL6c76xatSFgPs7ClR/j8Y8BF7xQRoB2n6v3aSr4LZuGpmspKSO8w/ujKTF9
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cc4:b0:3df:154d:aa60 with SMTP id
 e9e14a558f8ab-3df32a14860mr77589685ab.22.1750916188849; Wed, 25 Jun 2025
 22:36:28 -0700 (PDT)
Date: Wed, 25 Jun 2025 22:36:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685cdc5c.a00a0220.34b642.00ed.GAE@google.com>
Subject: [syzbot] Monthly block report (Jun 2025)
From: syzbot <syzbot+list43aba7164f4c62811792@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 3 new issues were detected and 1 were fixed.
In total, 37 issues are still open and 98 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  22870   Yes   possible deadlock in blk_mq_update_nr_hw_queues
                   https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
<2>  20143   Yes   possible deadlock in loop_set_status
                   https://syzkaller.appspot.com/bug?extid=9b145229d11aa73e4571
<3>  6151    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<4>  2574    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<5>  1680    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<6>  706     Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<7>  594     No    INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<8>  380     Yes   possible deadlock in queue_requests_store
                   https://syzkaller.appspot.com/bug?extid=48928935f5008dde0a41
<9>  257     Yes   possible deadlock in pcpu_alloc_noprof (2)
                   https://syzkaller.appspot.com/bug?extid=91771b3fb86ec2dd7227
<10> 157     Yes   possible deadlock in elevator_change
                   https://syzkaller.appspot.com/bug?extid=ccae337393ac17091c34

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
