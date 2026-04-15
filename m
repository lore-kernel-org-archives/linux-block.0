Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9513C918
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776231056; cv=none; b=A4+ZfKiTwtdnpS8eEuw73xgTqH20GqMvUnYcyaw0GbfExQGQoOwnVQzeXrvaQYbrXWZnAeA5b1PsSVnLR1RqMqmWE60P98os2znD8FME2Lj1IPd/36jzmFZvdp1bguTwfIxyEs3JCz4F4Q7cJVhaSzprTmOb5PuZ3ZG+xRys0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776231056; c=relaxed/simple;
	bh=yTnQ5CAqd/UhKMcqDiDVIchriTG9e9wvpYUEVj06UmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbZl5Cu8h8Eyd4V+oAsBCiKUXJplRQTexoAckC3N2FvAk04rZ0IEIz9gdjsAPnXmARusfheSKzrFauakId4IZ0A5V+gdFpcvwFjuhlXFwaPpzG1UQcqI6AdP5lMFJm+MSPPVdaySrWv5oT8vMGjQxqGbblw0KLVtiojUkrKIQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4c383f2fcso5184852a34.0
        for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 22:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776231053; x=1776835853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y9GVkYuXTJNpmm1CRCAA50QlNbF7wx2z6REKbWX7K/s=;
        b=CzAGuBjDh9Df5QfvtkVQjIJJxsX/0WTS08sSW7GhT1/gvep3wvoslUCehbkTtNitOl
         0hGW0a/sPWpznz+TzCYUzqf6RBcBlxIhWhDWzDLPxTYsltuhGYFJDzkGHHYGUfZvC3EK
         QfB6IX3hHfxXZRtweRH90pMcOs+7YkLpHfkCGSCQbEUsek84K+G8kt8X9KmAmFapl2ZU
         g+2MMLtsPhalLdpQWc70P/DfvPhyvvN2S3xXy4tu6fF1yqN6dfodLmIJ2sw1Vw3EESGs
         9v4f3TpNKEIc6jn+Hz8ubtDYksa0HgqbvSsxnBs78ko2CKPnlJBX/Y4nsrbujMHrqKhF
         uxfg==
X-Forwarded-Encrypted: i=1; AFNElJ9KbnTG2OoALt7Dmrwf3A7mGEmnj/3eqmq+6OMhYvYfsmK7lEbqcbzdU7t7gNgGt5XJcHTWhYVwPnLmYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYz6FRvObtJKkiU3rafFRjblZ9OAB9FcQ1DYNBifXNyMxvx+D/
	57pmYadEGHYBeFdCTt1vun9VY6ZULPBFDfUoy/es0d3tz/bvxadWQiXMBsps3tc4
X-Gm-Gg: AeBDietJzRI9hweRkfyK4dh0p3citfJK3QBm1XsEMD9icI2ygMPz78jDgDKI+OIJdLd
	nRV0Nc1nn7jLiU/87KS9pM4awkRjCGTUBd6Bxu91jDA6NRwHE42zCMWxGMN7gwPANFnFLMRDSE6
	K2H5+octqpyb1mhOMHX/xH8Bhe1cxjFHt5G3ZjFJhqWH+O/q9IvpHilU+pO9+6YqqMH4fUPF4KB
	orpR6hYzvbgzV/0kEiIdhPYH9J/WVwp/rozXz9g6HdLS5WOtY/GuoeDloe/6jw6/zNrV5zX+7Q7
	1o2RViQoe70KP52CQo+5MqF1+v8B2LzOuOsdu3+1nVhCDaSe05vZFhQEaRWRQzzot47lboj6tJ/
	Z8G0EnYrOY6JxXuQ5q8A2SgQM3DVO8Hk8Zh5f8TwK73NJpb1TGx4Hia/BFN7pvFgrs+GUzfvYp8
	/eDlagQ/jf712iNIcAC0rlG4dbwgLkrm6iF02CI6oYdQNSEaPrVxxdQ9Hlw0EMng8ypGMVj8rr4
	KttOCtCknE+CKSKKYx9cw5WfRWLh1PbHvzsqEApdse0ApQFhDUAasF6T4hZ7p17VmyWfpNWeA==
X-Received: by 2002:a05:6830:3897:b0:7db:ce20:7f56 with SMTP id 46e09a7af769-7dc27f0b2c8mr11891833a34.19.1776231053254;
        Tue, 14 Apr 2026 22:30:53 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc76b95a2csm669609a34.22.2026.04.14.22.30.52
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 22:30:53 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbf23885dfso3860233a34.3
        for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 22:30:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/BJqK9pITeUZ122oFdtOV9/Aqe5i4Vl88KJCE9Dm0E2lRFWQa/ne6X1KtH046zugMV4Ho0QxU61tyA7g==@vger.kernel.org
X-Received: by 2002:a05:6830:438a:b0:7d7:ef4a:5ba0 with SMTP id
 46e09a7af769-7dc27e5fb9cmr12397641a34.12.1776231052630; Tue, 14 Apr 2026
 22:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260221205606.GA23260@quark>
 <CAPjX3Fet5M2C=1TDNRhrqmanvJ2=aFdtQXfXK7MuxiOkz2rNUw@mail.gmail.com>
 <CAEg-Je80=M9nS=Dmj3FiGfXTEP_fDYytAv0ouN_iu+GzRrHp+A@mail.gmail.com> <CAPjX3Ff0=OOWcPHWam0WEGUY-xx860NHQt=igfZ9102-Zj1nOw@mail.gmail.com>
In-Reply-To: <CAPjX3Ff0=OOWcPHWam0WEGUY-xx860NHQt=igfZ9102-Zj1nOw@mail.gmail.com>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 15 Apr 2026 01:30:15 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9XevtRv1VLPCQtog6+UrLL32ZWY_TzXVd8mU5Vnp+Nzg@mail.gmail.com>
X-Gm-Features: AQROBzC34OjCDF6LKBnu6dATulz6eZKfdg2cuV20SScBXwf_3JWh73-Zk-aV9jM
Message-ID: <CAEg-Je9XevtRv1VLPCQtog6+UrLL32ZWY_TzXVd8mU5Vnp+Nzg@mail.gmail.com>
Subject: Re: [PATCH v6 00/43] btrfs: add fscrypt support
To: Daniel Vacek <neelx@suse.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 2:57=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrote=
:
>
> On Fri, 27 Feb 2026 at 23:26, Neal Gompa <ngompa13@gmail.com> wrote:
> > On Fri, Feb 27, 2026 at 10:55=E2=80=AFAM Daniel Vacek <neelx@suse.com> =
wrote:
> > > On Sat, 21 Feb 2026 at 21:56, Eric Biggers <ebiggers@kernel.org> wrot=
e:
> > > > On Fri, Feb 06, 2026 at 07:22:32PM +0100, Daniel Vacek wrote:
> > > > > Hello,
> > > > >
> > > > > These are the remaining parts from former series [1] from Omar, S=
weet Tea
> > > > > and Josef.  Some bits of it were split into the separate set [2] =
before.
> > > > >
> > > > > Notably, at this stage encryption is not supported with RAID5/6 s=
etup
> > > > > and send is also isabled for now.
> > > >
> > > > Where does this series apply to?  There's no base-commit or git tre=
e,
> > > > and it doesn't apply to mainline or btrfs/for-next.
> > >
> > > Hi Eric,
> > >
> > > My apologies, I did not explicitly mention the base. I'll do it next =
time.
> > > This was based on for-next @20260127 (commit 80dbfe6512d9c).
> > > Since then, some changes occurred that will require additional
> > > touches. No wonder it does not apply anymore.
> > >
> >
> > When you make your next revision, can you also provide a tag or branch
> > that I can use to grab the patches for testing? It would be easier for
> > me than trying to yoink them down from the emails with how many of
> > them there are...
>
> Sure
>

Ping to ask about the refreshed patch set. With 7.0 out the door, it'd
be nice to have an updated set with feedback addressed...



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
