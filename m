Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293964;
	b=NUqSocNH83HucHlJM600Y5UMNAQg4sWq9vJjQQE2MS2w852YybNPUdSbnj5+HMOBZscq
	 r40akdGvG13LJcht/R9nBWgPgDDWK2alMljJKhRYpUG1V9/vBYNp5EcFqNMYv6qLqa8RK
	 pRJVA3S9n7idR47HXKlCNniFvCH/dfldZzqsdty/mDH3TqvbztkhYCK8ro+MDvfkcQbWo
	 EmfITY0Ss02YEmIgI5CH4ywE9j5psMCX4W+yejH1CzxLOqRNsLZ8F1z9rv4loXTt7UnDH
	 +hu2Yje4O4dtBW8mznfWqkLnS0faPnehF0p2DpmzFxSBN8I/lF9leMvd7kHx9d/GliA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293964;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=dqlkwUV9tYAEbSb1BQ5TfPNY6DFBwHzpfk0RyIwAqNI=;
	b=DaIzU2UtP1OcIdF3fgFqQaJMlrlSJvXz0kv/BpQK4/8balEoI9Nxu/htInteW+7RLX6F
	 KKR7ojdc4ZMbUvIpQyBrjknIPK03KmT/ZYif6T0olJCFK5CZBZBKUf6bszU3hrFVDzr0R
	 UCwA/+BNlKvG2BT89tyEhWxkAFOrC9B0cUiyAq7yStbFkm4fdROFR/KoBiye2wYOfsUd4
	 IPNzth03rGDO0HLtzhFyPODB6j0ZZ17tVcnUf/MWN9jl0zjPJKfCUQl18/ehQMp6w8Kfy
	 0tr10a2N9o5mZSHmNewdOGUOGOgOxPsRguHvHgvB8QRkl5QiG5a31HWS8C8IoJCZ1aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F0606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 17:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A10F0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6de1fd5f572so1170802eaf.3
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793293961; x=1793898761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dqlkwUV9tYAEbSb1BQ5TfPNY6DFBwHzpfk0RyIwAqNI=;
        b=jbB7m5xkSbMsVHA43BS/Wdw7yxNxRXuSxF9sZjwaxRsa+P9Adr+maDdfwjMVW0tt5z
         9xy96Ryetgo0KDwM83jlI3Qo/k8orojzOGXRu0ZmRbtx9rvEamnNQ0KR3vl9oElWqRvL
         AYaVN/0pXl3h5Hatlvx2he6KkzZ7uCNhnrEhE/2UFwIiYzli25MdkmJpnmm3BQS9c8Sr
         FM1+0Olm0viL1RsOGum9YEGxlmLxRhW/uYgQlvKZ8Sb0O3IZIQKgR4CuHeqkj6iv5dkO
         tu2hCzV+TdcC83N6D08b2nNAf8g+a+zQjqfkdjYRvCQ2rFNM4b/csRoyykbSApv5/jH0
         t+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293961; x=1793898761;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dqlkwUV9tYAEbSb1BQ5TfPNY6DFBwHzpfk0RyIwAqNI=;
        b=mPZ+Z5dpgo9XNgQOmR9WoWbQzOocP0h7Ww/2TzZj3+cMxZwA/Zo/5JAOzF+DBRI5qt
         5nh1HG7YMSB4UUr/oNIGWLCD/jJG/hoxtavCkh+mf/8OSokTN2l3VogbbtQ4/xAW9knv
         cLmTY7eZMfyGya+AAXMTWQ5XnbmNytO8cc98Zlxn1xIAHdosKmn/Squ1+botgIaBPeXC
         +wHCzIT/MHD0ys5DuU6tUfSeNYWvVavhxBwC3eImDhUo9jzZAb+Yh9y21b+enlyi51+S
         STEVrup/Ghjd7JhIXhRIFFOS89a+v4Y0+USx61UuVzxN1szauoZ+eU9epCbVJ9SdV1hh
         qLGA==
X-Gm-Message-State: AFq9FYI4JNUtVECjXZPwfhUAJ0pr3/OQ918HPszzC/s72pAGFNKhV9ks
	xnd2KM25G/gZOQLq/UtYmiMIJEZznAwHZd+5g4eKdbdPpO+u8PYtxhgvEjCRyU02fck=
X-Gm-Gg: AYBFou0BjTaQjdHzrDUGxbV8lfodsIrq+RO9KANfVIw3MA3Cm3uD+Zj6V7Xq/udUaTc
	Q2NH2KuUXWaz9PrrMTDJzUGqhVPd8ko/ePp1pr89UNkGqA1r/0uxqpfcFPSNQ0YiwQ2/6xM72HY
	rA/92dxSWezbnN8ahy2DXLMFYuNcv9SmLsbkFfbJyyifq21EExroi/O24FD8EGnSLlQFxv/irk3
	uQ7ZKn00bpu2/2TQZVeTDDWV0XmWprp+cD3ISd+E4FtaLLovWCansmAS5cKizc+gjATwv7DPOlp
	iYZsrYONt0+UWmqlimgexWG5Kh7h3fTrmIofXxTa1cF2pNnP3Nyq6Oj2f10tq9CSwC7TgSQfgM6
	FnQVcHspz8U/Ww7R4Ks6n6m8/IBxU83k9unEz+0RzOkWdDnR532fS2oc9CFM45jd6x71kUPWKVL
	iup3rsnKRUqeefunwlWg9NJqeoWqs2wDTd8dMecbJIKrUlPJpJdgur6lg3srQjbhxxcAXDF9zFK
	QGGb4Jj98BpxtO5jIC8Tvlc9hwd15RiLd6NVxKh7QeePQ5zhRgbfKp98fj4p05kqALUiZW9aO0R
	5VHlfk5UK/GQsG09ys0Gzn28mEG/CYqu/xgO3deFtDHZUOhKyYLNCZH9m5ZKktG6so2juMGhzGX
	hSUkO+Ok9pA==
X-Received: by 2002:a05:6820:1505:b0:703:27e0:354 with SMTP id 006d021491bc7-713efb14bd8mr3282860eaf.66.1793293961512;
        Thu, 29 Oct 2026 10:12:41 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a9049af7d1sm463fac.12.2026.10.29.10.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:12:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Baokun Li <libaokun@linux.alibaba.com>
Cc: ebiggers@kernel.org, linux-fscrypt@vger.kernel.org, hch@lst.de, 
 dm-devel@lists.linux.dev, mpatocka@redhat.com, sweettea-kernel@dorminy.me, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
In-Reply-To: <20261023081908.3505413-1-libaokun@linux.alibaba.com>
References: <20261023081908.3505413-1-libaokun@linux.alibaba.com>
Subject: Re: [PATCH v3] blk-crypto: fix NULL deref and UAF in
 __blk_crypto_evict_key()
Message-Id: <179329395926.1528866.6542405425751626681.b4-ty@b4>
Date: Thu, 29 Oct 2026 11:12:39 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Fri, 23 Oct 2026 16:19:08 +0800, Baokun Li wrote:
> Sashiko reported a possible NULL pointer dereference, triggered by the
> following flow:
> 
>   dm-inlinecrypt ctor            # first use of the fallback
>    ├─ blk_crypto_init_key()      # succeeds, ctx->key.size != 0
>    ├─ blk_crypto_start_using_key()
>    │   ├─ hw-wrapped key: -EOPNOTSUPP
>    │   │    # profile never allocated (NULL)
>    │   └─ raw key: fallback_start_using_mode()
>    │      └─ blk_crypto_fallback_init() fails
>    │         └─ kfree(profile)   # not NULLed
>    ├─ goto bad
>    └─ inlinecrypt_dtr()          # evicts whenever key.size is set
>       └─ blk_crypto_evict_key()
>          └─ blk_crypto_config_supported_natively() = false
>             └─ blk_crypto_fallback_evict_key()
>                └─ __blk_crypto_evict_key(blk_crypto_fallback_profile)
>                   └─ profile->num_slots # BOOM!!!
> 
> [...]

Applied, thanks!

[1/1] blk-crypto: fix NULL deref and UAF in __blk_crypto_evict_key()
      commit: c8c53d669d4e45b3a804013251a34387d7e11bfb

Best regards,
-- 
Jens Axboe



