Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8412B9DD
	for <linux-block@vger.kernel.org>; Sun, 17 Nov 2024 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731831245; cv=none; b=g/TS0OT36+A3+0JEpb2qlwTOIh01vnm/XHQB0YOyBFCLsKXJhmmkLDeamIJW03nqV5P/toqWSJtSGn7zks0hqZ8Fd2Wa0L2aMsD2LBvmAnrJr4u/H56p04+hDko/TvWD8B911uuP85OnzyZ/YAGaa4c/iY9EmGtvQhzEfN8MnsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731831245; c=relaxed/simple;
	bh=sITDq9pgxV0JGeUE+jutRHugAwm7EjJ+KKPhCIWr8/s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uCZugNq1c3m8Qr5trz+cXNC0mthaE+z+rRxVPNYwBzZmvDCVUwiwpfVzOIKMRGtKQRpyD0kIXvrkkzwxez2BEVWlPzIG5TUT+vh0tD4A5P9HlVLUTeyOnknp0+FfaiMFUtY0tBLHxxeax5e8F6ER5o4n4ck+OR/Sys/M6/dCP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a71d035135so12845215ab.3
        for <linux-block@vger.kernel.org>; Sun, 17 Nov 2024 00:14:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731831243; x=1732436043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cAXStZgVrmvMzECPpPJcbsX24KNDbw/bMwbcFv7apo=;
        b=TjVgH/+aT+eVvPKWlpncdCDC1eHxCKpVVbN6FOhPRHV1oVwqQ+M/tpRzQnbrm1uxkK
         wN3uqseQy+DpvwG19g2OgVlpfA5gC97jxQpKsFtc9HTiRwyCn+K/XZ6lpX5PQMhGPP5d
         kTQiJkzpmZz7XF8as+i03m/iOUwjfDZ1/glaSYaonx9S+jk5Ji/9Jayn/ghDmEE1CTSi
         2UKgtbOUC/J13EWcGuSi53xDxSgxxlyGaUW0P+rfin/ea14MNL0vrb9UFYLmyN6eQ6Gc
         337DK+CvAbgpTF1Xr6VanuKn3wYwkvVkwuObkE+Kh+d6ZgRpjhe4JW2wDeReaXA4ed3Y
         KQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAilpNeklwq7e7OvZixPCKAYcwUcP4SY8Ub7RPi/kcgb8Qickr6DoGNIpMidSw5nX6TkJXmsppPROvDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxls25KUidsuDHjkdJARcmHAQH9XW2seniKRdO51k7FD6yjmQX
	YRGgaiAunQYqguSr5qROVE5WibECfYFVe0t5Q+cIzp28PatTCQ3Ch+eHPuyJ4I8I3OlxZYvqWYB
	fYHw3/sM3hGlGafwhLi5DK8c29DeV7okQuRgfSefuFx2NWLfhZ06M6dQ=
X-Google-Smtp-Source: AGHT+IFd1nbd3dh0Rhw8u+kcphrA3gBgDy9zioD/bdGdledmXplLVHrzifgX/GQ1F/B2kxhtseYyiN1YIX4ZI/wlZ3Q4qSUI0Xzz
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca8:b0:3a7:1891:c5f2 with SMTP id
 e9e14a558f8ab-3a7480031bemr85191805ab.1.1731831243214; Sun, 17 Nov 2024
 00:14:03 -0800 (PST)
Date: Sun, 17 Nov 2024 00:14:03 -0800
In-Reply-To: <672c2a44.050a0220.350062.0283.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6739a5cb.050a0220.87769.0006.GAE@google.com>
Subject: Re: [syzbot] [block?] [usb?] WARNING: bad unlock balance in elevator_init_mq
From: syzbot <syzbot+a95fab8e491d4ac8cbe9@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13aa32c0580000
start commit:   c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=106a32c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17aa32c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=a95fab8e491d4ac8cbe9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1722ab40580000

Reported-by: syzbot+a95fab8e491d4ac8cbe9@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
