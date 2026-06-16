Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3C2F12AE
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642827; cv=none; b=GiqrHj04Gm+XdAtjaaVxpOMVk26u33AnPqwGTKKYwnysVanBzPc76u4EUAJ8nRx+iKIfw2WX4+3NJchftWT/6hJEIn3ih1jS4LfuIkP+7CDZST/nD9CMmHZhic4y9c1d3unSfdlvd8n/og/7AqqJ5DWNVOYj+5HTVwjHSxVdHdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642827; c=relaxed/simple;
	bh=55ubhwgPFP/ggX+sEQoWYZsZ9CMeijE8qXL6+9SVM4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QU9XMrV440WZRFAXI9ysK+EGouDCHEMuIw51xktsQ4HSttbC6oBozN65F0zbjxlVMKbDhq9DPqYmnbf5KT2THvaIgUmuLmFyIsZzBbmj6nZI/1ZCAR7UzUv2CK+9mDYTKnBgn7uxZu7oTk8Q+MDXPskZyKwNHv7SY3E8h64/8so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Py9mUpUd; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Py9mUpUd"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-440ebc72386so2644929fac.3
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781642823; x=1782247623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3bsbmxS4GadL4Z4bToRsBD+Gi0dvukUshOqKGVXCG8=;
        b=Py9mUpUdWt5vXOQMHpSDFKNdc07dV8zSmKyrmmqNUKFTu/VSDcSGSFT/b2qqNsW69W
         SNSwSPbiHJsW7x7URUBqDzziXp+n1NzryTK6BcpA4Rp1Nra3/rgmAqE1ch2zhzeu30wP
         e1wZ/1W1k+2sVKyjipQ8CzHQw2tNo2TI0UXy5fhdoeYEJPL9fckaT7oF38Oax4pwssJK
         0MUYJxjS5vtn2bFYV+tidJ0pp8MVx6j2bH6L5OgHnqOA5K9+Brdd+NsaYlPCCw2f4h8W
         ODsQ5gbidbn8t2I5yA/Zgp1SMqBzcNCcFo72ar7wJ6jooOBG+XkY527bxxeVUQFJ9PNA
         B29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642823; x=1782247623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3bsbmxS4GadL4Z4bToRsBD+Gi0dvukUshOqKGVXCG8=;
        b=qeozTMGXCd8+e7fdtw5TvLrUPTbo7I75rTmzALXvrBXOMo+Esq7ymC2r3dCyUH0H56
         jMqJJWngzk4B/x4vNyyvkQqSLa0mKYhzGN5OgV5zaSzAQLKxlJI/RiBWZMgmkQipT5l8
         7GMneLL5xpslZ5rrKOQS1Q2qt4qAI6M3K9mBaeab46NJk42cbUOqmRE8KVRA0LhCGeCt
         zv9jQ80q318QC6l90CsqjMxMCGnkUYRIcrYX5zRriBGaZtSbSTn1ndkfOdMoWpggHkrv
         f66TWrn3dzSG5552Apboaf0pTzH2EhLmZTbs3ALDLtEcbuaxWhHSaGqz8x/fAKtWQy1S
         GURw==
X-Forwarded-Encrypted: i=1; AFNElJ9QOjgsjU8dzLKxM+86v2xuUulPncWUzAODIHQ1xshPXeZKuBK6i1+Q84O9N/cCZCu84i1qUUiBw+/0dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLSU7Hg11RQ4OV1sjj9aofdQXrtwn8zpjHVajqEn+9oJYsAm2+
	rnZREHHLqa8MOVJBUBvadaYb1yx2eSnWu+D7+WjakhXwRzKzccbUzCY7MJhqZSDiJfw=
X-Gm-Gg: Acq92OF3M9QUYD1nYHYlHIq3czzalaec6J/qGW3MWNbdKxX0zj6tLHzGLg9oGo+qoAp
	KrwrObomWCSM/yqpkLVbiJ7Hkety/hwY1gJ7uy4K1cflq14q61yVuNSt+TmETmpEVf6QqxudsIc
	97mYjBa5R/JSVj2xHwgxgU6gy8lUJdIcACOjGdLCnGjXOyuLooxjvIs8iRDAouHVCHRaEasUojb
	m+6qEacpL8eK8Xfiv97GoHmN0AkXwugNjv8ilv+Vxs9OEY75AA6NiINUXldwCZ4UF9l21lJAccv
	F9dFKzb1p5+9Vj1CKNBRNsg4zqF7qAqzvPA5sUnda/qQ+Xg4c/glHyPCU8Kbg9/mMrU1Bj3wqaP
	gwuNtmNImFCHZ4afGwe4U95nK+1EAnz3C9fFfyFVG8k5SEdKf3BlzQYKWt3u3uSSUqentOt6hvz
	R2e8O+lyIPtL6ED21Y6GQE7uNwPRo/+kuaVAh4J9yUlSitIXpQlNO/a2TZEaXYCSG1w8uZpM+Yb
	iHQavtGTw==
X-Received: by 2002:a05:6871:538a:b0:442:175:cea7 with SMTP id 586e51a60fabf-4469010a70amr626699fac.1.1781642823167;
        Tue, 16 Jun 2026 13:47:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-443090386basm2851306fac.17.2026.06.16.13.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 13:47:02 -0700 (PDT)
Message-ID: <910230d8-6a14-4d56-9520-169bd379f3d2@kernel.dk>
Date: Tue, 16 Jun 2026 14:47:00 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
To: Octavian Purdila <tavip@google.com>, netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
 kvm@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-2-tavip@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260613000953.467473-2-tavip@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/26 6:09 PM, Octavian Purdila wrote:
> Export iov_iter_restore so that it can be used by modules.
> 
> This is needed by the virtio vsock transport (which can be built as a
> module) to restore the msg_iter state when transmission fails.
> 
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>  lib/iov_iter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af73..067e745f9ef53 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
>  		i->__iov -= state->nr_segs - i->nr_segs;
>  	i->nr_segs = state->nr_segs;
>  }
> +EXPORT_SYMBOL(iov_iter_restore);

I don't have a problem exporting this to modules, but any new export
should be _GPL. So please change it to that.

-- 
Jens Axboe
