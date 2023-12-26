Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248354F5E3
	for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yLETI7l4"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bad333144eso15868439f.1
        for <linux-block@vger.kernel.org>; Tue, 26 Dec 2023 08:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703608078; x=1704212878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xOMGLbsQ9RzM9b4GH1sZi3XCxnyOtKMyWm93wPrQ9NQ=;
        b=yLETI7l4PsCDRf5Kn58dk884r6RxFXdB6JdQwSDmbPwtHCnPXR6qtJHbJlz05xStRT
         /1aU/boBhS0nS1Oc1ZCkVH60u2Yxr4WK5b74wQChUeBbC9rxXIUaHRsOamnDFnbP0PVZ
         I1SxokhleyqbeyKyrXcLfV1cEOToa+uT3eKMYGnKFTaW4Lg7GQin9ZJQYxhpyBldnL+I
         uPUyK4jfNTy8ypegxFkDXDe9vWiWcs2YfgJvIrPYg+Vl/XH4FfSG2r0KJtc4oQutk39k
         0mHK6XfHTfkcItmD/ei9SbXtvCEutER63O4etdtDociYvbeyfxeMaXx6Si86uDhHpXPb
         BjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703608078; x=1704212878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOMGLbsQ9RzM9b4GH1sZi3XCxnyOtKMyWm93wPrQ9NQ=;
        b=QNHcx1786uR9kYkEcrWr/O7de7vsKbTc0hyiSvHuTns+1hvjPeJeAb+ZZBC//C+ztz
         ggdc1bhAsZ2YcmFeaqhyfsdeX7O+W6N+9vlhd+R7GI0a2cAaGPHiFs+CkSxwflOxQKbD
         YpJLlOTgKzn2GYw9MUs5u5Ktr0BpV5TZXP8yVWdr+uzblVM2uPHacvGvrPkJPFUf/YKp
         Q3PMCL7FVwzWWfk3Te4ks0b7TKF8tZ4MUASpJDZG/mQUpd6hdgbbUvZfZQYhoE7/wGp4
         IEjTM+ykra5KMdTEYTAJLa7zgQoGgS6AeWI8E5+qRkAGBACO37zMskm8e9DfMkTZlRE4
         hVdw==
X-Gm-Message-State: AOJu0YzvhbowwUkujq+cfd2+nlg1Xe43vcnKlUzhcoJB1PS6ZiCGyS3/
	Sc/sS0tNqmruGP/cMj/eZsfSmwdZPRhFhQ==
X-Google-Smtp-Source: AGHT+IEgyg08vkH3r2LNXz77+SvWCKLe1kl8w+wmTxYI0Q2Y3xIjVmbHXTPWx58lZLUgNU4waXN8yQ==
X-Received: by 2002:a6b:6a04:0:b0:7ba:ccbb:7515 with SMTP id x4-20020a6b6a04000000b007baccbb7515mr4749377iog.2.1703608078311;
        Tue, 26 Dec 2023 08:27:58 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x6-20020a056638034600b0046b6f096e3bsm3092448jap.134.2023.12.26.08.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 08:27:57 -0800 (PST)
Message-ID: <4a9913bb-41b0-43c2-b7b7-22472e954a12@kernel.dk>
Date: Tue, 26 Dec 2023 09:27:57 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a memory leak in bdev_open_by_dev()
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-block@vger.kernel.org
References: <8eaec334781e695810aaa383b55de00ca4ab1352.1703439383.git.christophe.jaillet@wanadoo.fr>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8eaec334781e695810aaa383b55de00ca4ab1352.1703439383.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/23 10:36 AM, Christophe JAILLET wrote:
> If we early exit here, 'handle' needs to be freed, or some memory leaks.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


