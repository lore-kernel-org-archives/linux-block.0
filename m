Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779102DEA6E
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901612; cv=none; b=UzODv9EwyAF5QTf7xOPZ+TjXVI5fnxrAsC4XrgYNY9Nostb85v6rACx4cNnrHjwKbCEchG1lWs1xz6yRpLzKeCIQ+Irp11mED9SmQccxIcEtWBi7yS1oz8y2sjwvtYFgOdB1UpWV6Zfcj3j/GmK+IdO3UrE7/Qnyxpl/+VsuG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901612; c=relaxed/simple;
	bh=9I48L1irnweIBx4TTSac9Gg780m997BU0eeBHwEtAjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2zvmP0cnGrEn0Xf3JgjeLe4+giSvEj/7VeppQLYMkKFBRTy02fUpdwECJfNpwHFfymOcfOnDUQtXrr3eA7umE5xTk77Ws2Hg6B6AdkB85NLdxwka+w7Mwp4QezeeCarxzDP33shy83hZmYxZLlQipRlLF4fkrMOykuUjMfORCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZVVBUzd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZVVBUzd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751901609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muwzm2Yj9piz8p4XGq/kFFkCDvcXS0AOAX32kThgznE=;
	b=MZVVBUzdo+PejHhFUO7waPtYSMDPkeYjRSutMH8ZHmDiTKZKj2g1DxQEIxqJKjrttXILbb
	sKUNBqe8B0T6IfnaDGofxkvGbrtAIO8qdTkhjWzSKhvDlWVYTBIgJ6Pj6LXyZnzuWiatYe
	xiX7MWYBmRBSSAQfCDvtMWVLE0WKZCg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-urkvq5Q3PIiZflKR-AsW0g-1; Mon, 07 Jul 2025 11:20:07 -0400
X-MC-Unique: urkvq5Q3PIiZflKR-AsW0g-1
X-Mimecast-MFC-AGG-ID: urkvq5Q3PIiZflKR-AsW0g_1751901605
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55629c3a5daso2567158e87.2
        for <linux-block@vger.kernel.org>; Mon, 07 Jul 2025 08:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751901604; x=1752506404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muwzm2Yj9piz8p4XGq/kFFkCDvcXS0AOAX32kThgznE=;
        b=nRth2f8U2ombeQxd84QnCO9xBNg+OGU5b2viMGdAIJl3EZoFL+1jXez3sfFzXE5V5A
         NAyPT23PGI1wNB/A2IVDtUuFQcLCbOEj1lrjrXxrSPH3GJB5nAmaoies7SCuRJxq+edT
         0jK0EwOdVumrnPGFHoV31Q7d31BuFRqgnncD0tm6mKj51vcPeoN/CJn3HK2ELX9msvpq
         pyZx8HxyVhD8PU5PzQiEGLrHwFaB7NJkgd5fsVRyjdqSbybSUvMjSVvjbJpPnnOXWncI
         gW5AyBurxoWL/MKFG7tYF0Rzn5TGGfyq5oI7SMfX/bI2q3vV3nJuSMIvoxewfD0Ftt37
         WpAg==
X-Gm-Message-State: AOJu0YzFwccXqxD40ymmF1avTVpsanmO30z1ymBb7tI8IjiQTxbEKLK0
	gQVh+xzH5U1qhqKhdjpnuFO8jAilA8EE5uRMlwsx/o8mql5VGoNphoTJDK3qNz/Gc1URR2+pVM+
	vtwwcqUSncAKzgLAdiYnGErQVXbk3RRHNxN59kbWkrNefIRZypO2y53P94/D1oBPItsgCzwD2V8
	qqROaOES2Yavf4BlpjLuGRX9D8yAeeU+7l61pzR2o=
X-Gm-Gg: ASbGncsRBm43dHr/xTz/jy6UcvmkCFqfcFP4FFB/bkpC8pWVZFCFRJ1itiLpeLaEf7K
	FMHlCxRpBxttuJLirZS8HnfCGDgzy5gqGEp++nAqwFqf22xNugxDej3HcWQe7M42fb9wNZQk1Nh
	7y81yo
X-Received: by 2002:a05:6512:1107:b0:553:5d3c:e444 with SMTP id 2adb3069b0e04-557e5539548mr2083842e87.25.1751901604284;
        Mon, 07 Jul 2025 08:20:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWquwldnTvkGhVJKYGr2KGtT55cJm5gyjZm3YsR7Xde3v6NJCAFUwNaIOGqwYgOzotqSopmEKaLK7TOQ4S+tc=
X-Received: by 2002:a05:6512:1107:b0:553:5d3c:e444 with SMTP id
 2adb3069b0e04-557e5539548mr2083836e87.25.1751901603841; Mon, 07 Jul 2025
 08:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704105425.127341-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250704105425.127341-1-shinichiro.kawasaki@wdc.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 7 Jul 2025 23:19:51 +0800
X-Gm-Features: Ac12FXx8fsNpm_nlAZuvWYlA6qj9xSI95yY7Gqn0AvIWVTHcO-QSTnLXckxivKo
Message-ID: <CAHj4cs83b59HMPfWNyvt4Uj6hhgooYZfXuu8zqeJ-LOLq6i7Jg@mail.gmail.com>
Subject: Re: [PATCH blktests] common/null_blk: check FULL file availability
 before write
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Yi Zhang <yi.zhang@redhat.com>

# ./check zbd/001
common/null_blk: line 67: : No such file or directory
zbd/001 =3D> nullb1 (sysfs and ioctl)                          [passed]
    runtime    ...  0.167s
With the patch
# ./check zbd/001
zbd/001 =3D> nullb1 (sysfs and ioctl)                          [passed]
    runtime  0.167s  ...  0.174s

On Fri, Jul 4, 2025 at 6:54=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Commit e2805c7911a4 ("common/null_blk: Log null_blk configuration
> parameters") introduced the write to the $FULL file in
> _configure_null_blk(). However, the $FULL file is not available when
> _configure_null_blk() is called in the fallback_device() context. In
> this case, the write fails with the error "No such file or directory".
> To avoid the error, confirm that $FULL is available before write to it.
>
> Fixes: e2805c7911a4 ("common/null_blk: Log null_blk configuration paramet=
ers")
> Link: https://github.com/linux-blktests/blktests/issues/187
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  common/null_blk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/null_blk b/common/null_blk
> index 83f508f..7395754 100644
> --- a/common/null_blk
> +++ b/common/null_blk
> @@ -64,7 +64,7 @@ _configure_null_blk() {
>         fi
>         params+=3D("$@")
>
> -       echo "$nullb_path ${params[*]}" >>"${FULL}"
> +       [[ -n "${FULL}" ]] && echo "$nullb_path ${params[*]}" >>"${FULL}"
>
>         for param in "${params[@]}"; do
>                 local key=3D"${param%%=3D*}" val=3D"${param#*=3D}"
> --
> 2.50.0
>
>


--=20
Best Regards,
  Yi Zhang

