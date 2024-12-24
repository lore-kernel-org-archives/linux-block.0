Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4EA1DA4E
	for <linux-block@vger.kernel.org>; Tue, 24 Dec 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735077125; cv=none; b=mEmwZqd9+57IJEnuyM5D44N2VEmY0OypSjE+PYgnbG2nD4A90+Qr9/a472rUPC3SYVY/CjXpgRfNeoJ3PremVeDoD7xf/b8jBlwk5WvQnfv80nPL6bZicySEA2xknEd7YhnPhV/pZX7QnnvprjyY091HbBaTYzD7FgNAxqZLz+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735077125; c=relaxed/simple;
	bh=1SccR7/85Ev+zmlVFYTm8gst8PE56/LLci2h9RzErFQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=thbvzo0wWvemi2M/gOGa2oU7/sQSlCbb7f2lhVsMdPdUSe+Jc/PpGhdFZE2gKRoaCT9GPN+BkwnHMYn1ThNlAHafxULyGIFsY6cV4jhO3gpnRf/8Dya4ox2Bi3zdPuXg8AA/ARU/8ID5AWWySPUEMxjVr+aGINC2HNDBXXoZrbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a81684bac0so108492145ab.0
        for <linux-block@vger.kernel.org>; Tue, 24 Dec 2024 13:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735077123; x=1735681923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76899iIyLRwwAHILxLbSYak/Z4CiuYUYRiqZJ99fGDw=;
        b=l5eBdIhS3sdWukXVgLmP0fkDeskAsLFz3np1mKVLG+H5MaKR1TlX3L47OLV2dLm3yn
         2/ukhlCWo4M7w9VoeLkEH17FjEZnQXARfeeHrrnyFxFpL74s9fKy8QoPA1XXRb5ZH0ml
         W34VL082tzsLTO0Swo5ETVWnSKjYzoG7dZlZW4wGBbz5MwWAxBj+UiIRyWrlP2qf02cL
         pj4HgswJDnkFCNXwGPIg2dHRRUEfd+FDTKlqg8itSiJ0QB86uak9cGoPO1Bbpo833vej
         BqR6kIL8WKYvd3C6c9gPaU2IjYVRaBnAe/x2eBN+cnpZ5Yu3+go/mCc3PQ854l6MwXVK
         eN6A==
X-Forwarded-Encrypted: i=1; AJvYcCUBkqVnNaby7Xm4EZtbyhcyBz7tCdicFnFqbIkOI00NF7m9Rkrkj/TYxzlSpHlyLkexP4Xnds0WON2j4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyLG8lsflPwR7tWPttmH1N1sZch0aeKnuT7quoEc6TN7rzbP/P
	8u7WuYztqz9eRUm6+5pY3MkLbiSX9SZ91OpZyc9f8O151C18ryWKXizhq7l9t1InEtnWDYUk8h+
	xpBglfBM6qiKah7ih/huLmqm9SE4poi/cmxIyjJJpalUk0E/QdkkV8pM=
X-Google-Smtp-Source: AGHT+IELSaY2yi5q69i55hpMIsdydyqjVz5Tv2kPSL6Z/IX0juRIHGLCcQNGIr1aG/W0dl6aCjEVM/jS5ksRpa6973mBK4SA3qoP
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e8:b0:3a7:78a8:1fb4 with SMTP id
 e9e14a558f8ab-3c2d2f47732mr141838765ab.13.1735077123166; Tue, 24 Dec 2024
 13:52:03 -0800 (PST)
Date: Tue, 24 Dec 2024 13:52:03 -0800
In-Reply-To: <672ad483.050a0220.2edce.1518.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676b2d03.050a0220.2f3838.0229.GAE@google.com>
Subject: Re: [syzbot] [usb?] [block?] WARNING: bad unlock balance in blk_mq_update_tag_set_shared
From: syzbot <syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1064ffe8580000
start commit:   c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1264ffe8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1464ffe8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=5007209c85ecdb50b5da
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d34740580000

Reported-by: syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
