Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CC6181D1D
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102491; cv=none; b=N3fCIxLMkvDFM82+fN8ePQexSBxAZayhimTYDFrorOHMadP3TIOCOs6zb1wCGd6OVOxl6adGSMTVwbljcpnkO/2WsjOot6+cFQ5Tqq22o9/qjnJfYbUko29kqFhr8JnM9je8WtBxMvppKhXW6AQnB6SrA8AovHg//FObHM7pSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102491; c=relaxed/simple;
	bh=eg+MIkwiEVxSkImTnP9/42HiBWABCU3sNxsgUn+kexk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enIgBjWpjFxjG2yi2ePDuDeCM1D+Tla5GnTHYHdWI7XqWpqcEumIDYp9v9VwBoutuZMgs+mm4+anQ4t3R1iunuX6ZzcQ1rgtzx96/UQEKxuxh1DhSqGenK5EDzaXfAB3VF8oJb27yQJWZDbYWxQ8mMnA9GPuH+8HJ7PZ3Yygr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BrzIFDm5; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BrzIFDm5"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62a08092c4dso12790187b3.0
        for <linux-block@vger.kernel.org>; Thu, 30 May 2024 13:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717102489; x=1717707289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHhnEY8EBCWzfeI4r7ZxHSk1OcUfnIeP4X4PVOCwAbA=;
        b=BrzIFDm5u1OGrheVMzkYq0tj0rbabzbKf0pTE8oxaIY+RyN0ZEytQzCrnnJreDPOIg
         7TQl9X+VZ0fTaRlX8iqumOhB09WMOpzndyPEMdEykX7NyENEaOKkQZfnijFXjWEozH3z
         8Jpd+FQxLvzyhMT7cBq724wOfUQslHfL7cnw/ncQNudTDP+XWoyKxjHiBawIxliDwHlv
         6Ck785H97sLYf86QFP/eOO/nxuZAAO/OzLO/ClrGsCTjSBbC4T16jgjO+ijjmzjwY+8e
         nRz9WgFbGVZalnPuTw229RHuigu3tO8iUWyIqbb3VCvm0OPGAkN25fTRlj7b9Rfjy5qD
         QNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717102489; x=1717707289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHhnEY8EBCWzfeI4r7ZxHSk1OcUfnIeP4X4PVOCwAbA=;
        b=cYrF0I94sgQ2gBnMil2N+Jh4amrQrd9KOkuKNXN8+5VueQirO0RpZLMi2zbsfsU1ZF
         PQNHTe/i+w2kmN48iHUHOsUViRYCgrFF1IFOESnqTgyHLctI+Kp/AOky6rjtgu6sB3Sr
         TG/XAevXaKIOsRJhSIXp+ngijt+sASbdZPC3SlP5E/as8yZ70a/Lu+zob1JB5GOR3Do/
         FL8Wc0vPypBEWYpVERl/N+eNfYQBXBFEeAEhoZOq6ybLcoqseMSLujE7irS34os9BP4t
         PCz4nQIP2eCD9VtMjge1FWRcmi8TYZSAs2cyJt5vRIzf4vaoVR8fXXbQCggUagibfC0w
         eNxA==
X-Forwarded-Encrypted: i=1; AJvYcCXV9qRAn3AmQphX/AwiXx+9th78OjjIfSkohugL7xItu9Xyj8zOUEvlPMhxAev5DLUP6g3TH3okIRLYfheHp4Jxkt+xItkw11+Szbw=
X-Gm-Message-State: AOJu0YzAlld3gBmV0eA49YnHJPLhohL7ziyTzBt4d4w1N4lIaWf6p7pm
	dQ1pxLd36Bc6j55t8A2c9BdNosA9VOvHzPFfIpRQel4WjruG3BsZ0wyPn2mpPz2jyrcHoBfQ0Z5
	n2fLV9d+OSTF8rIftgMsMkUgTphvVlgm7KWoN
X-Google-Smtp-Source: AGHT+IFGAao34yd3dClXG2DXw+Iy5chVgrvzZN/oG9tpxQvuE1hMom7wnNuLEmL3KD2ppvrBp7AAzHWyXJlgtWi13+A=
X-Received: by 2002:a0d:dc83:0:b0:61b:33fc:ad0e with SMTP id
 00721157ae682-62c6bc3120bmr35459887b3.17.1717102489115; Thu, 30 May 2024
 13:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716583609-21790-1-git-send-email-wufan@linux.microsoft.com>
 <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
 <CAHC9VhRsnGjZATBj7-evK6Gdryr54raTTKMYO_vup8AGXLwjQg@mail.gmail.com> <20240530030605.GA29189@sol.localdomain>
In-Reply-To: <20240530030605.GA29189@sol.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 30 May 2024 16:54:37 -0400
Message-ID: <CAHC9VhRySQ0c16UZz5xKT-y5Tn39wXxe4-f7LNjFY+ROGGxpaQ@mail.gmail.com>
Subject: Re: [PATCH v19 15/20] fsverity: expose verified fsverity built-in
 signatures to LSMs
To: Eric Biggers <ebiggers@kernel.org>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 11:06=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
> On Wed, May 29, 2024 at 09:46:57PM -0400, Paul Moore wrote:
> > On Fri, May 24, 2024 at 4:46=E2=80=AFPM Fan Wu <wufan@linux.microsoft.c=
om> wrote:
> > >
> > > This patch enhances fsverity's capabilities to support both integrity=
 and
> > > authenticity protection by introducing the exposure of built-in
> > > signatures through a new LSM hook. This functionality allows LSMs,
> > > e.g. IPE, to enforce policies based on the authenticity and integrity=
 of
> > > files, specifically focusing on built-in fsverity signatures. It enab=
les
> > > a policy enforcement layer within LSMs for fsverity, offering granula=
r
> > > control over the usage of authenticity claims. For instance, a policy
> > > could be established to permit the execution of all files with verifi=
ed
> > > built-in fsverity signatures while restricting kernel module loading
> > > from specified fsverity files via fsverity digests.

...

> > Eric, can you give this patch in particular a look to make sure you
> > are okay with everything?  I believe Fan has addressed all of your
> > previous comments and it would be nice to have your Ack/Review tag if
> > you are okay with the current revision.
>
> Sorry, I've just gotten a bit tired of finding so many basic issues in th=
is
> patchset even after years of revisions.
>
> This patch in particular is finally looking better.  There are a couple i=
ssues
> that I still see.  (BTW, you're welcome to review it too to help find the=
se
> things, given that you seem to have an interest in getting this landed...=
):

I too have been reviewing this patchset across multiple years and have
worked with Fan to fix locking issues, parsing issues, the initramfs
approach, etc.  My interest in getting this landed is simply a
combination of fulfilling my role as LSM maintainer as well as being
Fan's coworker.  While I realize you don't work with Fan, you are
listed as the fs-verity maintainer and as such I've been looking to
you to help review and authorize the fs-verity related code.  If you
are too busy, frustrated, or <fill in the blank> to continue reviewing
this patchset it would be helpful if you could identify an authorized
fs-verity reviewer.  I don't see any besides you and Ted listed in the
MAINTAINERS file, but perhaps the fs-verity entry is dated.

Regardless, I appreciate your time and feedback thus far and I'm sure
Fan does as well.

--=20
paul-moore.com
