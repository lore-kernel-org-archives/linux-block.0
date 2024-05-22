Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C7770EA
	for <linux-block@vger.kernel.org>; Wed, 22 May 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716410050; cv=none; b=FeRwPWRWcujhdA+q09juDQq1l59pZH2IKpRWudvWe2FW36rwwm8MMyNrkWtSqqWZ2qNhqTgr6yQtNz8T4C34rjlz4GlN82z/dVpwF/CqjWRqBQ6fEyr+7SiIZB591nVEz53l4Row7CwhMvAjRP7MoQNxmDWbaNVyA6aivZjXqSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716410050; c=relaxed/simple;
	bh=lw7qxI1EG5k1V/CgFWFkAlmixJPYuYeuePjzKcJEqN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZ5Xc8F2oEBoAZDpycT7A8TK6aLFlLepnhkvg55iVh7DrLNOdno41MhMFAY2cqV9B7ukHbiC/pjhV10IUkVxRcSpQpQmYjuvjTRY4+a14gla6ycdIUpTacjYxaMDgctCi6OycDuQPx5P7zz7Wpy9l0eywxjoV2jN8eesjqNn5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlPx46SY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlPx46SY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716410047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ge373HOlN0Aik/3EkLuJhurpwm+4P7IPirL4EqDjrfg=;
	b=hlPx46SYqPJsZHogMxCQ8sQqxL+S7F0yVnkjqv8LHnDWWWA+eQIQTa8bhsY//QcwKlBfjx
	Sd+WZoaqnMJIapCm2ZZ3VZquH8/gpv6/1rDPPZWtZxrEJ4bGOtn8PvFlMVWVsWvTK7PpBw
	0acdrUCP3VsNZvZODz9932Rr5mdA9XY=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-_TefZIL7MHWTLhGpZdqxSA-1; Wed, 22 May 2024 16:34:06 -0400
X-MC-Unique: _TefZIL7MHWTLhGpZdqxSA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-61b028ae5easo225375657b3.3
        for <linux-block@vger.kernel.org>; Wed, 22 May 2024 13:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716410045; x=1717014845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge373HOlN0Aik/3EkLuJhurpwm+4P7IPirL4EqDjrfg=;
        b=pt9VgIFSTkj1N04eRTPq7a2aQEKH4AqK+Y+OMWxQt3eilIUHroBg5fD4fLh7OxyAgb
         zvHoGSSbKzeHSs0FtugZJqOhjnkQApqirpd34fy9WbQd8y2xIAT028CYjXj/t3fuhBhF
         TqdHX2wB42OWhiS1sfgn+B51AU7/1xbIRdDLznzZyfKSMBW4SDfQEndpQx4yI+PDIggA
         TK9DXWekXLNq0uoM9DL3e5f/dKgP6FBg4gdXRr3h/aC09PQUn6tF7B6GYAeiMx9RGX3c
         OEYtjHxo4UaDfHVSksmbS4p8vghUYr5tQOG6APUonZUgLr6+AyX6SD4LltmNCp+rHWZw
         OXrA==
X-Forwarded-Encrypted: i=1; AJvYcCUX/ybKeEllqULGf0kCFDw5+t9UbWUA9UzWe3yEbNBCh/USQSXZ55i83uLy022k9JUIj1HYkdAeyoWFPxJCjZlo3zTpp0+o0ARziXI=
X-Gm-Message-State: AOJu0YxR3AX8+apLGSfFvssB9ijIFv2Bu4PbAjrfOxRrArhLb6Os4gV0
	f2rlvbZHSePqalO0ox45g5aPU8GADwWmO/iQ2uMp5VEYT+0ZCE3yUtvtGW91M1imLWGnbM3RwQX
	iaDgEzplb8+NbRsXuVPuM2Hj07FQF104aV38r/vVT61E+wKUZyL70TAfIPrlJB8r3skSsejG1bi
	FW+5KGrxGEyolK9tFAEEpEZ2kdXbMgsHpFjAzHziRlvIM=
X-Received: by 2002:a81:92d7:0:b0:618:8a27:6150 with SMTP id 00721157ae682-627e46df567mr31092207b3.24.1716410045488;
        Wed, 22 May 2024 13:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEquxDTlRXGGA4s22WX4KXYImQfH+64pcqPMeHwlR2wNKwmu5VhT1cWrWZHjKw90Pdk3ZCZHnvRz+hJXHtXZdo=
X-Received: by 2002:a81:92d7:0:b0:618:8a27:6150 with SMTP id
 00721157ae682-627e46df567mr31092057b3.24.1716410045103; Wed, 22 May 2024
 13:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522025117.75568-1-snitzer@kernel.org>
In-Reply-To: <20240522025117.75568-1-snitzer@kernel.org>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 22 May 2024 16:33:53 -0400
Message-ID: <CAGtn9rkcsmOiw0ZLA5DTYbybROMqp0rUTCbh9h0b1r29TB9oDw@mail.gmail.com>
Subject: Re: [PATCH] dm: retain stacked max_sectors when setting queue_limits
To: Mike Snitzer <snitzer@kernel.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, hch@lst.de, 
	Marco Patalano <mpatalan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:51=E2=80=AFPM Mike Snitzer <snitzer@kernel.org> =
wrote:
>
> Otherwise, blk_validate_limits() will throw-away the max_sectors that
> was stacked from underlying device(s). In doing so it can set a
> max_sectors limit that violates underlying device limits.
>
> This caused dm-multipath IO failures like the following because the
> underlying devices' max_sectors were stacked up to be 1024, yet
> blk_validate_limits() defaulted max_sectors to BLK_DEF_MAX_SECTORS_CAP
> (2560):
>
> [ 1214.673233] blk_insert_cloned_request: over max size limit. (2048 > 10=
24)
> [ 1214.673267] device-mapper: multipath: 254:3: Failing path 8:32.
> [ 1214.675196] blk_insert_cloned_request: over max size limit. (2048 > 10=
24)
> [ 1214.675224] device-mapper: multipath: 254:3: Failing path 8:16.
> [ 1214.675309] blk_insert_cloned_request: over max size limit. (2048 > 10=
24)
> [ 1214.675338] device-mapper: multipath: 254:3: Failing path 8:48.
> [ 1214.675413] blk_insert_cloned_request: over max size limit. (2048 > 10=
24)
> [ 1214.675441] device-mapper: multipath: 254:3: Failing path 8:64.
>
> The initial bug report included:
>
> [   13.822701] blk_insert_cloned_request: over max size limit. (248 > 128=
)
> [   13.829351] device-mapper: multipath: 253:3: Failing path 8:32.
> [   13.835307] blk_insert_cloned_request: over max size limit. (248 > 128=
)
> [   13.841928] device-mapper: multipath: 253:3: Failing path 65:16.
> [   13.844532] blk_insert_cloned_request: over max size limit. (248 > 128=
)
> [   13.854363] blk_insert_cloned_request: over max size limit. (248 > 128=
)
> [   13.854580] device-mapper: multipath: 253:4: Failing path 8:48.
> [   13.861166] device-mapper: multipath: 253:3: Failing path 8:192.
>
> Reported-by: Marco Patalano <mpatalan@redhat.com>
> Reported-by: Ewan Milne <emilne@redhat.com>
> Fixes: 1c0e720228ad ("dm: use queue_limits_set")
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  drivers/md/dm-table.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 88114719fe18..6463b4afeaa4 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1961,6 +1961,7 @@ int dm_table_set_restrictions(struct dm_table *t, s=
truct request_queue *q,
>                               struct queue_limits *limits)
>  {
>         bool wc =3D false, fua =3D false;
> +       unsigned int max_hw_sectors;
>         int r;
>
>         if (dm_table_supports_nowait(t))
> @@ -1981,9 +1982,16 @@ int dm_table_set_restrictions(struct dm_table *t, =
struct request_queue *q,
>         if (!dm_table_supports_secure_erase(t))
>                 limits->max_secure_erase_sectors =3D 0;
>
> +       /* Don't allow queue_limits_set() to throw-away stacked max_secto=
rs */
> +       max_hw_sectors =3D limits->max_hw_sectors;
> +       limits->max_hw_sectors =3D limits->max_sectors;
>         r =3D queue_limits_set(q, limits);
>         if (r)
>                 return r;
> +       /* Restore stacked max_hw_sectors */
> +       mutex_lock(&q->limits_lock);
> +       limits->max_hw_sectors =3D max_hw_sectors;
> +       mutex_unlock(&q->limits_lock);
>
>         if (dm_table_supports_flush(t, (1UL << QUEUE_FLAG_WC))) {
>                 wc =3D true;
> --
> 2.43.0
>

This fixed the FC DM-MP failures, so:

Tested-by: Marco Patalano <mpatalan@redhat.com>
Revewied-by: Ewan D. Milne <emilne@redhat.com>

