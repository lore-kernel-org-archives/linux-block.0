Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546E324705
	for <linux-block@vger.kernel.org>; Sun, 25 Jan 2026 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769355305; cv=pass; b=LkfZo1ED14oNrRPWjqSSWR11k00tFUQx8Dd1fdCHcdqm8FgeK32algHyyCgFc9Ffer3tjXKW4bz9jJNXb1+XtVWN+k5QKWcVkcrElHEkUW4uHT8SjAA+GVfi3N5J0wwDE10aeZp2TX0e8L9PMOAVAqDEpvqvBf2keBTu04n070M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769355305; c=relaxed/simple;
	bh=8vgTsasdoGFJyysV4QshjqJZujkRrkBDPiELEwZd58w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvnqxBU1RwiJJLCnDwAv6S/PWggRl1i6bWg++56fCCXr9oguWtlHGR23fFtM/SRJliNgGDetKVnAkyBrGd13ipjDtBlvWmnM6PZuugHtaz3b+H7KH1TIzCGarJCjFuZQbg5AKNtiS9L66y/2IMZT7bNVtkmVOxunOP5T1pSKLFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dByZVtR4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=muZcKJsh; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dByZVtR4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="muZcKJsh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769355302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hh86i8LoFrdXRrDy9tOfNcziJFbkWPtFbzTiy83QQwQ=;
	b=dByZVtR4IVkJ5AbniCGGC2O9MvqJ5w1OL46faU2W1hT8j8nAIFbNpTseP5uu6OxpOR2xFB
	+N9Z54a8WsCFw4lOgtCusBfOj7eOZCnFo+TB7bEjAqTWS0DLVun48ILtXZ93k7tvc/FVyT
	4jYxR2Puq2ejO1xapWDuwTHFNr0w7q4=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-Cre2QFuxNemxYiDEjcoUfQ-1; Sun, 25 Jan 2026 10:35:00 -0500
X-MC-Unique: Cre2QFuxNemxYiDEjcoUfQ-1
X-Mimecast-MFC-AGG-ID: Cre2QFuxNemxYiDEjcoUfQ_1769355300
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-947ff72c023so14305718241.0
        for <linux-block@vger.kernel.org>; Sun, 25 Jan 2026 07:35:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769355300; cv=none;
        d=google.com; s=arc-20240605;
        b=DuQRr1H1FWZtQW06CvnjYBsGTHLq8/EWG/mbcqKjPkYok+6jQd3EYXjoD5y1FFeH6h
         KQ3jtnZIQ0MWvo2GjBqZyYEg0rJJt4I3H6vTrigVVyL7C8+67OQzJ5aWdZUScS2ayVMG
         7v2NUUf24dSqqc52ILVrvGf3RxuqvDIdsacCz/QM1LOEzxkCxeD5YTXdnhOj8y/T3ly9
         EDcpSMSopqSjOixw3or2lFc7E6/C81j4SkupemI7KqpQTyYAoIYzge4vvSMuw4ihhTpF
         mEnSduwAkUNXYQHONIdkw2N1ahQ4eAgecxD79HKH8XlHcD5l8/ODOl/HJSFMDj/51cV2
         4uEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hh86i8LoFrdXRrDy9tOfNcziJFbkWPtFbzTiy83QQwQ=;
        fh=tsP9/dXQtXWAzN/iubq3MIoouyGvpGx8lK+qivxit+Y=;
        b=PF1fL4Cdo8kjeW0MwmyO60W86/48bSvxCJNEkYWmFMW8Ji8bmHheHJ7w7S3GZswU8G
         Ir/Mjq4SbK+dpZAqV1O4oZKQe/bAnuIboHMupDkdf+Jn5+iS42Q/nX5q1oBQhlXL8v1P
         VvQJxM8baBgJfnYkYaDlS+jHbJQXet0U2sbREiuTCDyn/9bg44+J6P+MwcRC9YxSArAL
         5F2zzPQbI6UU7OGs42zoMWzHIw45tzAVre6iYOubFGop3YwiWMopsD1krI+Jo67Je4gR
         vBu09koM5KS2EANshUZcGyHIChsOTX8VJmWww2vLgSD3x27UkQqMC8xVJaapWVHjgBEq
         CRRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769355300; x=1769960100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh86i8LoFrdXRrDy9tOfNcziJFbkWPtFbzTiy83QQwQ=;
        b=muZcKJshEbDkmfNweNe6WRH9Joykn+wh8kFspH80xPKri1hSw6Tus/hREli8ZyfUuY
         O3lwYiFT2BR6qqLptfAPD+r2WpAyYoKvUNnOXSG3gD/wkmkKVJFb4cyHU9GrFZPjSdJs
         vh8Bto/M2vRyHJbtutisAeQlUdrVzoQuW/hwEntyr1T08g7TgEG5klmXvAN0D9qsKWPh
         DTxqK0CWNQ4JMwoBHOWhgLMF7hGXUYw5BqR6q4db/kbgS8BZgS/8RAYBVGfdV8/x6NL1
         2yyNuQFmVtm5rRH/u1YluzmyTcONpYfBg/e4A9Zs+cxJnG14sOpqC7emv5oRrBTtxloU
         rqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769355300; x=1769960100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hh86i8LoFrdXRrDy9tOfNcziJFbkWPtFbzTiy83QQwQ=;
        b=pXuOV9K1vuDB8TAXfvRrpdcj73FbzmzZpF1dUSR+4RZ1M4sfM8z8keq7ZCCkL3Kr0H
         fOm1/sHZr+EP8VbXHTob8Q/QeNXnK7ygtv8E602gSVpmH+s2Sro+ZWuAhvmR4K28viQg
         uGmIYCtPlBlUd9T3QnHqwkCUjyR+CBm+s89oXR/KySyGA3dTsCe/hhfyWjyc4TcKdlvF
         vu4M7Qh37rTmDy25w1L4s7ebSog7L+6EanpnQ8r6vAUgHmqZORB47YSZy1IRbyxyVMQC
         GryXPlix4ardM9osDt5T0tXuf3JfLt9/Sskc+iqhSP5+zeQTfGGiK28bVmsI4RZUa0YK
         BMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWff28q9q35C4P2FICfSRMi/ekeEBsucx+ew++e4ebe6nPDQLYkzZvChAemYNrpc6XFzhqVizAfl3bAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzy6Yy0lt7Ps0EJDQM/77C86bxKSlPZvpY/SNZ9r373FsepgLo
	yOceTvScG6Any5CqfSVvniEKUBrnz/f2BpBM7QVNj/nWEcmr0PJ+my3fcA0fV0PZWmse1e2P5RA
	z5Zpsv9zuLK4hV+PyRSLfURl+k6iH8vLLeUMys1micX6sHZp7RigkHNeV/W+Ss6f3+thtbiq+PU
	AD4VLT/7+E9ACMgB82AeZDiDpRQLKterGtS9Av3Rs=
X-Gm-Gg: AZuq6aKPfdWjy9LKYESpS9hSMvnJ63oabhgXH24SBk1UX831T3+5KrJ0E4u7RG+fDWX
	teZkLrMM7Fmwa/1cHxEje+2/b3JDYMDfSTNKNWLWa4wNgVPWRau1fs77Vo19u/2HU2hloX+PL5u
	Vjg741oI5all+XyEugFgJSFyrke1SOZ+7xghdG54Vk/I3MaWx5wdBRhLnvuSA/fcVqsn0=
X-Received: by 2002:a05:6102:440a:b0:5ef:b32c:dff8 with SMTP id ada2fe7eead31-5f5771afee6mr466115137.5.1769355299906;
        Sun, 25 Jan 2026 07:34:59 -0800 (PST)
X-Received: by 2002:a05:6102:440a:b0:5ef:b32c:dff8 with SMTP id
 ada2fe7eead31-5f5771afee6mr466107137.5.1769355299558; Sun, 25 Jan 2026
 07:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123112039.1370223-1-alex@zazolabs.com> <aXN4mFuoXhtJDKyF@fedora>
 <147635F1-943E-46D5-8EF1-D1C965F85EC1@zazolabs.com> <aXOGrXo3AbXPHA-K@fedora>
 <03C8F5B9-B2E1-4C78-A043-B4F9422508B7@zazolabs.com> <aXY2qdYtfVTSc7jB@fedora>
In-Reply-To: <aXY2qdYtfVTSc7jB@fedora>
From: Ming Lei <ming.lei@redhat.com>
Date: Sun, 25 Jan 2026 23:34:48 +0800
X-Gm-Features: AZwV_QgarjvWYF4UOUXMdwNp7c1A1qUIGGWrhDgv7qw_q1o9HQBQeyECn9XA0Pw
Message-ID: <CAFj5m9+hGUkm2Se3iEhkmtVs8sDxVVdfvzCc-WUjYmRd+OdUrg@mail.gmail.com>
Subject: Re: [PATCH] selftests: ublk: io-reorder triggered in test_generic_01.sh
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026 at 11:28=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wro=
te:
>
...

> >
> > Fedora 43 default config with some debugging options enabled, but no ch=
anges in schedulers.
> > Test VM storage is on a networked NAS over iSCSI - both boxes VM host a=
nd NAS have two NICs,
> > I get the errors when I load the network. So I believe the requests rea=
lly complete out of
> > order due to the network in my case. All tests that have the bpftrace c=
heck fail on occasion.
>
> Can you test the following patch and see if re-order still can happen?
>
>
> diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/test=
ing/selftests/ublk/test_generic_01.sh
> index 26cf3c7ceeb5..26d5e52ece29 100755
> --- a/tools/testing/selftests/ublk/test_generic_01.sh
> +++ b/tools/testing/selftests/ublk/test_generic_01.sh
> @@ -13,7 +13,7 @@ if ! _have_program fio; then
>         exit "$UBLK_SKIP_CODE"
>  fi
>
> -_prep_test "null" "sequential io order"
> +_prep_test "null" "ublk dispatch won't reorder IO"
>
>  dev_id=3D$(_add_ublk_dev -t null)
>  _check_add_dev $TID $?
> @@ -39,9 +39,13 @@ fio --name=3Dwrite_seq \
>  ERR_CODE=3D$?
>  kill "$btrace_pid"
>  wait
> -if grep -q "io_out_of_order" "$UBLK_TMP"; then
> -       cat "$UBLK_TMP"
> +
> +# Check for out-of-order completions detected by bpftrace
> +if grep -q "^out_of_order:" "$UBLK_TMP"; then
> +       echo "I/O reordering detected:"
> +       grep "^out_of_order:" "$UBLK_TMP"
>         ERR_CODE=3D255
>  fi
> +
>  _cleanup_test "null"
>  _show_result $TID $ERR_CODE
> diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing=
/selftests/ublk/trace/seq_io.bt
> index b2f60a92b118..60ac40e66606 100644
> --- a/tools/testing/selftests/ublk/trace/seq_io.bt
> +++ b/tools/testing/selftests/ublk/trace/seq_io.bt
> @@ -2,23 +2,45 @@
>         $1:     dev_t
>         $2:     RWBS
>         $3:     strlen($2)
> +
> +       Track request order between block_io_start and block_rq_complete.
> +       For each request, record its start sequence number and verify
> +       completions happen in the same order.
>  */
> +
>  BEGIN {
> -       @last_rw[$1, str($2)] =3D (uint64)0;
> +       @start_seq =3D (uint64)0;
> +       @complete_seq =3D (uint64)0;
> +       @out_of_order =3D (uint64)0;
> +}
> +
> +tracepoint:block:block_io_start
> +{
> +       if ((int64)args.dev =3D=3D $1 && !strncmp(args.rwbs, str($2), $3)=
) {
> +               @start_order[args.sector] =3D @start_seq;
> +               @start_seq =3D @start_seq + 1;
> +       }
>  }
> +
>  tracepoint:block:block_rq_complete
>  {
> -       $dev =3D $1;
>         if ((int64)args.dev =3D=3D $1 && !strncmp(args.rwbs, str($2), $3)=
) {
> -               $last =3D @last_rw[$dev, str($2)];
> -               if ((uint64)args.sector !=3D $last) {
> -                       printf("io_out_of_order: exp %llu actual %llu\n",
> -                               args.sector, $last);
> +               $expected_order =3D @start_order[args.sector];
> +               if ($expected_order !=3D @complete_seq) {
> +                       printf("out_of_order: sector %llu started at seq =
%llu but completed at seq %llu\n",
> +                               args.sector, $expected_order, @complete_s=
eq);
> +                       @out_of_order =3D @out_of_order + 1;
>                 }
> -               @last_rw[$dev, str($2)] =3D (args.sector + args.nr_sector=
);
> +               delete(@start_order[args.sector]);
> +               @complete_seq =3D @complete_seq + 1;
>         }
>  }
>
>  END {
> -       clear(@last_rw);
> +       printf("total_start: %llu total_complete: %llu out_of_order: %llu=
\n",
> +               @start_seq, @complete_seq, @out_of_order);
> +       clear(@start_order);
> +       clear(@start_seq);
> +       clear(@complete_seq);
> +       clear(@out_of_order);
>  }

Forget another change, please apply the following delta too:

@@ -28,8 +28,8 @@ if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
        exit "$UBLK_SKIP_CODE"
 fi

-# run fio over this ublk disk
-fio --name=3Dwrite_seq \
+# run fio over this ublk disk (pinned to CPU 0)
+taskset -c 0 fio --name=3Dwrite_seq \


Thanks,

