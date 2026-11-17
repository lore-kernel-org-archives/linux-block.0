Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913223;
	b=fJxTW1I5kbKcJ5FRtO0PF+gOTKgcaMRX00zXNXgQQh/oH4TOk/dAXmcdG4YZCUxTzpGz
	 NrqgOFpMEYRltWJbxmrGXol9AB9+MGH7n+UgkrV3aU/qxvr1zxLWtP5jGkZnn0qXkBKrN
	 ODAgcyM/vEohYLZ8bm4jT8YCQ9DA13wp2cNjO132T/YxaEFgxy5EKVHniYSm18mVshgJ8
	 nyB4MdutUDDvvmp174MZZ/AMUBbIG4MjMPC33TUlZN+Vk7O7w8V6cZwUmIApTKNTb4HiO
	 0dXSBwumoBkTv9IiCisGX/d0xYv+7ECorVigTMav4LpgjcvWl/YfLfpw3HyeHA+VJ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=+3AXZBYyaaLha1235Jifs6+NRua5WAqO1ulZoEtAElw=;
	b=WmAdUHsB2PO3zb6bBjUrbRF+c1tazPwkmNc+Ig3xzZcK13DDMedDvc00Xiups8rxhBhr
	 5MWs3sOtJZbxqC50xW6AbKo4diRasmC8LvajAqblZoM1GdKi47kOAMAeKEhmhtg5rHLYx
	 szqe8DoVldXl/R80kUtVKnhFOHhj1em5ht6nuEaSn743VHEPMu330LZCdEa2K7kdd06GK
	 iIIZxbTJD19MfT3dHHP/rEiZgpGzVK541iCcspjO59/FC340q1ky8+ZmKTinMoqrkBDH4
	 8/89CgcSiPVcE34veT69K/btBIXv6X9dD85qbll4pZL2J38jU6VbFKwSy/zM/ylMb5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYLvHtJq;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E45606A339
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 11:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92E45606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYLvHtJq
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33c10faf6easo549183eec.0
        for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 03:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913223; x=1795518023; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+3AXZBYyaaLha1235Jifs6+NRua5WAqO1ulZoEtAElw=;
        b=PYLvHtJqr4D0IYvZqYJ9ZLKuDXFx4SYLu5VHdoq+gn9rxqGNudL/ifZlQdSwQ8aoN0
         Wk9F6daVlGM/Q8Zafz5whOAFFceeItqFEva854OiiaKuihaBL6puKmnalWGTRl7Te3/K
         4D/A8mqF0coTTHkOwpCU9aVOaICJbDxNRwNpQY/rM8tKuLhGnNvAfu2uf92pQjXuYlgQ
         wDvDuqiPKqsjlqbiTSQ7YN1TpVVynVirFOJIGWvFA7vQO8k4B3Ct/hx0KRGEOaQpGYak
         +cQaPv8IhiwTMclWkByHtAK1jd3KoXhgd5ZMaFGyNswNduFlq8RkmC8CxBa0X19vLLRE
         zCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913223; x=1795518023;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3AXZBYyaaLha1235Jifs6+NRua5WAqO1ulZoEtAElw=;
        b=KTlLDVEALjwAVWmyYbyJHB2Ez5v1JyWYTOn0cuC6ffV0YdFQ4FbnMk8V4XjHjAVEVU
         5J50APTbi8STr5UYFXUmQ+Az+eh7YhGATp/Bu5VBg7PzZDZFQtvdnuKzMf76B1nwnwJq
         aa7TMXP+WjH8X2Pe3Q0y6KO9nNX5yVMRny+q1kvfv+Q6fsNP9VpbTEDNw7cozDpJd5Sj
         2/kMdlR94A+WLnZHHTsKZHAg+IsoKLCv+Cqz6RxW82AL3Av1kjEPl8cZugGeToA7SjeH
         wvMs65bMVtWSiro6prL3ZJsTLUujBa5BjUcozQkhzSRCbutikM8B3CHDjldl5hSicrkz
         CFAw==
X-Forwarded-Encrypted: i=1; AL+hErESYVKUl2/7yv8SRZ7tGadITgX6iMbUnSc0n2FZ6bmpLuKlihK1KIpwE3Q4OXUpMklmjSPRLcYrwMp+yw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8I+l59RPBloCvFod4nm02PrlhDVrJppO/HQ1UOWyYY9ycHUb59
	QU/An01j+DU/Wt9gzjB+3zbaNu67OXNc3idIigHk/9XSA24o8OjA89D6
X-Gm-Gg: AYBFou3RuZ3uhptmvyM0PcBG13WqG1Sj6NtxXtM57whyLOZv9PHEZA/eyRRs7MbjKns
	ILriN9YFdkUmGF+mou27zHUvsi36ZnhWDSZvFPob1vZc0/9rqSLPtAIRTrnXGcE853nUNs5c520
	fTW1+xpl0aksXlmLjcfcn4uqKcNoOT9xZtSOi1LP5lHcrm1HV+UkGTJ9b7El/ElcBLRqwUvumEJ
	yo0QNoUEQlPaJxSSHYKOWVg6oYosZhIUAWi03hK2zRypElzj2uukO83kuQ2q1mt15WeNJxCiha8
	2D0O3AJ58ytYwJodSAkdw55JPCKRE+5VcP5zGFHoQWLOz+MEgm/VgTYxZhGsEMHshoLA9dFLr5c
	nU+E8HxMoKPTqysNBDTl1xrJUIzz2nMxCpGn/e5r1Rhtwu1Adj4ZAiwaVv5nWf5rJEHDC+I7cAN
	mSnQ15AcYpbq57MjZFgPFthDGzBrnoKdt8Dz5tBTJjQ7WBRjhEcW+GlIuB+npY7bCNhrofgJsCg
	N9robURRWFVs/oQMiNiXVAAmgMoCNxppaSDmlLijcxwC3t8qOh7KLPz0zLZLdwHcvhcfyHPkH4Q
	a7ZeZQ0W0dtk9HRM/nlBcX1hAIl8cdu9cHIyHS/li6LgSUdD02NgK/DogsiXow9vZkg=
X-Received: by 2002:a05:7300:7481:b0:36d:cd5d:d809 with SMTP id 5a478bee46e88-37964ff2d6emr27080643eec.1.1794913222375;
        Tue, 17 Nov 2026 03:00:22 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0c40sm44844871eec.28.2026.11.17.03.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:00:21 -0800 (PST)
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 10/11] zsmalloc: fold zs_obj_write() into zs_store()
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Brian Geffon <bgeffon@google.com>, 
 Minchan Kim <minchan@kernel.org>, Richard Chang <richardycc@google.com>, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-mm@kvack.org, Yosry Ahmed <yosry@kernel.org>
In-Reply-To: <20261111064707.2568433-11-senozhatsky@chromium.org>
References: <20261111064707.2568433-1-senozhatsky@chromium.org>
 <20261111064707.2568433-11-senozhatsky@chromium.org>
Date: Tue, 17 Nov 2026 19:00:12 +0800
Message-Id: <179491321252.964041.5043408594966028356.b4-review@b4>
X-Mailer: b4 0.16.0

On Wed, 11 Nov 2026 15:46:33 +0900, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> zram and zswap always call zs_obj_write() right after zs_malloc(), and
> zs_obj_write() has to take pool->lock and look up object location
> again, which zs_malloc() just did.
> 
> Replace zs_malloc() and zs_obj_write() with one single zs_store()
> call.
> 
> [...]

Reviewed-by: Xueyuan Chen <xueyuan.chen21@gmail.com>

-- 
Best regards,
Xueyuan

