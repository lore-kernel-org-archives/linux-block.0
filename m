Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91915D5B7
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136682; cv=none; b=r5JMVSJLOXiu8QKepXj1SH03sVjIOqjzLCy00JbeExySwhInxCzIe12LisaisertnLz6+MN1Jsmzi0Q6QQzjBwY3m/3B6ZG/pRkRP5psV22YeHagFO5YNK8dpM29fst9LI/pVtAAFPDmeBX9kawdi93u8rDjEcnmyXsRer2kGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136682; c=relaxed/simple;
	bh=0/SXo7LUmEd3Ek4bAWDkgWgcqOozxVlfBaRmQBjkoGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYJIEwbaTFh/jufwVcKiqG2XBpFH6gutFse/IdCEVhP3GZmKBUabXFrLgARmgCJ+8jE/lJB2zBuGGCtJaieKCtMI+1xuPYLLFEue4tGTBRuRvVPRT8JfPCvXBSX5Py897LZiHmn4//VHKL4cK43IyFARaIDUsH7jiRDQ7zMPaXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BqQufdcG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BqQufdcG"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51320536bddso212824e87.3
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709136678; x=1709741478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgP8egN9jzbqWUtue2PPYahrXFZRT/aZTCnQiSVag14=;
        b=BqQufdcG93NRMdtlmwIbirbO3IJPfo3SQexOsal13voIGqPi6mHJmRC3klyrLejE8Z
         BhTE9MKKi86w5Z9GyTkTCDVw2JdiotqLVpYXNLfdcGU8jFjbYn6FYhcYCCxpepKYn4+/
         ydHNCxEoj09Otd0IcAnbbtf856vJ6J7AN+UZdifABfOm5MCpSkXNwKqVCvKnK6rfQNPc
         0OYk/ntEe+G7AfWtxwf/JrwE70bM1Bw/H9JeBtZYmb5mtlQK8ZwHgqpzgr2d7I7+WKyr
         xk3/nwlidEGLWLGLxWO5i+Q+xE423NHcDiwhytDs0VctGULjDQWOAIqsyUMqWrd16Cqj
         Jbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136678; x=1709741478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgP8egN9jzbqWUtue2PPYahrXFZRT/aZTCnQiSVag14=;
        b=JeWEeUy4tkcdHGzpS3e9gOG4bhf/OxzSWey0sANOazWvvT/5o1TlXB8MXJ4v9TBPWD
         CkQsYUZ3KyBvYGL1px/C18GvnYiYB4zXL9lv75xf6RDmVVNxA506FdlO5OZkg3mVHWjH
         lQxFmzoWhMLkKn1rQbDFVIz4w6J3jkl5ORHbj83h/KjL22yQMxDYeQlzOcxG1VKIF4nE
         sK0HqhLj54sMLGefV98modx6Dh5AhkRtRXXl6qpDRM0Ffr4MnzCieNFyAprfpPe/40Sj
         Mr2G5p+laj0RGZg/A9FbOrGasCsN0vOP6asGNzi5eG6OIG04GXTxtner1TiWRL+DvUPt
         5hqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhcHiMZ5bGMFNhlP08x+6fb6Fg8FsBQkkFyGU9EqVHivuubP/AQ0WmnshA7qp6KtrLhUgAGuSX1iHxrbrBJqcFkce5+/sQ00U0EM4=
X-Gm-Message-State: AOJu0Yzl2WC0SKR99448nYfMhSH9hLb8kpiiTSWr1pXvl/Dq3U9dFaJX
	ePihimg5MUcKaMV9fLrFbXDgRZMGIOGSQfxdUU1MHOiEU/kGQPHWhUsYo5/in2BxlgzilNy8v6p
	G
X-Google-Smtp-Source: AGHT+IG9pHQRYhPAl7gRn1uIw/tLwD3MS/O8eajbw9qNVQ3ZgXy9u/fSDDd8ADWubwAiIqrGVivLDQ==
X-Received: by 2002:a19:2d11:0:b0:513:174e:a152 with SMTP id k17-20020a192d11000000b00513174ea152mr104784lfj.29.1709136678541;
        Wed, 28 Feb 2024 08:11:18 -0800 (PST)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id w4-20020a5d4044000000b0033b7ce8b496sm14762361wrp.108.2024.02.28.08.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:11:18 -0800 (PST)
Message-ID: <4111f9ba-e1dc-4158-af6f-c048bcf8ccd2@suse.com>
Date: Wed, 28 Feb 2024 17:11:16 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RIP on discard, JMicron USB adaptor
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>, Keith Busch <kbusch@kernel.org>
Cc: Harald Dunkel <harald.dunkel@aixigo.com>, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <bvanassche@acm.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <70bc51d7-c8a2-4b06-ab7a-e321d20db49a@aixigo.com>
 <62296d89-f7e6-4f54-add8-35b531dc657c@rowland.harvard.edu>
 <Zd9Xbz3L6JEvBHHT@kbusch-mbp>
 <76fcb1b1-cdf2-45d0-aeab-c712ee517b34@rowland.harvard.edu>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <76fcb1b1-cdf2-45d0-aeab-c712ee517b34@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.02.24 17:01, Alan Stern wrote:

>> In the code comments above the WARN, this condition indicates "the
>> discard granularity isn't set by buggy device driver". The block layer
>> needs this set if your driver also sets the max_discard_sectors limit.
> 
> The usb-storage and uas drivers do not set any of these; however, the
> SCSI sd driver does.  Maybe that's where the problem lies.  Adding more
> CC's.

Hi,

that seems to be conditional on READ_CAPACITY_16 being used.
 From the cropped dmesg we cannot tell. We need more.

	Regards
		Oliver

