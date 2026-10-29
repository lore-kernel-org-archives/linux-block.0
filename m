Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793277312;
	b=0e+rsljwgHefXUafNAdtD9impu5tGTclSVCv/iECrmBQuACF+1RzWy3M2sK6WJsuqvdF
	 Hza+qHcHifHXReuJ9dJ/w2yJzlBpfdqPe7bwrOBCQvnYLNBpwbYO0rVPMODG99z1TsalT
	 124Gj0A9gVxNefeuPr6kIH15afoqHhwcu0dHlkAU0s1xA3VGfPvNCG8056mKYnTLShksh
	 hPWcfPESFxEbpoBIFpxGfvcPLMndF5Bpl6UGpOBKNWtiMHqdp8r4VyIW9ccf/R31mLYrx
	 BgMiDvjNF9Wz6vYtOU0sSdlNUHxSablxkG5UICRardlnkhSKVXs14fm3g6d0wFhiRIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ws6QSRlxf9xUUT21hz9FQPNuauLV0BVZdCHG9RDX+/0=;
	b=Wg/PkZ197RtpteMzBia6hUPruc4i5SkxCn3R9s/056AfdHta17Lqu3UrJhXpgAnkwm+S
	 N6DwOHjBVF6FtooGS3BWARq2h2QRN2fuX8C6U1Dm/5mUWpTumgHhJbm6xI4WPgDaYV9BQ
	 05ijdbL6i5P+BvnXsAEBMfcyahcERWVNRjdWO8Rj59efVXziT0t1wGNvbwGH//SrT/Zmt
	 ATpnI+Qn2Q75HXZsm+S/wQ+yKBZw0ImDNwXJ+kTfRvVoHVlaKGBhDDEP64dPPO/J+Fr7c
	 gl9uUMJavmQY2KNyCqgM753EIEIRP135cRoI97FWy8wkcyJ2t/zmI/so3J8wAPPnwwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WajvgYe3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645F606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8645F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WajvgYe3
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c49c32650adso235155166b.0
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 05:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793277311; cv=none;
        d=google.com; s=arc-20260327;
        b=eKyVr0SVfEiZicArUiSXfty7mkKuNpQiKBhZPmnxUHDo0XSrOR0eJME5axiXB0ykQY
         57enLXbv8ejJO6Ir6zHpuP+VkplGXjYAYXsG5+mKXZlSIuHX2AYtAnT6kZ7yyvo33yII
         5/YOOBlP00t3gEAKIRSy1MR7PeBj6CsFqMEzOmDMOhOdnOVe5LjTHfIj/tZ3E7D/GPSp
         WBDjIVy/BCtvv9HJSuEcfHNfrZb03hMLqOHILLHiEkpWwCeH1ieqPxZXxmmHPNQL55Ou
         MzANPwifKVMoUZ/ARwm/ylLLqoBkBlhDK27Jr0YvUrvwW+lIdrz6eeGQzQeErQtd0tAQ
         AVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ws6QSRlxf9xUUT21hz9FQPNuauLV0BVZdCHG9RDX+/0=;
        fh=WaznP8PJYQ/KM3+xVl4Lw1mIrH1ie67MY4oDer2snQ8=;
        b=KMvAldyW75ZIYDPsy2/qfYtRfsFYqhPU+6w1rRv+vwBYe2qb/7TeCIWj+X/TQAp823
         wRj3mc8X3cSQysVRZchFPHJy5cy0IZOWE/hkWNhSD8LaG8ZyRfiCj+DT7EhODyMY1kf8
         +wKR6q350E1JlRbS4D7Wl0/jKlF8rJW6146LeNjB3X3+oONKY/0oMK33sxotmrTvCHGn
         nq3sUrs8cn8AqxJhohKMZSuOYHaAoscmbqBxSWDvibtyPsqc+/iXXNIIrGBmg8/E1uSU
         gHtoNpeUgfJHdA09ADMsjjiCK89gYypbUQlR+LEdIdnV0mIafpLIOJ0T1TaMxDLW/u+m
         MWYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793277311; x=1793882111; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ws6QSRlxf9xUUT21hz9FQPNuauLV0BVZdCHG9RDX+/0=;
        b=WajvgYe3dYlapDFzAm2oRhMFFRUA0gMWPJK+FSjU3Hs4695k19A2fz9REimtDM4DHf
         ZO9ztyz0ihu4N6NaHoObMF4Cf56C8Ue893fabgALqEaM3Sr+aqYEpuFJgouHDvqQH0Qh
         d0RdWCpK7+k1HDyIh51OB6TrcdDL5i9u5BnUPiSAkQ9dZLwu6CGm8Ru1ZTRSzHUdsGbc
         KA2Ktdeyyj8qkj/8VN/PMjWJQrMX0invtnh9kxoCRxiazKIGzMMu9NezJGl3NWaBeHyk
         3zajunPQdTSXo/3BCVClZ75IObXWTHPXkpr182tGKkNVfmDgbOK7ZIcY+ESA/psYG391
         CDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793277311; x=1793882111;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ws6QSRlxf9xUUT21hz9FQPNuauLV0BVZdCHG9RDX+/0=;
        b=drBrNnloeFLzRxm0jcLomYabCTAZE7L1OMvbKRiygu/ukj+HaI9omjXU+Qn8PXhGIr
         UAyEvO69BCae4Jf+WrrSM7rfahQqr61sS5lhoEuX14gooqYfZQODqfxFbxZ839E+slE7
         rvrwyAwUyOH5srLt8V/Ph4Tb0sy3PM61FN5EvZIM8Rgn+3Z1HRI2W37q0MkJkYK7Kxkz
         142XHN5j7YAVQd5HSTJaDSg4zmttC7QDLByH/I1vPt/zJri1aw7+z7Q1GQjPYrZhgkNW
         8ATr47zPfy5NDIjzvYxwkxjtpVfC2GZcV7j25R5xSBfpvYf8Xjj0x8cwnCInkJxEub7o
         jNHw==
X-Forwarded-Encrypted: i=1; AKwUvBzL6Bws75cZrIJCYo4PkvIM1C3HYKHFLYSmV2fIqUGF2sJAAFCnrLXktHH+uLuxRMusA8OF3HDUAiACWQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLR68kw8ToMdo0YTVW+iGclmzMGFqw5FVPPG+moSJXSXMfhUn3N
	9tXolBb1cIfnwdRjXH9FIPHaQooWejREP3ejl/VJmwN0Vi5wl5HRbTOAcMDR2MvWWOFySj/npy8
	ADJNuZwbSDuCC0u6cjktGtn+qwhupDA==
X-Gm-Gg: AYBFou1op67q9w6TE00moI05XNA2D63Wsl2qYlEYH5sI75bfaWuOOe5zjxFZfomsbpP
	qxyNBgrbrqtevDIlsmAhAQlnKCnMeiBqPQS669GJFUOvO8kObKT2OWFMeGZ2SS1Y/0OloEQWd8X
	G7Qq8mgu+uXn7jOVJQr0aEri961ZV6br8+ZIxp9UrXliAucVdF2S+LX6mDBjtlgbzwGBL8AFJCC
	tyLHruIbkaIHPMqp4DBuD3RJc5bLzwbvvLh96C83eyEeBomNDQT8UKZEIa4TTk0FdDbZ3H7McTz
	7sO77J8ZlfeZ4JAgkazBIeoBDDRF4VmS/+A86BtRPzfiCC5Dlg1Oq70EiXN6dl1atqxe0yoVsFx
	5cr9fNniviRDivQNVbqbcZkYKtj37dMixFx6OAKXHBTHxOwSfeTSPNYqbooNOKqiLcldVS69Wbg
	5Gl30abi1Qe05mmkWR8pU1lqx3FaSX2htpVqjlcbmea6r0
X-Received: by 2002:a17:907:9686:b0:c41:30be:4f84 with SMTP id
 a640c23a62f3a-c49bdf0c1f5mr467599266b.9.1793277310583; Thu, 29 Oct 2026
 05:35:10 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029105330.1427462-1-anuj1072538@gmail.com> <9d7703c6-c502-4c2b-a896-3fe251198a3b@gmail.com>
In-Reply-To: <9d7703c6-c502-4c2b-a896-3fe251198a3b@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 29 Oct 2026 18:04:32 +0530
X-Gm-Features: AclHuK_YBtLuWe_ufbu0sNZiXyjbyONJpQXvV055-JNraWyiad65juq_C74OUSs
Message-ID: <CACzX3AvGG3PwiCfHX0UNNLDB22ve8nPjQ3vPaP8vvs2yNWEX3g@mail.gmail.com>
Subject: Re: [PATCH] block: don't use the bvec fast path for dma-buf bios
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, 
	linux-block@vger.kernel.org, anuj20.g@samsung.com
Content-Type: text/plain; charset="UTF-8"

> That's odd, I recall adding a check to bio_may_need_split() before.
> Thanks, let me test it.

Right, v3 [1] had a BIO_DMABUF_MAP check next to the
bio_may_need_split() call, which seems to have been dropped in v4 [2].

[1] https://lore.kernel.org/linux-block/646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com/
[2] https://lore.kernel.org/linux-block/f97985ac5cfff3d9f7777b93f11456af57e253e2.1785274111.git.asml.silence@gmail.com/
