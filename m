Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718281A08B1
	for <linux-block@vger.kernel.org>; Thu,  2 Jan 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735814464; cv=none; b=ux5vhb4MUzLbAp6Zs35XgT3mefsg53khrcmP1WKC5OyUoKI2ebr3FKqal/evoWCiETCEpI5ciJidBYvK9rfbM97+x3emmhp2thRAsyEgcYetqfcWALW0SCxudOZ0rpaRDs+eSlIXgM5EYZG5uQnaRinDAKUXzTDznarfXltLIos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735814464; c=relaxed/simple;
	bh=pMXZiRpBRPmiXly100IZhcwAkq4eNjiCbRiC92Qtw3g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ovyPaOsxxUFA0NoYQhFN5om9tdq2czy3YKnt/pcvHJx7C0/BZoueN0srOKAhtkDLrtTrSAs9yENmWNBD2AYVKdQGiPRCcjalsx1JzmkXLKDYZ/PmGJGjefB5spKOSn3T89fnu7ntvku5fVx3Y+KiS40xLgYYNXLvSC9TL5+Y6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9cbe8fea1so118498385ab.3
        for <linux-block@vger.kernel.org>; Thu, 02 Jan 2025 02:41:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735814462; x=1736419262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzyV7ZElCa83ikzcuqqoZD0xz4zHyxxfrWJ2R/1Mz00=;
        b=t5WArKSDuuz2ixgxvaHuXn0e2Bpt7iTIOIlqxHgXV2q/gWW4GegaAAYhM90FefUoYn
         ImNwn5eqHcK7nBlWphoUp7FuTqqUyN+n3YSgq3HdIKKitB7hKJfKRs/FDy84e3WqrWg0
         qpELmbFRrMwro4vaNA6CoBCxIjHfr9hDXRO1yLNrPpXuTXtow6Gz+ZUMmEGofrjIksXT
         UvhjabAYywOJZFOBA2K53+XydHxVB3L1dquqVymjkkuUGpfZuKVar8oUta8MUGQwAtzn
         UuSgFYELw+KEL3fbSsyCWM+sA4s8LKrqva/XP992RW1xHQcR+IsLGQmDMtEWF1D7F5yF
         5FXw==
X-Forwarded-Encrypted: i=1; AJvYcCUE5U+c0UVSu7cJO9AO87VmryC781GEBe4XRLu5nN3vB+PxKHD1mWGCrfuh4eA1rNUD6iYBh3sDDXHIWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlW+cBHq6N9gMml6L45Xwn4ky7TzKCYMpAumfx4//8YAWU83js
	loQdCC3put0Wpouze3TRk5Zlb5gWljAJTKRVmGt0ct9YTiOx8Ib2lG7/EjKb9yhLCuxC7J4jJ9D
	Z50TIo86hWJqIRiaUF7grqpN2WI80ER+Xv0C6QW4E8Z2IiJg2KNPZgMQ=
X-Google-Smtp-Source: AGHT+IGA47IBOBbWR6mdnglpI3uKmGDqxXLykYJo4Q03z3y7tq1aR+ciBFlNzYQC2yO+rKBanjoFhJopRY/m7KUMI3RP96hMqXnu
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1705:b0:3a7:e800:7d36 with SMTP id
 e9e14a558f8ab-3c2d2279c01mr369064545ab.10.1735814462620; Thu, 02 Jan 2025
 02:41:02 -0800 (PST)
Date: Thu, 02 Jan 2025 02:41:02 -0800
In-Reply-To: <20250102102816.1261-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67766d3e.050a0220.3a8527.0038.GAE@google.com>
Subject: Re: [syzbot] [scsi?] possible deadlock in sd_remove
From: syzbot <syzbot+566d48f3784973a22771@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, ming.lei@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

block/blk.h:728:7: error: use of undeclared identifier 'queue_dying'; did you mean 'cpu_dying'?
block/partitions/../blk.h:728:7: error: use of undeclared identifier 'queue_dying'; did you mean 'cpu_dying'?
block/partitions/../blk.h:734:7: error: use of undeclared identifier 'queue_dying'; did you mean 'cpu_dying'?
block/blk.h:734:7: error: use of undeclared identifier 'queue_dying'; did you mean 'cpu_dying'?
kernel/trace/../../block/blk.h:728:7: error: use of undeclared identifier 'queue_dying'; did you mean 'cpu_dying'?
kernel/trace/../../block/blk.h:734:7: error: use of undeclared identifier 'queue_dying'; did you mean 'cpu_dying'?


Tested on:

commit:         cbacbf06 block: track queue dying state automatically ..
git tree:       https://github.com/ming1/linux v6.13/block-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd7202b56d469648
dashboard link: https://syzkaller.appspot.com/bug?extid=566d48f3784973a22771
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
