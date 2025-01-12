Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F88729D05
	for <linux-block@vger.kernel.org>; Sun, 12 Jan 2025 04:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736656444; cv=none; b=PuGFypQ0R4wBYI//e7BRX3RPguntlX+QFOEVr1QJcK55KR9DPY6UlsvuozJZo1/BYGmO40Lzs/WhsoyKStCkdsyLBrfUr+tX5q7eWhj0VbmZindOPhNYNT8TWgZdI8pHm4vdz+4ecZLopnnvAhgKK6emiSgTOefA5fr848mOhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736656444; c=relaxed/simple;
	bh=TM0tNhEPuE7N6cbbigbiDdIM1xi9Q+8KRGTUDEu4Tp4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V386i5rUrBKAKBTSsXABHiPfEOZ6KqnmqvmmZzGi3mi+Rc8Pe6R5D/z5x38+HobGWKEvBhU3Bk/LHmE4I9l/9CU8vlrU5H2bUMnan6khB6RwjlYnFAEnF2lbkbufa8XsRjquB9LG9I0zx93zHsdL4Txv/toYdUA7fbUQmdIZED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9d3e48637so26843275ab.1
        for <linux-block@vger.kernel.org>; Sat, 11 Jan 2025 20:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736656442; x=1737261242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMpZdJmkeYtA3G+Dgwmq4KJjywHeSdSEqMe7q17JRGQ=;
        b=lqt3D0MVtZ/f2PSaQiQ4qVjst9uG9EKwR8I1VOIGVSapNUBeYwNsYiNQxa+/T1TwpH
         0kUW2Hl0466ig/Tmkx5JitQN+etiCtwAK8sbR+ytqABZK/YD6HBcbdaGpBIqakFrFGV0
         QX2+K5O3gszXV56L03BAfKzw4jjwKkZHOZjcH1yppM+kZagC3bsjmiePj1uFzQ87xEUd
         ZWPoohAexfOZHasm2wgY35SI8Va1fB+2T34hHW4BD2SuW5ou4uZbtu45QKNFPTG6Ct6+
         IfivrTlwo1yoxWlJUX9YeBJbxRycdvlQ3MlKTFpZklg4OIBh+RvmRhIyJ6zOh51PdYOc
         UmCA==
X-Forwarded-Encrypted: i=1; AJvYcCWAUQZVvAGByCPTIjyzpzo2sgb816Hij/t1E8GkMlBI2lOlT9B7R2EBTsSqzy8CEXevLhJLZkdUaYnmGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn88BGCQhmqdT706riQ/7Ut0CQKWbPu/yrt7gz41IQY4iZ6Qg5
	vAfyTjvufogizEkRy/wp+EWWF9vRwsXU6NgvnLvJcKNKcxN1Q/+1A58//SQCS10KnP65PbP8C8R
	7Ot95waglgkVenrMp5HvH2dLbe4P410AQm/P2wCPADSRQlVNoYiUmE+w=
X-Google-Smtp-Source: AGHT+IE/3tjNIHJ4ZdK6hwTb/lARq6L/Q93iB3VD2QDt1nliWCsMrtQDs06CpwM9mR1Doc8rfH3mjB138PAkGmn8aLbklsv2OBdA
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:10c1:b0:3ce:5af3:783e with SMTP id
 e9e14a558f8ab-3ce5af37a81mr42541635ab.7.1736656442279; Sat, 11 Jan 2025
 20:34:02 -0800 (PST)
Date: Sat, 11 Jan 2025 20:34:02 -0800
In-Reply-To: <67251e01.050a0220.529b6.0161.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6783463a.050a0220.216c54.002b.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] possible deadlock in blk_trace_ioctl
From: syzbot <syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hch@lst.de, hdanton@sina.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, ming.lei@redhat.com, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 00:37:20 2024 +0000

    block: model freeze & enter queue as lock for supporting lockdep

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13cd2bc4580000
start commit:   74741a050b79 Add linux-next specific files for 20241107
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=102d2bc4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17cd2bc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3ef0574c9dc8b00
dashboard link: https://syzkaller.appspot.com/bug?extid=a3c16289c8c99b02cac1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175f7d5f980000

Reported-by: syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
