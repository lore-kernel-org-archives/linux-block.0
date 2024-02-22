Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E7155306
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623231; cv=none; b=AwScVtlHErj8HcuQjwC54DbgYu7M4KOry1cpo/QNZfVsxOusmJaMdoTKeq0a6F1dae1b/yA7r7A2UJv73lwgsnYhG+uYPeSb0OEZoH/Mj+IcHUZjeB52Pt27ykMp6fhM5RuR91mN9UG/ZrFXGteYEW9A1IYk2XWGmxWJWRAINy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623231; c=relaxed/simple;
	bh=V/N4+LIqAU9vvZFMbX/xk+AJCYdk10vFs25xLxgwt8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYVY/9zJcRnC+EOyYCMZ7zQks9O0c6EBe8m7YsTBvvGWxnlUV1E+5yKe8SuJ7Z07BtRSBnr5u9NyYisYbPnfaaFAziUWZ1eBGFBauIvThwaRltImbxmirqwpQXrRAzdCUm37rHX4Li802jRSMmbPQTCGVqYzdznBCeuEOOBzwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e4c359e48aso1146949b3a.1
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 09:33:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623229; x=1709228029;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/N4+LIqAU9vvZFMbX/xk+AJCYdk10vFs25xLxgwt8o=;
        b=Z+dV5FOJ+lSBNrDoW7vXXOsZTPB5l18W4FRU+lcBvAm4m6gQ6FWYkTwqef8YQDj09C
         nOknM1FotCBNaTbEnVTZmGAOJIWDWt0viNOrF7JQ+zQOaejtfHB7HhvfPoY/WCQpMfUl
         mEBwsHL/lZbi86we9Mz4YK5DWlMG/57Uv4I/Nejuv6mNmyufdgsXKaTJc7qDuh6NpsZa
         MogCwRby0qc4xJkRmc7YZ4BkBkNcZX+DoR4/NG8UPrSbTtVPbECZwyHVvYCwq5uJyweD
         Mji+moQBOl9zXVRYZz8n2CPT8j7hG4uekDdSjkhjs67NE5H92yEtxHVAEAas1vchZ7cM
         PddA==
X-Forwarded-Encrypted: i=1; AJvYcCWWZILaKXOTVvZ+UG606OQBHlHFBPmnOUZJ4slcttC36TL72MLYEJtHKV1MW47hsZbvCQBZ6j+aa5G31YMu7PW5wTjJhcT0QUOMF6g=
X-Gm-Message-State: AOJu0YwqTUbHd28zNlcCWqHqGMdekdCq4DYVIuEMFO0zr9vZL/4c8cWo
	/BcxQmLSTOOua4q4WK9Uh48A7h/1HaGem5FwH/fThL/yTgfoboTx
X-Google-Smtp-Source: AGHT+IFjpzp9LFKK+XX4u4mu5/PxhW8yhYdfo9eJhqCY2E9cZNG0PXg6gWDde5uFNyMYtDmGkQpttA==
X-Received: by 2002:a05:6a21:3181:b0:19e:3cbf:60a8 with SMTP id za1-20020a056a21318100b0019e3cbf60a8mr23692925pzb.39.1708623229302;
        Thu, 22 Feb 2024 09:33:49 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:cb6b:6b1d:5f36:8b80? ([2620:0:1000:8411:cb6b:6b1d:5f36:8b80])
        by smtp.gmail.com with ESMTPSA id y4-20020a056a00190400b006e1463c18f8sm11198091pfi.37.2024.02.22.09.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 09:33:48 -0800 (PST)
Message-ID: <ba5f02dd-943a-403b-98c4-3e3729fe3ffc@acm.org>
Date: Thu, 22 Feb 2024 09:33:46 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: Do not include rbtree.h in blk-zoned.c
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20240222131724.1803520-1-dlemoal@kernel.org>
 <20240222131724.1803520-2-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240222131724.1803520-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 05:17, Damien Le Moal wrote:
> The block zone code does not use RB-tree. So remove the include of
> linux/rbtree.h as it is not needed.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
