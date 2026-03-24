Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BD3BE15F
	for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378097; cv=none; b=luTkpjAjtzCXZf9XxYLW3dFo5kAA3nr5Gfs/I+8GdFAL1her8wuS/VkTdJJYxSr5gIXmhF0H/emhjiDYtlMv5kwVwGVeFS3w4WkhGpfRa0O8crHq+dAGKRbzEmvwCeh7rxEBssN+mpOgfIMFULr9dpWMYYMyRxMpDpfSpzp3IT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378097; c=relaxed/simple;
	bh=u6oOk1X0S26SCObLglImxKOc7Oz481CGlkuridd3b6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aL5pmcnffIcq3XCnRinGjDUkZ6hbCf4ovbRHlKwBdG4w0BIyH2NUiK1kftRlXJU0soaSRoG/0GEEpedTqiyxjHZmglEvX5vu4pjrCquuS0Dl5ukJ8NXhmR+a/xVaMiru+Q/dgGLy/OS4Xj04V4/8S07+Y+j4lGuD5UxaQUhW8vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JSWuw/Fe; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JSWuw/Fe"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d744d9acbeso1699406a34.1
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774378093; x=1774982893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmJZ2IWyqe9C+y8W974uEjXLq2yLBMVnY6/rqpsVLYU=;
        b=JSWuw/FeNBtzQtbW4Bdnh2QvwNj89+LGzfnG3X/NI3RoXCyZKcr92JSH+2DdCYGnvg
         8cWyjHTq4eGYdRcxJ/0oC4dxBiXoIMzrlQ9IadW7uwOsIHvLzRKkNlN3mod2hMbFQIAy
         yZYoeFPw+NBj3GBYoSVSPRGf6JjRQzgiDUT25HnMtJmnPqByEJhlCbbf4RJyucN5Eqn6
         2cbKQ2SEBuJ3aZ+UmuP9GdSzsX3sn3OeIfNKExtlblyiN5DvW0tltXnO5j/e+R6bO27W
         SPmKHtATr4oPRM15UjcDwF2bVsdbnYxbz6klBL7866RQDJ7CdGfNhcuAv1/HpldYlAGA
         lZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774378093; x=1774982893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmJZ2IWyqe9C+y8W974uEjXLq2yLBMVnY6/rqpsVLYU=;
        b=k/BZyuUD2JTzW19/mj8ZABi5YZ+nx+jcrYtgd/+56bJzpk0kGw+DAIaFPEUIeGoqjF
         3ALMmscH0J232UCwzJbgYrAtI9QgwzjvEvbdrMJ1oIA6/p82vhgniBmPIiXfikKBWD9I
         HwUMe0CoJXULxyqiUqh0f9Kvzdsi4LDKc4NdsqCxA5N9evL1R4K8IjK4anXOZmBX3aIs
         Fq2HfCb3/9MqJgURhXpdB7Kr06c/R/Rh35bSPcqhgt5WqnPDSjhE+Rz4WURIxdwLUxib
         oauyI4juUelzbXdut8nrJGBRF0qpJnoE1RFYu80YlkeJI6G5Bm1tqrbVy8llSckjwLoj
         7XTw==
X-Forwarded-Encrypted: i=1; AJvYcCWN7PVEnYBd2iei+B7qnAq8Fk/uqS/0uxAoJ0qFUFuffzHJbIv//76bw4P8KneE4tCR0wGRQumQzH7tcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf4JYfvOkdXttp1sPqgv4Yf4wjozpLtks8n4Q9pfu9CoZpBr+u
	QCL9yo6wiOkl8NM83yVDzyhPfWSjc3iXVxgNl4/3KuMGCrxh6X3NZbj/pB9a2IGOyKw=
X-Gm-Gg: ATEYQzz9lglbg2xz1bYJWOZqeigL4Wq3IpRwqxI2BnXVX6DNilkhJX460HeP+ZEwKwH
	ZzPPdNKXH4vamS0syFHPHpw31PXEcwEWiEDV3NycIlD89dRsjfb/S0ZRzL1Cy7gFB4sBmsRXZ86
	cuKev5v1j36vDYOMlJIYmktHzXcU46CIqbhD/Ako3/CIjDs+fIZYg+8yzaAHyr+6PdJYEJL+bsU
	v8pvMbwEk1U2FfzTedaFAU49aQGmGMMPWKmw2tXXx7buNYPaVO3BlJfsICD9CG6ughs1b4Mv4+w
	1aBOJNtUtfnYYjBRihduQwKT1WHqLTEIfo3m4qupROiOe7XiYRnkQZQEFvmEPiKIuF0Jok9Myre
	iOObSkqoMlcNju93PCqaQco2EEsZ0EI7vtNdX6wdnr1R0o9SAbEZxVj1nXRUiuEE7TGEWpVPvYE
	UCZHm5U9g3+e9iE3KIYMO10lug5BINLwDRJ0hAuWlrEXjR3bHbYUO4tkqfywLCabTbUJMyeSQZ2
	PeV7fiUbv5B8MJY7OM=
X-Received: by 2002:a05:6830:258d:b0:7d9:9e43:b8c2 with SMTP id 46e09a7af769-7d9d68fce31mr269547a34.22.1774378093231;
        Tue, 24 Mar 2026 11:48:13 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eae1c959sm12274619a34.23.2026.03.24.11.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 11:48:12 -0700 (PDT)
Message-ID: <5c12f6f8-5962-4d66-8414-8f5185438ecb@kernel.dk>
Date: Tue, 24 Mar 2026 12:48:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: define new rqf_flags RQF_XFER_SINGLE_BLK
To: Bin Liu <b-liu@ti.com>, linux-block@vger.kernel.org,
 linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@linux.dev
References: <20260310160408.3976760-1-b-liu@ti.com>
 <20260324143448.2631888-1-b-liu@ti.com>
 <20260324143448.2631888-2-b-liu@ti.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260324143448.2631888-2-b-liu@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 8:34 AM, Bin Liu wrote:
> This new flag will be used to handle multi-block transfer failure, in
> which case single-block transfer will be used.

Maybe I missed this in previous discussions, but why can't this flag go
into struct mmc_queue_req?

-- 
Jens Axboe
