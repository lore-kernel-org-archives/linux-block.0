Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD3183CC3
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155033; cv=none; b=jIaGJxmERIoVJHD+/EOU+KJKO5xQD928pjM4Z2tQ+OencKeYpqONc8l0oiTgi9PPCyPmd0gIG1GxruhHweHND+xr/mMpcDk6Nu9+OYrb+XGk/Zp4iJnh8vXmxlBLcl4hu2zKdo+UxySBRCVAOibTKfrp2WeaeNLu/CngC6NuwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155033; c=relaxed/simple;
	bh=s0fcrwpL2pm/fjTm24d9eX1gLmRMYXkOW/b3m91QmGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNIKIWo130Vg3nXVxmAJ26d1lo7YlwTobtaTcn3JC1BjcgzaWEC2p+z15bo0lAAENQ3YOkknTbva4FcXYxWr/u0+4eKBVOLIaugaTK4/oOZyWniVwcaX3Xslfmid6CwqxWNd+FhH8eExnKv4HT7dUdXIFbK+3gDGHg+bU9ZhQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpLlVv9+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpLlVv9+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758155030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pZqRGcmDus3bnIuaq6RWbpR1gBV3kYvw8Rf5YK6gIw=;
	b=hpLlVv9+lT/FcNUHRHul6xiwiLFTU0rKOVlgAIktED8b6zlVu3S3FjCd8OV+Ul+tabmAgZ
	NUco6cjxrd3mCaxhMqHU+Fnr1Ogf77xgmVCksrnsGO1iS3sHwH14a6eaCMmyoWIYjuguZ/
	uzCyYh5Uzh5CUfTgP5VblOZxTvTkBu4=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-nw90Ru7iMvu50cCDdamOcw-1; Wed, 17 Sep 2025 20:23:48 -0400
X-MC-Unique: nw90Ru7iMvu50cCDdamOcw-1
X-Mimecast-MFC-AGG-ID: nw90Ru7iMvu50cCDdamOcw_1758155028
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-8e35054fa3bso264553241.2
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 17:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758155028; x=1758759828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pZqRGcmDus3bnIuaq6RWbpR1gBV3kYvw8Rf5YK6gIw=;
        b=v3+Ihfv++IdHJtgQCF4dcRYM2kowWl6+tClDGZdJCpc6jk0bUIp11cLDQXSYRslZl1
         9zX6ozJVG6OMLtDZseqTK3O6FhRCn7gnp9dilhIXZzRkwSg3uzsHsOAUgQ4BP2AeOflG
         aTv5m4YMv2DHVAovcQatfwNo3EZv/xy1R+BtHDQK3DpKyG7yt3KC4fZAkAnKb1Bts8mI
         urrmtBXHHkKOuagx2/R/uFif/NeM9JhSr1VJqzHZgKhuYuLa/5/CmLaaLEfe6T5FeUy1
         +mXqFIOH0r84f5TsCGXW5oAIaJWCQTZTas2cC12Y7O7CTu51Lvi0k475jXbJAWv/nHi7
         myTA==
X-Forwarded-Encrypted: i=1; AJvYcCUjZfoRp0bT6/3DoX2Er5Wl0g20zQfw2/dFLvd5SbmudHu9tE27H3Kc8w1KRfYIA2p64ZfISCRTgv77dw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/MRjBBBrliXgkqgCI4JOdTOkAMlLa4BqA83bFbfnEns4Nm6Mm
	/lYlxQyxQUFPWbteyrAii2PobNbKZ32Jn8lV6NzTD0ydr9Ulq0MsTmQVwtGZ3oeBEWEIwIgZ98s
	2ytPrOgZXmxw51moNFq/1oZuDPq4GZ2apzKnGT0koUO1cfe9H5vZZww8Awlx00CnOPQln7VSXA+
	9ZvMoyzjdDJvfOV1s7HI4Z42G0t7uamTAg5jEIeMI=
X-Gm-Gg: ASbGncuL/22JRRhPGnAIIkiuMmNQWfH5tRXdZvp8PrEnewfaIbIFAtH/o/H6pvqdUEc
	vOIeHzhHkiJAbqjbpo/wrbZaVjLczxgrtfw1e0h7nvhOFinkwE3cy4hbfPzqAVDV3WyVgpUkKcn
	EIsLduz9qXw+zy8M+n50Ev1g==
X-Received: by 2002:a05:6102:32ca:b0:55d:cfa5:9d52 with SMTP id ada2fe7eead31-56d687e4556mr1592605137.27.1758155027855;
        Wed, 17 Sep 2025 17:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjH+5gjD4iTqKVfLW4cMZT90Ce0ddT81kIw4YmFc1EBwzOUKokEtagpEa2Fxsw6F389PNh71L7jPVuyvryInk=
X-Received: by 2002:a05:6102:32ca:b0:55d:cfa5:9d52 with SMTP id
 ada2fe7eead31-56d687e4556mr1592595137.27.1758155027499; Wed, 17 Sep 2025
 17:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-ublk_features-v1-0-52014be9cde5@purestorage.com>
 <20250916-ublk_features-v1-3-52014be9cde5@purestorage.com>
 <aMowhqjOND9EdiKh@fedora> <aMsIJXDRhkRWDH1m@dev-ushankar.dev.purestorage.com>
In-Reply-To: <aMsIJXDRhkRWDH1m@dev-ushankar.dev.purestorage.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 18 Sep 2025 08:23:36 +0800
X-Gm-Features: AS18NWCiidGYT_VgCdwWEU62sBlqsLlypylW6Bpb6YKeAgqKSuXBJomyi02EFF4
Message-ID: <CAFj5m9L3+=UsMzM3JU3QXw3tVqYjZs7s8QHbFy_KaG4Rs_z_VQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests: ublk: add test to verify that feat_map is complete
To: Uday Shankar <ushankar@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Shuah Khan <shuah@kernel.org>, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 3:13=E2=80=AFAM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> On Wed, Sep 17, 2025 at 11:52:38AM +0800, Ming Lei wrote:
> > On Tue, Sep 16, 2025 at 04:05:57PM -0600, Uday Shankar wrote:
> > > Add a test that verifies that the currently running kernel does not
> > > report support for any features that are unrecognized by kublk. This
> > > should catch cases where features are added without updating kublk's
> > > feat_map accordingly, which has happened multiple times in the past (=
see
> > > [1], [2]).
> > >
> > > Note that this new test may fail if the test suite is older than the
> > > kernel, and the newer kernel contains a newly introduced feature. I
> > > believe this is not a use case we currently care about - we only care
> > > about newer test suites passing on older kernels.
> > >
> > > [1] https://lore.kernel.org/linux-block/20250606214011.2576398-1-csan=
der@purestorage.com/t/#u
> > > [2] https://lore.kernel.org/linux-block/2a370ab1-d85b-409d-b762-f9f3f=
6bdf705@nvidia.com/t/#m1c520a058448d594fd877f07804e69b28908533f
> > >
> > > Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> > > ---
> > >  tools/testing/selftests/ublk/Makefile           |  1 +
> > >  tools/testing/selftests/ublk/test_generic_13.sh | 16 +++++++++++++++=
+
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/se=
lftests/ublk/Makefile
> > > index 5d7f4ecfb81612f919a89eb442f948d6bfafe225..770269efe42ab46036648=
5ccc80abfa145a0c57b 100644
> > > --- a/tools/testing/selftests/ublk/Makefile
> > > +++ b/tools/testing/selftests/ublk/Makefile
> > > @@ -20,6 +20,7 @@ TEST_PROGS +=3D test_generic_09.sh
> > >  TEST_PROGS +=3D test_generic_10.sh
> > >  TEST_PROGS +=3D test_generic_11.sh
> > >  TEST_PROGS +=3D test_generic_12.sh
> > > +TEST_PROGS +=3D test_generic_13.sh
> > >
> > >  TEST_PROGS +=3D test_null_01.sh
> > >  TEST_PROGS +=3D test_null_02.sh
> > > diff --git a/tools/testing/selftests/ublk/test_generic_13.sh b/tools/=
testing/selftests/ublk/test_generic_13.sh
> > > new file mode 100755
> > > index 0000000000000000000000000000000000000000..ff5f22b078ddd08bc19f8=
2aa66da6a44fa073f6f
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ublk/test_generic_13.sh
> > > @@ -0,0 +1,16 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > > +
> > > +TID=3D"generic_13"
> > > +ERR_CODE=3D0
> > > +
> > > +_prep_test "null" "check that feature list is complete"
> > > +
> > > +if ${UBLK_PROG} features | grep -q unknown; then
> > > +        ERR_CODE=3D255
> > > +fi
> > > +
> > > +_cleanup_test "null"
> > > +_show_result $TID $ERR_CODE
> >
> > What if the ublk selftest is run on downstream kernel?
> >
> > Maybe the output can changed to "unsupported" to show that ublk selftes=
t
> > code doesn't cover or use this feature.
>
> Yes I pointed out this issue in the commit message too. But I am unsure
> what you're asking for.
>
> I think we need a failure here if this test is to fulfill its intended
> purposes (catching cases where a feature is added without updating the
> feat_map in kublk). This does also cause failures in cases where an old
> test suite is run against a newer kernel. Since I think this is an
> unusual case, perhaps I can add a log line when this test fails saying

That also requires any new feature to have a selftest to cover, but sounds =
good,
and should be the motivation of this patch.

> that the failure is expected if running an old test suite against a new
> kernel?

Fair enough, then this patch looks fine for me:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,

