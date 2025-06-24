Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737162DA742
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778428; cv=none; b=g99nzuQGLnUmEToGuLdvMxNTBlnRAmRhDxqzrRp4T0shRttC39KwpRnvCPnFPWH60ae/cHkA38BOhMJhHS3N5WQp+dZOZbhk64W8ukEhoDToSzv1qZ1WZyrQ/rau5V1fnOkSiwjlE856cioayBJBA3wkfEEa5aNMrkjyPDso/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778428; c=relaxed/simple;
	bh=j7TpqxWHyAugIFwC3tJXyLOnNdUnlMrCkhiwNGxBrmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3SQarMf6inNM1cCfmP2LIOMx+nfHKa7TyashAs7Z2XuMQmExW2H488Ns9vX8VUDrQ3ivbWUBDdxPbN4pwGh9hxuJBcVptrlMAjw7H5i30a2x5q5GHXWbVZiIgFo38IiE48znDJoL3kpX38Oc4DVBxLtCSca7pSJFt/zj+YB1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ISxuf47C; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ISxuf47C"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-312f53d0609so623947a91.1
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750778426; x=1751383226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNnX/NCQJPVMeRIjd+Q/ozMWoWPLYIVnnIJ/6mwjYwI=;
        b=ISxuf47CzA2lMKhlG1hyqVX9ppRZJzkrfjwmuvYNaHh9DfEISfh/94UkB5LOaH4HN4
         Li0bhtjc+rnJvlW7rdUNzEeL1S3bNwzJwS1279jBbRHfaarAca+lZzYfBBT17GvRu5BM
         EBSY/mlO8n33KPi8jdz1l8KJh2Yd8YEj7ISbbeKvWW6YqpfUAYrk+PXQrNwbqnrsviuo
         ZxXKPVXSP0s4knFL1k575nlfm1la6kefUptf7IT4retRnD6MYfwdX32o08Bav3TfXl2p
         ZA5vY7V3h/bcoOaS3tevLTacmDbDSP5mcDyKojxU7qRt0k4VW+tabXzm7/+JKGnQYvB1
         u/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750778426; x=1751383226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNnX/NCQJPVMeRIjd+Q/ozMWoWPLYIVnnIJ/6mwjYwI=;
        b=m1OEcPg8GLKQyi9z1j+/q2JnJVJXrTBKjzWSI6MyoCFmsUnZcnMDcF6U+gEV+ENTC4
         0ZgXc3ttX6HTeOwQIoLkf77aZNcMq6Wv48vmdhCTwkMGXEquw32MVF2xfBDhzNG7mv/n
         z9IiAyLLSYjpCKZ8oV0zyL8fm9pAEDDoCv4SHjV09aS5yF6PM6wBQAe6WzU+58BM8njv
         Lyn0kncHD7GxEqDNrwDhDOAWi6VPX0wqIKLsZooHrZNOChI6wjQotNGFRrKeF+gtp8Qe
         PjKfemwYbGGi30xeuehXXnZVpG6p8R2TrZNkQADHQ4MemZlDylOBiZzFbXmYkM9oaOVQ
         RRmA==
X-Forwarded-Encrypted: i=1; AJvYcCWwZby8iXyPS+GrQvZO+S6M3S8pyliLYLWHkebzSl8KfunVD0BnXWYSiEYXJFl5Sgn3cmG1AIpHOyE7/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YywLJ1rOvLmen9XQPUVIS7AuininrTxbDDL5ESw7QlVxOnYzJlJ
	a763b/zwB6GW8FWbg3CdbVkSuRd6zX+70t0X24I2sNF3BUVZXgsBBPxjNw7FDo/g7cDTQooVKzH
	nJ+ffgWBN3cnUwgTJs1qrV92JwXY6qjrx2qRxMq+GgqgpO6OLOrZogk0=
X-Gm-Gg: ASbGncumsX7qcWNDUX7kC+tNS5uauCwpptb/oQ4aHVKRTj+3+6z0qGrDUo5xMgMHkJp
	/zBDt2Kfj+8tewWOd6wjyPpTn1GkCQdkeEauoHT/h6UbNRNBLC5099XJUuMH8bmgKJ3schBV1XN
	jJDmXt6DFJNcjxU4sZoRXTjtzYUVTe6K1E/stoEGuDb9rJxbtAMU1w
X-Google-Smtp-Source: AGHT+IHyiFsRoP4efAsr/P60ML7sEUfX0m/7mRiUy/TiHbVxVxXJevJOikLAIa2J8MG+w3NmVvMpxpJjCs2JDfOxD2w=
X-Received: by 2002:a17:90b:5286:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-3159d8f9537mr9732627a91.7.1750778425533; Tue, 24 Jun 2025
 08:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623011934.741788-1-ming.lei@redhat.com> <20250623011934.741788-3-ming.lei@redhat.com>
 <CADUfDZq4_463nageZgzH8hMtr_gTMhvMxHfVCSuzVoBCWbgsww@mail.gmail.com> <aFn7n_GN4y3Y1WgD@fedora>
In-Reply-To: <aFn7n_GN4y3Y1WgD@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 24 Jun 2025 08:20:14 -0700
X-Gm-Features: AX0GCFsp-JgCl8ouHgg_aAgRHfkLkhdPVDpw3sMa7juKM4TChK-FEdBrsZmgWwQ
Message-ID: <CADUfDZoDkr4QMf8Z=KAy6DUAybfWQ0TPAP__XS=2XR_5ENwi3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: ublk: don't take same backing file for
 more than one ublk devices
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:13=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Jun 23, 2025 at 10:54:58AM -0700, Caleb Sander Mateos wrote:
> > On Sun, Jun 22, 2025 at 6:19=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Don't use same backing file for more than one ublk devices, and avoid
> > > concurrent write on same file from more ublk disks.
> > >
> > > Fixes: 8ccebc19ee3d ("selftests: ublk: support UBLK_F_AUTO_BUF_REG")
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  tools/testing/selftests/ublk/test_stress_03.sh | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/t=
esting/selftests/ublk/test_stress_03.sh
> > > index 6eef282d569f..3ed4c9b2d8c0 100755
> > > --- a/tools/testing/selftests/ublk/test_stress_03.sh
> > > +++ b/tools/testing/selftests/ublk/test_stress_03.sh
> > > @@ -32,22 +32,23 @@ _create_backfile 2 128M
> > >  ublk_io_and_remove 8G -t null -q 4 -z &
> > >  ublk_io_and_remove 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}" &
> > >  ublk_io_and_remove 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${=
UBLK_BACKFILES[2]}" &
> > > +wait
> >
> > Why is wait necessary here? It looks like __run_io_and_remove, which
> > is called from run_io_and_remove, already ends with a wait. Am I
> > missing something?
>
> All tests share the three backing files, this way just avoids concurrent
> write to the same file from each test/ublk device.

Sorry, I didn't see the "&" at the end of the ublk_io_and_remove commands.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
