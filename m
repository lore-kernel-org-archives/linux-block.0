Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NP5RQzWn"
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64ED59
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 14:40:41 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58dd5193db4so36777eaf.1
        for <linux-block@vger.kernel.org>; Wed, 06 Dec 2023 14:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701902440; x=1702507240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAg6IU+L83TOHlh/mEafNkn0GjjiO2CUCPVmGp0iqEA=;
        b=NP5RQzWn0ihAsWAt6fgpB7YqZr/yKojAUjB22VALW2FEv1UY9M1NK6SkH4LrgeEmAb
         2mr5N7fsv3jpoXJLCtbtCOZ+nLCD+GSSZ7dY/2U7+/oo8yiiSbOKwLWY0Adg8VuKNyCs
         sQ6qzupiCWpdT4A4P94zEQjGdfeB8doun+CWQZ0951+hSPBfj16+UyamA2sNym1rAYeL
         HezggGdmxN8nR6PmgINAB0PIIy03OLlKiTOiEttEoS0hs3tMvQ59xIhyzq8F8AUBwEo8
         hxMSwE3f1RRscS6zO4ZU9SicJQPbF8xu1p+2efxTXxsAzsjVFYjybLxDWKAq7xOjKB1z
         18RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701902440; x=1702507240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAg6IU+L83TOHlh/mEafNkn0GjjiO2CUCPVmGp0iqEA=;
        b=aGVBxbkCEJOWk7zteRPNr+PWqS088i8Cpetk3F/ni/FOxDR7NVM1ry+SDBXmIerizY
         uUMOsiXshCFyWPJ4eYAsJcOeWfyySzSrUoItn+0vkOBcOCqatNX152vPa0Sh8Mfh2m5k
         k7LvoT6EAX4gBzqtnc1nMbtB66eXBntGEHyfaU8COvPaA69lX1JSECQX8pbnbzhBUwiA
         twYR6ASEfr+0QQKYVeEZ9NCswM+9/+DeBQconUOn8vyGIKm+BmlxCVkwdGDDORpsAOKw
         rlgjEalZNCIzKxpUZsPJARdUfrrfbKUg51R6uigGHojUWQOCduoH771SDDyMryVWcI7w
         9f/Q==
X-Gm-Message-State: AOJu0YwlauecIMtvkKXlrGJqsHuoy2LGIJd8jszILvc6nRSX+k8Nrc80
	xLuI4WO3lEJ64xMUh6HjgESCuw==
X-Google-Smtp-Source: AGHT+IHcdPtRZ/szsRDjMYTvx1WWuzfyrQ7nSkUukPv0HCce7J6rgvbMjcCwcsj8YShSR0JUyyH47g==
X-Received: by 2002:a05:6358:5925:b0:16e:b5d:43ce with SMTP id g37-20020a056358592500b0016e0b5d43cemr3720343rwf.0.1701902440398;
        Wed, 06 Dec 2023 14:40:40 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ka42-20020a056a0093aa00b006ce9fb08502sm29767pfb.46.2023.12.06.14.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 14:40:39 -0800 (PST)
Message-ID: <72bf57b0-b5fb-4309-8bfb-63a207a52df7@kernel.dk>
Date: Wed, 6 Dec 2023 15:40:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: Rework bio_for_each_segment_all()
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>, Phillip Lougher <phillip@squashfs.org.uk>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
 <20231206213424.rn7i42zoyo6zxufk@moria.home.lan>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231206213424.rn7i42zoyo6zxufk@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/23 2:34 PM, Kent Overstreet wrote:
> On Wed, Nov 22, 2023 at 06:28:13PM -0500, Kent Overstreet wrote:
>> This patch reworks bio_for_each_segment_all() to be more inline with how
>> the other bio iterators work:
>>
>>  - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
>>    one in the iterator and pass a pointer to it - bad. This way makes it
>>    clearer what's a constructed value vs. a reference to something
>>    pre-existing, and it also will help with cleaning up and
>>    consolidating code with bio_for_each_folio_all().
>>
>>  - We now provide bio_for_each_segment_all_continue(), for squashfs:
>>    this makes their code clearer.
> 
> Jens, can we _please_ get this series merged so bcachefs isn't reaching
> into bio/bvec internals?

Haven't gotten around to review it fully yet, and nobody else has either
fwiw. Would be nice with some reviews.

-- 
Jens Axboe


