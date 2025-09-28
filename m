Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E34B275B16
	for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759090324; cv=none; b=dyUGs0IiU43RiErTbMJm8mC4eKBjA50cfnjfxdMSshDYU+KshpcpWQcQyXF97PO/F0KE7djr1jo+FJi5eR0img5/PcbvGIzKGq9A1tnCmkvxyfOsRxnVzdCTOjHvWAgOTMGpfJ6ejvKngMaqzUn+i9PHWEkUuBBTIZParVgbr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759090324; c=relaxed/simple;
	bh=0RbFeTDokiBIDFXYwXhTqeTngrPJxIKeMT9v6nJhPYk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u+3NE+3aAOAwkT86NO/gq40iU9sLNzCJ2Cp0f8H/hkh/fQ/+pCbx8xskVr+N2QWbLlIoqI289ShIhBEb85Ch4i+d8rA+nJ2SoqcLHk2lA4hSB5aVh8pe5HPYDFHM6KcRBRgbbdc1YJScQTC0+h664zH+Mxl+MlvkpHMMSG0FwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4294d3057ffso16054795ab.0
        for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 13:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759090322; x=1759695122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DaduVv8+j9xG9g2Olc4KfHdOBiR7JfOMthlP5Ksd0K8=;
        b=qPhaRT/YT0x71x88pVi7dS2WFRbE3jU0xWENQc9lZzKwsjAfEg/X74UZahOuVpIItW
         HhnN3X8hSv/id0Vqxj4MQ6kcL/bmu7k0Ulv3vEy3O2CzflBhSsy5nolx5lZiaglZ2ZeI
         M39WnqSxQr4xUkyCsyvzi6mTavEq1mNgCSuMu3byMxuFiB3J09lrNH5D8Bp3qBCbYQ7D
         O7OzLJMmr+Uesr34xyvg5KEJIpXAYBl7phTtX2QtwHg+Q18MxGmqr6qBCfspzJURNCZJ
         huNC0Sf39aRV5H8v+VcaKMdCSQ1TxR5MmdQkIR9U4FDvJ9GsMRfQqnKY8n3C+oxpO1HE
         B4GA==
X-Forwarded-Encrypted: i=1; AJvYcCUAhMPTsPwoaijFCzPGSUhbxbW1RhxlnJ44FUvx1FfawLYaTc2843Zc3OdJ9KOIox9WaC5+GN9BXQuZ3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaeg3zyhTjMK0HDPJOH9pZfoxf5rNPDUCW2APN23BeCr3o2yb3
	4ZqU8S00MNOHyZtZ/fvLmRKptNKrKQ4IBYodxORR4VrKtHwFtE0wiC0/s+mnJinzO98EHB9xoNd
	Uk/Nl/sTJW2GQIKgJmp1e6uWUCbYuN/jMpuCVD9sJZDR2APLG9umxToaQl8c=
X-Google-Smtp-Source: AGHT+IFe1cPN5hHZibJvP6cJECKOPK7CIGqP3ONZivzTbEMVJkCeWmbblnq11+o6oAttzrZ2589qumHKCObY7OyIrrC974/LLSD2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c83:b0:426:c373:25db with SMTP id
 e9e14a558f8ab-426c3732a86mr162405485ab.4.1759090322279; Sun, 28 Sep 2025
 13:12:02 -0700 (PDT)
Date: Sun, 28 Sep 2025 13:12:02 -0700
In-Reply-To: <68769347.a70a0220.693ce.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d99692.a70a0220.10c4b.0027.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_setup (4)
From: syzbot <syzbot+9c1ebb9957045e00ac63@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, jiri@nvidia.com, kuba@kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c2368b19807affd7621f7c4638cd2e17fec13021
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Fri Jul 29 07:10:35 2022 +0000

    net: devlink: introduce "unregistering" mark and use it during devlinks iteration

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12620ae2580000
start commit:   347e9f5043c8 Linux 6.16-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11620ae2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16620ae2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=9c1ebb9957045e00ac63
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138dfd82580000

Reported-by: syzbot+9c1ebb9957045e00ac63@syzkaller.appspotmail.com
Fixes: c2368b19807a ("net: devlink: introduce "unregistering" mark and use it during devlinks iteration")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
