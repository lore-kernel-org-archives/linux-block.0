Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DB41EA7DE
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711624; cv=none; b=Zxzvu9DOqFWOe1ykyRr9yjGBDNSws6O98R1QhV/kJjyPAG9v0cjXn6G0bkgz1VEIHJeW4qve127hyVP13EYtIOHzO0NhjRJ/ZstUVMLFNSl/qczoRidzqR02Onzis1xa51RW9UWDy3loXNRy7q/BqHCL8Ybbxui24ZyWMz57Mzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711624; c=relaxed/simple;
	bh=LemxrSgbISHecGwZDg8d1YDEy+VHGq0FxK3EasKvRmc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EdUEsqF2oixwq6v4BLFWbyY0KJIQs58pCH/RWxo1XmwLwf4jzZgIQ+ZvjLy/3uR1WkJ4NqggQZypamXB3/udWtu4gh3HPtPvHVk9umcu0XDnDfo0/xuZomI1QjOx2sKn1GRsg3Ch3wiDNUmA3evLstUGCXFO9GDi+oO+9fhXAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d6e10f8747so50976355ab.3
        for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744711622; x=1745316422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekxtkAYIfj9WYYWGRtuMIkrL5W+mUE1d81+QmoJC3I0=;
        b=Zy0oVT29VOcAF38rV/QSJfMbFHnov3Db5JgA22sPtY5QmUvYz3HGKGj1JugzrAAiCd
         S1XkUSY8Z7J2Dy1G8mh56xuGe/g0Yt6RY3mCc/w62g9KnymdfYFclGVDySsg7itxSsqJ
         seZINAo5asUl4VQ+iaL2vAPVSQRuGMnoVgurZRL+b7gB9MX5bmqklRQHZLPgvDWHiPdy
         uvO3MxVLKL+cp6P1c3NfPpc4N+SC8B/1xWzAcVQMQFW3+Vwt/d7p4ULHxaA3j84hsd/d
         gXTzDhET5WQQbPPBLwy/Cuxzce0U0Q3j4OqWiK4ZTL59Hfx5pvDlJs+up7zV+7fwK2PF
         z6uw==
X-Forwarded-Encrypted: i=1; AJvYcCXSg1ZLdONvLqVj9i+Ez3uAS7wqnsmWQf6yPK6GSXOxOYY7GRcy++hw5MTdvRXlG0F1do9DmNt6O2Zt6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9w0YO7jqTADAsPEmlaOZag33qbO2+8pol1xqd3PC7BaiI00AV
	sOD+/aPF44ipfHniDYXXykhMh9XM1jhPcvNegz2IlTU47UQq64gbcqByIjhNpscPJiCLnVf3H8j
	G36xgFkb0cCZVtpDXQv3DJwT5Sn7mVlJlB0UN9hXFmxx2yVJxG3MiBf4=
X-Google-Smtp-Source: AGHT+IF0T2CRgbXUbT4vmgmK1YTgZn8RZJgbSXksVxvQoT0lh3iTSFP4A3u0nMuYNkC3SkdO7G3r0lGa9db6H/6xjiyKgPaRyX8a
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1888:b0:3d3:fdb8:1792 with SMTP id
 e9e14a558f8ab-3d7ec265578mr137221655ab.14.1744711622446; Tue, 15 Apr 2025
 03:07:02 -0700 (PDT)
Date: Tue, 15 Apr 2025 03:07:02 -0700
In-Reply-To: <679fb3a5.050a0220.163cdc.0030.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fe2fc6.050a0220.3483fc.004c.GAE@google.com>
Subject: Re: [syzbot] [bcachefs] general protection fault in bioset_exit (2)
From: syzbot <syzbot+76f13f2acac84df26aae@syzkaller.appspotmail.com>
To: axboe@kernel.dk, gregkh@linuxfoundation.org, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 3a04334d6282d08fbdd6201e374db17d31927ba3
Author: Alan Huang <mmpgouride@gmail.com>
Date:   Fri Mar 7 16:58:27 2025 +0000

    bcachefs: Fix b->written overflow

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11c360cc580000
start commit:   76544811c850 Merge tag 'drm-fixes-2025-02-28' of https://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8de9cc84d5960254
dashboard link: https://syzkaller.appspot.com/bug?extid=76f13f2acac84df26aae
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159248b7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13152a97980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Fix b->written overflow

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
