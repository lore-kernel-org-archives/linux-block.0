Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0A3A7F5D
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289093; cv=none; b=CHHNxFHtEJrGaZXUQGdyWcOhtPv0Ea7iExp0LTinlDgeAgtxuJcJW60WV0EW99oV9Vs8Nl9z7ZJYxNh9eBeLX+1ubfNIDHNOz0gZ8FGa0R7OCHd/Lx4PmITTzTzL9qE3aYbHKHWrQEOREORlTXE5Zm0Bq/d+QYhXU37BUlZVXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289093; c=relaxed/simple;
	bh=cbh82RvVDowM0gxYQtkrt6AcVZlckgrZRO7ZexD3Ur0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1RLq459QlOZydqrIqbib3o5dpJ37hKFNPrGpOBFMp6RRKGMZ7eaAcTwt0BkB1vsRInbqRqdhAD/lzIaiT+6yEeG0A8+WpmS5/+cW/8XqSvd+a1DNiCXY4bQtnkroEnsjOY3Rd2yEjNXf5g1Vi5Aul9awZKm56UHXzJBi0xmmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVqzRBIh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVqzRBIh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so5986065e9.2
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 02:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770289091; x=1770893891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb1Kwo5msKrY9tFVghwuuNrP+c1AKSAw5Wg6OfLyWuE=;
        b=SVqzRBIhQMJgVpd0tOtqZV5pxLPjwDpqBo3GTGs++gci1MtxhcW9ZciCleIG+XQZJ8
         SY965oozWXRUr29+bhV+6CCnolYqplyNGirk9JMNf/WaXizMhSNyHbB7GGC5sS5IXy+Z
         KBk8a30RPr85h0qWT3KYTZE2AEGbzrODyrYW8Q8eMDwVUaXDDOl24Q43qGCQnXbXd5cj
         gr8KSkeI8qeAc/3QRZeQ8c9RFpd1Qt7xcVLp2LZgMFW+ggU1FOc0DI+PReScmHTCOZSJ
         UMOEjp33OXABFeaAEDxgL7mi7oJfSx/0PVbNSBs8JStndwXo7Gl9WzoU8sOV+VYMpraa
         vmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289091; x=1770893891;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb1Kwo5msKrY9tFVghwuuNrP+c1AKSAw5Wg6OfLyWuE=;
        b=lqMaA65o80KBikr+u7QdD+Mt10bMDJOUDbOz7kiGhxCB2V5ZWdbxdkW2IoEy/a4VXf
         D8ihhjvst1vMObX+8gqxMchwI7Jpa9aik5eh7xIa5xfmyvprlghANejdtLGyZdvS+857
         omcztEmRrzcS3TjhzbV/dsg+r+WhFUH6yX/zba67joAgHxo18Cp30uifOccL0vFr3KVi
         +am32UMMGCMLsExt/cAhtz7l88ecagi+C8Q+ENc/acMFtwFE5AuCecQ+xhwVNSIKm9Rp
         tn9cmIMKq+SCE7qNFomWFZv+PmxfRRhNaMMn6CCrgUGzcN2nNoV2rVgwjqjwG6QqW91o
         bYyA==
X-Forwarded-Encrypted: i=1; AJvYcCUvTnfOJchtKOFuQSJGRp+vsnLdaKVu9F1Yt8Bff6lzFmC6pZSG085wDZPSi0PLOAL3VIVfXQjhVKv4Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGaMmKhXrCv5rPOEBRlv5/uQvDRTitgPgPa2QI+tbECq+Xa0OH
	1m4AVRi4KCYTdKfOXLrpcIgQKfexT/uhb9hcH7cUBycBbHFPONY95RZdoRlquCjJ
X-Gm-Gg: AZuq6aLk7Cbjd7a29QKVQldiXo/WxV87s0XwolnhHc0FkFkP2R7f62O9MowG2ac1CCp
	9gOiGlIYBmnytqeNjWUwu8PXDOyQz3poYi0311fLWU94BkmzIXa7FrkGQzVrXi15PCDaS2qhSut
	Nzk9+3xx6oWIbMSVPDSHLyxrOggxHkse/j6nSVai4foJxGpa4CZA//Jg8FGQg5SjB7AyIfGrXZP
	7IdmZksN3kZ/KIyIGJ1Lp9IdJ6o52+UAxaw7Ao82D/A+WC1tLxs86WrSY2YLyxKUZMwINpuZpbI
	QdYdRy/kVgflNaMgEafhAbzhRGHOf3vtljgSS+6P+1BDT5J8PkVhodXCL6yftpYRczFRmCgv9NL
	F3/fUvIwv1j8UKINwlYM9v5rTu3AN/+3ldG3Bi87MD9eL7XGnDQtfaso/W8uH0vDtE6hXF+lyma
	NCodfDFTJ+8igU6Mk=
X-Received: by 2002:a05:600c:1f16:b0:480:5678:1fdd with SMTP id 5b1f17b1804b1-4830e94c923mr82470515e9.12.1770289091078;
        Thu, 05 Feb 2026 02:58:11 -0800 (PST)
Received: from [192.168.1.27] ([176.74.141.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fe69e9fsm56649575e9.6.2026.02.05.02.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 02:58:10 -0800 (PST)
Message-ID: <607e0309-6909-447d-a1c7-a2b37c7e96a7@gmail.com>
Date: Thu, 5 Feb 2026 11:58:10 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] sed-opal: add IOC_OPAL_GET_SUM_STATUS ioctl.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: gjoyce@ibm.com, jonathan.derrick@linux.dev
References: <20260130162527.570255-1-okozina@redhat.com>
 <20260130162527.570255-7-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260130162527.570255-7-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/26 5:25 PM, Ondrej Kozina wrote:
> This adds a function for retrieving the set of Locking objects enabled
> for Single User Mode (SUM) and the value of the
> RangeStartRangeLengthPolicy parameter.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>

...>   
> +static int get_sum_ranges(struct opal_dev *dev, void *data)
> +{

...
I would add here comment (with reference to TCG spec)  explaining two possible responses
(list or whole table).

> +		while (!response_token_matches(tok, OPAL_ENDLIST)) {
> +			lr_uid_len = response_get_string(&dev->parsed, tok_n, &lr_uid);
> +			if (lr_uid_len != OPAL_UID_LENGTH) {
> +				pr_debug("Unexpected response token type %d.\n", tok_n);
> +				return OPAL_INVAL_PARAM;
> +			}
> +
> +			if (memcmp(lr_uid, opaluid[OPAL_LOCKINGRANGE_GLOBAL], OPAL_UID_LENGTH)) {
> +				if (lr_uid[5] != LOCKING_RANGE_NON_GLOBAL) {
> +					pr_debug("Unexpected byte %d at LR UUID position 5.\n",
> +						 lr_uid[5]);
> +					return OPAL_INVAL_PARAM;
> +				}
> +				sranges->lr[sranges->num_lrs++] = lr_uid[7];
> +			} else
> +				sranges->lr[sranges->num_lrs++] = 0;
> +
> +			tok_n++;
> +			tok = response_get_token(&dev->parsed, tok_n);
> +			if (IS_ERR(tok))
> +				return PTR_ERR(tok);
> +		}
> +	} else {
> +		/* Only OPAL_LOCKING_TABLE UID is an alternative to OPAL_STARTLIST here. */
> +		lr_uid_len = response_get_string(&dev->parsed, tok_n, &lr_uid);
> +		if (lr_uid_len != OPAL_UID_LENGTH) {
> +			pr_debug("Unexpected response token type %d.\n", tok_n);
> +			return OPAL_INVAL_PARAM;
> +		}
> +
> +		if (memcmp(lr_uid, opaluid[OPAL_LOCKING_TABLE], OPAL_UID_LENGTH)) {
> +			pr_debug("Unexpected response UID.\n");
> +			return OPAL_INVAL_PARAM;
> +		}
> +
> +		/* sed-opal kernel API already provides following limit in Activate command */
> +		sranges->num_lrs = OPAL_MAX_LRS;
> +		memcpy(sranges->lr, lr_all, OPAL_MAX_LRS);
> +	}

...


Otherwise it is ok.

Milan

