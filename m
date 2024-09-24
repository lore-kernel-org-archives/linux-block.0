Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BAB1B85D5
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193361; cv=none; b=PGE/MCfrqCMmc1p706eZNqcNxrUeW6yyO7nh0LRl5u4TBu8IuVnRVJxK2XRzsNvl/2FvGxK36pE4wuF0TgegEM94gYQOrxzce/PyidImAItYN5sS4kBIg3p72d3rArpGCvU8ZQuymkJR60Ek0yBTuENkGNrsLHdMYTfMopjBVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193361; c=relaxed/simple;
	bh=KMvYTbk9wiNNFP09y9qW2ipDYTHn2Hx1yyBZ4pAbUlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsGoVwvy13X9kVzFGjEmOUAhbRoZfHYnhhlLGRER2py/MgEAD5iIRYsWZtnyXFXB5N+HGTHTNbzEqXt501FhFWwJWxecsJLXap7+hd+dHl8emT+dCRPzkKY3hYKyYi3sL/Z73y8daZdPllMKq9zxp9x/Iy71ru/0zX2nETBge1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42e5e1e6d37so56828105e9.3
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 08:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193358; x=1727798158;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLRXCvFsQakvjWY99i8tUnp7t5+YzvJOdpBkcBUyWGU=;
        b=f7qq2pt/QQ6kTlmoYt/wW8tEbxbZD5N0BEz56eLms8uXFuITdERl/Z3Ips3EqbLpsU
         YlHuxULSQNBVDymuIXUUGeYi7j0Fc4nAktV3hnBYE3jLwFLvnj9lHOQwKOFJVhL30z4x
         1ER5PipY75yS90ByPTF21O6UQvJxVMYBuiwkrlcx7F+9mosNL0Eq4yks+/FxIwlZT8So
         /gXmnCtx97pqK/7e83KUeuW86MaOD8b9hpst2YUsN9pC0toysex5xFNQ+7S8M3zBlTkH
         Wk75Ef2kqXMrPHkkk8/4W0O3dbZqMltSupsxGOWOHIJwXpaBsCNkCqhgJpJlI2WSIQwb
         8f7w==
X-Forwarded-Encrypted: i=1; AJvYcCVk3yYayAIuvcKRSfi93PQOa6IweQT0Sro4NUVrywvmj3dI42SV6AH1WCaKn+wqsEgkqpn4Od3v0VywAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnnw7tpplwXHPn34ffbn/rwUVo+/57RanGYL0GLB2dy0geOWC
	FPVwr+KURsklWnbtndw6lvAMzp383jOO6bPKTXF8TfAA6fAeXvz7
X-Google-Smtp-Source: AGHT+IGKcWmQa7oR6P6e0meckL08EUqdgWZpsPcQ1CPCWkBgOZNXShZgZv8YUsEMsNOekMiY6liuBg==
X-Received: by 2002:a05:600c:1c29:b0:42c:b55f:f7c with SMTP id 5b1f17b1804b1-42e7c16ec8emr99855365e9.15.1727193358152;
        Tue, 24 Sep 2024 08:55:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::bbbb:12b? ([2a0b:e7c0:0:107::bbbb:12b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7540e47asm163355585e9.6.2024.09.24.08.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 08:55:57 -0700 (PDT)
Message-ID: <26a78e19-8909-43a2-b4b1-f5b650bc4107@kernel.org>
Date: Tue, 24 Sep 2024 17:55:54 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Prevent deadlocks when switching elevators
To: Jens Axboe <axboe@kernel.dk>,
 =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
 Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
 Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240908000704.414538-1-dlemoal@kernel.org>
 <e30fe828-0786-40d7-9da9-4f570d261542@kernel.org>
 <47b98ddd-631a-4b49-811c-c0c1fd555d63@applied-asynchrony.com>
 <85bdae7f-4911-43a6-a68a-3f263d4c1811@kernel.dk>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <85bdae7f-4911-43a6-a68a-3f263d4c1811@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24. 09. 24, 16:34, Jens Axboe wrote:
> On 9/24/24 7:08 AM, Holger Hoffstätte wrote:
>> On 2024-09-24 12:46, Jiri Slaby wrote:
>>> this broke udev rules for loop in 6.11:
>>>   > loop1: /usr/lib/udev/rules.d/60-io-scheduler.rules:25 Failed to write ATTR{/sys/devices/virtual/block/loop1/queue/scheduler}="none", ignoring: No such file or directory
>>
>> (etc.)
>>
>> Patch here but it's not in mainline yet:
>>
>> https://lore.kernel.org/linux-block/20240917133231.134806-1-dlemoal@kernel.org/
> 
> It'll go upstream later this week.

FWIW works for me.

thanks,
-- 
js

