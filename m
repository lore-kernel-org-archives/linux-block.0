Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5038143C69
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687172; cv=none; b=SKBk1AnFOqj37BEjOueDv6urfzg8NnGlbip1Fk8x1IXBY7kOTUHb2SaMSPNBAfZHDy99J+Nz6m6ROHq8MztT0inJV5FnQWX1hkEFRXxzQ/zI+aBiHSzuRdjfig5B2t2QgiB2C7JFNOUz1Jo5dike9yWP7YUTp4YDFOAWuHumKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687172; c=relaxed/simple;
	bh=2xLVoQahYDG/Yy0AV3UFbWueQ8rm1/faUzaNAFbsF1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRm156NOYGsXQ8bn/VkUs2pupsv92Dj44sjHlPpvWUCsFS+y0h22gjIf04m2KcKZu0+H3uadBIJbKwDA2h9HGW/WE2jfL1FnJB7tcP1XpGC3F0EdkWDIoUsU+CkasamNc9WjY/59BEhJOzBfR3EKbUJ893XpcAtqXTf4t8VwaEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6Ui+qa2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6Ui+qa2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732687169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/fjIUkQ27yd9Z8Hs7Zp53yDHC5wrDnKDcAqHCnJGWY=;
	b=S6Ui+qa299TYQR6gAAH8hidszYvW1Smlo//rvAyzgB4ajUxlR4D6bwFZgIAeaU5tUTlVVW
	6b1GoGclD328zgH3t4BZstTLX2GKyOLZLIU0DbLygJKAbZ0qQ/U8Lm7fRVuKTIRJ+ccO0j
	mpHaUiQo4cj5ZvHlOjOrByQA/a1YKgI=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-HhOjGBo5PH-wVPF_iZ2LIA-1; Wed, 27 Nov 2024 00:59:27 -0500
X-MC-Unique: HhOjGBo5PH-wVPF_iZ2LIA-1
X-Mimecast-MFC-AGG-ID: HhOjGBo5PH-wVPF_iZ2LIA
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4a46b27749eso1893420137.0
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 21:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732687166; x=1733291966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/fjIUkQ27yd9Z8Hs7Zp53yDHC5wrDnKDcAqHCnJGWY=;
        b=k/rZz5dGApG90tXSCR9VtRUv4WlF1ckNgX1z0j2VnB7oUZL7w1gL6hGh3YSGCtjEjA
         GvTkmbAuwSCJEMZChBrtkv7zQOUxfhTOX22ajLFSmE+6xSZasveMw6ZnyO52oaS37jS4
         4iSYs6wLM3IcIfzobfDyhbvs+7mpy3a3aNOFRABTedHbTK+ChQIm+pyBuWvX417vMbtf
         P8iYw5qMXlGHSU3KDVvM6ywKuv9NEoo9n6QNjgm9eh9caLCflHtFRPfTTcaICN78suyM
         iifBeciep+SWzI2SnFF9fMuzRt3lVQQdACsUZHzONKIAu8AHdDyOoGMBQ5iAw6DZaRU/
         AkDg==
X-Forwarded-Encrypted: i=1; AJvYcCXRlXmggBEqR8MYo7heyNznI1cNn6GMbyNglJNmVL+WqDdZxDZciY/w8P6kUtu7kLKjESnKRAakSVw3ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3QPMuE5x5Fe1Ugwq9aKPP0Cg/oBy3vg4eeHqUFQEmnEjF7az
	UL5y6Q1sIyOUr+aF3N96ySlNabrTcP+KhzOIETgBRABZVE5HnQ0KIktjxOpXm+EHCiR0M6NbTUP
	HT8uLjdT9aewufa259y7pL7+WGZT62CYKdBKWTnqSUI6XqpwnwRa7mfvBEoUGMYnUbdcNkXboMD
	o0HvzEiDLFkHZWLC+xI/vEG5LzbTtGS/HqMp3jaYS2AeZFps/m
X-Gm-Gg: ASbGnculTXnSzcytRCHqXfUn21BlWpvqPG3nIulU1ER30M7mZ2DCKrwTyi1duc0bz88
	r+omermnd+i93Z1V1u+jAy6UgpEQVj5G1
X-Received: by 2002:a05:6102:f0a:b0:4af:3f3c:515d with SMTP id ada2fe7eead31-4af447ba11amr2730466137.4.1732687166719;
        Tue, 26 Nov 2024 21:59:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2TQ15E4W1Ojy9i9gQaYjKOCM7Cc7smqBFyBhqtgupb5Nxx5IMgBRjxp6hWjbGXcqRPwQNKJwsG7sA0LlUiwk=
X-Received: by 2002:a05:6102:f0a:b0:4af:3f3c:515d with SMTP id
 ada2fe7eead31-4af447ba11amr2730459137.4.1732687166533; Tue, 26 Nov 2024
 21:59:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6741f6b2.050a0220.1cc393.0017.GAE@google.com>
In-Reply-To: <6741f6b2.050a0220.1cc393.0017.GAE@google.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 27 Nov 2024 13:59:15 +0800
Message-ID: <CAFj5m9JTrOdETvLY=pO=6oXC6NXPumAPa82281qra0sfakjr=g@mail.gmail.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_submit_bio
To: syzbot <syzbot+5218c85078236fc46227@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:37=E2=80=AFPM syzbot
<syzbot+5218c85078236fc46227@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D148bfec058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db011a14ee4cb9=
480
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5218c85078236fc=
46227
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
feb34a89c2a/non_bootable_disk-06afb0f3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/aae0561fd279/vmlinu=
x-06afb0f3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/faa3af3fa7ce/b=
zImage-06afb0f3.xz
...

> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report

#syz test: https://github.com/ming1/linux v6.13/block-fix

