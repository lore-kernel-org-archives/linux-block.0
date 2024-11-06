Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578CC3F9D2
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865175; cv=none; b=PKOY+k+4SeqcsNhUDxeELHslFCLLcHgfuwWNF44anWsaZYHYJpVn2r6zQTohJDXDkP5gLXALp4C4dwDL5sIzh7fKaODUqIcxhvDZmZhzTo3jZcVGEqB0DOesB2dT7xvRYf11HQAstQi7mJmRemT/36ceOsE0nzJxsvH8YRsJcqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865175; c=relaxed/simple;
	bh=5aE09eJAw+DWO/GK0+6zxMbedIgfEssWtZFIf9Rdfcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfU1qjIsyz2Nl6zPrhNaTyDBbClRU2OLMDHnszE8pj83Z+wV4dFakh+YbCKIR2L1VHTt+u16YT9q07Anc2V9OgvELERWZfv/AfHmwbuK+tdQo1IDZFvvWXnYRd/q469+r7fq7CDy0CSW7rzRcm0oI/IQB2CXsk1vmL4pAgYrJ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTk+ySqb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTk+ySqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730865172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TiMSpJJDatpGrOSJe9rj+NgTUiSiplFcFvJnfcnFCY=;
	b=PTk+ySqbMqcS7O7CB3Yqq4I1JOGfy1sDW3gN+I9oh0Eu00v4N+CWlD3I//ZvcHum2LWDCd
	V1vRI22QpMOJoh3nGR9LOCKqRGf/yDeM9DIAH2b49ASKL7HnGrzM2f+fSM57aVqmnjXePf
	BBfcUKNHuUmzxHmEsCtjKn6+VVY82AY=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-Wt0T0E-vNleDMpKgkfjkZQ-1; Tue, 05 Nov 2024 22:52:51 -0500
X-MC-Unique: Wt0T0E-vNleDMpKgkfjkZQ-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-84ff1850a9dso1480315241.3
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2024 19:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730865170; x=1731469970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TiMSpJJDatpGrOSJe9rj+NgTUiSiplFcFvJnfcnFCY=;
        b=gG8XF0PYAJlflX7sfWOwEor4B76o3nomFkitkwWlOIWun7/vG08o06hbTChUNYmvcS
         ztRQlX9flXvICiM7+43Ra1O9NllCybX3wDutP3w+Uql6jeigDn2n6i0C/vI5QlitpK9u
         V4R6QlVU8LTw+B8coCi4swjN8Ka49ZTZEIigfM9kbJqAWUxU1dlCv/3nfydYMYH5ICWT
         GdpA2PRjBFuAXOS/ojeTjFqrU5nLVl59b/AWUEXlkgWn85Sl0p+xWRaGzZa2N9Habl4O
         8saQt4HDsNsjKlfzb9XM4AzyXz17L97qO3KDI2GFNRaZjlDokSuaC4eMa2hRYa0QBvzT
         LNRg==
X-Forwarded-Encrypted: i=1; AJvYcCV8CpKHWMw1rFGgfN3Iny40U1UjNPoWcHpDcY8MFBSI60P6vjnpDv7UjRzMPZ9lblQKImdv0IEr0F749Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8B4zaACAAWMsijadLTzOrfwyQxvIFQ7MiURP/9kp7IuLWPg1
	3eEDY0r/54MByxQ9mRWfCY7nCX/3dCihN85RR8hXO98umu3QYlu11Bq64Ol4oktOLKLyNag6URW
	dblzIY3KKvCcgf5d2grpETRA9COxxdiRmvKHNM7Rzlmt6aLBPVnghRp4720hAGongoaWZGgE/2A
	wa7NOqb+1z3fMcqnRGB7q3wPUfkg/k7FjsZQk=
X-Received: by 2002:a05:6102:54a6:b0:4a3:a137:ba7 with SMTP id ada2fe7eead31-4a9542a6648mr20367586137.9.1730865170502;
        Tue, 05 Nov 2024 19:52:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhhXYpi0AcG+0c1Qcso/83tNVaNoAmn2rY1up2L2z39Hn10xr/7RtAngqs2ZydHcl7R3SGQT71bMWdEEDqwlk=
X-Received: by 2002:a05:6102:54a6:b0:4a3:a137:ba7 with SMTP id
 ada2fe7eead31-4a9542a6648mr20367570137.9.1730865170142; Tue, 05 Nov 2024
 19:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <672ad483.050a0220.2edce.1518.GAE@google.com>
In-Reply-To: <672ad483.050a0220.2edce.1518.GAE@google.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 6 Nov 2024 11:52:39 +0800
Message-ID: <CAFj5m9+1dZtWufO0xzGgWPyMjD1NZ_a-kfeW+Q3ujH_rnR09hg@mail.gmail.com>
Subject: Re: [syzbot] [block?] [usb?] WARNING: bad unlock balance in blk_mq_update_tag_set_shared
To: syzbot <syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 10:38=E2=80=AFAM syzbot
<syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c88416ba074a Add linux-next specific files for 20241101
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12d3474058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D704b6be2ac2f2=
05f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5007209c85ecdb5=
0b5da
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16d34740580=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/760a8c88d0c3/dis=
k-c88416ba.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/46e4b0a851a2/vmlinu=
x-c88416ba.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/428e2c784b75/b=
zImage-c88416ba.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+5007209c85ecdb50b5da@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: bad unlock balance detected!
> 6.12.0-rc5-next-20241101-syzkaller #0 Not tainted
> -------------------------------------
> kworker/1:1/57 is trying to release lock (&q->q_usage_counter(queue)) at:
> [<ffffffff8497aa7f>] blk_mq_update_tag_set_shared+0x27f/0x350 block/blk-m=
q.c:4131
> but there are no more locks to release!

#syz test: https://github.com/ming1/linux.git for-next

