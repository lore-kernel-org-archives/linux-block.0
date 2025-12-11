Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49213214A64
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478750; cv=none; b=lGP/RpPvq9efucTCYwUdgJ4FNqEZJaRN3jrHnlvyherlA2Fvf33hEWx4QdmbN/h81ib48bz7iapot9yNL8Meb1wIG8u788GEUFOKJapF+XJEyixrC16YbQ3p9+V0gbnnFKJr2q6dTAxbGAeXewp9dtLAnW2MZr/vAJH6+GAwilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478750; c=relaxed/simple;
	bh=qIIfQ0tiC8lC0gSGIbKioKpzKjWa9/lMoK6bVi7/mFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVTxl6PCk2dLrxgS1VgmJLchQv/lt3PMbCoVmgsh+ErssyoOKv6akhUV7dw5R6manWq+NWkjuntzHEBo9+nbuEU8fq0K6cKkXPeAzkrOpH1xVK/PXl7sU8jlFF81ghgPUb//vw+6IZFDLxnNHwc7/Nr7VHNBTw3oZ85CIG4KN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=M+5esPOh; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="M+5esPOh"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-349210f0f44so60979a91.1
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 10:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765478747; x=1766083547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNXq5Z/8QIyZJ2UMGJcCMYvDUAvIGTEcnNAkIF8CFOE=;
        b=M+5esPOhvgfShjyltf6emIM2+lyoAzr1pXUH2D5ObKICMfamYSF3jatCJ0MrjrdGby
         hTJtkeB62bYSAu8AQ9pqViwJgjyWuTWtgMpylgLmBmRsiLYWgypt0v6V474I18Wzpt/x
         h+VEctJQkDEG+dfiKMg93jpu3b1qf0go0Yp2SUsGC5/SorV/aYx+oTpeAwdWJNMq4RsK
         tT06iVSCTD1cRrCP0opo+u02I5WsfeKPDoOT6wnSJTSopc5OM7w3f1n0PBLT2zHO31y0
         Tn+zO0WiUtEgwF2QiyIvufL5JvGx5WbcOoWj5hWWpF1dPTDOVYxXgDdOcTIrcdQ7sd8E
         x1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765478747; x=1766083547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zNXq5Z/8QIyZJ2UMGJcCMYvDUAvIGTEcnNAkIF8CFOE=;
        b=TDLHUH44RfsS1OqWRIBLfMXuIg38Cym2Nn3A3OjjE/O38Emm5bOp99tXcq91arSkQ/
         7GMeS112UmDSS/gafXBOwSLoQ5G7Y38nyDFByhO0MLIMydG01FVH7seDJM3bFGApMQIw
         NKe6zAlTNIgj0u+J4KyBv3PoN0LL1r6c466MOhqJA9tlebiP316t28ArPQFFezFLYSTv
         auvhTX4aqUJKnBaQlMkQLpf06htZm3kvK5h+UtbxBwapSk1pzLWKNNcGgpfk7sKQT54/
         1L6vUiJdU7trITZen5r+HVsLSvlRlegzgsoD1h5qsgVeyoAiHSEu3MKI/QTasDtVO3UL
         aMuw==
X-Forwarded-Encrypted: i=1; AJvYcCVIudlEJQtSdA/4GWwo9z4OLdI10nABk+n/AHP495oVkjubh255OquGLL+qQwuB3aTvhazXnECcDEyBAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOu+L0WyhNvG0XVsKqzumZXxbKbvFoxokqtlrv0JR0IhFASFty
	6LkYzo3q+xzSqOhFn0mkiVuOrIC5cD5L5HUH03DthsRQ76M7kEpDgeQ4iv1Mm+5fHx2/PUFoTyH
	QzKN/GpgJ1jkk2gPPWzHyFx1cUuhXwmS0iHTi7noNDw==
X-Gm-Gg: AY/fxX75OuXUFIDpSStx2j87zpsB7v9RdoPTYpFMoDTteGPZXj9tnQNgKXboIQLRgkY
	zH8cvfkGvuj78vFe5U7LpscDTW3CF2DFVePuOmVSxlNWx4PZ8mRZ/wGcS/EZKGhDF/kaRkjNfAJ
	VxzU4bpCheOwa6IEhV0twNHJMfslMVnD/h+ns+Tw2/6zoumAZuQasJAcaL+XjUIeB6rz5b7wgjH
	5dpl6ITeHSwbb8es1UBDSMslw3NZNtfEpyqaTY+P8aI24JpoEo9+qjYaun+f8d5Dz765H063JlL
	trw/QmI=
X-Google-Smtp-Source: AGHT+IHLAq48tdJzSS4QiyKmTZVpxeyqk+RxPWbgtKfUWLQnuS31/6SlbIHi9RehgR50jqnVxhyEMULnnzPvea9BtWM=
X-Received: by 2002:a05:7022:f414:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-11f2e7f11fbmr1940169c88.2.1765478747302; Thu, 11 Dec 2025
 10:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-7-csander@purestorage.com> <aTqKLSbpQN26XLNq@fedora>
In-Reply-To: <aTqKLSbpQN26XLNq@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 11 Dec 2025 10:45:36 -0800
X-Gm-Features: AQt7F2puWcoifKNjfdQitAhl_fK0qS0Emp58vZpsULp4G1PxA44FzloQ1WkRsao
Message-ID: <CADUfDZpX3RTu4m5WZ1LrjnFRxg96qpeM0fMtw1-c=7Qn_5gKQQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] selftests: ublk: forbid multiple data copy modes
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 1:09=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Dec 10, 2025 at 10:16:01PM -0700, Caleb Sander Mateos wrote:
> > The kublk mock ublk server allows multiple data copy mode arguments to
> > be passed on the command line (--zero_copy, --get_data, and --auto_zc).
> > The ublk device will be created with all the requested feature flags,
> > however kublk will only use one of the modes to interact with request
> > data (arbitrarily preferring auto_zc over zero_copy over get_data). To
> > clarify the intent of the test, don't allow multiple data copy modes to
> > be specified. Don't set UBLK_F_USER_COPY for zero_copy, as it's an
> > independent feature. Don't require zero_copy for auto_zc_fallback, as
> > only auto_zc is needed. Fix the test cases passing multiple data copy
> > mode arguments.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/kublk.c          | 21 ++++++++++++-------
> >  .../testing/selftests/ublk/test_generic_09.sh |  2 +-
> >  .../testing/selftests/ublk/test_stress_03.sh  |  4 ++--
> >  .../testing/selftests/ublk/test_stress_04.sh  |  2 +-
> >  .../testing/selftests/ublk/test_stress_05.sh  | 10 ++++-----
> >  5 files changed, 22 insertions(+), 17 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selft=
ests/ublk/kublk.c
> > index f8fa102a627f..1765c4806523 100644
> > --- a/tools/testing/selftests/ublk/kublk.c
> > +++ b/tools/testing/selftests/ublk/kublk.c
> > @@ -1611,11 +1611,11 @@ int main(int argc, char *argv[])
> >                       break;
> >               case 'd':
> >                       ctx.queue_depth =3D strtol(optarg, NULL, 10);
> >                       break;
> >               case 'z':
> > -                     ctx.flags |=3D UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_=
USER_COPY;
> > +                     ctx.flags |=3D UBLK_F_SUPPORT_ZERO_COPY;
> >                       break;
> >               case 'r':
> >                       value =3D strtol(optarg, NULL, 10);
> >                       if (value)
> >                               ctx.flags |=3D UBLK_F_USER_RECOVERY;
> > @@ -1674,17 +1674,22 @@ int main(int argc, char *argv[])
> >                       optind +=3D 1;
> >                       break;
> >               }
> >       }
> >
> > -     /* auto_zc_fallback depends on F_AUTO_BUF_REG & F_SUPPORT_ZERO_CO=
PY */
> > -     if (ctx.auto_zc_fallback &&
> > -         !((ctx.flags & UBLK_F_AUTO_BUF_REG) &&
> > -                 (ctx.flags & UBLK_F_SUPPORT_ZERO_COPY))) {
> > -             ublk_err("%s: auto_zc_fallback is set but neither "
> > -                             "F_AUTO_BUF_REG nor F_SUPPORT_ZERO_COPY i=
s enabled\n",
> > -                                     __func__);
> > +     /* auto_zc_fallback depends on F_AUTO_BUF_REG */
> > +     if (ctx.auto_zc_fallback && !(ctx.flags & UBLK_F_AUTO_BUF_REG)) {
> > +             ublk_err("%s: auto_zc_fallback is set but F_AUTO_BUF_REG =
is disabled\n",
> > +                      __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!!(ctx.flags & UBLK_F_SUPPORT_ZERO_COPY) +
> > +         !!(ctx.flags & UBLK_F_NEED_GET_DATA) +
> > +         !!(ctx.flags & UBLK_F_USER_COPY) +
> > +         !!(ctx.flags & UBLK_F_AUTO_BUF_REG) > 1) {
> > +             fprintf(stderr, "too many data copy modes specified\n");
> >               return -EINVAL;
> >       }
>
> Actually most of them are allowed to co-exist, such as -z/--auto_zc/-u.

Yes, I know the ublk driver allows multiple copy mode flags to be set
(though it will clear UBLK_F_NEED_GET_DATA if any of the others are
set). However, kublk will only actually use one of the modes. For
example, --get_data --zero_copy will use zero copy for the data
transfer, not get data. And --zero_copy --auto_zc will only use auto
buffer registration. So I think it's confusing to allow multiple of
these parameters to be passed to kublk. Or do you think there is value
in testing ublk device creation with multiple data copy mode flags
set, but only one of the modes actually used?

>
> >
> >       i =3D optind;
> >       while (i < argc && ctx.nr_files < MAX_BACK_FILES) {
> > diff --git a/tools/testing/selftests/ublk/test_generic_09.sh b/tools/te=
sting/selftests/ublk/test_generic_09.sh
> > index bb6f77ca5522..145e17b3d2b0 100755
> > --- a/tools/testing/selftests/ublk/test_generic_09.sh
> > +++ b/tools/testing/selftests/ublk/test_generic_09.sh
> > @@ -14,11 +14,11 @@ if ! _have_program fio; then
> >       exit "$UBLK_SKIP_CODE"
> >  fi
> >
> >  _prep_test "null" "basic IO test"
> >
> > -dev_id=3D$(_add_ublk_dev -t null -z --auto_zc --auto_zc_fallback)
> > +dev_id=3D$(_add_ublk_dev -t null --auto_zc --auto_zc_fallback)
> >  _check_add_dev $TID $?
> >
> >  # run fio over the two disks
> >  fio --name=3Djob1 --filename=3D/dev/ublkb"${dev_id}" --ioengine=3Dliba=
io --rw=3Dreadwrite --iodepth=3D32 --size=3D256M > /dev/null 2>&1
> >  ERR_CODE=3D$?
> > diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/tes=
ting/selftests/ublk/test_stress_03.sh
> > index 3ed4c9b2d8c0..8e9f2786ef9c 100755
> > --- a/tools/testing/selftests/ublk/test_stress_03.sh
> > +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> > @@ -36,19 +36,19 @@ wait
> >
> >  if _have_feature "AUTO_BUF_REG"; then
> >       ublk_io_and_remove 8G -t null -q 4 --auto_zc &
> >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc "${UBLK_BACKFILES[=
0]}" &
> >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILE=
S[1]}" "${UBLK_BACKFILES[2]}" &
> > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallbac=
k &
> > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback &
> >       wait
> >  fi
> >
> >  if _have_feature "PER_IO_DAEMON"; then
> >       ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthreads 8 --per_i=
o_tasks &
> >       ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthreads 8 --per=
_io_tasks "${UBLK_BACKFILES[0]}" &
> >       ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthreads 8 --p=
er_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > -     ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallbac=
k --nthreads 8 --per_io_tasks &
> > +     ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fallback -=
-nthreads 8 --per_io_tasks &
> >       wait
> >  fi
> >
> >  _cleanup_test "stress"
> >  _show_result $TID $ERR_CODE
> > diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/tes=
ting/selftests/ublk/test_stress_04.sh
> > index c7220723b537..6e165a1f90b4 100755
> > --- a/tools/testing/selftests/ublk/test_stress_04.sh
> > +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> > @@ -35,11 +35,11 @@ wait
> >
> >  if _have_feature "AUTO_BUF_REG"; then
> >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc &
> >       ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc "${UBLK_BACKF=
ILES[0]}" &
> >       ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_f=
ixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> > -     ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fa=
llback &
> > +     ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallb=
ack &
> >       wait
> >  fi
> >
> >  if _have_feature "PER_IO_DAEMON"; then
> >       ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --=
per_io_tasks &
> > diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/tes=
ting/selftests/ublk/test_stress_05.sh
> > index 274295061042..09b94c36f2ba 100755
> > --- a/tools/testing/selftests/ublk/test_stress_05.sh
> > +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> > @@ -56,21 +56,21 @@ for reissue in $(seq 0 1); do
> >       wait
> >  done
> >
> >  if _have_feature "ZERO_COPY"; then
> >       for reissue in $(seq 0 1); do
> > -             ublk_io_and_remove 8G -t null -q 4 -g -z -r 1 -i "$reissu=
e" &
> > -             ublk_io_and_remove 256M -t loop -q 4 -g -z -r 1 -i "$reis=
sue" "${UBLK_BACKFILES[1]}" &
> > +             ublk_io_and_remove 8G -t null -q 4 -z -r 1 -i "$reissue" =
&
> > +             ublk_io_and_remove 256M -t loop -q 4 -z -r 1 -i "$reissue=
" "${UBLK_BACKFILES[1]}" &
> >               wait
> >       done
> >  fi
> >
> >  if _have_feature "AUTO_BUF_REG"; then
> >       for reissue in $(seq 0 1); do
> > -             ublk_io_and_remove 8G -t null -q 4 -g --auto_zc -r 1 -i "=
$reissue" &
> > -             ublk_io_and_remove 256M -t loop -q 4 -g --auto_zc -r 1 -i=
 "$reissue" "${UBLK_BACKFILES[1]}" &
> > -             ublk_io_and_remove 8G -t null -q 4 -g -z --auto_zc --auto=
_zc_fallback -r 1 -i "$reissue" &
> > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc -r 1 -i "$re=
issue" &
> > +             ublk_io_and_remove 256M -t loop -q 4 --auto_zc -r 1 -i "$=
reissue" "${UBLK_BACKFILES[1]}" &
> > +             ublk_io_and_remove 8G -t null -q 4 --auto_zc --auto_zc_fa=
llback -r 1 -i "$reissue" &
>
> --auto_zc_fallback requires both -z and --auto_zc.

Ah, right, I forgot that the fallback path relies on normal zero copy
buffer registration. I guess we are missing coverage of that, then,
since the tests still passed with --zero_copy disabled.

Thanks,
Caleb
