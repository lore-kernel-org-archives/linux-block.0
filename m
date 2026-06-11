Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975EF1DC1AB
	for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 07:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163185; cv=pass; b=a1jYLyJA2zKTWchE42kCbnWlYRNVAmJbEdI3P4hefTKcPPMtz48glUk/HPK63Np5pnZyv5XBI2E/z5DRZH8skefzblk8B2YDso0NjC26jbNk+34+TKRwBSfXvgjiYI7jz87fOSbIYpiJdvu7tUoHX79Brc4KNQwhWPlt13c8vOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163185; c=relaxed/simple;
	bh=Bn3EnBHfkP6gImyPH7TD72VAQaqad5HMgVHCeA3f1VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRze8jfeUh09to8bvwo4wjvEzkYpqllGs+FVj9I5A1Y7eP9EYzPu+g4HPRy/NJHqUIvaPCUhWM/PDgDwE1firBAc4W3I3WQkvMUoh+B1e8bc4dLLHTpzb0SnS+BW7ku2gAsi5zDphfqPSPWT9p9Cpy+1RDBW6qCbJXylSaYIwe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6D09883; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6D09883"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-307b668e1f5so381043eec.1
        for <linux-block@vger.kernel.org>; Thu, 11 Jun 2026 00:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781163184; cv=none;
        d=google.com; s=arc-20240605;
        b=TJ9Z/AeoOzxajUMmdm+5YY7vXlBHYKXKUomMfH7Jw8wy6s4EmETcN5N4HAjMHxgfcg
         tb9UiUE8HsOuejLoaDWru1SDFYn85zgSLGcD7Kk6cAnCd8EbC85DNlePh+KdcR1LZysf
         1Vq+WpC3vs/5Opg1dhtdkkIVVd7gr2vAd5eEVtPUtKO0uomJYCiBQlTXXWtSFFK7h5um
         lY4qoIJPsPizLAsEYjEgwEBQDIcx6c39hxHIHLQjz7NYJajsLHOdIjRn9TGIHr1M51pT
         9sGOckYhLVe+hGqjcladuSK+DIzurT4ndFPZJNaZ3qtXovq6epXCRYgokFGew1SjcS93
         qmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s7aaFi9ftWqsXPgCpvnLACAdtxJeDiLmPHFUiwt4nVA=;
        fh=XuMk90iENABSNy9diXoJL58onWM259W1Nw8dsjzPhS0=;
        b=JxISBZawgtjzgmeJWslwzapmttbgNIkbf+0E9BFyETREPPHbL5sKwloJML1Yonl7u6
         SnRF5OzBcAaVV1sQbioRgeRiV3PkgSbxx85UGW0QNJ/l0vjjcoZFSTm7Sqtmm97Kh/ZF
         bul71SsXbVQezEEOeAEEP61spO9ELNVE7bKWsaMyGa/LPlUuagw6k0PGNjYuyKlbysV6
         F7x807J0qmQIeQrnrL3zGr7s69z7GMc4hLOMZdPK9XG2ZWLpHqI+Cp6d7JSLXdi8y2pM
         Wvwma/y5bYF7Y1qG8VVuj7YT3uh/W8muEO6YxCCwWJ2whnhq8wQZI02wLieJsERAw7/m
         Qaew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781163184; x=1781767984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7aaFi9ftWqsXPgCpvnLACAdtxJeDiLmPHFUiwt4nVA=;
        b=H6D09883bLMFNUI6huqoQxBNzoozIz6Ty0Cni0y5PVzMk+P9O1rXg4gxpvDTygxN8l
         +z84uWORF/8RsEMc+lkiIddiLdbue2QlcTWyNjYX66rTHz2swxHGkZuizymPDAB4HLqB
         5levxSVirtd6dPP36iDujBgKZ0K2iV2V3lwkL24G5RS5/o6n1JsDDIKEeLVPBm8etaP0
         8quFLR9RmKax0kO+CfDYqlAUN002KkCnZ1YqYMQNv9UPfWP/AmkNx4juNafAWLz47WEf
         ckEeA87nYhN75sibippt/S7Vie09BW3KMSrUdK44upK2NPhbrikKDywZf320ZKr4ucbS
         wx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781163184; x=1781767984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s7aaFi9ftWqsXPgCpvnLACAdtxJeDiLmPHFUiwt4nVA=;
        b=LiDWCSMMgIEYnz2hkzyC7Wb3/9evygVWK/BhFOcd2K7sYc6V+ef5SR689STcTt6Wmn
         AWcflDmF35mtW4C/VxrTLJ07TogG2FAmhke1QEa+ASFtge/1pgvyKut6Lrb8RjgmlCc9
         1IFE+4RRr3PTmtiTaPrd439iYTNUfDFaYdFaSqblxvtxt4sAgo3yPeetKvc7AWNQHaw2
         BIrYuf5HAWtYzuF+Mv72HmnKPBPn1zP27otR3wOaA3gDnHpHQRN9CS8+mSpbbPVVFpma
         Cllr4yzP5T+VCPvW505lz17hS0GhOSMTswq5WdmodKCoUKVHrskqAe6eOHruQdjTsUW8
         MsrA==
X-Forwarded-Encrypted: i=1; AFNElJ9+oE/8oJdkSM6Dm+vmNAqDiy2Mmh0QnQsZQ3Ong5nSBOUa99Tl7bnA6kSLiX/7yOq0M2l68cy1HOKMHA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx34WCAu37QvFNBZ+c1hwqDbEvHVeGJ6AvOplWqP4xAWyKkun+E
	hexD4DV/M6YcKJzinCIKk+YO+FrNwfqrr+7s9koZmwaN3QtqNg6RjIg2HeGviW/1qxh6YS6Ew+d
	+32LwOUWeomdXq6pLnwEm384HIBhUaSw=
X-Gm-Gg: Acq92OGrC0hr8RdOkg0zjJCSpWaTalirU3yAweMDATZ+c8Zk+TVE98rbH/1PgzEJu9o
	+BY+tyaQGJa87tdPbDAWQNTeBbu9quEe04wzyj1v8hgXX4nEOTW+HDrWyjql5TCS36Ew+VIJri6
	uKRJA4prDWbucw9DDQKCBVl1K3g3wU0cxmsberXUUqev8WVeHSAo+fYtNj6lChIoxd4RHqN0VRS
	2INk5KbAouwgabVruJBgFxJkubl2viTTJk7waOSTADe+vWEdzuKBu6cfDKJ0iJTCp9Jxc3aTVKY
	j+QiNlyhChnPWi/GP4lFxt3QjgF2qi4mO3pYzPXP6mvxCxTFL8LsxOKoe+dUIpE58BdYJK2kpI3
	C742Uu5+5KUzuLZ6wGOJeQCxRjAp1YYP2Tg==
X-Received: by 2002:a05:7300:8606:b0:304:8860:74dd with SMTP id
 5a478bee46e88-30804cd9ebbmr561035eec.8.1781163183579; Thu, 11 Jun 2026
 00:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611003220.3512652-1-yuantan098@gmail.com>
In-Reply-To: <20260611003220.3512652-1-yuantan098@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Jun 2026 09:32:48 +0200
X-Gm-Features: AVVi8Cco51ZUFpFSA8bcoUADhAgE8DZ9MPZ_w0DEB3uCKsG9ETpglatFmEhgDSc
Message-ID: <CANiq72mJ7JuN_j7WwApewjULvhpW_G0Vya9NuNz3uAHYE7ONnA@mail.gmail.com>
Subject: Re: [PATCH v3] block: rust: fix `Send` bound for `GenDisk`
To: Yuan Tan <yuantan098@gmail.com>
Cc: a.hindborg@kernel.org, boqun@kernel.org, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, zhiyunq@cs.ucr.edu, ardalan@uci.edu, 
	pgovind2@uci.edu, dzueck@uci.edu, Yuan Tan <ytan089@ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 2:32=E2=80=AFAM Yuan Tan <yuantan098@gmail.com> wro=
te:
>
> I am not sure whether it is appropriate for me to take Andreas' patch and
> only adjust the trailers. Please correct me, and my apologies if this is
> not the right way to handle it.

It is OK to re-send a patch from someone else, but you need to make
sure you give the proper attribution etc.

In particular, you should keep the authorship from Andreas if he was
the author of the actual fix (though it sounds like Andreas is OK with
you as author due to v1 (?)), and you should also keep the existing
Signed-off-by (again, assuming you were actually picking his patch,
which I don't know if it is the case here), adding your own afterwards
because you carried the patch. And if you make any changes to the
patch, you are supposed to mention that too, inside square brackets,
etc.

Furthermore, if you reported the issue but you are not the author,
then you should use Reported-by for yourself too (even if you have a
Signed-off-by because you are re-sending his patch). Either way, a
Link tag to the original report would be nice if one is available.

In addition, the Fixes tag means there should likely be a Cc: stable
tag too, given the hash covers other stable releases, unless it
shouldn't be backported (in which case, it should be justified).

The document that explains these tags etc. is at:

  https://docs.kernel.org/process/submitting-patches.html

I hope that helps!

Cheers,
Miguel
