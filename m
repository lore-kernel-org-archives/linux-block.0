Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9DE242D76
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391961; cv=none; b=L2kaJ0TnmtJEoNznazrkoK7rLdBNEsRi9dUuX8ByQV0xSRnNqGDBu9ZE4C9S9SxmDq3xuY6ooSI6DevAQiNNehaFdaJ5m/xLbGw6LQ8oVmkpxrLzHcOqPUT6x40jr2mPhuO6SNCzZQ9rZRYBvfnJZdDY4DK9Ov3pZ9NlqxS5YmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391961; c=relaxed/simple;
	bh=4gFast3a3aDehAbyHuMKB4QqjAaDPmFDLGzXIPTEMIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhQeronrG/FZzEVJDQhpPEEeRxLhRT1Xqp7AoOWid7J8KKVdU4M8Sc8fOOKZZYG61Qe3pTetsJKhK10H9Hfotm7v+9QR77wbQEAM0lkrqQfElVhpqHdEchdofuyqCZZ4VVJqB9D1g7lN2RA+UMLi+hshdTYI1+R/K81qR22XZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq0OsawK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq0OsawK"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48327b8350dso5487835e9.1
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 07:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770391959; x=1770996759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/oiJNwlJDnWn9WGbTGc5xmPnE33TNlEqRQ59rrTQk4I=;
        b=Vq0OsawKngDn0dRbf45FPrVU2c5ku1mHb29nF4j3m0tfWL1vF/LQvTt36EwTZBLtEJ
         T+/Pl0ulNjAReuy8vnnC12JRHT8UYggHEJBcwHzOuXSPBFtS/dGUbhK7Kf9BspZKdOJ6
         1uF4iwFX63eAiszTRPMerRvpysdpuHDMG3YcchwSYAmU9cpMMjtHc1OqTVosDqPtX4Bt
         F30YawACes2DKcRXOyBCvJksEFc/52pUffwQ0Wnr1YdHC5tUceP0VLulz4PFULMl28PD
         TFxdtf33PACLrNSmE1WwPwZUWYDre2DK/43ArEiW50O47EFi9ig6JP9h0jUXQ+SuDEBz
         jRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770391959; x=1770996759;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oiJNwlJDnWn9WGbTGc5xmPnE33TNlEqRQ59rrTQk4I=;
        b=V8KqopMewurX6gjforQX/jDTV/PgWPSpsaJErAjKeB4KLaJmAVDMQ8rr3AkYfR+Jhr
         6k4IW0S8DSOzjZLQX4/dJ3sds4+4VAPTlGTVPX0Vchy0tl8X67wi6ZHDYMZ48aGqN/vZ
         A6Eo+vx4Thh7a/PxcC4kniNgXGD39X6ax38mOEvpH11CbXQErWLGXbeUhnFgrITjbAF0
         IDvY1d51kHfxTjLno4nlQBTRVsI2tjjDVRfCUUHdYgqNhbBgvL3muqngMiRr/Nte5cgG
         EOZ9SLyG+mUgYFIMPbfd7iLpiPt1u5q6DLmsZgg5EmlTJiYzlaBj2gXsx0xfeK8YvGQq
         pgAA==
X-Forwarded-Encrypted: i=1; AJvYcCUJyVqkFTIek9mfRnjuerKoxOCQ/OGP2lBCgmqfOiOyOcGbBLxR5wEawBIsBcg7Q2c5YgrVaN8WROHlww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwNUPK0CLI8/pDeDGdg1gUzg93R4Gi0/kd2ICg6Xj+RQx5UDR
	va1UWi+ko+noF8B2hJQ9CjtGkPm4skOUX0qD1T5iOHFk7FATkrZXiKag
X-Gm-Gg: AZuq6aIBG08OCl8bXbvtWdj+ESH+y0Sel2oLrw0UP3MEh5YzHwdbOADWYIHZOPF95tZ
	eeWzTqqpLJJSSZA61hJ1Vj6T+qMRCV6GBXEvuuy3MtozaL2h93UAZ+mQvSoqTIocIgqwWtaCAS9
	tOqv9QixRxAhNO/OQYtsZhbuITUp6hu2VqfhQib1etHcRvPPuAP2nR15yrT1Q7Raw+Ns2QC0X8G
	mvRIO3mQorPTqmg6owKKTmPru3DQvKkLI5clcP6gQ0aFqoL2Ym96VGYLNFOTqOrorK/SrUZ+LuG
	3J1COd8YxbQoz/i25nDyPo4aeM6D9Lli7Dc0Yr6hofno5juoQZvmL96kgZgExQkRNdxmKr+qTIo
	+8SInwGBfHMKcxuuSZhqEEtaCFNxM3+Yr5lER2nGLtS3hoAPFHrwQXYex/6cN3Ai1PR2oM+1Q90
	tBBMVmnsREleVo9aYVnUjaB0+fbxyThjNEYHv6
X-Received: by 2002:a05:600c:4fd0:b0:480:6dff:e786 with SMTP id 5b1f17b1804b1-4832022a5b2mr43808735e9.37.1770391959052;
        Fri, 06 Feb 2026 07:32:39 -0800 (PST)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832040a3cesm37543345e9.3.2026.02.06.07.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:32:38 -0800 (PST)
Message-ID: <28798758-fa0e-439e-9b57-00fe45de080c@gmail.com>
Date: Fri, 6 Feb 2026 16:32:38 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] sed-opal: add IOC_OPAL_REACTIVATE_LSP.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, gjoyce@ibm.com, hare@suse.de
References: <20260205150935.238137-1-okozina@redhat.com>
 <20260206141804.278721-5-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260206141804.278721-5-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/26 3:17 PM, Ondrej Kozina wrote:
> This adds the 'Reactivate' method as described in the
> "TCG Storage Opal SSC Feature Set: Single User Mode"
> document (ch. 3.1.1.1).
> 
> The method enables switching an already active SED OPAL2 device,
> with appropriate firmware support for Single User Mode (SUM),
> to or from SUM.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/opal_proto.h            |  1 +
>   block/sed-opal.c              | 99 +++++++++++++++++++++++++++++++++++
>   include/linux/sed-opal.h      |  1 +
>   include/uapi/linux/sed-opal.h | 14 +++++
>   4 files changed, 115 insertions(+)

Reviewed-and-tested-by: Milan Broz <gmazyland@gmail.com>

Thanks,
Milan

