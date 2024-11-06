Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D739518D63A
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730866686; cv=none; b=lvcS7UfAn3zhrrAqr0IIHEb+UAMruWlpjQCaRPdduo+tzQZWAdqCI6NmZvUhd4O793rufEPhZ3Wel1p6nXavWkMW7ZbJqOAKN92TLEXbkkKumvKesH9hz6aw/4A9LgUwzHqEbb+5YSR5VTxlaYfXnHsCZz4A6Gso1bvHP4PwRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730866686; c=relaxed/simple;
	bh=UsvyeQwFOXvv6+VXcRzjvnK6RKi6GGF11RmCxqB8K0k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lcMir4pCY3GaXGPTF5NTkscCx6rWVu1UhbDvO5ARWI4Tw1i0NvoS/SIspMllZC/VlE5GLLr0Qys2fwLZP4WHrLrsNfxbfaeJofOAZ3YtDFtdkFkPs/JhFFWkWEsfOkFZSSTmTazvy3oAKS4ZdhUoZWEblIviFbAlnh3e9EFBobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b7974696so49472185ab.1
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2024 20:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730866684; x=1731471484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky0pjP0MyMB/9Y+3wQlKW8z7mKjqaQGMXxUNw6OuBtY=;
        b=J097ofsaZnksHE2lLwWAij3LGBOQ54sOJODfwd0z2vGkI9dkH/qeuzjpeGY3TP/vCt
         kqYC00QWrNyrA8kPwW9HHIVWZWbJ6UjtcfclYHx1n2RaOmy5ehuTDnw9fgewFy/3RRo2
         tZs3xqzy0BOW5CERTZTC8IK6qKzDyoNDFM9UilfPhE8OvFMr5mWzLm+OS5HOnT/2r27w
         3j8kSZ2F6kTt+N659+H2hTvioSs+1pR0cDP5bRLNLJ0pxXBdmYncBz5hh4BRP5iojeJS
         eluTT1q5ksqsqZ3auvZx6wOxXgHxRFyIJlvk/VYeQAwOsHydSj933TnkmUJNPVyjGkWy
         1ZDw==
X-Forwarded-Encrypted: i=1; AJvYcCVfjXeTc/d6LXr2Dc+XRoBdJHVxUIMBLYrMb6I9YRt4JXD/xSmd+8/vL/9tiQjQYxgkMni11jGxirtRDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytshwo4CDWaoTzKZQCac2z3kOSCe9CuexuWiQ8ZbiHdWSXva/B
	IQDkInlRttQmpsLr7APaQOnrhRx4vIU3skU4yCNHQVDEwpVlHKSDtGEmBT0LkJINWEuMH3DSVXK
	rarSBNYEI4YNcqAWTujvUxwoVt5Exbvip1a9R8+E2ySn6bgZqYFPCOIY=
X-Google-Smtp-Source: AGHT+IF9DA3K1n/dhePvzfFzpVBSG/hE0HFkSo+hk+R0r0yj/kZKXbSM2S8qmluaj9BUmbOqKtIVuy7jKBUS8RwFrT/Jx3REKKnW
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c41:b0:3a5:d2a:10e0 with SMTP id
 e9e14a558f8ab-3a6b0229ecbmr171859145ab.5.1730866683853; Tue, 05 Nov 2024
 20:18:03 -0800 (PST)
Date: Tue, 05 Nov 2024 20:18:03 -0800
In-Reply-To: <Zyrm8uw204eZW9wF@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672aedfb.050a0220.2a847.1b23.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_alloc_request
From: syzbot <syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com
Tested-by: syzbot+ca7d7c797fee31d2b474@syzkaller.appspotmail.com

Tested on:

commit:         72697401 block: don't verify IO lock for freeze/unfree..
git tree:       https://github.com/ming1/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=172b9d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfea72efa3e2aef2
dashboard link: https://syzkaller.appspot.com/bug?extid=ca7d7c797fee31d2b474
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
