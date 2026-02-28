Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0439901C
	for <linux-block@vger.kernel.org>; Sat, 28 Feb 2026 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772265441; cv=pass; b=gYNhklopWDq0vb4s3jMDMIGFDOE/x8v/qKG9o0E2HjNxxpL8a1GYdm7cS76Uy07+MrcIRz2nuViQ5uEIiJFF7nf9g5+2PAvwiA7VtzSlJ3nQvVhEm/3w3ezH//Trdq+zb7r4Xa89lH3g007W6yXYEwPR4ygDTR3n51j5jcwD1Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772265441; c=relaxed/simple;
	bh=6PdqOpfgB3YMOOlux3bduC+ojGyQw/085BF80Hxj8Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRSz91r20v0WRHq0d1kE7XR1MZ3O1IAJrP+ZvGYHcmcfngJ5kE7jdE8LRxvauBuLsgxIBRTXWNmgFitQqYzmOc6h3sser9k7sgVt/fSradGhZUZnhvBZXw1959MRemU57lk6lObF9mcLup8VOWcglgwMHbpUfFQCpEIt4a1/xiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Vbt4Wigh; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Vbt4Wigh"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4398913af88so2451993f8f.2
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 23:57:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772265438; cv=none;
        d=google.com; s=arc-20240605;
        b=b0dh9CkNO+PQpdI8Ksa/i68zLbUqPc09d/+zGV+ozLNSkYnvGJ2QuAify+UJLXUCx+
         URx/7WyZ1km6RR8EZ3Rn4x4fSCl4IvNx3r6wpshXMvclQ/vfbfCm2QteqmiPQp2p6x/J
         96M1VM58D+Hhau39qWIXGJvGDUkocVasVTShojdLUxz2D7dFJpL2lIUqyzqfg2XVWym9
         HOzWgIVylo/T1qzXpXK5+5+DdFWmd14xJVIgePtHgEYI5ph/XvxJe0E5QiJCOC96RA4q
         rw5DuvTwybVu9RlG2QA2ocs/fy8IkzXRu/mX52GnTTO1KgpxOTwsJVyPnAGgB4Xtpf/j
         SL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ClMAoK6WITuHcNfY7J0tERhWJlZRJZGKOpSkq0A50FQ=;
        fh=BPPHTFnyWiw11/Bnf+lKkxTnpiohx2XM63Q5jYd+H8A=;
        b=Lmi7uPFRPTK4LTu0lsL/npe2Gp64oSO/ct6JmhGWlSlrq/I5x0GTU89bmNt4245AQ0
         BmHKfFJjNMR9Z80PVUpLJoXOGi5FszJxeMO7EOSFdIpYSb4VxWz4R9UV9fQihq04QuHO
         LwbWSLF5W06I3lqqCbGkfnOYKRU5PwebXXGDJP/c7uypOtroJH2ZL4AfZ2LRYPjMoz/Q
         3USzE9ws2CwY7UXL5BZtLxU7N59OMxA+wZ44O2dKpNZoStTURx/rm+xkPZhdNi4uld3j
         5nzv3FV+vTTZkr0NABW12MNHfnV1hVQF5CxndlfatE/abN/yIEf5FkpPLsW3fgGIKFiJ
         KPaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772265438; x=1772870238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClMAoK6WITuHcNfY7J0tERhWJlZRJZGKOpSkq0A50FQ=;
        b=Vbt4WighTUGP+oXtWsfyZsltXqfo6+swatGLEdwqw8HOMXUzJQ7k2UoUQjxP//tcfj
         s9N+MX9Ipxw83tnOHvudb4TyAyI8FCDUPR2tK+Ewh0j+jm+4zYd6e/XJROtE2cv/yD9b
         K/opeqNAkvON7Vq8CZn1ZWZXdVSzAINrdtTL1StdkB+x9FID+sQAv7ETgvTqqWLM+JwU
         Z5L4Zc9WFQD7ya26sb1shoa/LuLzx9QleW6EQXT34Dcdbli4nZbhzeLdOWwjlblpCmCU
         jxqp+lVO2+NSumQWufcdTISg8r8yyFNBRbagOw0pXNQ+TDMb5gd+Ee/lOdniQpJZyfR3
         4Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772265438; x=1772870238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClMAoK6WITuHcNfY7J0tERhWJlZRJZGKOpSkq0A50FQ=;
        b=sIurwuM0U5AohF8qCXqKp+LULEPu78IsWoQjQSe2Yxt0m+8lYIRjU9ULL+nAL6rDO9
         Lc4+nfHORh1bqbpnpWcK/DXtDK54qcT85pXdTO6VUFB82Iau0/AMr3TzNc8RQU38KPTd
         +a5bgQQtjpMqMj2rRK0XdsAZOBicrItDaAXCaiUzeUqoSnDHwyBHFiYyRsYUgznU//z9
         MWmVR1jFQ97x2T2r6BYnaYNkszVepCyq8mqv2c3yOZFJusrwcKjIu/aLF/E/bjsR/Wuo
         xp7iuNBI17isUQNOpM5nX0CjSWTKQ5LiwYWrDp6/A4mZku3d8qJBn8D3PUziWrpZ5Laq
         fwWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjXBVl3PsWJtierP2rIEWcG23DmY/abD59kszU1R45YCy3ikXyVpy3KIshaYgrHbnmcnB9eKBJn+WdeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUc+diAB/SdlpheWQGuv9sKuhUYIw8xg6G2Rf9dTI9K6BGntC
	0L7o3xCSk5SpY3wRYMGDyAZCwgqpJjSkeQZHtKC1/6/i8lbOl1DoSoryOI0/D+SLmONReSHnNbM
	ZMTQGrjWzHcYY6AdNY9BD0ELBGcS5rQdnV9HVVs2OPQ==
X-Gm-Gg: ATEYQzx12q6XsITy/20nxXrvR5E10hOCEG24Q+QVkhQ4g5IyY6X46dimP50zxa991Zz
	rKXuzq/SGSSQvIOX3XQTh3kqFOImE4sbOmCqf12lw1U/n0v8tSmWqfrOyTgKx8ZhpS8bYEGW9JQ
	0wQUsXZVjAmmXrGq1QuVNdyN42T7x4azdskmOSrN1yoZDX3ynSPcgVXj1rdfYeBtAJn56jIOFeo
	vmV44eg53nB6pEQNg4JOXio2bdzjlSZapJasGKLy5hMm9OluBLig6fDPgX/lLf7BgCjv/1lzGwE
	3J7RnK4E5Z7goCFT6zq4mwS9RF87HWnaF52cSyatIpMWiq/H5p+o/86F/rPIqCAqN8Pll3x8FES
	haOlO
X-Received: by 2002:a5d:5d0d:0:b0:437:771b:26b with SMTP id
 ffacd0b85a97d-4399ddfc43cmr9839007f8f.26.1772265438557; Fri, 27 Feb 2026
 23:57:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260221205606.GA23260@quark>
 <CAPjX3Fet5M2C=1TDNRhrqmanvJ2=aFdtQXfXK7MuxiOkz2rNUw@mail.gmail.com> <CAEg-Je80=M9nS=Dmj3FiGfXTEP_fDYytAv0ouN_iu+GzRrHp+A@mail.gmail.com>
In-Reply-To: <CAEg-Je80=M9nS=Dmj3FiGfXTEP_fDYytAv0ouN_iu+GzRrHp+A@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Sat, 28 Feb 2026 08:57:06 +0100
X-Gm-Features: AaiRm50fp_4Fyhos6nvwQgL-IlBc5T53PNbqLb3xsg-h7pbpyOz2GPW0NAm_PCQ
Message-ID: <CAPjX3Ff0=OOWcPHWam0WEGUY-xx860NHQt=igfZ9102-Zj1nOw@mail.gmail.com>
Subject: Re: [PATCH v6 00/43] btrfs: add fscrypt support
To: Neal Gompa <ngompa13@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Feb 2026 at 23:26, Neal Gompa <ngompa13@gmail.com> wrote:
> On Fri, Feb 27, 2026 at 10:55=E2=80=AFAM Daniel Vacek <neelx@suse.com> wr=
ote:
> > On Sat, 21 Feb 2026 at 21:56, Eric Biggers <ebiggers@kernel.org> wrote:
> > > On Fri, Feb 06, 2026 at 07:22:32PM +0100, Daniel Vacek wrote:
> > > > Hello,
> > > >
> > > > These are the remaining parts from former series [1] from Omar, Swe=
et Tea
> > > > and Josef.  Some bits of it were split into the separate set [2] be=
fore.
> > > >
> > > > Notably, at this stage encryption is not supported with RAID5/6 set=
up
> > > > and send is also isabled for now.
> > >
> > > Where does this series apply to?  There's no base-commit or git tree,
> > > and it doesn't apply to mainline or btrfs/for-next.
> >
> > Hi Eric,
> >
> > My apologies, I did not explicitly mention the base. I'll do it next ti=
me.
> > This was based on for-next @20260127 (commit 80dbfe6512d9c).
> > Since then, some changes occurred that will require additional
> > touches. No wonder it does not apply anymore.
> >
>
> When you make your next revision, can you also provide a tag or branch
> that I can use to grab the patches for testing? It would be easier for
> me than trying to yoink them down from the emails with how many of
> them there are...

Sure

--nX

> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!
