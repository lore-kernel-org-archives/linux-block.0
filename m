Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A5466B17
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144916; cv=none; b=NVcEAYBOL8w9BEpQjSSt9Y2sTWu0Cx6QtdocRjxzA6MS4uw2X6rE6w5SGKXmrFyG/nIDrrmEioHS/XUPvgJWGCaWaW/7ivX/imaaEvjWunWbq9NCaBQDZhYoZIoDYRdLGuwbzOTjsHPfWPyytflvM8QwvU44St6YJLIJCNn1MFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144916; c=relaxed/simple;
	bh=dymLEMq7gQk/SK2E5GSTPgap+f3EGXcC2iN3svX7+3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYxRW92IIxIc1MmnNz1yU58LH2nDehAhIZkF+86GUEFTUCXWxRqEjWemhrrC4GsXaT8FJlXRN11XFqvPwwlF3QONN7kUFbnD3Jx1NYukN3B9Z16tOQ/U8Y+6UX2jpTgIb8jFKYwRZv42LRNDyOftC8dfgawJcrXcN36dgAEsjY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rnPtjq+/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnPtjq+/"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2acc1e170cso1058707866b.1
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792144910; x=1792749710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WI1kFbw52XGoj4bOp994k1OihbC+rWfsOCWi8eALBk4=;
        b=rnPtjq+/Oeo7IlYs+os9WNO9k8LRhq77hPj4PAU59ji6NDQveWi7SsmQA0kU6ShjDP
         TtRRsEErk3JBVv7/r4PZo8Sg+/evYz2/WLTS3rinsg72gZ02UVdYimT46FwoeC7qqR4Q
         lFzOzR9ZwkXV7vpErod6xZGpEQANzgA8d9VbWlg9iZmiplzOCijxuTvs3G6lKm5m245L
         UmTYGIuuHEsvc1RW8qGNyKDKPooFeR9aRilfrZKNpQhdOzkmX1dENBsY8d2Ub3TEaqgB
         y2p42rKAbUOQ9DUzC1mkJqAiGWvFe88ODA1f/BEUUu3b8MqVZ7sOuiyE6P0WLHwbE+oh
         Ag9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792144910; x=1792749710;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WI1kFbw52XGoj4bOp994k1OihbC+rWfsOCWi8eALBk4=;
        b=a833lyqO1qPYqiCiMWGNJDBqJTXmw1P1O+epOd3ojss18IGeNVto0kaH1W1KMqtJNh
         NVSwg66ZcVhDaEKW8DTOHpVT4U/P18Ja/DGoZIm29vJoR7LF01JqHc3hjhtyfoGys/PA
         bIpqowJxqw3o/nkAiQI5MrUZwWSAFgB7Om0kU2rO5wVbeP5d7DsoYChV6R/XLX1RLwnJ
         0/vs2IchZiRjmWr63pVKCWzlRTrP2d60dC4vSxCO10ULKc0OZrVtAAy6IQk2j1nzcYZO
         Aj7Pm7dnwvedTK3EToaMKloQaDqwCM5v7iK7e9DywTUtbbKzUB8HoMnzDB5w9FrpNROA
         8fmw==
X-Gm-Message-State: AFq9FYL+XYyUEA21cftep33J7ajTZClh8BB6KiDRGQpIP9CdrX+FPofS
	Ug9mwKJEGbfF+abcqG8PS8ofZcBxX8ETo1905wrdrLrQE6ciPJXa+Se3sKm6Mw==
X-Gm-Gg: AYBFou3wS5wAq/SDhdp5Zf3rHZIcEMfvn1zNmxVOLox3AgcDTFv8ni9RC8Gfsj09Cdq
	8nnpCCP9nWmIX7uj0d2seMLsYNUmHOFG0JKx5k7xg7x6TY4Sd/QRWckCO4jP+4JYu1R5a4nutY4
	3pTWN89W6XMjmt0sajhI9s5xJ0SSo9qeAyvt/DMOLEoGlj82zzDryYfUsmefg8Zf6uQJOiNIR7a
	CIljCS/syGGvZRmHEG1L784GuecjMx5YWir3kvWW11NlRSY0as6m2CjjUv4/+akE50HBW0LLeou
	gvFqQzJsdJvkOl4PlElcTNeegA1iy8hQccjPYJD5bnLBK00VqCyqrVswG1w11mLaM/U13/NMx8x
	GuqHNfA3F6Em8a3C+y5Xe4gVv6bNASo/yB+gAgslq70fgz+FVp65EiGCIoT/ftwuZYAxfu+W2Ea
	Ch9dyqKYBHTiqKCkjetOF8JtfmljWXPVSQyh0+oK5YZQc46eUmWaNPjfeP4aVH6ljL6YnlhxoA/
	/qJtDDLR76w0MfH9jemPl1inwOk5Fai+7gACehRDe7bI5BtJmRWBdfYAkOF70MJQo81/xsyxYI0
	2wdf9bHKPgDsdA6SKvopMLpXOCgVxFIac4oHgHQHX2gyAdCP
X-Received: by 2002:a17:906:dc8c:b0:c25:2688:8212 with SMTP id a640c23a62f3a-c31a970483dmr1923161666b.0.1792144909918;
        Fri, 16 Oct 2026 03:01:49 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5177sm3877291f8f.30.2026.10.16.03.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 03:01:49 -0700 (PDT)
Message-ID: <b6c84fce-2d20-48ec-afa2-d44d9cfd4486@gmail.com>
Date: Fri, 16 Oct 2026 11:01:46 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix indention for dma-buf checks
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <de91f480f8507d44ddf99c193ef63dec0f02c749.1792142187.git.asml.silence@gmail.com>
 <be2b6881-75bd-4113-bfcf-c3ac9ed2b80c@gmail.com>
 <20261016092933.GE23141@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261016092933.GE23141@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/26 10:29, Christoph Hellwig wrote:
> On Fri, Oct 16, 2026 at 10:22:37AM +0100, Pavel Begunkov wrote:
>> On 10/16/26 10:20, Pavel Begunkov wrote:
>>> There is a weird indention I botched while rebasing, fix it.
>>>
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Can be squashed into the following commit, if that's preferred.
> 
> Either way looks fine, but I guess Jens doesn't really want to rebase
> this late in the cycle..

Yeah. Mentioned only because it felt odd sending it as a
standalone patch.

-- 
Pavel Begunkov

