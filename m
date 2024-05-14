Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47EF18131C
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716224; cv=none; b=exGQjchwxiV8R9pkW1i2rwLfXdM7s9P95cYn1MMKmnbiryHZn4SvnlshQ06CKpZBuZ6Q4aMRtM36Mhehp/52K33yXr+G+S+izSSnaHMynl/ZkDtrebVujFJtwQEynYWagFEM1x4NRHLyHkNuuY8efXc6UCIj4Zj3m4zbruml4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716224; c=relaxed/simple;
	bh=xCGobSiEZZKVIGvtlb17VkXzrJav2cpynpYO5pxHsTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fs2czrxxGI0radmSkmESPLj67Hh75ERXhVQ7k38fb0cFG6SsiNcVM3ELCOmz2LrB1H+K2FjysqXKQdDwrNpvlOBKF3PBSi7aR5DfjRB1jNcHpW+7elPckJPQAqfilsHlzIlpdXe7RKzh+bOgHk3eAAxICVu1dETHb+DAQQd8V1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JF+Zbwi4; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JF+Zbwi4"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-de60a51fe21so5994393276.0
        for <linux-block@vger.kernel.org>; Tue, 14 May 2024 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715716220; x=1716321020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkp4I1/EP34xCsXz894jXcfOHu9Xc+3+8P13l0GVrxE=;
        b=JF+Zbwi4A37UVjOELqyuSxI5XF16PnHoy/clBUi83jiG+YRodmecFW52qZKz4Kq726
         4PTOrHIBMXKsd7NPB6GCHO6oGJCvxjHHJaMw38WnlU+B/cm4WbJETzVMZ2TafdoTfo4X
         rBPSV09s7/igRv/0AE1D7RnilAUdFI2LXQQWFeHNyDVUgFRiRFPHAJLU+iEB4N2/widJ
         cASIqHwqPxifXEwwXws+q0QEDlDblFWXqGYAXJmXfXw3VXV1KCegxMxVhRx0XCksA/sB
         1VxkK02/WpwjROj2m5sVqBTGjVDYmmzXsDovMQ2t1pd4IrqPTv+jT8xruRy07h+w1pWB
         IsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716220; x=1716321020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkp4I1/EP34xCsXz894jXcfOHu9Xc+3+8P13l0GVrxE=;
        b=YLI0rXd2yrXT9dNJVmlCJbAmzT5JBYzCAbmHQ2nwlihACAdKTYXJhOqf5i8+5Le5RL
         3dWZNUJ89EWcEIjA5qKu7lTJgSfiGkPEgRWoZTe/pn8EeelZLPBo3kaWcoVF0aW1qikw
         uejkz/7qaj9E8EhGdtyosw/RddD6RHmjnTyZNiBa8f/G3B4h2aEZ1/kfsbBvs1W94OLy
         7cpffTOmj3XESupbGPip4N0ZEkNlM9CEWPOJgUs3hZWXD1y9V9Ck7HWVmdlCkytMKpcm
         +kC76r9DSM0INAUagtfFfJK+kEerGE9AsuTXpn+fOayEx+Houm5X3XHIQnFsV71Ex+wx
         QgFA==
X-Forwarded-Encrypted: i=1; AJvYcCWPmREMirqYTcWpQG5CKXquoxyDu/TJjefMdUVohQIk6OC8/941sXIm1YidLSbeEU13TYA1FeyQ9gtCxLG2qoF38Mwy+oFX5wEH1Ec=
X-Gm-Message-State: AOJu0YzYmlSBoyu9wtVrsCZAP/5/WDvkULSJehEN8YfgY96/dynWGxaX
	Ea4lxIkQkfEl3mLKx4jxUTYml1Aa+pSe/Yxk1pzxHs58+3Bnw6Si4dqVYmMADwFVt/wnshOvB1x
	HhFg0fbjusF0l5E+6tC/iurbTQkjElPv5SYRf
X-Google-Smtp-Source: AGHT+IFWIy5UA2F/+z955H9aT1kkILcAstR0rQ1Z6k7ELYYSk3poMncJ+M812qPYw6M0u0TMB7AFkJo/BviRvM2KHkE=
X-Received: by 2002:a05:6902:218f:b0:dee:8da8:aeb7 with SMTP id
 3f1490d57ef6-dee8da8b092mr8719461276.25.1715716220678; Tue, 14 May 2024
 12:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
 <1714775551-22384-21-git-send-email-wufan@linux.microsoft.com>
 <ZjXsBjAFs-qp9xY4@archie.me> <ab7054cd-affd-47c3-bd98-2cf47d6a6376@linux.microsoft.com>
In-Reply-To: <ab7054cd-affd-47c3-bd98-2cf47d6a6376@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 May 2024 15:50:09 -0400
Message-ID: <CAHC9VhQewDL4cWXSiAgzvrHa8N5rd6TbhSCM3jRp29=Kmr3m-Q@mail.gmail.com>
Subject: Re: [PATCH v18 20/21] Documentation: add ipe documentation
To: Fan Wu <wufan@linux.microsoft.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, 
	axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 4:13=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
> On 5/4/2024 1:04 AM, Bagas Sanjaya wrote:
> > On Fri, May 03, 2024 at 03:32:30PM -0700, Fan Wu wrote:
> >> +IPE does not mitigate threats arising from malicious but authorized
> >> +developers (with access to a signing certificate), or compromised
> >> +developer tools used by them (i.e. return-oriented programming attack=
s).
> >> +Additionally, IPE draws hard security boundary between userspace and
> >> +kernelspace. As a result, IPE does not provide any protections agains=
t a
> >> +kernel level exploit, and a kernel-level exploit can disable or tampe=
r
> >> +with IPE's protections.
> >
> > So how to mitigate kernel-level exploits then?
>
> One possible way is to use hypervisor to protect the kernel integrity.
> https://github.com/heki-linux is one project on this direction. Perhaps
> I should also add this link to the doc.

I wouldn't spend a lot of time on kernel exploits in the IPE
documentation as it is out of scope for IPE.  In face, I would say
just that in the last sentence in the paragraph above:

"As a result, kernel-level exploits are considered outside the scope
of IPE and mitigation is left to other mechanisms."

(or something similar)

--=20
paul-moore.com
