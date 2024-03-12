Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAA58AC4
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249139; cv=none; b=nMujt3kqHjYj7edYUz3QkfHIxijc+TsNqt7J33BCKxnBuUxt3IrGn4PWZrgOEpQMBQrmK8KyoUi0+PRq7bt9PwM9pGlrQ4AA/iNl58YQQI8LdgA9c/Zw5KYGw6fAAlR3mT7Jk0UoAfmFeAMrl78b+G2EchJ8PVT6OWYUCjMKmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249139; c=relaxed/simple;
	bh=5rt+RWbBJPhAUl1uqDwh5UWlve/OPz4PeCvfGqj3MHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYgnm0lD2Zf7jhg+FAvyTii+0yUXQ1pnYPVuKW7aLJX7/vLkfngdyLpRoQZZkSRylcygo1GBEohooamkBvi1LFTs/EPUhzITdxEATlII0D+BcsSyJXyzDAlw5KHntOjYPZN2YUWf950xq4LLezs4zCOxLVpkTHtD8CNPqTaRUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AeF5oxQS; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AeF5oxQS"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so4503531276.1
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710249136; x=1710853936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGm6l1YRLh5BPGXSeJhTa5Xkczn4uT6yuT0rED+ytkk=;
        b=AeF5oxQSugPKh8jPGo1deH2heQlPo67Gx8uPfkXw+A6XRCMxKrmhop4RTi2Raye9w5
         td3/8L7cAv6COx2n55EwL5JReK1i4P5PPiYypoSIGkwLVHIPPS/nIssVhO6EvVoiSdwa
         25PWyN9KMeoyTR/gJFW6FP+77dd1uhGAFDEy7I0P298m/ZrujwVNmzfBJ57RnEVJRnz7
         hFIHzsvn0BzaDpDVS99DEsWFQFKYhVbuQt8C8bZjIr3opLAh5ipZEgkQMXlkanYGp1ue
         yhcJEtkhHMAz7ALFS6U3xG0xIZj2H6Bi1chBbMLE5wbZkq+AccKzNCXCc5KD/mfWZoRg
         cqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710249136; x=1710853936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGm6l1YRLh5BPGXSeJhTa5Xkczn4uT6yuT0rED+ytkk=;
        b=mG4Ho38e6mpJd02ZprVgAfZXlw/PaJHpCaX0q6Vk3qLeOJ+eBxFUMeRGTgByMQN9po
         +ri9ldlr7ThKx1S/vOZkdHtFaZ9gScSfI9/Mv6CNglmzRLJglH0SoQ8FuziSrERdjZoO
         4TGL5WBqMf8Hu6ZyQ5JgebJDbxh1Ie8vbi6yZgABpZj0D+TLA8QY+i7dlHDNHB7gEMy4
         r+nbRkctPp7pRXCTob46kU+7fsoWNWQ2iSABDiRq97POJ2Vc4DROIxnGUCceXsEwkNxB
         U1jCyc9Kw6sI5FkW14BRMxcBO4GjF93Pp1UHkaiQbc63DJxJioVpIQqmhrOzRfVkeR4F
         phfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCbTcCY8dTIUY78j6REEpRNzCqUc8IL9Uk4HAss6yW9nMBfISU030NaB16OcuSjJFaM7IPh/dmMZ++Andpdr1RRlnPCFxWRgaSMNU=
X-Gm-Message-State: AOJu0YwqgbENrAwCVIj/JuXKrxN36XrtV53ixiI2/nAZMfvO5MKZCnNj
	gwKTot0VPssnC+I9It/IgiNN0zzDaXrJVfKpvoUw6/esyaXk/S+sjQ1p5CGFjhOY1T24JNvOqpo
	eVhLB3dzds043reylW5bdbloP5gunswEzLh16
X-Google-Smtp-Source: AGHT+IEdiOBkJ+adeSqv+rNybEPwNkGGa7iFCLcf94f4++BXPp1TK3JUSZqCbU2Yvqne0MvrzB+F7Mt8oGlgCeTEfL8=
X-Received: by 2002:a05:6902:2841:b0:dcd:b806:7446 with SMTP id
 ee1-20020a056902284100b00dcdb8067446mr6722695ybb.1.1710249136161; Tue, 12 Mar
 2024 06:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1709768084-22539-1-git-send-email-wufan@linux.microsoft.com>
 <1709768084-22539-16-git-send-email-wufan@linux.microsoft.com>
 <20240312025712.GE1182@sol.localdomain> <20240312030712.GF1182@sol.localdomain>
In-Reply-To: <20240312030712.GF1182@sol.localdomain>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Mar 2024 09:12:05 -0400
Message-ID: <CAHC9VhSSWNa1qwZrWtj-ERFjN9QKR7fz17yb9903P_a2k6ewaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v14 15/19] fsverity: consume builtin signature via LSM hook
To: Eric Biggers <ebiggers@kernel.org>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:07=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
> On Mon, Mar 11, 2024 at 07:57:12PM -0700, Eric Biggers wrote:
> >
> > As I've said before, this commit message needs some work.  It currently=
 doesn't
> > say anything about what the patch actually does.
> >
> > BTW, please make sure you're Cc'ing the fsverity mailing list
> > (fsverity@lists.linux.dev), not fscrypt (linux-fscrypt@vger.kernel.org)=
.
>
> Also, I thought this patch was using a new LSM hook, but I now see that y=
ou're
> actually abusing the existing security_inode_setsecurity() LSM hook.  Cur=
rently
> that hook is called when an xattr is set.  I don't see any precedent for
> overloading it for other purposes.

I'm not really bothered by this, and if it proves to be a problem in
the future we can swap it for a new hook; we don't include the LSM
in-kernel API in any stable API guarantees.

> This seems problematic, as it means that a
> request to set an xattr with the name you chose ("fsverity.builtin-sig") =
will be
> interpreted by LSMs as the fsverity builtin signature.  A dedicated LSM h=
ook may
> be necessary to avoid issues with overloading the existing xattr hook lik=
e this.

Would you be more comfortable if the name was in an IPE related space,
for example something like "ipe.fsverity-sig"?

--=20
paul-moore.com
