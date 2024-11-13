Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B091C8FB3
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489290; cv=none; b=M89guP/As95qkCmxneSsBbE2ddnYQwGuLN/qwRR7VndB5YIjQ9FXuKSJm4UmBTvtyxpLRY5f5d9gYUPbQezh1S5qsYoUXln4RFirATZONhjrLDodehp8trKuyAsVqN2aF/1PZ0e8Fy4n5N72i3ZP39y0iQClLqKuV612w2P92gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489290; c=relaxed/simple;
	bh=0R+6XRenndLMIJM9nY3chba05E+5sqc+/i8cxpXHfIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GO0cwOdBU/d1Ko91qyH0YyPYxwP1yB2l40DsCZbLt6uACrpY2Jt8RrGYWNYhk67XOShHaZr11o/cAIVWfeNKzWJXE3TnqoUmQhK3ZQISuA1I7MVUwyHq1XYvqsqZu54tjaKwGOk/lbYOTqTTnVLGu0kLh+E6ePO0wqQIyazceiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ilLXoQ2/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ilLXoQ2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731489287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bo+a2oJM/DzF7/2w/lozMNF13YjGxFBwuRsrvmeNqLs=;
	b=ilLXoQ2/t+LrTXd0GAUMp+YamQZw1LgdX5G5PoVj2EkScASrIEloadJmBASL1KOrflRYzx
	C7JmWcEbgkLWKHVsjOyl0qTV1fxxCId1wUkBVHF8yVkMOTRne+jd9ep6K254toNXy7sIDh
	CyoNP9P5HvvYvHUWLW0jDQdIBy007YI=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-ScJE62PzOTOuGLCjXpp4vg-1; Wed, 13 Nov 2024 04:14:46 -0500
X-MC-Unique: ScJE62PzOTOuGLCjXpp4vg-1
X-Mimecast-MFC-AGG-ID: ScJE62PzOTOuGLCjXpp4vg
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-50da7722724so705416e0c.0
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 01:14:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731489285; x=1732094085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo+a2oJM/DzF7/2w/lozMNF13YjGxFBwuRsrvmeNqLs=;
        b=B71xNHkngOp9Zc14bgWYqvTSNBl/sRrefYS16og8qn2YCuhYllVSKBXr1rI3+MX04F
         AFGvpMciD5ZkEOY2BtKibJi9X829IlF+KJAfl2c1ukBAfVHbzjQ+GKpkrQY6Im05dZrj
         5peO3egMhS1+YzDgxqG3rV3DWMj/F8HqaPjJDgjWC0LyryJMOlti5TwzYvNTNe00zNRX
         K+AzNCow5dTMa9S/Q7MJJ77Y5l/bf7pC5CEBt1sJHgM00ism7H8Ri8Hw9fwiU1wYRRSf
         rdM9lK4y4P1VbUjxmN5YAPTxbCC9FBvK+/8b+MyC/NOmRDGn3mPvqUv54DCYxFYmJeRr
         Alig==
X-Forwarded-Encrypted: i=1; AJvYcCVihXPjiIcE1RVRMRqG9YSEbcbJIocLZMi9hUOh8z4lfAreGgyhfhjYQuq2GFyHrEmS+pcI9bT3x6r7Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzMjXzVqz6Qes2pv0EE0oSBfEAYkZN+K37jJHZQkHEQjjMSSus
	BeKU/h0BEQnUpBWkBLhCrH+jHEUrTihKPGy3BsJ0JVGohRWkarqOOIvPdR2+uC2KCK6RRFQIpQg
	2XN+rBBH57RVv18DeHavYi+hpoK5RNgKZLNCpgCI2lQHTeNsjpreOHi8DUy/SJ6ca6ZOSp1H9Z4
	CyHQsm/M+zr4oln0X0MqHunxdO/2jUPGtpFR8=
X-Received: by 2002:a05:6102:3f50:b0:4a4:92f7:3611 with SMTP id ada2fe7eead31-4aae22bf83amr16647604137.12.1731489285755;
        Wed, 13 Nov 2024 01:14:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOl+1geTz+2YuwUXdn5bVXsVX5Z+UuowifTsSD86yBEMAnagBRJMr3rM3zLY10n9GT2KGtLlMIc44W6KxLIHg=
X-Received: by 2002:a05:6102:3f50:b0:4a4:92f7:3611 with SMTP id
 ada2fe7eead31-4aae22bf83amr16647598137.12.1731489285487; Wed, 13 Nov 2024
 01:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67336557.050a0220.a0661.041e.GAE@google.com>
In-Reply-To: <67336557.050a0220.a0661.041e.GAE@google.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 13 Nov 2024 17:14:34 +0800
Message-ID: <CAFj5m9+j=KNhaRruRZ7p0Nnt6PiqOVQN00vhgcwEgfKji=rJEg@mail.gmail.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
To: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 10:30=E2=80=AFPM syzbot
<syzbot+867b0179d31db9955876@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16b520c058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D75175323f2078=
363
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D867b0179d31db99=
55876
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11b520c0580=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9705ecb6a595/dis=
k-929beafb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dbdd1f64b9b8/vmlinu=
x-929beafb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3f70d07a929b/b=
zImage-929beafb.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/7589a4f702=
0b/mount_2.gz

...

>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git
 master

