Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F3033066D
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524577; cv=pass; b=SGyghTyeeGOgZu7cmtNsdWlmVBjGWF6lTJ3/s8cU3XVJoPqdDIUF4iwJSx0m1/ySGIYo8R8MQxGbmVM5OV2FPgBzWsqY6buMnOgmrmEy7xzd6zYh+ZK2/+xWwaaJYp5iGBKxqaLVXkM3T4oz+DqViqh688aXxbdKOMCke1AqoAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524577; c=relaxed/simple;
	bh=OflXqsSyvvbmjuy8AroyLssO2EUMChVLd5GWhHBGiKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkCeT+L9vPhP0I4z+IR5+3LofQUrqUSGp2SbBFeZhkS3gIMbe1qcC4bf0qhcgkXskbUH7ExLM1sTsjH/ETS4zZ6xLiY9hVtf2M5HrnT/LZBSkZXlol7X6Zp1yW0SbpEuqXWWQ80+vCT87a5KPQSWkcI/pjPkPr6gkvtnR9rv8t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjPZgAB5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tyzn4DTN; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjPZgAB5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tyzn4DTN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772524574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vqpuyzZft7zvKOQUfVvHueOqa/tZf1UWFzBviVWPqpc=;
	b=ZjPZgAB579mQ50jKaE1qUOflin4AfyzjjBJkcgDV+wlL0wduhM/vtlWBUioxniVjsVpfaT
	2oxEL0h66SuiIC1+0L6qDvpBx2lsQ8lOceQB4OOwQXBg3Ibrz8JCRloDF5gOzF+jgz2liV
	vdiOi18ZAHiUbeexi5nGW6Ab6YVceSs=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-P69rXX-kOrSZeuS32cgbhg-1; Tue, 03 Mar 2026 02:56:13 -0500
X-MC-Unique: P69rXX-kOrSZeuS32cgbhg-1
X-Mimecast-MFC-AGG-ID: P69rXX-kOrSZeuS32cgbhg_1772524573
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ff0eb3ff4cso6404155137.3
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2026 23:56:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772524573; cv=none;
        d=google.com; s=arc-20240605;
        b=iymAOoKt6odSuJy/8QjoIeZpQIPcZ28PziM5Q0qPpVC/DqoUOYm0z0qzLp2kevnosW
         D5l5EXmr4byAgRD9FoYPVXRpFAhIXPpPCO2XVwUmzpeOUaf3F3kAUQSiSMIuQLsbt62B
         TEZ509291zv3WsL2sxfcP4/GGbgloa9fgP43IVE/rlUCulSBieaNzTxqr9a4odvSlO2I
         raFCuJl8UDFWO176am7R5UsUG6udovUndBBwuJ/8X/qJbPescy6H5mMHGpuwr++SYuiQ
         5XNxNIQyiEM4jpPRFb/F0sgVJRPyqgG/X5QhTyDM5Lh7vSY13CPfNdXBcB/RnL2kDRB9
         uYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vqpuyzZft7zvKOQUfVvHueOqa/tZf1UWFzBviVWPqpc=;
        fh=/rMlnLLIGtxOJ51D/SDru0fWpTYWAaAes5w2szu2PS8=;
        b=CZ8GM6dsLLd0rkcvRxGqVfkElZotFqglAH+nXxREv0VPaiX4lXLtPnYtsEWIm4jLAp
         WrLlFxQ0onlSB/6fzTGu5GubRQlrVLouzUpn5kwQ/Xu4YuSAo1swpXzZ+Wh4tla32gdi
         aEZe3pN9E3lSR3rBhikETKtdIUASQ8xFjuTE8VevuC0LdF/mpH5D22tAJSX+qs5P7Gn7
         qaeHYeiIyn4fr3kAxuPukZ72dd5pK5Bow1oA3RrN11It1NTfWIFHlTT3uHqzK0Pt+7X1
         4BbbHR51iCgeSfywbl+Vj7rrjJW+BL5ffEDOeJXes/R4GkuYGPk5HXZfiUALpd+9voRr
         FvNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772524573; x=1773129373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqpuyzZft7zvKOQUfVvHueOqa/tZf1UWFzBviVWPqpc=;
        b=tyzn4DTNZ4DCSgNkUAFdiiIgg7aADYe5Tct/ugm2IiGZUXnno2+FG7heRpB+UIzauF
         qICsHyJBmutja4ZD605haadIZMWv5NcLAvANrl+vHwT6k6yPeGzXUth6jZQgLhidxUPZ
         /XBYiBj2QA4PJbGox45lJGM4rVRShBUdt2FX3nwzC36wq3m2D7fmTv9zPG3qrFWhKUsb
         S6xwNfzNJnahWlGLi/qOVTfsAsptWSlsAApENC/q2+J26s5761VRxT/MOIBY/DMAmGEK
         WGtiSLBByGWIazOhfrYKf1QJ+uok8L8XsQWpiTwJgM65Bnv+Yzvewmv/ZHaeFjta8/bn
         Prpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772524573; x=1773129373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vqpuyzZft7zvKOQUfVvHueOqa/tZf1UWFzBviVWPqpc=;
        b=ixqXjWjqnflsgzFn+YsSGwJw1tePN9eXHnzV4nRNNaAEKeNYZN9JN7zYtYZ+pgyaNh
         MLJe+9mJOBSUcCQVzGEaNwzcngUW3gT8DjBtkCWFNcuf82AlY+pUSvLo/oQjsajrwbjr
         3IUktm+fwb0FhyJRbJ+xXdHny+0JadOJ1wXdFZV2niQ8D1xVQZE+JIUPjV/lwBtP/24P
         JiH/fq0pUFAwo9FDSKgxNKTnVK3v9X4JQCzukCPXZRHcfbynrjCDVP3zbuyAqKGpwgLB
         GTdDKECOLFZ3Z0HGg4I1YHRtGR2qhRCP7kVPkJag2au4l5ttMd0KO+8+mM/sUl/NdFrH
         EdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrF5O9z2HLnf8q9g/YU4xxe0FtzQkCoOOu8xJeScuUxSR6Rx4APhfSfSkTzkCQN0g0H6p3oZ4S4EgxjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeYXLS2sA52Kvl62SEZEEg30KhAuUIey0Eafqq8Iu29OaxtHwm
	j6neXWwzUTTBBussonn8nvULq25kysCzWJo0CZiQQGbZjXlCL+zpBJnOrY4cSOTfO5/PupnkN58
	6QwJMf/tYGs1d6gGQS5tr7+kLwkqTaG3pRvhMxWkccze2s57mCuVWMRWOSIykB7+BgfTdxbcx0I
	FTCkX3WTXcESShjGL1wGdKNqp0PfH5Mwb7DAaRUo0=
X-Gm-Gg: ATEYQzxtaBcEbmIoXexGX+jSm/UNNKQVAj3lHczXGwdNLdaM37wvbJlMviFJw9qp1MG
	aH+NToNYDi7EuJtveWFuuuxxdB8ObhBl0bpZ4hiRx2sbt7qZ3QLeYHOEVFUKW2QKDoeiZRlb4hZ
	V4e+//5ru6CI+UzJI6/gWcSg6K8beHisqJpspDfZkFYJ8H+cfhc5eaQKlj4gcil/6unStxh2UF/
	IR+AOo=
X-Received: by 2002:a05:6102:3a09:b0:5f7:24d8:537c with SMTP id ada2fe7eead31-5ff3252f6camr6568772137.31.1772524572971;
        Mon, 02 Mar 2026 23:56:12 -0800 (PST)
X-Received: by 2002:a05:6102:3a09:b0:5f7:24d8:537c with SMTP id
 ada2fe7eead31-5ff3252f6camr6568761137.31.1772524572546; Mon, 02 Mar 2026
 23:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303072517.571437-1-yangxiuwei@kylinos.cn>
In-Reply-To: <20260303072517.571437-1-yangxiuwei@kylinos.cn>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 3 Mar 2026 15:56:01 +0800
X-Gm-Features: AaiRm51a4hxcDT8fFpcY5aWe86X7Bnd7LdvTi6oqAXgl9B8KnVVO3IoKLAkYDH4
Message-ID: <CAFj5m9+f7KsqX6e2vWwveiCsFobJ72o4VF-jYj37Aqs8yMBupQ@mail.gmail.com>
Subject: Re: [PATCH] block: fix page leak in bio_copy_kern when bio_add_page fails
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 3:25=E2=80=AFPM Yang Xiuwei <yangxiuwei@kylinos.cn> =
wrote:
>
> When bio_add_page() fails in bio_copy_kern(), the allocated page
> is not freed before breaking the loop, leading to a memory leak.
>
> Fixes: 42d2683a2704 ("block: simplify bio_map_kern")
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
>
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 53bdd100aa4b..ed0ff4e77833 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -398,8 +398,10 @@ static struct bio *bio_copy_kern(struct request *rq,=
 void *data, unsigned int le
>                 if (op_is_write(op))
>                         memcpy(page_address(page), p, bytes);
>
> -               if (bio_add_page(bio, page, bytes, 0) < bytes)
> +               if (bio_add_page(bio, page, bytes, 0) < bytes) {
> +                       __free_page(page);
>                         break;
> +               }

Reviewed-by: Ming Lei <ming.lei@redhat.com>

