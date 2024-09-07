Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6874F20C
	for <linux-block@vger.kernel.org>; Sat,  7 Sep 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725691076; cv=none; b=Seehcn3p+8LNaSecL3et8pd/n5FCYcY3xPm+/Hsa8NxAsjmgcgz8bPVGRJmdzI80DvGqs6ve0k8ilgJutzDcGLvG6q8/Ffzt9LwDWa21vrB2qcH9l2r7Fqpor1YOyScKLrlG8uueMjqaK7L0TUNtC9UYxe6UlrFHVfoC6R5eers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725691076; c=relaxed/simple;
	bh=B+4JSBKI1bUBYQwbvt07wp0DYctmABf2lqugBefZ7Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXLSCTwxCDSJezcCGIy7BkZT0J88XyWr8gsIT4e8HstYhO/5+4oGnzOUHTG1jPb/tHDTggBX0/PnLO61L9dvR81s6KqS9Jm73R3i1WJI+GD7Q4SiBfS/5pIm/9JZG4czTHxKioBlauV37HFmWpjJWVZ+JKA2NulWMTudYEwkxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPunyF4/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPunyF4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725691073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjQU1QeLt59MiSHO48W4SSULpumhuxHPIcuQGZ8Goe0=;
	b=PPunyF4/QmCS2ObzDknNX/dbD7shUeLlL+Y91vtDqNviXFNOkOoQf/sYoY5MsWGFkkdmOb
	3yMFMPvgcf9S/2AYGhj6OGXa7ulc2xL/+UGiz6s+hlUQhKW6FgHdePDD9k9ZAGVhV4kDgg
	8y6YngQPFmqUTaPiN6QF9V56DeXh3Jw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-RgleAGqiOlyjr7S4LpsyPA-1; Sat, 07 Sep 2024 02:37:51 -0400
X-MC-Unique: RgleAGqiOlyjr7S4LpsyPA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7d65a13582dso2219535a12.3
        for <linux-block@vger.kernel.org>; Fri, 06 Sep 2024 23:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725691070; x=1726295870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjQU1QeLt59MiSHO48W4SSULpumhuxHPIcuQGZ8Goe0=;
        b=HoC/xD5me3zXOwXpWyMSPdBV3g/UkMc8ubyApllnZDQtcLFNNoo0d9bEO0MN9oM/6A
         vfsKHTvuH2g2wekjMm+1ApDMxYXJAPKG7xOS1eDnDRW4GR0f0O/a7NEwYRSokRruJDuq
         lHVZl+oak0GCQ29za9e+6a1dZREkujifdG2+fAOr0/T7QSMLrbvsUjNmLyFSRb+3dp6e
         PxU1t0AJSro/sgmYzSKXtXTIhIBGZtckF88XZrlCM0CsI+My6MrKbU0kwVtXH7mhIQe2
         7dAtidvgVF7tSlkUALj5CS8hk5tkCq2L8uPX+Y8lcjE8JXuGuAc2t894sJootfvLSrRc
         8H2w==
X-Gm-Message-State: AOJu0Yy6PADfEab3JvthGY/D/VKu2aJxFzGnHlaJ6GdDA4qve+ZexfuB
	EJUxgJ8l0//RpVC1T91G6BmorfqTCdwewoRB+i3ujhpT2xipBttnxgFE6eex61Cbk/fugtzuYul
	MQOY5ljTRpGCfKXPg0iFTpHJEboChjA72PLKHugj1fU2PfYaS743e33H7mFIYj4fVpEBYJeMdVs
	Zb+thiW03xCl38AmNlk1J/4OWmt4Ejq93muBY=
X-Received: by 2002:a17:903:41cf:b0:1fa:9c04:946a with SMTP id d9443c01a7336-206f04c9dd2mr64553205ad.1.1725691070533;
        Fri, 06 Sep 2024 23:37:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ29SdijpTBv7ZRgvH/AH/T9uuUK+QtzHvNpWO62vl0wkkG72JzN2WeUlkoOFIKoSGEVJrk+pqrx/8+MDbUhQ=
X-Received: by 2002:a17:903:41cf:b0:1fa:9c04:946a with SMTP id
 d9443c01a7336-206f04c9dd2mr64553105ad.1.1725691070238; Fri, 06 Sep 2024
 23:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902105454.1244406-1-shinichiro.kawasaki@wdc.com> <x5e7cl6iupvspx6eadustxbzt442cprye77dh7u2rjl32xajg7@egnrpr5b73so>
In-Reply-To: <x5e7cl6iupvspx6eadustxbzt442cprye77dh7u2rjl32xajg7@egnrpr5b73so>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 7 Sep 2024 14:37:37 +0800
Message-ID: <CAHj4cs-hhV0S+BmLyn++LSE=V-hgE7JTqQDJYtxRjAExfRwuMw@mail.gmail.com>
Subject: Re: [PATCH blktests v3] nvme/052: wait for namespace removal before
 recreating namespace
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Nilay Shroff <nilay@linux.ibm.com>, 
	Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 4:22=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Sep 02, 2024 / 19:54, Shin'ichiro Kawasaki wrote:
> > The CKI project reported that the test case nvme/052 fails occasionally
> > with the errors below:
> [...]
> > To avoid the failure, wait for the namespace removal before recreating
> > the namespace. Modify nvmf_wait_for_ns() so that it can wait for
> > namespace creation and removal. Call nvmf_wait_for_ns() for removal
> > after _remove_nvmet_ns() call. While at it, reduce the wait time unit
> > from 1 second to 0.1 second to shorten test time.
> >
> > The test case intends to catch the regression fixed by the kernel commi=
t
> > ff0ffe5b7c3c ("nvme: fix namespace removal list"). I reverted the commi=
t
> > from the kernel v6.11-rc4, then confirmed that the test case still can
> > catch the regression with this change.
> >
> > Link: https://lore.kernel.org/linux-block/tczctp5tkr34o3k3f4dlyhuutgp2y=
cex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd/
> > Fixes: 077211a0e9ff ("nvme: add test for creating/deleting file-ns")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>
> I applied the patch. Nilay, thanks for your help!
>

Thanks for the fix, I've verified the fix on the reproduced server.
BTW, after the change, the executing time also reduced to 7s from 22s


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D294
nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsystem) [=
passed]
    runtime  7.759s  ...  7.673s

--=20
Best Regards,
  Yi Zhang

