Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B33515F8
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139419; cv=none; b=bpXxYfTtRDkXtWvjSCe1xQFvIr1bofVMS6+nGHpZPjtG2cQvQaTV/srtAbRUOzU0ILCvKQlQCxCSLvBCRcIBhoLL6drbuY8VkxYhjc5JeMUEhwTpN+8mtTZrhlzsIYLM0Q67530X/tJ3kfVz/PtPy7djfnLt4pFPat1pWsQVU0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139419; c=relaxed/simple;
	bh=mqiwDcKpOaRNus8j/Fg3j0JoEM5rH/wkoPe7vyjGseA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+dx/ZkJzUP7Y2T5sE6rSfjHmks2EtrtjD8MNNBAVH6GmaerN0YgLNGZlOhNw0b+2u2mubu3FqD3rFx36lBiMV37lkMyO8+uAQgQAbY8VBlpb/IV0JMD/KbAnsEpm5e9HBAXdPSBl8logJH8UAS4vj0nrm1h+CXO9MsgYgIdQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=kK4G/F9w; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="kK4G/F9w"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-8050801d337so160719a34.2
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789139415; x=1789744215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cMKSvjVBgJtd6CjrRqlh3dJgvYQUN3eoWH2kuKct2qs=;
        b=kK4G/F9wPPusW8S1G4rXbeFmBv+/IN48Euc/NhlP+M7DENbx5tgQNCT9J3oNAowLsx
         ugow5y7Oiez1bisxwk6MJ2UIRxoPG5gZPnQYO5mCqAAwB5ZjhTKjRtSJs92RM0yZ+yt1
         CJq1uT7goVyNFuQ15NS/hMr4b4T6bt3YCeoRlMJFQ7IEqkHbZ4NJhB6NMfJqRVLD1Czk
         9QzeEZ4YV7Q7JCuFCRVKamzfNym6sf3Y8yL7V3kKj5ns7po0oiAUVN2UIcw6SXz8dO9C
         3U3VoEuO9qcaMhml2ivm5wRn5w9ISrpjEa5184/d9LUBlicwmSuLk0s6OT0CZ7OZ/T/e
         9zNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139415; x=1789744215;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cMKSvjVBgJtd6CjrRqlh3dJgvYQUN3eoWH2kuKct2qs=;
        b=FFaeYnn8+qAWflB7hQ28u5XipB5dVFptiNpw0FSqrL0RQ1/PE+/W16nwsFxbN/+K2Z
         evQ36DuwNNP6LsQDwpoZm7aN6v4L5fGoNEMDWoROmFfz9FG1QC3UlkKVezd+r3Aamt+b
         ezC+6GJQG0LybFK6WeVLZ1KRr20oS2y0N31kII1iDjodF7BjaNOI8V5LyjGREHYVCBL8
         wAcFKnkp6kAUhUvevdNifTqSRIwsSTTXm9nGkCmww1Mm3pXlu9yfVfdrYsPT4UGGT/0j
         ISGSzZ6oAn+v8VNUxfB6ep/Z1bBKJAQz0kKqqVTMCbgU9U5gyGW5XP2t3xRgZZZMFVS2
         gq4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxueQHiSF0QRpkgzvOTvV7vDbNkf3IASxoM3T88A2SbP8WxLYsQEpJRlYVpHmwUtSCAVhZTxPZ+SfgXwQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kYgqdsOW0gWNhx5fdbats7U7VL8lvzl/DKiHbvlSSVZAUO0pZl
	Ah0O+ZlKpdthw8pW8qohvWmRxAiDaXNrmJymofrNQ8ocMW3wxLePFXX+YqnydECK6zY=
X-Gm-Gg: AYBFou2OCY3yTXxTVRsR2xYSaX90MmRtBxvigTMZj1o4CtNh1l3PhmqB0mYqthELWDq
	ctlrpNH3K5M4Ovru9NTD/hv74RyhV3m5sli+DfLIfOl1Yrbl27zA3NslrQC6wuXLBDRNxlYVJ5L
	W/qsGuXOJqHo5pq8Q+hPEItywpiUJd5lbOn4hN+n1WhBVDaZssHl9ICrstIp3GMmP/vJvDGFgs6
	qm3N7+PXnPA830U4LAwkUVwIBKGzyjBlK0jlBwz0gT3dILSgbBWvJR98WtEo3dLuybNi34ahZgx
	WEZShSlFkME9bWt0Oxq8c8T5Y5maX9QGNj33nKLswqvNStcy53XI2DcFGfHTif/iq3b4Y0IPKRI
	V2xMUz88BZ0ntqJoBGNGtMFJ1EyxHV8M9HLMG4BWSt/Ggul72dAnBnpg2qpF75seuskhpuOzWDu
	5Eo4jgddLXeHS5Ljb3+PyH8RE41C7Ze5wXnrylyA6Dkevmq2Yk6GExtar27+C2YJt7s436mcrTW
	0De+PYlDAcQmfn6vrPuUnQlxSWZm2dfM8O8r3ss6jgnOp83EcP1KV7L
X-Received: by 2002:a05:6830:82c3:b0:7f6:ec23:7956 with SMTP id 46e09a7af769-803fe1bd730mr7936240a34.2.1789139414671;
        Fri, 11 Sep 2026 08:10:14 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f6d1875csm2548656a34.22.2026.09.11.08.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:10:14 -0700 (PDT)
Message-ID: <258d93cd-a18d-4860-bab7-2c9c7d43a015@kernel.dk>
Date: Fri, 11 Sep 2026 09:10:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] block: Include error-injection.h for
 ALLOW_ERROR_INJECTION()
To: Petr Pavlu <petr.pavlu@suse.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Simon Horman <horms@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Francois Dugast
 <francois.dugast@intel.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, linux-block@vger.kernel.org,
 netdev@vger.kernel.org, linux-api@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260911-module-include-error_injection-v1-0-5da895d8c84d@suse.com>
 <20260911-module-include-error_injection-v1-1-5da895d8c84d@suse.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260911-module-include-error_injection-v1-1-5da895d8c84d@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 9:04 AM, Petr Pavlu wrote:
> block/blk-core.c uses ALLOW_ERROR_INJECTION(), which is defined in
> asm-generic/error-injection.h. It currently relies on this header being
> included indirectly through linux/module.h -> linux/error-injection.h.
> 
> Add the missing include in preparation for removing the
> linux/error-injection.h include from linux/module.h.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

if you want to shove this upstream somewhere else.

-- 
Jens Axboe

