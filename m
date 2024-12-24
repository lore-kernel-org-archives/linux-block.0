Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F7214AD02
	for <linux-block@vger.kernel.org>; Tue, 24 Dec 2024 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735021444; cv=none; b=QQR+ydNA46MPn6Xxmm2GmTUbI2vLfX5JeA3BZF4aihrwkzR3A03tVoIqd3Oyu+zFtFSBcEnrBs5+3bXlx30z9yD/MZiL83a1n2ZPxl3D2qPOBmwJbfebVHvd0UNzs9yH3LhW2+3PvFcRMUEyhUAOVR+QmQp4c+SFHBCZ+/16nLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735021444; c=relaxed/simple;
	bh=MXzlKSwOGCI1XXQ61VjEYAgCn6j6p10k4UqY5qMglZw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PbXIHlQVaqc1HmbJ7gb3W4aHHs5V8TB2Psk2O1Rv50pEKGj3zQWdP4MkvTBXbfLtlciADmdyNR/JI7t372+xLwDzL8FOa563OrLG/Hcr4xWlHWlgRrtD+KTgVCVIAroPu1twPlTObNqmddz5zy0mtzDCDNP/5575xct3BhJHrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3abe7375ba6so90323395ab.3
        for <linux-block@vger.kernel.org>; Mon, 23 Dec 2024 22:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735021442; x=1735626242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SblzuJBesHFVjaNJKKW8WutChPVdT51mxhglVDJXNiE=;
        b=WChd/vSngLJ4fzFJ3c7YNJJrkgep6Lr+A2oNXBmAfkkq/x0341HROLPyCdOcVhZ4Rr
         1x+mDSqlookzyWYabBz7lzZcIL+8swww7Q6rl28J8sHjqB7LNVdEBzd32pI5R4lnuJ+1
         UCER/t36gKn8FJ+5yjg825fS4p60m5HGl2CXIBUuHiWHy3KWJ/7JFGW7dtcTj+q2ttG3
         gTPcOWozAaFJ0V2oCOK+nsXzRnivBPp3k4nsATzVznslb8izwd7XaxKz1YdZNMKRyEM+
         9YFILzrtH3CtUC3aHdOf4ZngKJbNtZpVe234sfwt8Fd2oRjWs4y0cGHpV0IR8ibaH51W
         0O/w==
X-Forwarded-Encrypted: i=1; AJvYcCW0YQL7W8kERZVTzD+7ENj3wutIxjYxbWFm1YnOAL3/oksuJFOOX3/5AWeI1qmpum2iZC6+FsEuJ/njmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLBXyQuuxc7JKykPxBkAwFJ6ku1HLNnZzYrvYu0gfHoRfrPVC
	Z+OY2ieaf8z8g6aPU8feScqGv0GlNyObGlfq8GXoe25bhKOpAfGwma7lzG9OiSaNiWWHjS3sYNa
	BGekLeqWMV/zN0p5TbWkkLIldROjXHYzQTAV8Pqmy42hlsQpsgR+c/ag=
X-Google-Smtp-Source: AGHT+IH5Hx62rRepnJelJtQJ8sdAWuFF5a3JpWmRIfv6/1eGAfZAGB/MKANmjkpA7PjVg1BABMu96SJYY0CPLJHJNwgC8idATgJ/
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:34a0:b0:3a7:21ad:72a9 with SMTP id
 e9e14a558f8ab-3c2d5152acfmr130327635ab.17.1735021442596; Mon, 23 Dec 2024
 22:24:02 -0800 (PST)
Date: Mon, 23 Dec 2024 22:24:02 -0800
In-Reply-To: <672ad9a8.050a0220.2a847.1aac.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676a5382.050a0220.2f3838.015e.GAE@google.com>
Subject: Re: [syzbot] [scsi?] [usb?] WARNING: bad unlock balance in sd_revalidate_disk
From: syzbot <syzbot+331e232a5d7a69fa7c81@syzkaller.appspotmail.com>
To: James.Bottomley@HansenPartnership.com, axboe@kernel.dk, hch@lst.de, 
	james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-usb@vger.kernel.org, martin.petersen@oracle.com, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117bbf30580000
start commit:   c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=137bbf30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=157bbf30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=331e232a5d7a69fa7c81
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16952b40580000

Reported-by: syzbot+331e232a5d7a69fa7c81@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
