Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22E9349B1E
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719926; cv=pass; b=BURBUSOpA2D8trd6l07Hu1JN9azxiDYvFI1qcjAWgZb43Kxn7n+JjIkh4buKChiAf/jI7XGyTlXODIoyQFmkDXp/1hm+9JivFFcfureu+984wzXDcRtsy1gKIaULuZ/gRIo9vZQapM7fFJ/7VXTfbemjBsvsumVLuJc6KIOkDm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719926; c=relaxed/simple;
	bh=4kIuX6Agq3HD0TLnVcZN913LVX+FCf68NrUDWYKrLZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkYjg9PeOH6uj9h9eDmebmy/eDPaSBJsiYzcZavOHQ6+/LgRHp3eMZ5d/1EnnNMi2hAelMT2SasFDYRukCOtrud6xh6RfQyZU/ohPtH6tPRgNZSYs+qRZa55QYnMgkfQMwrdeUg5ixuZsxoTkbIMwxOTlF2olNmRJM2UFoov+R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=L0JCrEf0; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="L0JCrEf0"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11b7bd9e6e5so37739c88.2
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 09:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767719924; cv=none;
        d=google.com; s=arc-20240605;
        b=MSpDuVvZtMVz0/jqwLeouoenc+TuJFHP+LPg2lyMuVUKjeJki6kxDQRLxWtrVD6dqb
         1kYIfSykTurUtElJchl7J5noNtfpWrWFSR8OoWHlRAedNQZgzavQRYrEEi1BWRBOQjM4
         /iRr4F1tIF+o4dD+ijdwR2hXpC+9aYRm1YNeVuOs1eRBgttbo4glJejllT4HMnJUBUqG
         Qid0VCJSTGPsdwxgJFIib2bifiYMZc7hB1kueEbSAEaTTwd+eCAQDhAeypKj/kPKYEb7
         KOm+U8EuJkvv1I1FsEcs3SOcGb/m4paxdpf7RCX2qBr5UHSGNwh89VWy/Z1D1g4Uq98s
         986Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=el9IdsVpvDRJVEdnxklkmPvqwg7S8+dzbfu1CSsjkVc=;
        fh=0DodeHMGiEObJydjsIbfb9MgyjVOUFBOkftjTCaprVo=;
        b=aTBfOYaGwk/pdwzUJw+RaRccwrtdjB3fwyETdoBqoGiO667NePjBqZqV9MlNG8xQjT
         8E4/CZhAB/3en5jMEvG8APEIeQSe9AvfLLZgr9GCbA7Pn7CO2Hao6cDC4+XHZotSy63B
         tahpOrWlMEQ8uZ8Lcmln/HVAz8uHz4M41ABUecCoe3MWTxtTn0VRjxvamOWEsooxcgcd
         oSrIW90jIOu/J73GrDjJHFbR21Y/ljk7UwZ+TL+esLc++i68pFMyOPq22nyRnbAXlDF2
         rfY1NQqp4DFOsRpzAIxFSB15RBFoy6R+yp5QVBz42Q4rWy1FiI6XHond+wPgHmopQMr+
         NS8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767719924; x=1768324724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=el9IdsVpvDRJVEdnxklkmPvqwg7S8+dzbfu1CSsjkVc=;
        b=L0JCrEf0CxGjZlVPdGLiAhubcYDAobdQSZrOsNjJpiygYspAp/4Ht6kGoF1CvSSp3W
         DSGBWeiFw1jvHjjgq0N329CbU1pzbW24n/uKPKsE4XRtpNBdy1kbfspf64RPQOJgyWdl
         lwl4zzH//6aRLc5CRsD04toFAIpd3u5WRWVQB1Mt4680h6y1TSiwHgz6lh22zgaBrv1c
         lT7Fp4PynyaldSrmnUTkVTkk5h8hKH0EJEPDkFnQxozoA82RuKaKm6MTgRPKCy062Sld
         dv31/jY9T3dPFrH13drZVvny1K+4jq3cNRQP8VuRnU9j0+n1tuOH6w4QYUws/9ha/7kE
         aDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719924; x=1768324724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=el9IdsVpvDRJVEdnxklkmPvqwg7S8+dzbfu1CSsjkVc=;
        b=EPE4Trrl0bFV3Fn4CNleEYsTPfpaFaGL/nKxmNFgVDLbpDw/Qx736aV2A/3OBfPG7c
         M91a+3p4CFZxf89m9q0Fe3ZvhkbMYisshxMbX60UzMPLQMWogl4TjVtZk7VyKYsiNi7t
         GjpBQ+HZktZOWb0Xqrg6i4Pxx07bsSsb29RAX8ruKllIOkqArGCBhO4UMYlTe5QFu1Ni
         zHC4mCfKtMp3HY1izT1tD3Sw3qWj1nmPUvkyJNvtWOQrRy1bGfgsVaNGydG4LEcCuckR
         bjzB3qFZlOxXVsHZO+1Vx3QHewDielwcAwkJdaoSY1Oc6KOSor3rs+m3xxLX6Us2EKHf
         gFtg==
X-Forwarded-Encrypted: i=1; AJvYcCXM2sl80o4LTqxpi7M3CVuT2Rftf4V4jZ4w50Z5xV5L8yILWVT1vZhtgfXDQqyclnFYdHQDhSejhoxDfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyad8M9CDacVwYWtunoEEF11M1kEOhYaFmkh2ClbX/T0eTX0/j3
	itRjB0WlGX9jpvALzCYFIRjTKUkUod8YgujYODbM8HsIVYyxku2ZpxePHxBApjNh6W/OHBn5S0T
	ueJqIBrQ+xVtKOjAEI2Yc/tY6IqIrbQwXj1sC1PSUGw==
X-Gm-Gg: AY/fxX6V9737eJDoHEWfw41SpDvm5etOJkSKB7xQTWQYJRM/pEXXAdjEJDjQKWgJrnk
	dsjQKnAaRtqDKuBzyK9+avwF5z2mXXKQPzjeL5UgooAXVI0KgesF7JRm91Pel5m7LTl1OnR5dMX
	0a6M0j9Iu9Xm/atcCR2DVcaVUz9G0eyt4SIMAhhzmjtUvLSLJXhDB0mlT70nSOcOhaEb0ZJ4GfF
	/mnLxgr9qPtik2wJzyeXMd7Z5GwM6+M7T9Et3UmvvBSzrNEeWg+56aKNoRBbAJlf/TK8M3l
X-Google-Smtp-Source: AGHT+IHJa/wLLHrmuywVzlRGyH5Yo3APVWKq7aE4CE/jD/1YOw2SXtvug2pAPBCT3XgeLuTQ6DbQhrJVVoiNv+zqfew=
X-Received: by 2002:a05:7022:e0b:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-121f188dca6mr1576758c88.2.1767719923753; Tue, 06 Jan 2026
 09:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-14-csander@purestorage.com> <aV0THiUJ0S1l8FNC@fedora>
In-Reply-To: <aV0THiUJ0S1l8FNC@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 Jan 2026 09:18:32 -0800
X-Gm-Features: AQt7F2p-9Q1Gb8POklMIHL1sT1S_3cYjSMMZ_GUmQXTheHiXANNW7Tkv76aEaqo
Message-ID: <CADUfDZpw7rfshnC649QG+N+vVvck4VNXDLwCQW=6TYFCiB7a_Q@mail.gmail.com>
Subject: Re: [PATCH v3 13/19] selftests: ublk: add utility to get block device
 metadata size
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 5:50=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Jan 05, 2026 at 05:57:45PM -0700, Caleb Sander Mateos wrote:
> > Some block device integrity parameters are available in sysfs, but
> > others are only accessible using the FS_IOC_GETLBMD_CAP ioctl. Add a
> > metadata_size utility program to print out the logical block metadata
> > size, PI offset, and PI size within the metadata. Example output:
> > $ metadata_size /dev/ublkb0
> > metadata_size: 64
> > pi_offset: 56
> > pi_tuple_size: 8
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/Makefile        |  4 +--
> >  tools/testing/selftests/ublk/metadata_size.c | 36 ++++++++++++++++++++
> >  2 files changed, 38 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/ublk/metadata_size.c
> >
> > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/self=
tests/ublk/Makefile
> > index 06ba6fde098d..41f776bb86a6 100644
> > --- a/tools/testing/selftests/ublk/Makefile
> > +++ b/tools/testing/selftests/ublk/Makefile
> > @@ -47,14 +47,14 @@ TEST_PROGS +=3D test_stress_03.sh
> >  TEST_PROGS +=3D test_stress_04.sh
> >  TEST_PROGS +=3D test_stress_05.sh
> >  TEST_PROGS +=3D test_stress_06.sh
> >  TEST_PROGS +=3D test_stress_07.sh
> >
> > -TEST_GEN_PROGS_EXTENDED =3D kublk
> > +TEST_GEN_PROGS_EXTENDED =3D kublk metadata_size
> >
> >  LOCAL_HDRS +=3D $(wildcard *.h)
> >  include ../lib.mk
> >
> > -$(TEST_GEN_PROGS_EXTENDED): $(wildcard *.c)
> > +$(OUTPUT)/kublk: common.c fault_inject.c file_backed.c kublk.c null.c =
stripe.c
>
> I feel wildcard is pretty handy, can we avoid to kill it? Such as:
>
> STANDALONE_UTILS :=3D metadata_size.c
> KUBLK_SRCS :=3D $(filter-out $(STANDALONE_UTILS),$(wildcard *.c))

Sure, I wasn't aware of filter-out. I'm fine with that.

Thanks,
Caleb
