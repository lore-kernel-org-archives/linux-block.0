Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA433E3D90
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789249032; cv=none; b=pAlTnUQJL3Eho4n5WKYI4mLqcgOaZE1BgFcRpNrallZVXWA4HAaNyM7Cyamm7OUZXUnTqf2RCCB+RUr8WzOGfY7AjDTE7Bn4mLOe3X9KiTDgTh+8Q0TLSAcBVuupS0JU1zXMr2apnxrkyQvWO9kvN0vk5KtXhhJ+3YEQkh+6GlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789249032; c=relaxed/simple;
	bh=1ItKt23VFuQcVXcDDYvLT16i240u2IaHpmq0QG3aiOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUXf5W2d459BaSegRBBcOz8bOQav6MasOab6ayWalIpFxC6BZUZ/BzQzClAtmRbIIyFe6l8RZgJc5WE1AwwQMbAITy0c+FSrfb8VgT8yKuo/ps+IvME1VAwIi1VoONwkbU5JIwi9opsmSnTWx9QFlx8NMTDpKvdxdvMqBHq+S8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb796so157849966b.2
        for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 14:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789249028; x=1789853828;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eZr9xRtQAbAJsVC1Pk0qBFaqMmdYuwqmgOvq06yAfas=;
        b=eVKOSSrcSbgyYEDy2GGOAcFP4zrdcooMmMANvGaW4jDV+PeuABT669yb3OKjmnOyhX
         pIh5RwoXPbfmVBv/83tLY8vCCb85GpPirLAKtQkyM470oJIzs+U5jroBxE7Xe0HBhnC6
         2Z4SbnOPUCemdTF0NpvWFnsxRm/3qN7v5yey9gMGdmmMQaU+Sie1wykfJH7Bpe83+20E
         eYV6YSqU6m4t47d1MQ0u6Ej6Yis/tBNgIG5ZXZXaTfxGQzS9CY0vtORV7+WeuAwAgoX2
         mAy9eYFXa10cBsIIWANsT0/VAGmWJ3OG3vfdOp29edn9QXNWwoD7HdLkoa4lUCFbxQKv
         rzbA==
X-Forwarded-Encrypted: i=1; AKwUvBwo3eFhDZun78T0Qk8/mwPJoXzsXuOkARxD0ou4blMzlgaswrizmLJGZtA7a4voi5aDsGbyvqfvgZ6usQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ltegg0p+29I0zvQ4L8utn8Q0O17jD7ZaN6dUO8LXnLPzxRAZqr
	rlm9vYxnwXcmcArz8kZsojiqlSJnDaN2X3r+KcR2UNxEVQ4ylAdMuKU2NmEK0Q==
X-Gm-Gg: AYBFou0RbKfzVSUG0EBKYOoW+ABFhLXXmYXr9pRCd5MHG4n7RZ2FmkQ/FA2i3Xs42yc
	vg1CxebytQ6Xg5C3T4OMmU/feSKQai1BE4PMKPM4yShFOFJLiKkwYlrC8jSsdJrNBsf5LnPboPg
	qbaXbfn8rd7hd7eEHIoJuCRIqhB6jq8Mh/6pD7mu1c8G5arYNlHEqwmw14ecD3zYdH3qD+pUuO5
	eqYz1ben1glnifbtfXYofMsQ3Re1eYwaVdxKcLj4F3wxys85cwI3vLqcvK5qH792n2rtkuHJLOP
	czqfCPpaqvz2yA2HqUROyqUCJCgxxFgW2rF3lUUz6/47LXaMHxGN9J0Y05WdQQNRX3VNsdynJij
	Yzxd0uz4/U6O/Vt8QMCRCsTjNpznOUdWZA2gpjcxI7R/HRWZH5wnYOVextPRznf0YhruURjhQ9G
	bdT06nJoiQMbu3FI3GVgv4wTt80YVWk6upvTXl3RgptuEVKsV07IE5COL/TiYrfaX16Cw=
X-Received: by 2002:a17:907:3fa2:b0:c26:1648:a072 with SMTP id a640c23a62f3a-c29667021d6mr511111966b.45.1789249027630;
        Sat, 12 Sep 2026 14:37:07 -0700 (PDT)
Received: from [10.68.32.41] ([5.194.84.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2965c4f77asm226666066b.8.2026.09.12.14.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 14:37:06 -0700 (PDT)
Message-ID: <89d72a22-17ff-43f3-a9a6-331a644fd67e@linux.com>
Date: Sun, 13 Sep 2026 01:37:03 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: flush pending work before releasing resources on
 init failure
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20260722034435.13432-1-kmehltretter@gmail.com>
 <aqUcNyP9DooWW9kf@gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <aqUcNyP9DooWW9kf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 12/09/2026 13:33, Karl Mehltretter wrote:
> On Wed, Jul 22, 2026 at 05:44:35AM +0100, Karl Mehltretter wrote:
>> The flush used to be here. Commit 070ad7e793dc ("floppy: convert to
>> delayed work and single-thread wq") renamed the label out_flush_work to
>> out_release_dma and dropped it. Restore it so the work drains before the
>> IRQ and DMA are released, as floppy_module_exit() already does.
>>
>> Fixes: 070ad7e793dc ("floppy: convert to delayed work and single-thread wq")
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> Friendly ping on this patch. It already has a Reviewed-by.
> 

Thank you for the reminder. I took you patch
https://github.com/evdenis/linux-floppy/commit/acf6cbd113f0cc68dc42e2ad7a83dd77ae2def04
and will send merge request to Jens with rest of the changes shortly after.

Thanks,
Denis
