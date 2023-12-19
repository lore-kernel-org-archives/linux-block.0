Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714410EF
	for <linux-block@vger.kernel.org>; Tue, 19 Dec 2023 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Wg1P0xis"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b93b04446so328255a91.0
        for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 17:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702948354; x=1703553154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FyD8HfWQyf6LfBl1NPEudbU6H1HSAZ5Pn+m4oHtEKJw=;
        b=Wg1P0xishPnVdzKuwGifzDuMLmunfkLZUA6/WaSzuTbNBF/Ti4nm+saBAgUXHfTTn2
         Ye59Ody1EOQP8hguHGTOdSz8hhlXQ9F5OwivN+58xvXxnUaxpJFZJKaibUXQDSUNOMKY
         wIyq/4FoAFmRK7qiE1aw6AGVfhV6gsyOlrHHwmvx8WV2ubr+NuX0Ke/BeHaWOkbs31iQ
         lLn8b5KF/KEvBEXB2f27fkBgJFeX/xQlK4rnos22rpD17C5QHyKukYBA415KYnHOR0ET
         TZ1ITABCYm63qSX6Nst2RjJK6LBCJNSKABA5P4q7vj/N1qYAk3CdJC4dDqQl0r1xRAI+
         pSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702948354; x=1703553154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyD8HfWQyf6LfBl1NPEudbU6H1HSAZ5Pn+m4oHtEKJw=;
        b=KvS9WgMqoaSCQ/8mNnuBohrVRm/4UAgQvHWrhlfZe7CEMV0/h/UHugorF2u/QomnCV
         l5p3joSg7dAPo+OwHoVikfAxlIpnhUdiXfJtZMUL+1SMehd7iTAFJvTIEvPV7T0owpXo
         6bn3znlfQ++7pEMWdzqviMq6A3dlPYCIDbEMitXVLO5B5o+7nK3FP4M5VRkjcPorHIhs
         22BoMQeXqcTsYLvakDakz8FarMTSj3Ft/6R+8py7m28wCaE9zu8j+J0My04C9PQMd5mX
         kshW5ALPepHGTqp/FycQDlwyrASa4RX2cr6Yo3TVaEKmfQWG2Xx0N8f2b9vwwYCCGbzn
         OzYg==
X-Gm-Message-State: AOJu0Yz3rNvSuc30KGzxPgNVJnGQ3Rhia8KiWKV4JDMKYZOwx3ckukZf
	NU64qiZBInGLt0dEaqCTD32VyA==
X-Google-Smtp-Source: AGHT+IHzTKkhe0cRVbbtQbsADxYsCKZfTSYLFLvAalrCz0C8TVbXqipR5Q215SljZARR92Emk8hj0A==
X-Received: by 2002:a05:6a20:7d9c:b0:18f:c77b:9fdd with SMTP id v28-20020a056a207d9c00b0018fc77b9fddmr40522857pzj.1.1702948354510;
        Mon, 18 Dec 2023 17:12:34 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 10-20020a63114a000000b005cd821a01d4sm4330736pgr.28.2023.12.18.17.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 17:12:33 -0800 (PST)
Message-ID: <6b3f9f28-1ddf-41dc-9f88-744cd9cd4b96@kernel.dk>
Date: Mon, 18 Dec 2023 18:12:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/19] Pass data lifetime information to SCSI disk
 devices
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
References: <20231219000815.2739120-1-bvanassche@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231219000815.2739120-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/23 5:07 PM, Bart Van Assche wrote:
> Hi Martin,
> 
> UFS vendors need the data lifetime information to achieve good performance.
> Providing data lifetime information to UFS devices can result in up to 40%
> lower write amplification. Hence this patch series that adds support in F2FS
> and also in the block layer for data lifetime information. The SCSI disk (sd)
> driver is modified such that it passes write hint information to SCSI devices
> via the GROUP NUMBER field.
> 
> Please consider this patch series for the next merge window.

Bart, can you please stop reposting so quickly, it achieves the opposite
of what I suspect you are looking for.

-- 
Jens Axboe

