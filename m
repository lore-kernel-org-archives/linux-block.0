Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609B20C488
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746186664; cv=none; b=qrlAjYemYHTmLZmxyiAqxUKGyB+doMIlsisdxAomCDcdRYLmYW8YlJPldjw5vTAC1tlLWt+W9+N9vZKl9ztBXFpHmVs+zDd1rCbAjsCWU25IvMKx7TobUWLkyRViy39kB44iCClTYbrYfgCJSH5HVvAQ59OxO6AGPqie3xFZVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746186664; c=relaxed/simple;
	bh=lxZ8rOkDSCsFVW2WQ32zs3zoTVWUyymf0py48Q98j4E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cH0NkCrKeBhoYSPSX8/oCVhaPSwEvY1v5mGhV1zqfg+S3MI3xDU3wq2tVH/PigmEqIr2n/dZ00O8vNclE5H4mJO9yVYELya7lLZzrjRk4J4WV2JvQZQErTCsBjujbpW15sl3g3BnMTJvPOuVFa7vPlcQUHNcAZAenHiYOb5XYB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b3b781313so431241939f.1
        for <linux-block@vger.kernel.org>; Fri, 02 May 2025 04:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746186662; x=1746791462;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GzGElVwrpn7WgINKNMDTHEhcwHxNIwhUYezPmIaX74=;
        b=dvvmVLdMdRSKFD20C436oTIDotUPV4ZIdOL/MQRWmPOSG0sLXw2RjjS1ZwX5+9aAVq
         NuJ83zvuV6Xth1QhDECt/tHOui+SQ6dFnJcprabRvUv19lk2g5c67pdiTayD7R6MvSDo
         P2W+00MJNRvzl7btM8tPN26uqDUzhA+K23f5wRJerVEXNrNrNDYVX76XIy2/ppPZv1Pd
         VHozv8LxMojGMdvcr+kRvpzUMqY2PF7Sl/SWXvFCAxRHMzuqcyZ0B+7FSGlkrhChh04k
         DFHgPIGXeZacyJEiBpiCH5oMzDhbE/Udn5A4FAEcWRrywuliEBql8gNtXohS7alUtnLv
         mXMg==
X-Forwarded-Encrypted: i=1; AJvYcCV7fayUtEGw+jHl93NBPuhLd5bgFIULsw7biWTZacQzLtr0g2gCjcz8rBnZJ2lWUSIqkrVeACbD4ZS3+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2vs4JAhhcJ4yY7JT5Dq/ccMWMBHU953TUcTvawA4VkfeMsu/T
	7fcnwoUHuVCCJuCo40WOnHZ3pu/LFh5eFHUD5Z94yhuaP2MY1t1Q/MAEygvg5rpJBf+3pRoy1t9
	VlMvBtzaqcgh6WEzg4j//49wBIv/B4wMZS8ime1lVemcugqb/c3P0QvA=
X-Google-Smtp-Source: AGHT+IHT9JnGD6WZpxKelt2uNR6CpHn9e5gtYlpxij1xhxDfwiXUAGH0J9rZZR1TszCZi4HVFfYfbExKCA7vaSyyEDPyBvQLsgxq
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:388b:b0:861:c758:ec35 with SMTP id
 ca18e2360f4ac-866b424e36emr311382439f.11.1746186662541; Fri, 02 May 2025
 04:51:02 -0700 (PDT)
Date: Fri, 02 May 2025 04:51:02 -0700
In-Reply-To: <6741e9d0.050a0220.1cc393.0014.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6814b1a6.050a0220.33cf57.0000.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_set_status
From: syzbot <syzbot+9b145229d11aa73e4571@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hdanton@sina.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit ffa1e7ada456087c2402b37cd6b2863ced29aff0
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Date:   Tue Mar 18 09:55:48 2025 +0000

    block: Make request_queue lockdep splats show up earlier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1411b7745800=
00
start commit:   f1a3944c860b Merge tag 'bpf-fixes' of git://git.kernel.org.=
.
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1611b7745800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D1211b774580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D90837c100b88a63=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9b145229d11aa73e4=
571
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D163650d458000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11652270580000

Reported-by: syzbot+9b145229d11aa73e4571@syzkaller.appspotmail.com
Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up earl=
ier")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n
