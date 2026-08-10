Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9663FE65F
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373199; cv=none; b=QoXBQ5I8/jLxEu/orHX6hdSDZxz6FWSq4u84utHbBcV1dhpuRRjayfY74A9+mSYPrawjQuG1DD5acveLYNHCt4jhuPqL7gm4M3gKZ+7p6gaWHeod6BcgD2OE/kTCQaLEwjALCqbvS+w+3kuL3IfRlVNCOZnCK6wDpmjj/3ZeAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373199; c=relaxed/simple;
	bh=xnO/3tRQ/dRSYwCuTksr2aqfx1rrExH7KLmPwM2j/ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXKloVJhajJRXKqqvxazNXEmrrlU63nTeAnfkuDJrH+O8OWsYLcVdt8ZBy5D6er8ndHtcCIolsjec/TQaTlYLylhbmyErBE7+G6cZX2wlxPlOPMr9dnt3d030y88U4FXGBhtvp3EuthVvw5cnAmNbNp7OSr2ym14kozfuEt5UqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=MjrhtiN7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="MjrhtiN7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so17689925e9.2
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1786373195; x=1786977995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tCttc6k64h4wAjlZ196iGabJt80ujK6RxFX/JQJNzX4=;
        b=MjrhtiN7aJO7EufO0mprr48HQ2BY4QfSVGRGe83QOMpedTW6w7uDnyPQC3bu5oB6wi
         bsgjoceILnLekNXQE6OTBT39NkLxUaDEiIKPFjYdTGlDsB4njOAdHSduK/QH3mC/kAZW
         vv3kamAiZDYFM8bcTY84TaFf2VxIfKRWu6h1nt34qoMHSGQyRFrqhZH+41AGb3/w+G5m
         X7zEimFZFwu6WeG4X1D/CjEBQ+r/COV1EpYhGfz0hPwIcgUnioVn+LkWivbVDqZS2fkf
         e+NX1QXaIY8Vv4/WZ7iLqwKEjRKEzuxxO4mIbT1dHNdlS9+mYya5RaANauYGJzwyaHQI
         lthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373195; x=1786977995;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tCttc6k64h4wAjlZ196iGabJt80ujK6RxFX/JQJNzX4=;
        b=V46AajsiQGvTNhqXu+2ig+tWJaJRhpimSpqvKixjFYzSzebsyL5Z27TFZemAyCtDXQ
         2bzKlfPFOkhl25KqRXVYfLsQ+3BuUs+e8brPv4zKNTYJoaq+5jOJmXGblUfmkQpeANty
         Kbz9+zqq2UC3Nh++mjQZCJa8Bv4FW1h09NwuDbHt9YMiDk6GRUyWil+idq0YoCTa8j8S
         IcYvXmPdmmL4YO/wHODWFrqiROYoqmfQfN6tEGduSXchpWR6xsnHd4mmfz7iRLhepY4h
         R+65pUWOueXk5iCRNcH26KmoVMqW8sORE7PCkliO4fjU1t2M6st3A5VtXL55aUE4tLmJ
         PiUw==
X-Forwarded-Encrypted: i=1; AHgh+RpLI8MPiYyoCYOWosLyAMp7KuV1/OLFpFnDtczeamnrwVrDtH1PeiALmpyqHgm8q96jB42Ne8TCp9/gWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxj5Qg5MGEwo6Xa2JhBf8L0LtOe1BH6C+h6Kw2dFNmE5f9OfSb
	LGK5O6ZO2Dk/QRDI0lPIubHFn7JKTKEAR0iEEyUUGLi+0U7jZ75v68VVa6C5yRF4Cxw=
X-Gm-Gg: AR+sD12mSrZ+uRM9/KR+sl+sopHmEaMTINRObEeIs6jroc73n1ACyfAZxBK9uzxDUEn
	DuventIufPWXJ8yjnLftkonwNJIJdy5poAOvPTkO9r6pG4CD7Z9TgsFnWF/9gV5W06mzeNtN0j2
	2lW3Jm7S83NzqEHevyxOJ3joTfJzu4S73FlpE0QOM8fgG5lEVSC3N7S5u9E3Ye9FjoB8kBXsydG
	Ml6lPkLa53Os/z2fowKeEMz61zYTOcsReXLvLRJSOC5mOgHReDuWG+Wuvv0o5ZLNoaHsSEgNeJ/
	OYmoKYOBjfdXwjOWqxDrNuiuVpJJOe950T0uYYFQ0gIY5ryN6ha7wtV6jThCUipsYegll9XcyHl
	dfWrATon2gaf2wQcjo1ZBEQePuLN79NFlng+TeVQZsryPviMah8n+A72zK3BmJli5HuTTmrlQKS
	CSVGIi3R3tmnEZW+T71Q10iHHtbeK9x6+BeFxBP3JM3NChlU0x4XNsrXq9l+Fs01h7t2G6SHfbp
	++8nGZTwHhPsH5zb2li4jzVyU1vLU1JtxausrQIQQ==
X-Received: by 2002:a05:600c:242:b0:493:c845:bc20 with SMTP id 5b1f17b1804b1-49959e0174cmr299256595e9.4.1786373194772;
        Mon, 10 Aug 2026 07:46:34 -0700 (PDT)
Received: from [192.168.178.55] (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bdc433bsm320370545e9.1.2026.08.10.07.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 07:46:33 -0700 (PDT)
Message-ID: <dfc602da-a30f-42d6-9901-97de1c9b26a3@linbit.com>
Date: Mon, 10 Aug 2026 16:46:32 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drbd: fix off-by-one in netlink NUL-string policy
 lengths
To: Ionut Nechita <ionut.nechita@windriver.com>, Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Joel Colledge <joel.colledge@linbit.com>, drbd-dev@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260802110552.50757-1-ionut.nechita@windriver.com>
 <20260802110552.50757-2-ionut.nechita@windriver.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260802110552.50757-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 02.08.26 um 13:05 schrieb Ionut Nechita:
> For NLA_NUL_STRING attributes, nla_policy.len is the maximum length of
> the string excluding the terminating NUL, as documented in
> include/net/netlink.h. The genl_magic infrastructure encoded that as
> 
> 	.len = maxlen - (nla_type == NLA_NUL_STRING)
> 
> but the hand-written policies that replaced it set .len to the full size
> of the destination buffer. Every NUL-string attribute therefore accepts
> a string that is one byte too long for the buffer it is copied into.
> 
> For such a string validate_nla() succeeds and nla_strscpy() truncates it
> and returns -E2BIG. The return value is stored without being checked in
> the corresponding unsigned length member, e.g.
> 
> 	s->cpu_mask_len = nla_strscpy(s->cpu_mask, nla, DRBD_CPU_MASK_SIZE);
> 
> set_resource_options() copies the whole struct into resource->res_opts,
> so a later dump of the resource options reaches res_opts_to_skb() with
> cpu_mask_len set to (__u32)-E2BIG. The payload length handed to
> nla_put() is computed there as
> 
> 	min_t(int, DRBD_CPU_MASK_SIZE,
> 	      s->cpu_mask_len + (s->cpu_mask_len < DRBD_CPU_MASK_SIZE))
> 
> which evaluates to a negative int. __nla_reserve() then stores
> nla_attr_size() of that negative value in the u16 nla_len, and
> __nla_put() calls memcpy() with an underflowed size argument.
> 
> The five net_conf algorithm names, both disk_conf device paths, the
> configuration context resource name and the resource cpu-mask are all
> affected. The shared secret is the one most likely to be hit in
> practice: SHARED_SECRET_MAX is 64, a secret of exactly 64 characters is
> what "openssl rand -hex 32" produces, and nla_put_status_info() feeds
> the unsanitized net_conf to net_conf_to_skb() for any caller holding
> CAP_SYS_ADMIN. The sanitized path clears both the secret and its length,
> so an unprivileged status dump is not affected.
> 
> Restore the bound the generated code used to emit. With the policy
> corrected nla_strscpy() can no longer truncate, so the unchecked return
> values become harmless again.
> 
> Reaching any of the affected attributes requires CAP_NET_ADMIN. Found by
> inspection while looking at the cpu-mask length limit; no user report.
> 
> Fixes: 8098eeb693c4 ("drbd: replace genl_magic with explicit netlink serialization")
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>  drivers/block/drbd/drbd_nl_gen.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Thanks for the patch, good catch. The fix looks correct.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

