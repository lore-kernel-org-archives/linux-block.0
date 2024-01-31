Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9DB50251
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704993; cv=none; b=fDpRUd6N4VF/6DsI0qVqGb7/mmHdduY2n+9cQwpxBqJJN1ufhl7jmOCrpYtw0eS5jIqNL02TzqGaaszSemwBTuqnJrH3zInDqGcciHv13PaA7y6N/LvXrNptcrLLX5MCk9dzUYs+D1ejFdyk7OhkO3DFzKq75WNzffpXh8AFKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704993; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edk/JWGwEDvt75BSlHNvf2bqBewexqYaXsMMOWSv0uVip7v20Jgbb46WcHfgCYTrKCTyM+DfyL6fWoaasI0RxgxXzDyPKyNZidO0+G/i5rcWtYVU9+QzTv7G4N/UXujgPlwWErO1g8QdGR6pLYzUNuAOobn7goB9K21tgq9nzGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ad9ec3ec2so628525f8f.1
        for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 04:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704990; x=1707309790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vvSFwUXe+Y2fuZE/xqmGQKz242yZAeGwWazTM9IAypTJ+m/WKVYtKW8/c+eVrqt4Ai
         M2LCJMK6S0dExW78ozdLJiHyV0nktg7mnPigHqJnoJcbb/y5ZP2kEJsSum4i5tPIjNhn
         poTKKL7FygLAv4vAaiANxHASzwMqZd0IkipqY+o3yjpgKVy94TCs+2gbjorEO4fx8UnW
         JjHe9NDMpE6wwKIZvn3rlOcbmUUhO0bJNZTdxri9eYkhHSYgOilrFiSWzfSDdWcifAbS
         gT/si9aQCE21NqJKp59URNk5qrtF2M7O3I9VoegR9GhpcJSwn0ND5I2zCEfW2+1orW6j
         LZzQ==
X-Forwarded-Encrypted: i=0; AJvYcCWJkQTsFlIH0eZNJiXjOMR848Afk2HlUzsoiSiq8nnKmf5V5FRArclyaTwvcWGnEywvkv3uLjEew5/1Jpu1DcQfJ+D2JpuIWniL0R0=
X-Gm-Message-State: AOJu0Yyws/cye44z5ZnnX7CchoKkDVW2kRV0AMyBF9FO3Z+MlCDOG09y
	Jlz1yCwL2XqQvBkooNR3L1mnpzu/oLWUB+kFOc/+g00HTgN85TSh
X-Google-Smtp-Source: AGHT+IHiqDri5U6yicVjAdTzw+nQJ/V3WvROrLRkTghi3afwSxj6SPokNbwq5yTXwX6Ik5pk7ipWbg==
X-Received: by 2002:adf:a2dc:0:b0:33a:e9d3:5112 with SMTP id t28-20020adfa2dc000000b0033ae9d35112mr1085807wra.6.1706704990370;
        Wed, 31 Jan 2024 04:43:10 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d5-20020adffbc5000000b0033aedaea1b2sm7893801wrs.30.2024.01.31.04.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 04:43:10 -0800 (PST)
Message-ID: <d2f9a71a-8e79-4d03-98d3-7c556efbaf45@grimberg.me>
Date: Wed, 31 Jan 2024 14:43:08 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: refactor guard helpers
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, martin.petersen@oracle.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <20240130171206.4845-1-joshi.k@samsung.com>
 <CGME20240130171923epcas5p4610296779861b362ef98f3b6f819a060@epcas5p4.samsung.com>
 <20240130171206.4845-2-joshi.k@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240130171206.4845-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
