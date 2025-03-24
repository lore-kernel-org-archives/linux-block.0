Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4A266EFE
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842591; cv=none; b=sefO9qPWOxnnheUzburFL2+7Y81Au/fXFTNpDfK+C1PAVeT+gkZsp4wxQHTtFTuUcnBU3XCe+NjZHCF0ebK+s2Doyqe2vkek4O6jPIQUsPAOcybXaz8hNz5Utf/CL28xrA90KSTxToUmqp0s9b2jrKO8Gz+hDOdwYfrTTV93bZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842591; c=relaxed/simple;
	bh=dGu8ZX7xORsOF8wWNZlRunghBJPEysAWFzcel8DWUz4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NJ0LnZnWf1hdihQmtwbQ9ho++gXAS9+Z0d672wfQ76XHRCre32oANZnCs03NOuFjGHLXtb3umhPrf0UKmabaFTCRje3uscg7jj6z8R69eDj6I4ptuiDoLO0SWmDtQVPXhb9ROSgLh1AoTjDd4kA5bnAvm3a6Btg09SQCiSKuvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d443811ed2so81146255ab.3
        for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 11:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842589; x=1743447389;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHEqM4s/n82u0+AHc6/WHpGzcmPow5ScOlUXqSyMHhc=;
        b=LkRZvViEJk7a3trADvp2KTMANZULOK6GZUjqGROCPhHyyzaPjgtuNm7tUmwOyy429H
         zVjfjbvssVGZX1wPVMoJEZI+s8uYOy271UknrRxxdNSRngWGNQokGf+jplZ2v5CcgU2E
         re3f59h/BGSvnN5lTn0Cj7nbW5AFkbMSF7TxmFr9dUlWCCHR0heWIygtxE3RJygd0qi/
         l2vy/TOHRFQkLpNJB44wD0TY4yeDdCXHP2gu/TausHIo+UPYrIPiQpYZIw6d7o4A6LjC
         Sl9Tq47gXXB8MPTl0bNksBdH5+tcaT32/H7WzYIkFU5DVHPHSPcpLICqhB4wwWWHsSJu
         BYDA==
X-Gm-Message-State: AOJu0YyXtdMImXN5kWjzKHlIf1KrubHZ6qNY+2wHklRi5ljdm+put8Dc
	sLJVXyMaQxAKhziUXvuyV2U8QpuISVM9YVDCl545OUhdxCwcosqHbhYwo4EewgdgDF1jNSyq405
	gG9pgrHWmEG31CY6V7opo2x2M2rVtTX9oEhgPM0GbV9wz3K0dE+b5/RQ=
X-Google-Smtp-Source: AGHT+IHzLyC+7Jgi2/vD5BMI7zMaViS3yAQGImmRsLAOstVx7G+O0tdzNlbkVVkc4kM3S8VduVt+pEakeD+f60HgWrv7GCUc88pI
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:3d3:d4f0:271d with SMTP id
 e9e14a558f8ab-3d5961602a3mr156971435ab.12.1742842589229; Mon, 24 Mar 2025
 11:56:29 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:56:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e1aadd.050a0220.a7ebc.002d.GAE@google.com>
Subject: [syzbot] Monthly block report (Mar 2025)
From: syzbot <syzbot+listfe2d68429fd5e51f6083@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 0 new issues were detected and 0 were fixed.
In total, 42 issues are still open and 95 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  60676   Yes   possible deadlock in __submit_bio
                   https://syzkaller.appspot.com/bug?extid=949ae54e95a2fab4cbb4
<2>  5264    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<3>  3626    Yes   KASAN: slab-use-after-free Read in percpu_ref_put (2)
                   https://syzkaller.appspot.com/bug?extid=905d719acdbd213bf67e
<4>  2498    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<5>  1675    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<6>  962     Yes   possible deadlock in loop_set_status
                   https://syzkaller.appspot.com/bug?extid=9b145229d11aa73e4571
<7>  305     No    INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<8>  77      No    KCSAN: data-race in block_uevent / inc_diskseq (2)
                   https://syzkaller.appspot.com/bug?extid=c147f9175ec6cc7bd73b
<9>  43      Yes   WARNING in blk_register_tracepoints
                   https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<10> 37      Yes   INFO: task hung in nbd_add_socket (2)
                   https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
