Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1D421D597
	for <linux-block@vger.kernel.org>; Wed,  5 Feb 2025 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735086; cv=none; b=hD8QXaGlaj1KNV/nJIzGAHPFpJ9HYAGBuhatVi+5ob/aDlhROl0gttj97sL3ViDH4ZymPgwzhG9KEpT0XEtfOFiKF1YbZAdFHJ8hxEf7IyYt5Gvd+IFN49VFxxr7xP4UBGp3KwHMs29CC7onAqWhkHorc3LN1+pswlbd7pwfYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735086; c=relaxed/simple;
	bh=eCnvaDRC7nQVJQXr7yFA3eXDOv1kw8Jo9IyBztnYNLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DKr6eaRO4i+ZOMHSh06Tou61abUvv31mbRmd353jQvRG7G1bFsTfL+E0YJC5dHb9X+DRZSlbbzW36IbzYKJbCEbqfX6aDn2CjFe2TcY7eA4NH41hovuGszzaQabcu9+ZForbnFeMxDefDGUsFaClJ0sKmXGJWW8fsPesCJJ3XsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d04f20f2baso10440935ab.1
        for <linux-block@vger.kernel.org>; Tue, 04 Feb 2025 21:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738735084; x=1739339884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgoGYXPL3jaqGsvD6yqUXKZyHZuAvF3NbJLN1Y2+mos=;
        b=TWAuJ7S4tnK5VcDiK5Qy47aM0fujXBstnarLfi605vMX9qMx2IexaW2zK1btT4MklN
         HdGfSBXhzrOySLJUenTZ8aCyE4mR9mX3lXioclKW+pjCK9UtzZiBVQDFSAVpADkArs8B
         xnnfKmvXw78VP2xlx56vZvcOHT2Tp5FkXcTXWaS6WWCxYAtUDdunC+x612Y1wFN/OW9v
         DjKzXXEvRLKsYkzEMrIu9UBnq/LrPfhDrGEukHF5sPi5/dGj4ECBeKhnMDXTTwi37rAT
         GKIu5gRfUddaVUKApbyzp3rqiXTBHF6o/dk35xzOuQufLGSdXL9RK0v9kvd3ElquUBzF
         bt1g==
X-Forwarded-Encrypted: i=1; AJvYcCWjqlLyxAWmt7IOM14vze2CMRN2vn8SlNONxo3lr66puRZHS3LX8I6u3/p/nC4p6oPqpmp7VTQg5inAsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTO8GB9DPO59JJGH8LMrXDbM+xli7RO3LRrjBHJ6wJmYbm3KY
	fc3+1TulGSp73a9x25nzCRpKozauHNP4Rm+2UMu9Q9gzGUpou44KPWWcPfUC7z0man2xbuAJYvC
	FMp9TQXDB+QOxvY8F2yuapNh12BsbeYzj1r2N7qd8ri2r7nuWz4bc1EY=
X-Google-Smtp-Source: AGHT+IH2nDOcRyAbsP/ZFFbGw/cJPsTUsTveiVlP2eXWQqknQYXSK25WNlXoJeeQrPdOOXsXY/uUaSs949Dx2cxKLiUZKAR2dHni
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:3d0:28d3:e4ba with SMTP id
 e9e14a558f8ab-3d04f917ccamr14330045ab.18.1738735083923; Tue, 04 Feb 2025
 21:58:03 -0800 (PST)
Date: Tue, 04 Feb 2025 21:58:03 -0800
In-Reply-To: <67a23341.050a0220.163cdc.0069.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a2fdeb.050a0220.50516.000e.GAE@google.com>
Subject: Re: [syzbot] [block?] BUG: sleeping function called from invalid
 context in unmap_mapping_folio
From: syzbot <syzbot+95f1db35defd8524f1dd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, ansuelsmth@gmail.com, axboe@kernel.dk, 
	david@redhat.com, dianders@google.com, kirill.shutemov@linux.intel.com, 
	lilingfeng3@huawei.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, riyandhiman14@gmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1760a1b5aacbe00dec464b1bf2b10443c10377ad
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Thu Jan 30 10:00:45 2025 +0000

    mm/vmscan: use PG_dropbehind instead of PG_reclaim in shrink_folio_list()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c2ef64580000
start commit:   40b8e93e17bf Add linux-next specific files for 20250204
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c2ef64580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c2ef64580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec880188a87c6aad
dashboard link: https://syzkaller.appspot.com/bug?extid=95f1db35defd8524f1dd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16010df8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f078a4580000

Reported-by: syzbot+95f1db35defd8524f1dd@syzkaller.appspotmail.com
Fixes: 1760a1b5aacb ("mm/vmscan: use PG_dropbehind instead of PG_reclaim in shrink_folio_list()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
