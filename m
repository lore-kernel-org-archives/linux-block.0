Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9E1F4F1
	for <linux-block@vger.kernel.org>; Sun,  1 Jun 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748794864; cv=none; b=jzHb9eAcoRjOyyyFYbG0kjpw8UF/DJivodS89C+wjzmCImk2L+JBYPxtccnMH41AbQJdoQV2yIF/2pY4SQLliNlng9Cho1HplgufhTlzbSA6JC66FjDeMjTa7CxDWe6uIGogyDvbaOX+sdVHhh51LFzcB3TXFFd0APrhZcm9+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748794864; c=relaxed/simple;
	bh=h6QoMpVGGZVy60Ef1tMLb7Ks9v3/ZkdGVQ1zpckE/E8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EcVo7w+XgHuuVtapSu57UVy76HO6zsY0vnlnADyGMRAflA8Q5Xdppbm1E2gI1CwYuL2HgiS2FyN/8oWB55pbant7kAFrSP38QEAyhLw5X+d0M970h5rlLPPzXsg7WMuoBxmxVffvUUvmTtP0IvmOb4Ds8UWBYIDYfmyskZawx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3dd76ca11easo77655295ab.3
        for <linux-block@vger.kernel.org>; Sun, 01 Jun 2025 09:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748794862; x=1749399662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxRCzM24gglLIr7E2yldOZZAcHs1wVBwC6JZOlmfhD8=;
        b=LvnQUgt3Am22G3RnraGkZlT/ZzdoMyVhoa47/cInZnfzUhzSJnIDCFTyc81oCc+Diw
         4xid6jRp2llJmlb2N/WQU5N3V4ZnjeMbkY5d4oJxIGIKkokQuXRJVWg6tp5mnz5gSFjO
         d79PTH0cV0sj9nW/1SxM+kADZ9+sf6KwA4ew9tOqqr2KKt1CjYN1ChjnEAkLcDyP1O3H
         zb9VN0PI+lnBChPpXlUm7AmhUkyVfi383lfpnTN+t7/sckGMvTQWd+8uZawgBTa+ViEu
         52dLfZ+fNq36r4MHklqlDL1wT+X7Js25tH72Ar36ZukUY/Q3fgC4x3XvZwqJX68WlXJG
         ojrg==
X-Forwarded-Encrypted: i=1; AJvYcCWGJ0B9LNkjNk2lRmrXjM/rvwSPQE0WCNPD2Rbg+IIcfaLgVb3PXWDy8hOLmdoW80SiVkaNKB9zvd7M8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKojyqyZQ/dGL1qTUzVA5WPXqeWLJ9l6CAdAnBraKpHW09nGmf
	xQWlU/d9GL+l9L6he3ayoMc08YoN9Q+4+CuWAloy1sTUDsdSpcLblnR58eVqQlxoacK9irbl33u
	pvJxA0gyG4L/wjoa1d+poT5MNAZExKphdSXJqFZTK/F0p+PtQexVVrgevxtQ=
X-Google-Smtp-Source: AGHT+IE6dM+Sri1ig2zWdcwsj1cdNpnH6D5Ew7GCODMXRc5foiZExQDqXF9qiWibFIJGCE3VMwNQPSukaY5jbkheuww0vE49Df77
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa6:b0:3ce:8ed9:ca94 with SMTP id
 e9e14a558f8ab-3dd99c2898cmr107808385ab.14.1748794862401; Sun, 01 Jun 2025
 09:21:02 -0700 (PDT)
Date: Sun, 01 Jun 2025 09:21:02 -0700
In-Reply-To: <6751e769.050a0220.b4160.01df.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683c7dee.a00a0220.d8eae.0032.GAE@google.com>
Subject: Re: [syzbot] [cgroups?] general protection fault in __cgroup_rstat_lock
From: syzbot <syzbot+31eb4d4e7d9bc1fc1312@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	axboe@kernel.dk, bpf@vger.kernel.org, cgroups@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, hannes@cmpxchg.org, 
	haoluo@google.com, hawk@kernel.org, inwardvessel@gmail.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, josef@toxicpanda.com, 
	kpsingh@kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, martin.lau@linux.dev, 
	mhocko@kernel.org, mkoutny@suse.com, muchun.song@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, roman.gushchin@linux.dev, sdf@fomichev.me, 
	shakeel.butt@linux.dev, shuah@kernel.org, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a97915559f5c5ff1972d678b94fd460c72a3b5f2
Author: JP Kobryn <inwardvessel@gmail.com>
Date:   Fri Apr 4 01:10:48 2025 +0000

    cgroup: change rstat function signatures from cgroup-based to css-based

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ca4c82580000
start commit:   932fc2f19b74 Merge branch 'irq-save-restore'
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=31eb4d4e7d9bc1fc1312
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161cdfc0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12dfc8df980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: cgroup: change rstat function signatures from cgroup-based to css-based

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
