Received: from mail-oo2-f35.google.com (mail-oo2-f35.google.com [74.125.231.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754513DFC8F
	for <linux-block@vger.kernel.org>; Fri,  2 Oct 2026 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790920719; cv=pass; b=d+yd65i7GhUYIvp6yQBJFZAFOFifSmHZhcTwYdWJjP+WhnMB8lsABT/h5rJM22iZwFxdn5vmbuEbVPZ5uHzYspg5yY5s7BKT8W76ZsRTquHeXy/Luh+zX2MwuEVTuJirtz2hzy7D01X90ajuHwNGkkpkvtm+Q0VpI1y/MTpJN8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790920719; c=relaxed/simple;
	bh=6ul12ShhhdnSjEzPLXZMAI9Fhat/ocCFJ2S5mpN0AkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdqKtIjTSkwBxrVL+TGVOy8TkAw/KqGmGJqhYOU6vB/9hkkMzQRRhk5MOuiYNqOSCuLZLlc2kRARlsaeNR51YaBBxA2aUl7uzh9GYzsj0sSqat/ZvuMrp8s8wK3bkGubARcD3QafJrwVIgASjPY2F2weRDYVbzF6A/OmDs9dpYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kraz9GB0; arc=pass smtp.client-ip=74.125.231.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kraz9GB0"
Received: by mail-oo2-f35.google.com with SMTP id 006d021491bc7-6dddb9da607so1009027eaf.3
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 22:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790920716; cv=none;
        d=google.com; s=arc-20260327;
        b=r/ZOgV3BR4nq/OpueHJPr9YyXNBVxL7iGu0bXv/2TbAO4uUQKQQCre5anaWlLpZkGB
         Sw990ScY9+DwG9/WWX5Ztt60XGCYTgDYDFFu2CkznFxIlrIaEsQR/MwPP+aGr1RxnbRB
         BIFznkU3LqZTRBVPcV77E6Cms8KXfYzvHg8Lkgtu0SNwBR0fZx0V2gvS5afRwe1mvP6j
         86qcthqPBpT9IZ6j8xjFZVbcfd1y/qLa6tHO4hxT8mv9RzfDmis66bch+HEaVSLwvDoY
         V0zTPxb8Efa4rK1jh4zLud1UkEESkYon0iYMGxNbFchP7LoMAGUdSS9JvQlbfA8T3K/I
         53+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ul12ShhhdnSjEzPLXZMAI9Fhat/ocCFJ2S5mpN0AkM=;
        fh=CX4crz3LOiRk6q0lBb9RRgPQFCe9PQexfL2BliJTh34=;
        b=KKcS2+cMpUBujR7AjWx44s7yPYI3tR+idrn+6kVFtTwOAxp6cjQNiDBWGv3SE0+Gyj
         gDwTanwJEtedzAqR6E559ufnEM8LMOMbVZnkVxz5d/kSl6rx+89MNuD8sJOhY19O3Xpf
         Z3gVTA+DbjeeX3PhbIbGgFucYTOcBZORkuCBkr/V8Z1ddi+2IONsowoyt5juqW8AIO6/
         a4qqKvqA35GrFu6EO36VF2FeNcsaRcsxzbrKm6FkYpZHuc5ysXPLW1a3pn/Lkm4zeOy5
         eqMXnOIc8B1gISh6LSiqZL6KR2kh8pSIbyIU+QrRen2XHmZCY8A6AYpKIr97u8xF1g5K
         V0MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790920716; x=1791525516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ul12ShhhdnSjEzPLXZMAI9Fhat/ocCFJ2S5mpN0AkM=;
        b=kraz9GB0ePLMEY1SjAjSo2lnKHTisdKvFBBI6/EidtLcaSsMdsgd19nJvTWOJU+Apb
         X3ge4mjknG1rzzRwJbVM+cF0tN7Lc8fi/Azh3Om55rSzxUDkCnIHtakWq6ipp4BiPzI3
         fTdVkS+1jrvwyHDh4QuI7Gbztrq1rMBEgpHuW7iz3vbsX0ga4eeuYv1jQVa5YE2GPJjw
         2RVrYGzW9j9ND8S/qtWKVQip3gPnjkoNbvKxcmL1OGwogDIHcQUSabdhZdUCdjLy4TY4
         KcioLU8haKmXsD/8TOAHhjfdjlUmHoRrZCdHwCfcBTvauSEGfjMf3+HSL/tUSjTZvFdv
         YMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790920716; x=1791525516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ul12ShhhdnSjEzPLXZMAI9Fhat/ocCFJ2S5mpN0AkM=;
        b=16eXDZrk6wiuNfxmD4fPJysPksbdtmdpjwvYdCO8+Q63SjIo3ESE0KFX6yc64WrRqI
         jDfsm+j0WFzlIxhvLiP+CCw1g1SIa1X6MOdbzAtbZDIlgGCCI/CU5OLoMsOq6kVVxHlH
         QlnwChB45cRZF7941pexMgZYBPq6cxp3zGMTvtfOg2z4kIBuO4RtYGKz8o+AAkNhIuFb
         HoZ2m0nbCHIvG5JpLGSY3H5QrfYLI2fSog97Ye6NdY9xnLuD5S3TEgAt93axUMvceNeP
         aXWlO5/GbEkPkhWTO+B7odtKo4SVp61PwgEzgk/SJbyXhTVvI8zfs2EXYzq8eUnz1ChE
         FZmw==
X-Forwarded-Encrypted: i=1; AKwUvBzVRgZXlig5bpmqY/sN9p2bAww1I32cjFSK58k4aQBd7FujYP/QrU1df55KQMPRCrRiK7afE/81ipysig==@vger.kernel.org
X-Gm-Message-State: AFuF++l6VnubITALj2EbMrRaSNC7fAZ+yjFv6/ZZDDXkBs7JveIETslu
	/kI8KzlDtaFKa/FSF7bac1bLB0Ph/LxIpp4P1KwBEhBeb5iDt+S8USjwkrDPF9G5oqeiflrbuPN
	orH97JFqnci03zgeTo9LaLk1qXpfvtuM=
X-Gm-Gg: AYBFou2eDUMQOWRTToWrgox7MNhNGLpIyp+RlZMFhAg72/X9yX4n7ZnV4FKIe8qnCuZ
	JjNDohVVjjTrIZ1gAOTO7Whk5Oh1wLJE79WpEOgA9gfVJjOSfmEgMLcgppjtl/I3Kt0486+6j3x
	sh5A+qmE3VSwIGQhHtjvETiGzzx4aSY8rPmdAirLBgpcYYRQ8KL4fNbfYAjF6pHYeoWuqrKrm+3
	8+uDxcpTH5bgiVqOKwWdwQHsrTOJ/FBvibqdhlK38LhH4btOZBd5FQwq/DgiZjAsNT0KJQsn6mJ
	eu2kqaH8BBrwOpvTVu4otyPPZOaMHt6e99cGViIRE7daobLCHco1nBq9qSg3NtL7kk2VEfvy8lR
	b3i1/IuFxDdYWNHhFwai51b9S1PPeemlW/1LwU0IaA91AKWBF+uFCa2B2u7iOy8QplA==
X-Received: by 2002:a05:6820:81c9:b0:6dd:40e5:3788 with SMTP id
 006d021491bc7-6df35a3ccbamr1230139eaf.83.1790920716194; Thu, 01 Oct 2026
 22:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930005914.2133-1-lirongqing@baidu.com>
In-Reply-To: <20260930005914.2133-1-lirongqing@baidu.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 2 Oct 2026 00:58:24 -0500
X-Gm-Features: AclHuK8wuXwhFkjO1EDsKiUX6JlQiB783NRqJazobSzq4sh95uymDiPu59MfE6A
Message-ID: <CACVXFVMirxfOJ0=fBabi_nhZJKyTeGJXEQuxLGzi57P6xpVYPA@mail.gmail.com>
Subject: Re: [PATCH v2] ublk: use global index for reported zones
To: lirongqing <lirongqing@baidu.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 7:59=E2=80=AFPM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> ublk_report_zones() may split a zone report into multiple requests when
> the number of zones exceeds the temporary buffer capacity. The index
> passed to disk_report_zone() must refer to the zone position in the
> whole report, rather than the position within the current request.
>
> Currently, the per-request loop index is used as the callback index,
> causing each chunk after the first one to restart from zero. This can
> make userspace callbacks receive duplicate zone indices and may result
> in blk_revalidate_disk_zones() updating incorrect entries in its zone
> state array.
>
> Use the number of zones already reported as the base index for each
> request so that zone indices remain continuous across all chunks.
>
> Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Reviewed-by: Ming Lei <tom.leiming@gmail.com>
> ---
> Diff with v1: pass done_zones directly


Tested-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming Lei
