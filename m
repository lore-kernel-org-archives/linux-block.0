Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9E1397
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792109081; cv=pass; b=TImKGNLd5/yFtnnlqyjRVMiOrPJtWvzPakafJUIkoewqmidPetA0NjaS+oIQ4v09hRBIwt6MvM2BpvIvvmr7lFGVAVaaVawtZ3Ez1k8Aw0nASgcJjvwy/MVgPf5786dye3o61O+jSyt0UO53O8sDxpm5X+De1xQRZlrULrMUMtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792109081; c=relaxed/simple;
	bh=j4c+M9poQOSYaSwl0VXX2WTCeiqf8vrckGaQG5UJg5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBMvlobNOxMHYHlcdSnHE5USRrXJlsNfjgSIHXx5mDMKOA3t8Mfizm0ThOMAYxmfISSk8ViK1OGp+lKKdduCenk8LOSVh58/6PlPLMavIlg+CO8zGu2XU43wbULmW0NlciPlab4qvu3kEI0fjsJNLa/z1scVeiaUSSfDwb8d6y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0osczjk; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0osczjk"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7fccba9c675so723041a34.0
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 17:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792109079; cv=none;
        d=google.com; s=arc-20260327;
        b=jnXC5ogs53WJOpp68TUaUeVhrFnr/6FTHp6RrgRgGaCpGlVtFVTut0ko/xlQBD0j49
         4RbmeA8m5+ZQr/RvfoaEkao/TlqEDZ4mP1eSQIypnlAfpjM2LePzdAhffE0gHUTqp/Mp
         8fKlZM+VclKk8c/0zSw0I1OyoTcUYNlh1roLSRdXleW9bgFi7XQVAIybpcz98ZF6EYQ4
         KnMcEUb9J4GzTba93JQHe7x9D6xEQ5FLwQreNKoK1LznqRE5+r1XQyIa8R8HO3xQeqoO
         77eqNUctA4kYYGiz/nQ5rBtYp9pQ4hYipwasUOOk3rU/Cf/B1MLR5xtgnDCV3OtBm4b0
         9wOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=txBXkaLeT2KKoYgqSxRnW4lP9rofYCCAvCoM08WY7xM=;
        fh=KmqnLbr/WOtc9ounqMfs+zXqRdohDcKs6GuJncEKMu4=;
        b=OggiHbeezfstzdiXKD+0du8sbMh/R8y4MaolcGUkhURJxo8baFEZhNu9tV0+lbwIfz
         T1EEH/OHyNb8KHvuw2Dy0s8MMEur8+V0yoPRgJg2twSNJ0CTHN4LH1XVK9fYx1wJmahs
         E/eHLUPQ2I5YUejuzOvP8R/AlH41act3O97b03Ahy61IBQGXCyxG/87eHFFPFHdygP+o
         1vkIdoaN+EeaUMpjn/4TCOcU1ko5TjVYdUgnGfkNxtadTm3XALWCizSENEq2u6jKg7U8
         0ijMSr22ysLQ2ZXpNR/M069LmR7rpIrOWHx8OBY7S8JYRoU5Zv6UCqoQ944elJ6po3xE
         fCag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792109079; x=1792713879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=txBXkaLeT2KKoYgqSxRnW4lP9rofYCCAvCoM08WY7xM=;
        b=M0osczjkvYtGCarWTCv0zymeqCNNNvvAqY+R3nOp6P6YmXOH4x+kfaPUXKmIF0lhJC
         oxqiXF3rDf2km5niWkRwQ+vEYvzg3zRzfyHHJXI99My6QlNbR6d6S3pXnm8a+bo35uwm
         sHXyfvP84iPKoJqoUZbKhpzRqXH5JzeyH2xNGce6KT/yewykcYXh2zwzWZoYR8shlTHi
         CKntSsxxKUV5kdcEBBlRAA5wF+CkgMg8n3255ZLIGfrV9pVFh2Pz+x1S9ia8FdFCWa0f
         AshRqHvKh8tS9YT3Nh+NxFbuN4coGXTRGhw3TNuc12ODY8GuMA30GXA9ZNta8JE8Unaz
         +WbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792109079; x=1792713879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txBXkaLeT2KKoYgqSxRnW4lP9rofYCCAvCoM08WY7xM=;
        b=ofZxBRKba+sre7iOVqglcfbEGPzvEq8ghvUkJpDxR4PYTsELzbwPAhTRcp2+J3TAgZ
         3+bHt+BRgWGMcHoNCWP4OPNTe28hROtL+fkvw+Ecci//bb3NZTvAAXmtD9mtSDFHctWB
         jWp7VxE7asaTCxEJwsd8/o3gRDxtW1Ty6wCgZbcrOSb5l40js10itmheeYfUJdOYt/fR
         U0J3avXS6/q2s25nJT5zy+c364WcPItWS8yu1AUVmwhCmkGoV6r9qOEfPEFC0Q3QQybX
         q5ijRONw0C5YHg9BUk12Li4wAsOqNaedKNynbvVXe7sLxKauPXJzBTlBEQYM9JX2XJcu
         HdJQ==
X-Gm-Message-State: AFq9FYLhANXCahwjdTg4SmCCSFJOUpXbHBgL1ofO7+Oj/NnjEWztqW9R
	hNaneQdY18Oh6vYtye4chLztTyYB0k1DYllNF6VL7IMY5p1RG0qwObwK8D8n/MrLkjbOsQCVLIg
	noburS/eYNOPWGDeVWkKooIincKIK8GP1GurR
X-Gm-Gg: AYBFou0zix0htReUGeriucYeeTxU2gyTlD8TcJoN9HCVys+JfpoAzPu+usav8RVyLIa
	8Jgy/pTRM8JNhp8r/Al7Ja5ADVAuEWIRqwBhd6uv/x2qYB2wQPj85Ek5XBdNPon3Bvnnd2thk/T
	CVpgGWn9tODroeiJkEAham0kpAXIaGFVxDhvDmjs65XYPKibK0kOi7ciaxkqvKnXL7cqbRjidgb
	vr0aTnOAo+Svdo2G4iSrt3HqCNATu2ZSJxPVyNQ4KBvKcUwvaRbROfvHtQiyJqdt4z5NKcP8j6k
	tfiDe5el5LaopjLJh9OTD9QY0u4phYbXAs7ORHmCsZgsujKEJ9lPXDB6qctITuHKXOVQpJDRqDn
	CWUO/zDSuk0cfx0OfxdxKY/QqUL0OIekFH2I36s/0UzKT12fXW/qlwUA=
X-Received: by 2002:a05:6830:449f:b0:81d:9acd:ee04 with SMTP id
 46e09a7af769-841f41853b4mr1136146a34.0.1792109078705; Thu, 15 Oct 2026
 17:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011063555.1142277-1-tom.leiming@gmail.com>
In-Reply-To: <20261011063555.1142277-1-tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 15 Oct 2026 19:04:23 -0500
X-Gm-Features: AclHuK9LOxMl7nb84zHZ9YGe-WJrlOsrCZO04QbKEVOfbjW1hUJ1VOGEyNHI9RM
Message-ID: <CACVXFVNrNzquXXU5jnOx_jEPhFputE67k+NSPiXDK0fX8dG14A@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] ublk: don't dispatch to canceled io commands
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Caleb Sander Mateos <csander@purestorage.com>, 
	Josef Bacik <josef@toxicpanda.com>, Li RongQing <lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 1:36=E2=80=AFAM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> Hi,
>
> Josef reported three ways in which ublk dispatches a request to a
> canceled io command, which oopses on the NULL io->cmd in
> ublk_queue_cmd() [1]:
>
> 1) STOP_DEV, then START_DEV
> 2) partial FETCH: a task fetches some tags and exits, then another task
>    fetches the rest
> 3) user recovery: one queue's task exits before all queues are ready
>
> This series fixes them in a simpler way, without extra locking in the
> I/O path:
>
> - patch 1: a FETCH round which saw a cancel stays canceling until the
>   server is gone (2, 3)
> - patch 2-3: an io command is marked cancelable before it is published
> - patch 4-5: the release resets the FETCH round, also without a disk
>   and under ub->mutex
> - patch 6: don't warn when the cancel callback finds io->cmd taken by a
>   cancel from the control path
> - patch 7: STOP_DEV holds a reference on /dev/ublkcN while it cancels,
>   so no START_DEV, FETCH or new server can slip in (1)
> - patch 8 (Josef): START_DEV and END_USER_RECOVERY refuse to go live
>   after an io command was canceled (2, 3)
> - patch 9-11: selftests
> - patch 12 (Li RongQing): ublk_report_zones() passes a per-chunk index
>   to disk_report_zone(); use the index in the whole report
>
> Tested with all ublk selftests under lockdep on for-7.4/block; v1 was
> also tested under KASAN.
>
> V3:
> - rebase on for-7.4/block
> - add Li RongQing's "ublk: use global index for reported zones"
>   (patch 12)

Hi Jens,

Ping...

Thanks,
