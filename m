Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE09134A5
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711582241; cv=none; b=mchlfxIc7wKgrMaxAkMD1o4xB3mwuKnXuOyoa8ETogHlzVSthzjSDR1vGDE5OxaURubmlBF8kta3atoun/dlFGADEP308Pd8WZ9gfGpAJeWgxoO1ddbGc99KGy9YLPceB1jVDpLtCr+eRoVwjn+mAO/oXP56yT+jMiCwifnbO04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711582241; c=relaxed/simple;
	bh=j0KD5i+yzwDSDoUQpii1Q3Ga3qoZhUYFodlgPU7YPrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEqkOghE9OJpGdH68ZMAAgSFuavoTYU5Jao428QPWQV46G1AQvHlmuUNmiDkJ+H9T8F0UQbkU24pI2DjpCvF9+VW/YrrcHvCpHezjJ/Vf9oWGsQh3Gdyg/mKjjegJ9LRXkZgy+7/9Jfi/hrjYgpJ9toVtRDcQt2GdftqjxoXZag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=aXTxg+mr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="aXTxg+mr"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dfff641d10so3149845ad.2
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 16:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1711582239; x=1712187039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6Cb9vuTNhhUgdwN65jsopOPWmZWIfJ2Db0CN8Jplso=;
        b=aXTxg+mral1+FnYhEQPTIKkn1GqFjT3om1L0VmaJeO7jbap/6fGywqXX2AEEc5xqLl
         3g6E7eHB4o2mYREsLZb3UhzAc31PUYEeyjXqOlX7FCXTnKzMBoKnSpshD4e6SvOQ6dXs
         Dpf1R++e92tjG1fxBUO7cy4PgLxWAezhO1jBj8GfQ0gcQXk4rEu/CDZZvIOTkzVGVv/k
         HT6tQ8/4YWDqu5xpH6EP3XByCVZfl1pOcTt7aCyhp6rdjiqmlLyqC+TZuv3b3Shquq5z
         5ShP0E3qLl2QGaBuH1sTv/qonb24OzK7htsd7at4/dnLMm+6AJhfQA9jsoQsOQYObCwI
         bDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711582239; x=1712187039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6Cb9vuTNhhUgdwN65jsopOPWmZWIfJ2Db0CN8Jplso=;
        b=rgd9gTbyP2VwTGnqc8wmBhGP0XIExqHUpngS1ZEhsQtKrhjoj60OJmis/kqqhhPJ4H
         wGIGA8FAX80x+q97tM2N/ALBRJO3IITpXCP3smnf7H+DXJdzMafBw0LcZTqq1MD1mwl1
         E/taNUW6ebkW1F0ltAfBw43Lm6Xtotv8c2SaYSCsAnH9j9YYZkDVPPPVbXNK/shC8coe
         RzBEy1CQdlkog0vC7RIvVkNPuJCdpZxcsmQEHgNcSrq2pzmDeyiR144KxZ04IBEcGnuO
         hDdLfzIxQoZrwQxroKN6+VjUBhnEVC41jALBogvlJKMnk6OIivcQ0j+olxSjR0ffu4eH
         2uHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9kD3OhO9tMFZKP8YsEcgWwfQDEzLl37QVNmW+92t3stOjlG5wEB14HepnFYffEpGt2v66pXZOK8HV9shNAfNze83Z+y277p9MbDc=
X-Gm-Message-State: AOJu0Yw8s9lInpP1i0Oi/b0CXrTPkFBt1r66ehMDvkpxv1u0GtrMiYml
	EvJlTL19a1oIE4QSORUAGUvctWdnwiOFJzJKsCY1zfItSZOrVCxptuty/hcVdfs=
X-Google-Smtp-Source: AGHT+IE3VpqjwHqfksgXx1JPb+BXQfac6HBN8qulQ3Pg+H6FG8ylXasKZ7fPLwJHMNXLJYtXg0s7IA==
X-Received: by 2002:a17:903:28e:b0:1e0:b0d:5b7d with SMTP id j14-20020a170903028e00b001e00b0d5b7dmr1258885plr.36.1711582238998;
        Wed, 27 Mar 2024 16:30:38 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::7:1d1f])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b001e0b25731easm91126pla.98.2024.03.27.16.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 16:30:38 -0700 (PDT)
Message-ID: <c31b0c71-dc6a-4481-b2d2-c41f5cf6371f@davidwei.uk>
Date: Wed, 27 Mar 2024 16:30:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] io_uring/rw: Get rid of flags field in struct
 io_rw
Content-Language: en-GB
To: Kanchan Joshi <joshi.k@samsung.com>, martin.petersen@oracle.com,
 axboe@kernel.dk, kbusch@kernel.org, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 anuj1072538@gmail.com, Anuj Gupta <anuj20.g@samsung.com>
References: <20240322185023.131697-1-joshi.k@samsung.com>
 <CGME20240322185731epcas5p20fc525f793a537310f7b3ae5ba5bc75b@epcas5p2.samsung.com>
 <20240322185023.131697-2-joshi.k@samsung.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240322185023.131697-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-22 11:50, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Get rid of the flags field in io_rw. Flags can be set in kiocb->flags
> during prep rather than doing it while issuing the I/O in io_read/io_write.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  io_uring/rw.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

This patch looks fine and is a no-op on its own, but I think there is a
subtle semantic change. If the rw_flags is invalid (i.e.
kiocb_set_rw_flags() returns an err) and prep() fails, then the
remaining submissions won't be submitted unless IORING_SETUP_SUBMIT_ALL
is set.

Currently if kiocb_set_rw_flags() fails in prep(), only the request will
fail.
