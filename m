Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EF11C8FCE
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490900; cv=none; b=GRikCM2LXIw3fqZoeJfKO4i2bmA6yQ2yJhg0jmHbqYnhFHEflGpVOg58a7CUK53DsNRTm+2KTO4PZq7/trsrbDV2L9ObiBggYiwGoESuLkTPPVIyEheYe3Ijkh0ls7pmC0H9f0f70m/ltp+q6fJSq5yBadGg/wAizE/bKRgTs0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490900; c=relaxed/simple;
	bh=mWORNrvMu+2nkHTeDt9zqX1bQavHll1/ZqxiMzfxAEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avNSBHP9bo1VF3eHWhB1JRKy6n1uq2rp4Uq30fnMHG0uW59jTvhWJKl8W/uJAbk2w0jFHTTa4XkbbTWkU8r9QxHP4CfCz7WtMtXRO2gUU1c8jt4eG5MpQSvC8+aUybJQ0VvBS0GPb+73wpoUjcyTjT4wGzfYKekeicASgW0RfIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKceI0rb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKceI0rb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731490897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YL5g8uaJLXVNVsk28lhyUE5R+bbRfdqWI4k5okbTmts=;
	b=MKceI0rb9UWL8yEWS3ezHgRV0HBAQTVfMaSmIv4vXYBK+yiOk7BTZrtRXHrvMYhacFFYWG
	iAOtRfcPoc2W9QLk59+DnUPpQdmSNtpEh3zTcs/kRp0PEzMAvHDcvoCLEvjTQ7ova5z8no
	6k2oi08FAfuZGDxpEtAHkn+ij9OFAtQ=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-5loOshx7McCiPoQUJGvjFg-1; Wed, 13 Nov 2024 04:41:35 -0500
X-MC-Unique: 5loOshx7McCiPoQUJGvjFg-1
X-Mimecast-MFC-AGG-ID: 5loOshx7McCiPoQUJGvjFg
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-50d385a8f9fso2635254e0c.0
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 01:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731490895; x=1732095695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YL5g8uaJLXVNVsk28lhyUE5R+bbRfdqWI4k5okbTmts=;
        b=VSp4r3CO4GbC2b7RHt1pbHqt0HOEE+DmyItrGvUZSwZTrnEFrvi27PRKVLMlwY3q6t
         tLhfMYxluZJUA4nnuiAH2ohRZlw90WS79Q3Tck425u0vXx7d/9B+65RC/6B3YimxVPvP
         jbLvxdoO7/fypFo1NOxDbNR0XEzXL+nqDmohVhCq4sqBXU1PLgFzhdoynyw7AVBrjFDa
         /+bocVuJCo8AbrzcAJRpPsv7gC6Q22f6mZiDIgKZAH8E8CNs3ieP6YjpzarE554chhds
         cSRbO0NI6Zkv87aqr4f3akghjzVdKFbkXc2saGHpeYEQj/eaqhorEMC/uK4GHYUUH+xe
         dpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWppWV/d9wflpWTAfF1bKJN28lki3akmLOEn5/Qaf/DXPpSDNeMjXICYV2uzz+emRXDXo6PXXAE8r4B/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/GCNomqYEo2onfKbrr1NkFTGJijzN+53Gi5G1dw1rlVFEX4Kg
	CsjYPUdoskbGpJgA/bHE6n6zoAtUloarsqMlO2hkAX4EPuUciIFUuHxp05sBu75t1ZKhY4wXsRW
	2c7S8e4db0jbM0/TJ3vJE/fIQXpaX8EMTQRYPioZgcW/SIdEGHnTTfqGPL35tF4QbbMIl0dGCYU
	K0Ygr9q9gy3M7NXcyLPLVhcfI8J6/iYm4Otkw=
X-Received: by 2002:a05:6102:4a9:b0:4ad:4895:ce1f with SMTP id ada2fe7eead31-4ad4895d3f0mr1376607137.17.1731490895276;
        Wed, 13 Nov 2024 01:41:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmtPg8F+hYG3+YJL00GFGvfj0vnU1ejxbK+vnoIcAzfsluoAugZllq4BSeDyoNJ5JixsLlnN2VAhxGwOo/DzM=
X-Received: by 2002:a05:6102:4a9:b0:4ad:4895:ce1f with SMTP id
 ada2fe7eead31-4ad4895d3f0mr1376591137.17.1731490894919; Wed, 13 Nov 2024
 01:41:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67336557.050a0220.a0661.041e.GAE@google.com>
In-Reply-To: <67336557.050a0220.a0661.041e.GAE@google.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 13 Nov 2024 17:41:24 +0800
Message-ID: <CAFj5m9+GAv4JPX=ABgwUo7RSSZ4zNsBKpiJOfuxmmwg+GDP3wA@mail.gmail.com>
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

> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git
next-20241111

