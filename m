Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAF598BEC
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173196; cv=pass; b=jqMGG9pHY5Pgvo4WcLzhMNud9KYtG5HGVo6wxP/qyzeiBKOCO5Yf7ZK5VHqddBpGJSIJSTHFIDALzz/AzB5N7q9chFYB0ekpR5fAWupVCXbHt6RHpIrbZGlYAyi9z+zzXuYpH0qKosy6XPjpxcut9pwghDPBA5hdjl5IA5wEH0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173196; c=relaxed/simple;
	bh=qxhgwpxti99f3N2pyvpz0N4HLMGri6OKfQ339YhtyzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSeSYB4Y7Ft/ozWp7CIpnTRkIlqvYCXsi8nTRg5VK9sTzo0nUXCmkq6++Kx92E9cGFuGMVu4weV1AB2V8Mi48ka6aZe6lFJA+0oaTXKvjVbCwMao6pREjPwFOH9MijRDzbS2D/HzhdPqb3KrehgmcHetWUPS3jE+D80aEMTkJ+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnUYbNFw; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnUYbNFw"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso169536e87.3
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 10:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792173193; cv=none;
        d=google.com; s=arc-20260327;
        b=PYYYC5f0ovqnovr0hxXf+SByFejuu2q62yWzoCLfp2C8LaFdFhc042JNmtLS2+HAG1
         SIyNvnOKJC/18Xsimv4h7gRNzsFE7aVnGlIb9yVYJjUlYYWS2JoMIy5roldhDSEklcAT
         4PWTUdskmnrOc/lGkCCRNiBrFgz8062c7N3AjKjfSiVzCR74AJmGaLWyE5piPQHn2eKl
         x4UkghFILGGoSNyqcKNpyGOzTep0mT6nTnYhX8Zy1vJ8+ca/97envHJZw2NwnoCeKehi
         E/lFm3ayJ4ay6+YcBXJK9WXMAa3GEUL+SvCYNOtTKh4qd24xxnsM0s7oCaFcMQiOsa5z
         wrIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3tvB3Clz576g5yH+PklBQfBq0dVAjbbpBq8eyXb6xzQ=;
        fh=0+GXwI94Hgq+Afeyr+YAnhGXwTfE+gwRySXp8j+c9fc=;
        b=ft8fUk8NGGJIc3zavW7bM3SGxGW9B2Russ4IP/QKFeTwyM7Bj4PoILkz/uhHeLyceo
         69X8FFNUV43FM3SKfGLBX1alWULibHdHS2LLbXmmNnWQZd62OS6svxpi75BT4KZWVDF7
         edUbk7hH71eGIv3xE1kyY4ZMtvyfFq6FpRDWxRVq3gw5QUhntLvjhBqVAOeovRH7tbqT
         Swr4i7dA21uijCkbKJgaIZIeqZOqqmziMaUkzkNbOoiKgdKCBFfKu653J0f79ClDPoaY
         ksJ3cOccXCb7fbd4Gbtr2+JHVdT9bkcIzmowIBV4Bhr9rgCjyXqAT1jByNTZSRzFS/93
         u4yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792173193; x=1792777993; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3tvB3Clz576g5yH+PklBQfBq0dVAjbbpBq8eyXb6xzQ=;
        b=hnUYbNFw3Ga8mMPBBPrjI2JM5G70Henf3gMwkyurJnPXl1IZjOLZ6QzuVfZ9dlco+4
         D37AZv9f7aPG02FWgmKdk3gXc/pjX+BeNflM84Y2U8A70ergKVIeiPNC5sINRG/lvj4l
         NVmlaac5JHWkigcvnRcktDrelFwnHQocMv3MCS2hYT46mlcLMS59G3PPGMZ7Ojlpfp34
         pzGyvvmGlAqkV/227QnwjnFI9jVQADQr4sDykjnlxQOUh8LvvXuxpCdEYfWg1GPRtSq9
         qzQBedmp3ONN8OcO5D563Q9cDcOTh6eqv+XSwsJ771cgkIAjxWT2n5mkVNx2eJQ6Ilcj
         fHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792173193; x=1792777993;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3tvB3Clz576g5yH+PklBQfBq0dVAjbbpBq8eyXb6xzQ=;
        b=pd9J07rChVzTXFcRQWRLonq3P9HVDwY4+LUWfCX4z9tioSFioF/7VqxnZVcb0PEU4G
         wp6UXOwyQWSTyOEOiWn4TqY0jaO0WyXymHiNjJe70VyLUX78LTp2BOVsOv14STjjTlSI
         Gr5k8i3yZWFWgu3rt8rIp833rjFKA50KlWi6mlVav2nWNp4UewJbs1M3Xqely1i4hxuV
         UK7tFJgBqgjFUs2km1boZOdyqRDqUN+Q/mqu/Jloni1Mok65y4qnX1Qa5i3EbZOg8wsa
         WlrjpakaR+f9U1XVpOkBK4nMM14s49P+NG0XR/uoi8M3NGI1v7DQDHeCDMJtnOn7iqHn
         NbNQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4pvAMZFG42EE3XuCB/hJJ8XXLINBvlJE0ry8nE0Q+jYuhuzT3R90ldZZuv6U0Zn+CCFWUcizrbUCaYA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL+Ry5hdipfk9j1k2syWKgVWM6+ZVTEzAM8rFZy4AtL3WTwcKbT
	1UQbKn9xa9tF57ovIla42tzgEZkM4Ak8d6T7UwjWD4Zd8MimVuAyGLbIqZZvYbabIvEdzDCFh/i
	6VBORy411QkwD07fs16UWOzfjrByUrVHH3AEGCI4XnqS1WjhY+64HavkJAcM=
X-Gm-Gg: AYBFou16LjXxkiIE5t4SSI2HMzeSLolNW6UN1frM/Xtabs9xvRDe1AvLxELEbkfkQCk
	YfjJlUClV3kc2f2yXXZKjvpoknC19FPKrEe88+G85joHu4SUleveGk6GEWYm6sia/Q/9pctAxlW
	v9HNh6POJZEXRfy6JgMvClcGhZv3pwDYP4Nqe1tlXAf+BTkKVOHdaG6i8o212Haza/KCbvPfrHh
	x38/P40IqDrUBau3eFwpQ9+DcDtysfKZDm57hkPZafg5baDw4iL7kYXDh0NDhL73J5SMh8PgvZe
	gwZJooGG1P9v9A1jx8vBfhTWvxB9XpP2f8Mj/84UAmbcyJQRNae+Lekxzk8i9XB0hbG7AERaRQA
	mtgFr+7YbcgYgEB5Jt3n6
X-Received: by 2002:a05:6512:124a:b0:5bc:d0fd:8c13 with SMTP id
 2adb3069b0e04-5be50a739fcmr81558e87.30.1792173192356; Fri, 16 Oct 2026
 10:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929160813.1599129-1-tadamsjr@google.com>
In-Reply-To: <20260929160813.1599129-1-tadamsjr@google.com>
From: TJ Adams <tadamsjr@google.com>
Date: Fri, 16 Oct 2026 10:52:51 -0700
X-Gm-Features: AclHuK_4Rv34tv-YMDX0Nx2GVH6URUQBwfhaVfCGCmFbgDv_SHA6doaKWlcSpYM
Message-ID: <CAL54Jgdt2QFZ1_p9nOXHviQsSHnXpOt=x55_Jm3srN5fqVsMoA@mail.gmail.com>
Subject: Re: [PATCH] block: advance iterator after copy-in for SG_DXFER_TO_FROM_DEV
To: Jens Axboe <axboe@kernel.dk>
Cc: "Christian A . Ehrhardt" <lk@c--e.de>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 29, 2026 at 9:08 AM TJ Adams <tadamsjr@google.com> wrote:
>
> When a passthrough request uses transfer direction SG_DXFER_TO_FROM_DEV,
> bio_copy_user_iov() sets up a temporary iterator iter2 with
...
>                 ret = bio_copy_from_iter(bio, &iter2);
>                 if (ret)
>                         goto cleanup;
> +               iov_iter_advance(iter, bio->bi_iter.bi_size);
>         } else {
>                 if (bmd->is_our_pages)
>                         zero_fill_bio(bio);
> --
> 2.56.0.rc1.315.gc6ed9934b7-goog

Gentle ping on this fix. Please let me know if you have any questions or
feedback.

Thanks,
TJ Adams
