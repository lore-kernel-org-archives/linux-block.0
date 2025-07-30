Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0574924B26
	for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864627; cv=none; b=j/wHseT/Q2BztZDGzBKNB/ZxJxQmsPfCfx4r8qTHjWznj8MdR6cZbkB9Thla4kW7DYOY7bMmdqFlEqq/CU4cAtRLkNvs7DBNKGkHlo1TINCUjAAQvwHR4uK9xGaUWCG2ykKwDR6KYbngbuHTMklCe35cJcNW0SuADHE8fKZ7es4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864627; c=relaxed/simple;
	bh=NkUOiRCCJLlWb7eUsmBdTQ2b3kyACzJhRlK8S3lG4C0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o5CPMwUjKTmWq/TEDgkn4R7vmpY2V/MJk/OyxgIDrMvLWqEiLIc78S2jdcpzYhx2Du5BlBGLON7pYQdl+1jbWQ5im45rALUIvefBSP3TubLS9+DT+Qr+GRGpBiRjOZd0J2oC1aFcaFY9OMXFX/qekdgIxr7fRSmDSiw9EcJ0NRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c41047044so184696139f.3
        for <linux-block@vger.kernel.org>; Wed, 30 Jul 2025 01:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864625; x=1754469425;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHawJtQ1MGRltb+5jXCTWQSQ/lIKowNfTpts49mnvYE=;
        b=Kl3OTp4TOdIkahZj3VTGdVY8zxFu/BL8VXTJVQrKsY3dN94fepQTMAVKXSiiT5W471
         PjOulH79xPQJb3Sx6claCwJ1j9y3c3cCWhGrN2HisiOvKmXDUND1NaTaDksA7u3sfcFa
         qZy17nF/GabsJwQQviSCMOU+CJxBGTiBIQVEXHzjNYu4PxWUAoHwJeEeJC5SyFr+lKAs
         EbugIW4oL9TfA4IwfeBx1hdWtkyyxLJ1l39dGu87il7PukwTMkWzE+ee7ezK+AEIBK5G
         4yFcefj9NfXXbEEkW9s4oc8xhQ9Q0NUZpYQJpMKxZuj7sfMhfdBW82TyA1MCuZzr/DW6
         kvFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvGys+gGJ84rGH49mQTWHzcPOU4Q9Rmd1FQpZlriJJ/SbrBvcn7C/KP7719DdVwQwHaoY85W6PiBkXfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbvxnqQlyAN0Uu+nciGVXlH3ogTS6iJ1lJcViAY+A/rBIHuNdo
	O6GhIhUwqx7+2JituGD1SkX5mW+kPeV2h0cm5kOoNRs3K9L1qL11CE4HEs3/K6WfkRS8HpUt/Lq
	gtbO0cRaicGT3yTdtFEyxoHi85HlCHOornWooPh3pEUFIDx3xqxFrVpTygV8=
X-Google-Smtp-Source: AGHT+IHn7jUIMw81pbjrArBZNOmKvZBfVtYJhOLqBNdCKPEBye74nPONjr+15DWwZ1JzBUIdk74qVZbF88BPYUSRJd3glY27vmrR
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7409:b0:873:47c7:6ff3 with SMTP id
 ca18e2360f4ac-8813771b53dmr493966739f.7.1753864625258; Wed, 30 Jul 2025
 01:37:05 -0700 (PDT)
Date: Wed, 30 Jul 2025 01:37:05 -0700
In-Reply-To: <20250730055126.114185-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6889d9b1.050a0220.5d226.0005.GAE@google.com>
Subject: Re: [syzbot] [fuse?] [block?] KASAN: slab-use-after-free Read in disk_add_events
From: syzbot <syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com
Tested-by: syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com

Tested on:

commit:         4b290aae Merge tag 'sysctl-6.17-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10908834580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=295b41325f4e1bab
dashboard link: https://syzkaller.appspot.com/bug?extid=fa3a12519f0d3fd4ec16
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ac34a2580000

Note: testing is done by a robot and is best-effort only.
