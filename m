Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F439FD4
	for <linux-block@vger.kernel.org>; Sun, 22 Mar 2026 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774138683; cv=none; b=qb6aMxP3S99JG6XAd64va2B9uYGkvjiqq7xRzYAPE9TgTItUs7n7lp8qlrZYFd536wn5+MPUJhu+BP+qIMc+ktgF7D4ifztQtgeM4WfI285qJjrCYLhKI3VneO5myq65JAO7J9hGgFH4jCMltPcsXws2pKC6OjYqx3/4YkmA/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774138683; c=relaxed/simple;
	bh=pgVU/LnAHveu7rXrMJSM4nRNOr6e8vNq7KtX/bcud3s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n/P6Nxea2ZB4A8MXt90rVN3DyTZ5t2mWydEOGh6wqgOeEd237VPkiyr3+caGJXGWHsKY8PI/at8fSVri+JEitf1VmnggCX9sQjdlkVPF/HhyznJ9gfiT08cRRXOW1J3bV0+QlkKAdeiPuLrqRScn/d7M1scLEMNXItRp9JfTTk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d74be44ccdso27029752a34.1
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 17:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774138681; x=1774743481;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JddUDtSCApHdMKa8sDCBEyt/zBA7m1Qk6e+QPWEsT8k=;
        b=tA7W9hgMUW/7vNMg828y/2hXfsCVUE44H5VT0PJ1QBRHwFWs9zlCRVXfZF7hYD8Fex
         lq7booF04Z5/A0BE+SjLQIw64BhE2s03wRMo6tVtxDbNP3rGp+JK8OB05BasX1MJD3O3
         Zelwt/CmW7FnfY1kOb7mYsWCBFxIty4MWuRT34ydDOgVKDLcFO3Q9eXihrSECjxFBNZk
         ZTUFWPnD26xXS7IFdlf2ER82tG15OrDoEJbI/wU9yacQKZgNzbm3fnmfKOjonF2h8HV2
         oH7GvYXAyr5pnB1k4Czaac9iUBSQ/mHevkOUOfJLH8DvAiEj7n3aXjBW4T8sc/kjJ9ef
         SUCg==
X-Forwarded-Encrypted: i=1; AJvYcCUxBazb4aitQVUC1iuDrKrcoC2nAyA+/nnlg4mwiRdEFavYU7SW1iLcaUevItV47wBHcYeJQBmpWwES0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61tzdR20CW8SPbwA74AHEpxBg3kZwOYRVrQqqck2NXLKq3IcS
	70zs5/KxjFUok+QBfPnVvI1OOrojxyz3LdE606ReqP1Nwaua3hvF32Cs28m/1kHJKU2Zze+r+Yj
	Zb3XXeSSZai1b2+5El/WjRVnfsCqph1G7ktHa+mWBJtPDUsM33NjCYYcBOt8=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:898e:10b0:467:da0d:5395 with SMTP id
 5614622812f47-467e5f55c5dmr3500781b6e.41.1774138681728; Sat, 21 Mar 2026
 17:18:01 -0700 (PDT)
Date: Sat, 21 Mar 2026 17:18:01 -0700
In-Reply-To: <ttc9u7u@ub.hpns>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bf3539.050a0220.3bf4de.006a.GAE@google.com>
Subject: Re: [syzbot] [block?] general protection fault in bio_alloc_bioset
From: syzbot <syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com>
To: axboe@kernel.dk, gor@linux.ibm.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: failed to recv rpc

SYZFAIL: failed to recv rpc
fd=3 want=4 recv=0 n=0 (errno 9: Bad file descriptor)


Tested on:

commit:         785f0eb2 Add linux-next specific files for 20260320
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1385ccba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22bf3527036b9be1
dashboard link: https://syzkaller.appspot.com/bug?extid=09ddb593eea76a158f42
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=143881d6580000

