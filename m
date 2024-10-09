Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDEA18FDAF;
	Wed,  9 Oct 2024 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474038; cv=none; b=HXmOdQnljqY4E5R6ECUKPs9IV9dtxShfxLgwBEWEenBmGglPTO8S33nWqbOnkBB3Ll1Bl2agohRJT7iWbyC/g8xsiocEgorh7oxYN9PIexs+WsDXoEsgoyXp4KFf1baxFR7PRp+cMNZYGydJpFZqcpNihofmhNk9I/LtGq9vefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474038; c=relaxed/simple;
	bh=a+57C84rClzBS7ubk6LgHlFunx8dFXsKxDKBsYdCEV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sapXcYMpZuh440ZZnTWYy0zFvsZUahF5K9TtZKV/cNdVF5GBB8ZK21Ff/I9ezQSOP40Fthj3VQ6kZdbO0qgWa7U6GWE/CUbMUocA8g2Uw42dFhXe62oyBTASAxN9ms/PjTVcR13aJlSkmbQbhVuYYZee9IqNlKZUzynWLkme16s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIFwWgck; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIFwWgck"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db54269325so5531210a12.2;
        Wed, 09 Oct 2024 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474037; x=1729078837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0U8brGX+QXwXhzrsq4Sm++YDJFuC1KzTkr7MoDharJQ=;
        b=cIFwWgckwTFKzd7D1YgAX31UmOhr9OvdQHJ21STAjHacvGXXTrQEJQt/ccG2iPH9bx
         hDdCcLFoY40P6jv9B7N6jbcX8zs3+PsCRd74VSfoeuMa/JQzVIa0U05RmRYR+Z8IPj3n
         nE68B5OKB6FcfhdGt3PH5e6GzZ0+rp6SlR8a4SCZs/Ty0nz4Jn5mb2Xk8nVIsWM23Duq
         gFrUUNzU02u8ATkE691LwSy25QllZ32mqcHkzbRmBtJDcZD0L9Ne2ANdprCbwni6ZXz7
         8uEIaume1Q3qSRBJMNiZ5/+kooHVEhJcDNiWuE8rW2WWWgQM/m4bHR/iSR+5uFvNDCQP
         caHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474037; x=1729078837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0U8brGX+QXwXhzrsq4Sm++YDJFuC1KzTkr7MoDharJQ=;
        b=BGfUr2wbZVPgIHkB5zspEGvzjWiZzRKJ1xtdD3EStwKZg2Lb6Kx+RrABlJgwtQeh2R
         T8O6prdzL+B67x6HukKH07ImAIfxW8mbVSnKFOGFlWJNH8JefI/EKNX9awTAQ11bqvHr
         JWd//ANvI8RgGZpFDwyxuyAYwMVQXtTAJ1Bf22yLmJuIgLfms2ir3zMazSXT7KmhPus8
         qQhkWNZGAz5sqbVUK9Dl78hV2Xjq0UAtUig0s+Dkzx9Kb/2+u/zCKcLJTNug7zMalmda
         S4g3zR459wuADL8tpXc3qexETb8hfKbd3j0hkdRlrUrTMi30Up/DwiMI+xQ5/Tuy0IWd
         klHg==
X-Forwarded-Encrypted: i=1; AJvYcCW/i1HXSR6udqtiyr/hJ0JCvVMl/YjXrCVWxohFaFlktMnTO2g5sVmaPxRYSLiNJqCUpT3p7MMO1XgCfVRt@vger.kernel.org, AJvYcCXlym+zxjGm+EX/itcrJfC5q1AwoYAXdLZDzp9WZGVQ9dds1Uu4oc+dh5xSCIuME5IjXu0j9oKKicd66g==@vger.kernel.org
X-Gm-Message-State: AOJu0YynNnwAmDuO23GDC/QGwMmxsXDA2j3uFXSJ3htpNo/iubu1NRvd
	MLvSzIY4QqHPzY6D61vAuJMHoIbIYyEjORgsjFl2ULBR7R51YMpf
X-Google-Smtp-Source: AGHT+IHNCrNFUCi+dkI/CAAMqHJEaK/iEAEaXD0WwXQ2PiC0daDYO65uRP2ztK1slhpuqp5ZHtqYeQ==
X-Received: by 2002:a05:6a21:31c7:b0:1cf:21c7:2aff with SMTP id adf61e73a8af0-1d8a3c30b74mr2933538637.23.1728474036778;
        Wed, 09 Oct 2024 04:40:36 -0700 (PDT)
Received: from ?IPV6:2409:40c0:1048:4b3c:cd38:b59:a263:1c9a? ([2409:40c0:1048:4b3c:cd38:b59:a263:1c9a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f681f0cfsm8324278a12.27.2024.10.09.04.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 04:40:36 -0700 (PDT)
Message-ID: <47216282-a3b4-4b85-a5d1-dadbf6814d76@gmail.com>
Date: Wed, 9 Oct 2024 17:10:30 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008175215.23975-1-surajsonawane0215@gmail.com>
 <ZwYxA1sfQdaj0Hy3@infradead.org>
 <6e290cc3-0be1-4ee9-8e13-351f8cd9f658@gmail.com>
 <ZwZq5hIJSmQW1Sxa@infradead.org>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <ZwZq5hIJSmQW1Sxa@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/10/24 17:07, Christoph Hellwig wrote:
> On Wed, Oct 09, 2024 at 04:30:56PM +0530, Suraj Sonawane wrote:
>> Should I submit a new version with the added empty line and explanation
>> about the tool and function issues?
> 
> Let's wait for Jens if he wants a resend or not.  In the meantime
> just tell us what tool you are using.
> 
Okay sure!
I found this error using the Smatch tool.

Best,
Suraj Sonawane
