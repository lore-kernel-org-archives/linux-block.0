Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD2056B66
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ogMOHIpc"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso64834639f.1
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704989945; x=1705594745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49OaiN4pe4SzMmyhHsjPMU1N+quRVb11/EMW05EkBRs=;
        b=ogMOHIpcBZYU1A2UVAzAVf6cO3VvdVWuIxX3+O85psb9khJUZvXMclR1f39t+Hrpba
         Pe+QbmiwZj58XzCDTj1qndbPBL2gQ3u7xS+9cQjBWOj30NFSrAEnHfqkWSTanUMpbmte
         ltPSBUjPBAjL5/7QNx+OdtDVgLyK1OzQt8UNEy9SUa8NaIVJ7Ru8Fa3AsBb1VIqKIDYQ
         VQum5+mw2N4Ry/LYIg3XfrEb5ur6ox4nISxoMUTuzm+QYkiWfRwzNXMyYsdfJsGpPcrC
         P2j3/3evok1Nkz06KJiM/v9qBWfMyw0wIFuZf/zYCohQkMEzSbWlIgWASIgIxFfnP9Wa
         RwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989945; x=1705594745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49OaiN4pe4SzMmyhHsjPMU1N+quRVb11/EMW05EkBRs=;
        b=GKOTYZ+uEvFf8Na51F2d+sLLXKwbJm9yBifi9A+jJdshPuDn28AuSvMLKHtjfggJPb
         PI8/Wzaf6zjIK2N242Y+ENL+lSGHX535myaarjiaoAf/k1PXDV6WG1cehjZZz7DtxDUV
         6gPQWUCPs+6DnWg2bS/ctU7Rm5Rj1LB1Xo02lXQ17xtkYN6i0ILRHsHaAS2E6IgBGCml
         zIsjmrRpNPK+Le81RhQ1DkAy3V+Mc6zQXyYqPxVGYPr7fT92J97sFRg7I79SWhD8CyL8
         ylgtuGUfZiARE1A+bkZUYTUyIyw1nMvfZsMm8VlxkmNAjtExLEpDJ2aUfHOX3hB5z8M/
         hQ0w==
X-Gm-Message-State: AOJu0YyP1JdqEln7wMavX/Ut7MDx3NUCTgQUayEVgKJq/9XSKkFLv2EQ
	ZJsXT5Qjl2V5W5/ho42WiUa8ECON67VcxA==
X-Google-Smtp-Source: AGHT+IF0MmWz+pVkWJah7wJJ3WwEUiHwYPSSxXFvB8EQ1U4ktWoPiyzMSM1T+QWatTvr2bryWOq7mw==
X-Received: by 2002:a6b:c882:0:b0:7be:edbc:629f with SMTP id y124-20020a6bc882000000b007beedbc629fmr2938586iof.0.1704989944845;
        Thu, 11 Jan 2024 08:19:04 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id eh3-20020a056638298300b0046e578ed0aasm224566jab.96.2024.01.11.08.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 08:19:04 -0800 (PST)
Message-ID: <d4fef9e6-6e3a-49fd-9fca-b8788d1dacb4@kernel.dk>
Date: Thu, 11 Jan 2024 09:19:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block/integrity: make profile optional
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com
References: <20240111160226.1936351-1-axboe@kernel.dk>
 <20240111160226.1936351-2-axboe@kernel.dk>
 <ZaASr3HWWZM_DWve@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZaASr3HWWZM_DWve@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 9:09 AM, Keith Busch wrote:
> On Thu, Jan 11, 2024 at 09:00:19AM -0700, Jens Axboe wrote:
>>  #ifdef CONFIG_BLK_DEV_INTEGRITY
>> -	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ)
>> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
>> +	    req->q->integrity.profile->complete_fn)
>>  		req->q->integrity.profile->complete_fn(req, total_bytes);
> 
> Since you're going to let profile be NULL, shouldn't this check be
> 'integrity.profile != NULL' instead of 'profile->complete_fn'?

Yep, it probably should... I'd need to check if we can have
blk_integrity_rq() be true if we don't have one, but in any case,
seems like the saner check.

-- 
Jens Axboe


