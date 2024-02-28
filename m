Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6F157E9C
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130106; cv=none; b=DDj+2ajxvehnU7JvmnFW8fnw/R6PPwyU7v1igRlVRGEqwJT3SuCuZli7itJfpUECpWetGR/WuX13EhAiocMOhcXAlPw+sxeh9jcFfSEcbxPktUzwKmC+QOhT2zbcNiu96Gq1f36k9n0KTkYh88cZzWRBczIgyKGAw7P8mIGfQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130106; c=relaxed/simple;
	bh=/IB3SBMJ8eU/LRv5ylO26FlaNO00FblZ/RbV/4pvBmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQtyoXuM8dWO5TBpgqtAhqcDVxwNiQi7B7+XXFtOIOJH46P89//z0fFn5kkvgsq9PPgyBVZJYQs+zYqM7b33BWbHVyU5VbEjQ9LKDZbFHk5TGVzLP0oAEhnfHDBY99sRjZqDf45VGtzOAt1vsD0RA//jIZfSPR+za3PPxg+rEbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=p1LOzAHL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="p1LOzAHL"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e5769aa0b3so47815b3a.1
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 06:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709130104; x=1709734904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LhYyEdJEEIz0w3oxk1CxMivJRZFIcNl5Zw/pnXVcaA=;
        b=p1LOzAHLagNxFlXnlIhWA9H49uAbZLzqinpgkKbBZef92TV16QiHo+EH//BzB2BkJ7
         jM4smlFgy8jEFMItl0pVjWPBlxB+iJAl5wLH1HhSTzAhB5ZNbMdpUlEugk0YINn9GY/t
         eDwlUTOEedWSWl53YiYHjtQ7IfhYnCRTc5VW69+8tIgLRb/N3musJF91W9S1fcQaLpY0
         8vAn8eOqcUlt/h8Dwx09zmXR1RsApnTFQ/IaT8KS1gk/yAMagdCj0qNc/LY2KqsYWhQs
         IfcPBtJin76nrYHJSL5p/mmJqhXfhLfQ3gLgem0pxsNf6nAuP2iV7lOi50wZuu5cOOV7
         6haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709130104; x=1709734904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LhYyEdJEEIz0w3oxk1CxMivJRZFIcNl5Zw/pnXVcaA=;
        b=RviwyYAdmA9j7XFGLeahgYsfb7SGOUZiUCaK+BfPGtMeuA0W4hh0P58kwrOets4yaW
         3AmH1GZNtUtsY3uMMPWTgvFjh1fgvOXz08mK+Th00IWSer3Pc+ig4qoFzaY6nRCaXu23
         lKPvGrALoubFQA6RUwda6PtzKt4YVc8ihfED8uJHDm3chrudUUUxYjvo2OSX0JhxiOxt
         6rm4GPfBE5t4kYclNeJXZ3/c6TQRjG90ZWC8hwBgcH1D0xQMHATCa/wV1DAU4CkJA1bH
         0IpQ1UqHHZ+3U0+7TBXIGe8656gnh3oX5FtTOWldJMeRGpqkN7SaeJGhjfqph6YU7dIJ
         SITg==
X-Gm-Message-State: AOJu0YxCxjt21TieejdZWU5nUnce2mxLvihKXy06Mv4unTpRtEFWsZxc
	TZZQXcCx9ZOcU5hB4qnh/+YDcHaTsIFyvv44ellEd8Rrwqk6LRK2pLtYZgmevCY=
X-Google-Smtp-Source: AGHT+IFI98HIwcv6EsdlK2DkBZisBTU972LamnrpRAsbHhUVTwEbCk46VrmE8byrnVwF2/Er5w2zPQ==
X-Received: by 2002:a05:6a00:2da4:b0:6e5:109d:8373 with SMTP id fb36-20020a056a002da400b006e5109d8373mr10517138pfb.0.1709130104239;
        Wed, 28 Feb 2024 06:21:44 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d18-20020a637352000000b005dc5289c4edsm7654764pgn.64.2024.02.28.06.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:21:43 -0800 (PST)
Message-ID: <2dea08f3-03c8-46aa-af57-45cbd9556df4@kernel.dk>
Date: Wed, 28 Feb 2024 07:21:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bdev: make blockdev_mnt static
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240227081958.89092-1-jiapeng.chong@linux.alibaba.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240227081958.89092-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/24 1:19 AM, Jiapeng Chong wrote:
> The blockdev_mnt are not used outside the file bdev.c, so the modification
> is defined as static.
> 
> block/bdev.c:377:17: warning: symbol 'blockdev_mnt' was not declared. Should it be static?

What is this against?

-- 
Jens Axboe

