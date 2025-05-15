Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ACB2A1AA
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311693; cv=none; b=Blj/vyROGF9jOGQ4dzoEaYPpLH0x3SenPQizOqXqbTHh9pLV/1lLz22UyNDfepvGdnb1yiC8wyATcBp3xQFrlCauluWxn+/WQirngDyZBfLQfl7CCBsg6YpOccgyrsSN8xAh4o2Q/bW9n0oL+r/v2OsexsePKJOSzjmGUFLbqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311693; c=relaxed/simple;
	bh=YGx4C3lejZyj1NCqUm/pZMe7PU39nLo1jlMNBxzmPp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1w79Z9Jpk3mY53+akFW4Sa29MIr2VqssoDI6T5eNLcFy41AcWPIlSG6aXbxYIwSgSgHwd2dSaQ/C/x1vtp/nlVk2jFdDjcVNsq+R9z2TMB+RmfUOpJEyZdgjevwtB29M4mbqEj+af4763ZNPVJKIypFJ7kDoOtqT9N01dxHCcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DtMuNaJ1; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DtMuNaJ1"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85e1b1f08a5so23012839f.2
        for <linux-block@vger.kernel.org>; Thu, 15 May 2025 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747311689; x=1747916489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LbhPwm2kQrXEE7I0F7tJYw0AO9eHa6UkyDJMDQ2wFeA=;
        b=DtMuNaJ1fhxVBRZDavxwZuZOCPy1OKQsDyVGuBVpYbuBRdI/it4wh5bV+tQj6N0zPI
         1/pJdGxxZOTWGs4Rnm6aVBqRsgerQo0iL/0xjo/0ex0SwtAREA8rc10W8UNTX/qE9xcL
         pke3j/3XxN/q5djx6zRq7ksnlXUo0QnHlqFxsZVSfJwh8zY+02yH2k3My/ooBK2MOwNX
         HEHDUI1w19ZtJZI1g6RmSnbO8x1yQ4t4CVtWMgCBEG1ERi4RlH3ZKS/rDXHB+cch4QQS
         m2TbIUoojBNtiJUzrzegnv3ccRGwwFW0yzGvcKJWgeFo3dJexCrG1DTARhC+sR2i9A/M
         rSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747311689; x=1747916489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbhPwm2kQrXEE7I0F7tJYw0AO9eHa6UkyDJMDQ2wFeA=;
        b=ThhYhfLA03cAuQtM/j39AqVoeROdyDLj4gwyG4L907ptYPIHP/LtIQwrGpsy/of0Mv
         yqsHYPX0KqICLUQsoYxoHWoWJwTPOYfgXGZa2RYAW9Fr32/WZ8mIbR4kqMPhd9yVIzmc
         RJMKUe9R3XXUhI7HIdEDL0bwmQpp5kO7yM2vZ91SbI113hXPw6eWFb0R5jjIPvjLda2t
         O6A2zjcFBARcMdh7nSwQ+RheYGoddHqcASk8Dzs1SLWhTINov4GiamuUWuua6p1ysZVK
         uJwuHQYwUR1dxw3up21DxjD4xG4KgT3Vv7L6aYutO797HFXQHXgbN2wNQzNAvXkV5A84
         1ImA==
X-Gm-Message-State: AOJu0YysvRBXfRdEPc6JCRp8Uz4ybAT3awEkzgTinYLJi4vzCBC/ZK1C
	9njJbUJozxMnHJaCudNoxEJwyx8amUiAUKSVyx+5BjCL0wprJrBoQWRI9Znx3qo=
X-Gm-Gg: ASbGnctTN6eQ6V/Vk1gNuhLsMlXh3Th00j8ZR9c7PDtM1lvHPT5reWO+HMtIkSip0ge
	M4uqSBm+WMs3gZwH6l6I3PCA4VNdhu6iGEWUYtdSm/iiZkjYMBLFaPPM60o7zNAvWxRVpxounGC
	2O08245saLZ2T+zKBm9BywtT1fInbh4lQh/M+q5vcfJ3YXpJSEdqA/feuP40roYmjRWEHLoxGWq
	X6dlI6UY/MYr5jVRebpig1tOCcECwOpFT/AoP3g1FrDWcYNvxOqsTRu83TZ7ceQNgGfUcm7jfxe
	MAfLCOz8lOzfyCKRs0G74DPM3wMbI4/XtwiwkUKoi3iaEl+b
X-Google-Smtp-Source: AGHT+IH9aRASV+LJDva4UaOVghaK7g1DLoDR7y2UWnzuWyWoRru5K5wOnKy+yA1wudSB2r+6kmq4OQ==
X-Received: by 2002:a05:6602:2744:b0:85b:3f8e:f186 with SMTP id ca18e2360f4ac-86a08dcadfdmr962758439f.6.1747311689219;
        Thu, 15 May 2025 05:21:29 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa4d01e25dsm2119491173.77.2025.05.15.05.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 05:21:28 -0700 (PDT)
Message-ID: <b81d2ab9-0ebb-4498-a136-9a65eecfc6a1@kernel.dk>
Date: Thu, 15 May 2025 06:21:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.15
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <aCXWVQ0-cbSsQXFk@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aCXWVQ0-cbSsQXFk@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 5:56 AM, Christoph Hellwig wrote:
> The following changes since commit 8098514bd5ca98beca6ec725751d82d0d5b492d8:
> 
>   block: always allocate integrity buffer when required (2025-05-12 07:14:03 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-15
> 
> for you to fetch changes up to e765bf89f42b5c82132a556b630affeb82b2a21f:
> 
>   nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro (2025-05-14 17:16:16 +0200)
> 
> ----------------------------------------------------------------
> nvme fixes for linux 6.15
> 
>  - fixes for atomic writes (Alan Adamson)
>  - fixes for polled CQs in nvmet-epf (Damien Le Moal)
>  - fix for polled CQs in nvme-pci (Keith Busch)
>  - fix compile on odd configs that need to be forced to inline
>    (Kees Cook)
>  - one more quirk (Ilya Guterman)

Pulled, thanks.

-- 
Jens Axboe

