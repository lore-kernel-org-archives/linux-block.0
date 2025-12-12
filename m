Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345D2561A2
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516911; cv=none; b=AmoI9tXJcW/JW2qd+KGXHDJX7y463B9314glQ4ClrDSukcEIOGuuTHGUF73xowqilB0GUPRU5vJ8/QCIBCv627c08RJF6+vTmhGvFvhOkyt+sy0FzI+KSCf7NrZNNOo29EmalE3rnGXkjSSlwlYYsK6mv9ZPbe8lQ4h0XLWvUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516911; c=relaxed/simple;
	bh=caRn6+YjTjfWjMskcJDu10kqvdlmrWciiKlFqekJ6VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJl/N2sDqy3D+NAG4UnYZ9e1SVsVZXjxtQSqRPVJq365ihnJTcF9ZnK9kW5vdvZXj95Dm+DRtVXWGkFLEqkiuiqHyyFtsXm/il6Y0Y2Fs5H8MBgWaRA/iE/JUdl6ArJhmoxIH9xrP9fNyuKo5DQLSHJuSSNi7s8F1dmgQ7XjBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FZm8sp+k; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FZm8sp+k"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-349e7fe50c3so120323a91.2
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 21:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516909; x=1766121709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTd51BYB9azkPglNcZoA6pJmBBLZI/2+nKAtQ6hSR/0=;
        b=FZm8sp+kqH2wnhjsV8SxuQ7+22ElO/7wIpbbKDkGg6KbSIIal/8z0xY471T0HSc7f6
         4ZWucjBvoo+nqIXNGPxniIMDWPtMpf7QvjCYop0OMGYRDBJb1cHqhlaCHldJZr1R5APl
         /iCdea8XC+K5eWheS7dVaQKo+iufzOAHYHrWWJYP0UIHKzzKQ5u5bjtN8R9hC199IBen
         rlLle7pQrMV4bDo/asYQW9PpK+vwO0yxnG4v/27O4Udn+IG+y1uULfWqTMERxL8r7SLL
         RG/ZfM+M3H2HOXiapv63e5EAvYnGCwkHS7SnVKsT5Y8yKg9oPeYUQTdBbcvoTLybeH0r
         BBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516909; x=1766121709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTd51BYB9azkPglNcZoA6pJmBBLZI/2+nKAtQ6hSR/0=;
        b=JIFYuA22xM3S+xRur4fV8Cuqp//WybHtLXWPiDIdBkpqo2h7RO4k9yyIsrKYccHt1w
         P4hN/wXnbHEJfPVBkmmOCMrWpCenxcqTmtuHfJPNQ8icBO/xIS8/rH0EP+cnI+YTeL8/
         mhjUYPPX43zh69RdpaMXs34hSlaQ/7VBQ19CkBVeBRKDPIEKaJO899NwBADJCQGB8Klh
         H/xuBeNh2kFRN3EkQNLayh7cVOFvDx4nOh2c1i7rvhaNHgrc0Auj8ndE+yMqYe6QfWHY
         pnuhcPANmuC65Q46xu67MxCxsGMVO73qRzAlDb536deKBt/fUdOaVvjRVqtEL1zGJLCa
         StBw==
X-Forwarded-Encrypted: i=1; AJvYcCUAupSp5ydYTio0SPTD5onCTKfLG7oKLZOtqVN1tD5h+MmmD1BCkkkMXB205Bipllnw9CE64sv/3FSNWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeji5QWFw8/IyBdxduu4uXVgex+BddzZePsvzcTbf4i9785lXZ
	6/6beShyUmIZd53Par/5BZ88AgpOgo7Vefx3rpWWohp6/Wq8zAF/NAfvpTxn85hgjaZP1lNvon+
	h94pC+dmRI7+v/B81N+4efU0t1Y4o/NYBIkF/WtYkFcMHQD9y2LonZTc=
X-Gm-Gg: AY/fxX6yjr2B59W4q7k6g8LNqkdswFJpevq5t5Yz2GKZcU63R0Wh9r7WElBDvIuTW9T
	cUIy2XYFCZgvr5ovVdqC1LUQJ3qES+Kj0jlOE2KHc28F8foo5VQiTKq4YxwG8n547jdpSxFl1OL
	Lfoo4KrH7jC4T2lyBenzprGjKW09qQxUrnHW6krl16hX66qvpx4JFJR4tmaWvNf5Y3viUeRhov6
	sIvvOcpE0XNctll/0xsJVz5dXQ0VfwOpiPinb2b+n2NRQEj30PWUnQ/SVIucVoJTy7Unc8AcxGU
	OuAdS0Y=
X-Google-Smtp-Source: AGHT+IE+oqHTuGWJeLoqvmw0PVKCBgzgOHg9zHDgSAZtgzbOOJWf8RqlD4i1hWesur0diOI7wLjnbsRXp+zxYGlLUOw=
X-Received: by 2002:a05:7022:989:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-11f34c47c98mr378447c88.3.1765516908755; Thu, 11 Dec 2025
 21:21:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-7-csander@purestorage.com> <aTqKLSbpQN26XLNq@fedora>
 <CADUfDZpX3RTu4m5WZ1LrjnFRxg96qpeM0fMtw1-c=7Qn_5gKQQ@mail.gmail.com>
 <aTtOGmEeYBZLozO8@fedora> <CADUfDZpzZ16vsWhMm6-tYfdj7EBBE_iUaLTmhyiZeR1CxT5d_g@mail.gmail.com>
 <aTuAGQOurmAfbJc7@fedora> <CADUfDZoyU2R2KGT9573CqpkFQAAn7kksE6mV58oWeK9hg9_fNQ@mail.gmail.com>
 <aTukkFnbsl5_I0No@fedora>
In-Reply-To: <aTukkFnbsl5_I0No@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Dec 2025 21:21:37 -0800
X-Gm-Features: AQt7F2rqVhacWyF5Nx-QnMQA06O8XPGiBfBGg9VIinhMm0TTfNgBmQjk0KtcG6s
Message-ID: <CADUfDZp3oyFSwLhuAOi24quNFYK2CxLB0dPm5dRiB-AjmHbG=Q@mail.gmail.com>
Subject: Re: [PATCH 6/8] selftests: ublk: forbid multiple data copy modes
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 9:14=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Dec 11, 2025 at 08:59:00PM -0800, Caleb Sander Mateos wrote:
> > On Thu, Dec 11, 2025 at 6:38=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > On Thu, Dec 11, 2025 at 06:06:51PM -0800, Caleb Sander Mateos wrote:
> > > > On Thu, Dec 11, 2025 at 3:05=E2=80=AFPM Ming Lei <ming.lei@redhat.c=
om> wrote:
> > > > >
> > > > > On Thu, Dec 11, 2025 at 10:45:36AM -0800, Caleb Sander Mateos wro=
te:
> > > > > > On Thu, Dec 11, 2025 at 1:09=E2=80=AFAM Ming Lei <ming.lei@redh=
at.com> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 10, 2025 at 10:16:01PM -0700, Caleb Sander Mateos=
 wrote:
> > > > > > > > The kublk mock ublk server allows multiple data copy mode a=
rguments to
> > > > > > > > be passed on the command line (--zero_copy, --get_data, and=
 --auto_zc).
> > > > > > > > The ublk device will be created with all the requested feat=
ure flags,
> > > > > > > > however kublk will only use one of the modes to interact wi=
th request
> > > > > > > > data (arbitrarily preferring auto_zc over zero_copy over ge=
t_data). To
> > > > > > > > clarify the intent of the test, don't allow multiple data c=
opy modes to
> > > > > > > > be specified. Don't set UBLK_F_USER_COPY for zero_copy, as =
it's an
> > > > > > > > independent feature. Don't require zero_copy for auto_zc_fa=
llback, as
> > > > > > > > only auto_zc is needed. Fix the test cases passing multiple=
 data copy
> > > > > > > > mode arguments.
> > > > > > > >
> > > > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com=
>
> > > > > > > > ---
> > > > > > > >  tools/testing/selftests/ublk/kublk.c          | 21 +++++++=
+++++-------
> > > > > > > >  .../testing/selftests/ublk/test_generic_09.sh |  2 +-
> > > > > > > >  .../testing/selftests/ublk/test_stress_03.sh  |  4 ++--
> > > > > > > >  .../testing/selftests/ublk/test_stress_04.sh  |  2 +-
> > > > > > > >  .../testing/selftests/ublk/test_stress_05.sh  | 10 ++++---=
--
> > > > > > > >  5 files changed, 22 insertions(+), 17 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/t=
esting/selftests/ublk/kublk.c
> > > > > > > > index f8fa102a627f..1765c4806523 100644
> > > > > > > > --- a/tools/testing/selftests/ublk/kublk.c
> > > > > > > > +++ b/tools/testing/selftests/ublk/kublk.c
> > > > > > > > @@ -1611,11 +1611,11 @@ int main(int argc, char *argv[])
> > > > > > > >                       break;
> > > > > > > >               case 'd':
> > > > > > > >                       ctx.queue_depth =3D strtol(optarg, NU=
LL, 10);
> > > > > > > >                       break;
> > > > > > > >               case 'z':
> > > > > > > > -                     ctx.flags |=3D UBLK_F_SUPPORT_ZERO_CO=
PY | UBLK_F_USER_COPY;
> > > > > > > > +                     ctx.flags |=3D UBLK_F_SUPPORT_ZERO_CO=
PY;
> > > > > > > >                       break;
> > > > > > > >               case 'r':
> > > > > > > >                       value =3D strtol(optarg, NULL, 10);
> > > > > > > >                       if (value)
> > > > > > > >                               ctx.flags |=3D UBLK_F_USER_RE=
COVERY;
> > > > > > > > @@ -1674,17 +1674,22 @@ int main(int argc, char *argv[])
> > > > > > > >                       optind +=3D 1;
> > > > > > > >                       break;
> > > > > > > >               }
> > > > > > > >       }
> > > > > > > >
> > > > > > > > -     /* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUP=
PORT_ZERO_COPY */
> > > > > > > > -     if (ctx.auto_zc_fallback &&
> > > > > > > > -         !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
> > > > > > > > -                 (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY))) =
{
> > > > > > > > -             ublk_err("%s: auto_zc_fallback is set but nei=
ther "
> > > > > > > > -                             "F_AUTO_BUF_REG nor F_SUPPORT=
_ZERO_COPY is enabled\n",
> > > > > > > > -                                     __func__);
> > > > > > > > +     /* auto_zc_fallback depends on F_AUTO_BUF_REG */
> > > > > > > > +     if (ctx.auto_zc_fallback && !(ctx.flags & UBLK_F_AUTO=
_BUF_REG)) {
> > > > > > > > +             ublk_err("%s: auto_zc_fallback is set but F_A=
UTO_BUF_REG is disabled\n",
> > > > > > > > +                      __func__);
> > > > > > > > +             return -EINVAL;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     if (!!(ctx.flags & UBLK_F_SUPPORT_ZERO_COPY) +
> > > > > > > > +         !!(ctx.flags & UBLK_F_NEED_GET_DATA) +
> > > > > > > > +         !!(ctx.flags & UBLK_F_USER_COPY) +
> > > > > > > > +         !!(ctx.flags & UBLK_F_AUTO_BUF_REG) > 1) {
> > > > > > > > +             fprintf(stderr, "too many data copy modes spe=
cified\n");
> > > > > > > >               return -EINVAL;
> > > > > > > >       }
> > > > > > >
> > > > > > > Actually most of them are allowed to co-exist, such as -z/--a=
uto_zc/-u.
> > > > > >
> > > > > > Yes, I know the ublk driver allows multiple copy mode flags to =
be set
> > > > > > (though it will clear UBLK_F_NEED_GET_DATA if any of the others=
 are
> > > > > > set). However, kublk will only actually use one of the modes. F=
or
> > > > > > example, --get_data --zero_copy will use zero copy for the data
> > > > > > transfer, not get data. And --zero_copy --auto_zc will only use=
 auto
> > > > > > buffer registration. So I think it's confusing to allow multipl=
e of
> > > > > > these parameters to be passed to kublk. Or do you think there i=
s value
> > > > > > in testing ublk device creation with multiple data copy mode fl=
ags
> > > > > > set, but only one of the modes actually used?
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > >       i =3D optind;
> > > > > > > >       while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
> > > > > > > > diff --git a/tools/testing/selftests/ublk/test_generic_09.s=
h b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > index bb6f77ca5522..145e17b3d2b0 100755
> > > > > > > > --- a/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > +++ b/tools/testing/selftests/ublk/test_generic_09.sh
> > > > > > > > @@ -14,11 +14,11 @@ if ! _have_program fio; then
> > > > > > > >       exit "$UBLK_SKIP_CODE"
> > > > > > > >  fi
> > > > > > > >
> > > > > > > >  _prep_test "null" "basic IO test"
> > > > > > > >
> > > > > > > > -dev_id=3D$(_add_ublk_dev -t null -z --auto_zc --auto_zc_fa=
llback)
> > > > > > > > +dev_id=3D$(_add_ublk_dev -t null --auto_zc --auto_zc_fallb=
ack)
> > > > > > > >  _check_add_dev $TID $?
> > > > > > > >
> > > > > > > >  # run fio over the two disks
> > > > > > > >  fio --name=3Djob1 --filename=3D/dev/ublkb"${dev_id}" --ioe=
ngine=3Dlibaio --rw=3Dreadwrite --iodepth=3D32 --size=3D256M > /dev/null 2>=
&1
> > > > > > > >  ERR_CODE=3D$?
> > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_03.sh=
 b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > index 3ed4c9b2d8c0..8e9f2786ef9c 100755
> > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> > > > > > > > @@ -36,19 +36,19 @@ wait
> > > > > > > >
> > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc &
> > > > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBL=
K_BACKFILES[0]}" &
> > > > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${U=
BLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --aut=
o_zc_fallback &
> > > > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_z=
c_fallback &
> > > > > > > >       wait
> > > > > > > >  fi
> > > > > > > >
> > > > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > > > >       ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthrea=
ds 8 --per_io_tasks &
> > > > > > > >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthr=
eads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> > > > > > > >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nt=
hreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --aut=
o_zc_fallback --nthreads 8 --per_io_tasks &
> > > > > > > > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_z=
c_fallback --nthreads 8 --per_io_tasks &
> > > > > > > >       wait
> > > > > > > >  fi
> > > > > > > >
> > > > > > > >  _cleanup_test "stress"
> > > > > > > >  _show_result $TID $ERR_CODE
> > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_04.sh=
 b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > index c7220723b537..6e165a1f90b4 100755
> > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > > > > > > > @@ -35,11 +35,11 @@ wait
> > > > > > > >
> > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
> > > > > > > >       ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "=
${UBLK_BACKFILES[0]}" &
> > > > > > > >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc=
 --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > > > > > > > -     ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc =
--auto_zc_fallback &
> > > > > > > > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --a=
uto_zc_fallback &
> > > > > > > >       wait
> > > > > > > >  fi
> > > > > > > >
> > > > > > > >  if _have_feature "PER_IO_DAEMON"; then
> > > > > > > >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --n=
threads 8 --per_io_tasks &
> > > > > > > > diff --git a/tools/testing/selftests/ublk/test_stress_05.sh=
 b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > index 274295061042..09b94c36f2ba 100755
> > > > > > > > --- a/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> > > > > > > > @@ -56,21 +56,21 @@ for reissue in $(seq 0 1); do
> > > > > > > >       wait
> > > > > > > >  done
> > > > > > > >
> > > > > > > >  if _have_feature "ZERO_COPY"; then
> > > > > > > >       for reissue in $(seq 0 1); do
> > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z -r 1=
 -i "$reissue" &
> > > > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g -z -r=
 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 -z -r 1 -i=
 "$reissue" &
> > > > > > > > +             ublk_io_and_remove 256M -t loop -q 4 -z -r 1 =
-i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > >               wait
> > > > > > > >       done
> > > > > > > >  fi
> > > > > > > >
> > > > > > > >  if _have_feature "AUTO_BUF_REG"; then
> > > > > > > >       for reissue in $(seq 0 1); do
> > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g --auto_=
zc -r 1 -i "$reissue" &
> > > > > > > > -             ublk_io_and_remove 256M -t loop -q 4 -g --aut=
o_zc -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > -             ublk_io_and_remove 8G -t null -q 4 -g -z --au=
to_zc --auto_zc_fallback -r 1 -i "$reissue" &
> > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc =
-r 1 -i "$reissue" &
> > > > > > > > +             ublk_io_and_remove 256M -t loop -q 4 --auto_z=
c -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
> > > > > > > > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc =
--auto_zc_fallback -r 1 -i "$reissue" &
> > > > > > >
> > > > > > > --auto_zc_fallback requires both -z and --auto_zc.
> > > > > >
> > > > > > Ah, right, I forgot that the fallback path relies on normal zer=
o copy
> > > > > > buffer registration. I guess we are missing coverage of that, t=
hen,
> > > > > > since the tests still passed with --zero_copy disabled.
> > > > >
> > > > > Looks one regression from commit 0a9beafa7c63 ("ublk: refactor au=
to buffer register in ublk_dispatch_req()")
> > > >
> > > > Is there a particular issue you see in that commit? I think the iss=
ue
> > >
> > > Looks I overlooked.
> > >
> > > > is that if UBLK_IO_F_NEED_REG_BUF is set in the ublksrv_io_desc but=
 zc
> > > > isn't enabled, the null ublk server will just complete the I/O
> > > > immediately. And --auto_zc_fallback isn't supported by any of the
> > > > other ublk servers.
> > > >
> > > > if (auto_zc && !ublk_io_auto_zc_fallback(iod))
> > > >         queued =3D null_queue_auto_zc_io(t, q, tag);
> > > > else if (zc)
> > > >         queued =3D null_queue_zc_io(t, q, tag);
> > > > else {
> > > >         ublk_complete_io(t, q, tag, iod->nr_sectors << 9);
> > > >         return 0;
> > > > }
> > > >
> > > > So it looks to me to just be an issue with my kublk change.
> > >
> > > But ublk_queue_auto_zc_fallback() is broken, so the auto_zc_fallback =
code
> > > path isn't examined actually.
> >
> > How is it broken?
>
> typeof(q->flags) is u64, but the return type is i32, so it is overflowed.

Ah, good catch. Yeah, these ublk_queue flag query functions should
probably return bool. Are you going to send out a patch?

Thanks,
Caleb
