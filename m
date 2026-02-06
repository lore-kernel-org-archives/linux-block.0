Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC1279DB6
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368727; cv=none; b=u1xzKq/2CyDw6WpLPalht34P/DnKO0ir13IsDHixyOafTnBYzEmGVlqtp8gqWnFVdXH2a9YkjIpNVMyi6+81sQE23SCHoS3W3qeY0Nr3Ak2/eXtIoLtDygnmwS1fN7ew3BoOWz+ULRderzoqzxDuEcO6q+hzGQfAFAUXrQDEZnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368727; c=relaxed/simple;
	bh=rLY24U3osKReFnFq43197zSF079bdeT5HEzP9YFoMBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PML4q52N8NXT+frjLbqNTfZFGWVc6GTVzQBisiLa+xL+V9nrArtU5p04JMKZwYMD65jS35NFLseJzTxFdvwt6D8X9RPgQE6ELEpP45rvL9QUFbVaCbWqJfxL8ak90fSzEr+Zvx4JzSX0MthRODgVBc5N4tZeF5WqBD7UVWb7MAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1K5l6yR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1K5l6yR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so17385035e9.3
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 01:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770368726; x=1770973526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sUJNu/XeqeeEa2B1kmKw3ErRK++OlLV9PEtqscKrqWg=;
        b=X1K5l6yRunUI5LlFGIJ9ztQwE8lwu+wxd7Xf+a+5hjGChsKYAqKKFxruyjLiTNp6aC
         uizessIt9FxXNIHtiUPtHt4QpMVYGgFt5Jd/iZD9K0UXnUQE3LUB+KrNjcc1oR27tFwZ
         OwGjQdK2l5OqZAbsyb4l0jsRlozUy09cE3jOJoDpM8bmHjhkgx+g+34Y/E1YZUe0LLJq
         rZgJsRzAHROeVI9yLOyimYD+41HpX8VOVHisoH1Mn5R0KvEg8gOJPLQsJP2tm3/DsMxa
         q+Hb3jlVgXlx4zpINvFzaT8QjDatcn3/aHrHcaQ2to7Z1X+SgOoglQPD9GCD58SCIve1
         mxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770368726; x=1770973526;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUJNu/XeqeeEa2B1kmKw3ErRK++OlLV9PEtqscKrqWg=;
        b=CkbPIBLroECfLEMghin5P9CysTJtCpBIjv0k48o06wJ1iGcLHf1dGqM7YClTU+1NfO
         LAnho+S44VWpER0ViXQ1Iyk2kUWu2Z9Iz0LCRpaiLawEbHgebnLYFGHEetWpuC0Cz8yR
         VsQEXnLnH7LUiDD+nJzYModpILG41iKgCxOBCZfqdabQpsjhoEL15nhmWUHq0nTSBjq9
         7dRSkiEhCFn9ANQneFEnJ1maaHWZGDoyTwoCFna8FLhWS3T8JxQw2vOvRUh2Ja1E1d/M
         RtXYeeF9cJKiGmil6ZCOI9cYGg+apsRc9FqqR5N5Km/Z4KhpNpqZ61Jxz9bKNva4ITo0
         5FVw==
X-Forwarded-Encrypted: i=1; AJvYcCXHUq95R79iKo5P6IwqqtOBaOyGZe42fbeEcYfYyk9gxWpfCk6gFFba9WdcPNu3bLcpHS8CpyIMRdg9eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZAY/8Q3nRumGX+Q3eWpdoTXyu009xZ1ZPjyRMEqSvEdA6AHZV
	DWtWgRHQJoVWbnnMQMDkNJtW/anNWCFoWxPvvmHgOirl9ppUeWlDdten
X-Gm-Gg: AZuq6aJaon1ULygtl1dgXRsWCv3C/TNhecCghZen3TI8RSYcanZ9IoFBwnItKdwouIw
	9U+0tapjGci/iZnaK4hlGTDBjuByaA7fggtXxxK0ox+Zdyo2JC2GnrsZHg0zBsaKr7Lq0B9Ly/C
	mToAJUdcYrYNb90miKZFOQYZ9pdgNotCg2GUQNaFF5I3A5WF6fdYDsekeSsSfWMXCldlvFnxg+9
	BFhqwJJZO3U768l+sHhoFFb+QpOX7ZQq9UkSy4hgM9vg+jNhGqjlPbG8+P7AL33b5V1v2RuT7vU
	yt0vY8CKLrYGiQ5oBKxvRRL1/YZEtlJT9xPRgz8pn/nhRFo4UVJyFDh1c8PqyMwkvlRhXdo47c/
	6euq0KiA6laORyfSDeLs/gogwLwbhTKsdJEbc+W8eJUz24882DfySCFuMqfrOinj76rtxAeTBwz
	7okTugRA1oSv9+uI2jdJfxAP+UZ50TVs85ufLhJlPhrdVF2Dg=
X-Received: by 2002:a05:600c:34c7:b0:47e:e414:b915 with SMTP id 5b1f17b1804b1-483201dc5afmr30339615e9.2.1770368725334;
        Fri, 06 Feb 2026 01:05:25 -0800 (PST)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d7a924sm170614665e9.10.2026.02.06.01.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 01:05:24 -0800 (PST)
Message-ID: <6f92bd5e-c1f6-44bc-bf34-07df014bd397@gmail.com>
Date: Fri, 6 Feb 2026 10:05:24 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] sed-opal: add IOC_OPAL_GET_SUM_STATUS ioctl.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, gjoyce@ibm.com, hare@suse.de
References: <20260130162527.570255-1-okozina@redhat.com>
 <20260205150935.238137-10-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260205150935.238137-10-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/26 4:09 PM, Ondrej Kozina wrote:
> This adds a function for retrieving the set of Locking objects enabled
> for Single User Mode (SUM) and the value of the
> RangeStartRangeLengthPolicy parameter.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>

...

> +static int opal_get_sum_ranges(struct opal_dev *dev, struct opal_sum_ranges *opal_sum_rngs,
> +			       void __user *data)
> +{
> +	const struct opal_step admin_steps[] = {
> +		{ start_admin1LSP_opal_session, &opal_sum_rngs->key },
> +		{ get_sum_ranges, opal_sum_rngs },
> +		{ end_opal_session, }
> +	}, anybody_steps[] = {
> +		{ start_anybodyLSP_opal_session, NULL },
> +		{ get_sum_ranges, opal_sum_rngs },
> +		{ end_opal_session, }
> +	};

These two variants need some explanation.

IIRC, TCG doc says that SUM info MAY be available through anybody session.

Of course, some vendors implemented it that is it is not, and you have to use
admin session. So we need both variants, that's ok.

Buy you should document how it works for ioctl params - if admin key is set,
admin session is used, otherwise anybody session is used.

> +	int ret;
> +
> +	mutex_lock(&dev->dev_lock);
> +	setup_opal_dev(dev);
> +	if (opal_sum_rngs->key.key_len)

So, this requires admin password is at least one char, using empty password for
admin is not possible here. It make sense, but it should be documented at least.


> +		ret = execute_steps(dev, admin_steps, ARRAY_SIZE(admin_steps));
> +	else
> +		ret = execute_steps(dev, anybody_steps, ARRAY_SIZE(anybody_steps));
> +	mutex_unlock(&dev->dev_lock);
> +

Otherwise LGTM, even for other patches. If you plan to send v3, I will ack
individual patches.

Thanks,
Milan

