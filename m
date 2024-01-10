Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F384CDE8
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28c23a0df1eso2588100a91.0
        for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 09:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909017; x=1705513817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbDUPrnrTHsHGLPM9LfXIXV5BYask7+UrObhyUAggQE=;
        b=twsOBvazY4Y+Tt7H8MelWR/JtDFqx6VMhw53UM/BfQDz4FJwHjIeHhKMJE6bdIWpsq
         3FB5Czm+I7ZO675aXmkMXSu2ATNTQ6Uq0OxMyd3/pcwGFOpNo7+aAyLfcttTlcgrdbr9
         f7aV4eurEJx669+GDIjFdyfZUgtKvYrW21/0Vq9oXLVEehIaygaF1s2VnFvWQk3cq7dc
         ZfhEcaBdetPCvu51QJXWcExfeJI3U+Bbp8/Z9B4TyErvHnx9GsELjWNy4YuJwnk5tYxZ
         gqS3NS+sgtpFELfZpL110Rm+Mc9Szd16RdqKJXSrQK4hjfFWb5S5M016ODvBM5J5vjwA
         VXAg==
X-Gm-Message-State: AOJu0Yze9CctST2w9hBavwa3H/Hi71onLtuAbE41BV2ZvBE8nqRsqNUY
	N0YQDlqnSu938EsgMnX13sc=
X-Google-Smtp-Source: AGHT+IHTiSBYPg3BlOYXn/1jhfIb2FZodQlZsOmcKrUS/SP9LiGAJmluo1iDhDsyDHTsJiALrVwl8A==
X-Received: by 2002:a17:90a:1c96:b0:28d:35d:10da with SMTP id t22-20020a17090a1c9600b0028d035d10damr915195pjt.32.1704909016378;
        Wed, 10 Jan 2024 09:50:16 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:b76f:b657:4602:d182? ([2620:0:1000:8411:b76f:b657:4602:d182])
        by smtp.gmail.com with ESMTPSA id bb24-20020a17090b009800b0028c9d359011sm1842626pjb.32.2024.01.10.09.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 09:50:15 -0800 (PST)
Message-ID: <f64d4219-5265-4cbf-b955-f72106f9e760@acm.org>
Date: Wed, 10 Jan 2024 09:50:13 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 2/2] block/031: allow to run with built-in
 null_blk driver
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
 <20240109104453.3764096-3-shinichiro.kawasaki@wdc.com>
 <4a6b2848-7792-4e11-9fc5-482b8e4e020b@acm.org>
 <7auicy62muu22xsd3adbvrljq3guvbdzgkbafxva5du45jli3n@wo4f7f6ut5eb>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7auicy62muu22xsd3adbvrljq3guvbdzgkbafxva5du45jli3n@wo4f7f6ut5eb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/24 18:19, Shinichiro Kawasaki wrote:
> On Jan 09, 2024 / 12:19, Bart Van Assche wrote:
>> On 1/9/24 02:44, Shin'ichiro Kawasaki wrote:
>>> The parameter has been set as a module parameter then null_blk
>>> driver must be loadable.
>>
>> It seems like the word "If" is missing from the start of the above sentence?
> 
> With this sentence, I wanted to describe current implmenetation fact. Before
> applying this patch, shared_tag_bitmap=1 was set as a module parameter, not
> through a configfs file. So I don't think "If" is missing.

If I upload the sentence that I quoted to a free online grammar checker
(https://quillbot.com/grammar-check) then it tells me that there is a
grammatical issue with that sentence. That's why I asked whether a word is
perhaps missing. I'm not trying to be pedantic - I raised my question because
the above sentence is incomprehensible to me.

> I think the inline comment above was not clear enough and caused the confusion.
> How about to improve the comment as follows? I hope it explains why
> _init_null_blk is called in the if-statement.
> 
>          # _configure_null_blk() sets null_blk parameters via configfs, while
> 	# _init_null_blk() sets null_blk parameters as module parameters.
>          # Old kernel requires shared_tag_bitmap as a module parameter. In that
> 	# case, call _init_null_blk() for shared_tag_bitmap.

That sounds better to me.

Thanks,

Bart.


