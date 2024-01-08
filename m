Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790FA56766
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g/1H8Bqk"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-35d374bebe3so1102805ab.1
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2024 11:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704741406; x=1705346206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUrgDLUfZaVfgTFOVEZNjpmTBZl4Q0vRFzYBcXml+vY=;
        b=g/1H8BqkMPWcbtyJANvJ9bqYUppywnuIqEJHhtBRaA8dPCIVmHXoZqcVu/ZnpzcaGZ
         lI8NPG7azNoRRjH4QrGfRycbmtSKjfGzvBdzUsIK9+6d7l6+sYRxM+VSvIjQkC7o+1Hi
         VpU/BzCwVjo1Kpm1LY55PCgCrQizfkD+jQSLyCuHSGjoiBbmo7DhLvoDKut82uCu+ew2
         mKGCENM2ttqx44rilJoj7TALdVyeMGZIryfmimFW++EccOqcvDfs6W8tCE4IDsAQQd+J
         SPEIXHqSBPz7rZGcL6yJ8FPE0NrzunuKl9oG4Aik3/iiBEySAAn8Po/iUkfnbjzHpGgG
         tz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741406; x=1705346206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUrgDLUfZaVfgTFOVEZNjpmTBZl4Q0vRFzYBcXml+vY=;
        b=BsDhegim44m8+tztBzqBge5zHqME2LwN8LEOU1DjB+PbQHMsLNJ5BK261flmQ22tuo
         Rrmzt215LDmoF0wkq0K8BQHuypY3RztjyQL9w2VuyyLDyK3W47/8KS8Ekk2ucWZbVPWu
         bcvK/l7UAzUm5/IsTcTsbzdCTob+nKCpwAQBxxPKYPO9ySxFIeUH0pgXEzQdZL99Xtfz
         J+NRr7XyqBGbMWcMloI3Y0Z/Zb7ZOJF4mNiMimMh+zKn2JHgzJXCXyj1N5i9QWfVitLE
         mjFSxyUZ5RpwCY4AoEoMXc2Hkx0Mfo5YCHrur9YpJcCvyzwTPkFTDzKIiqiD83qPseIZ
         Nx4Q==
X-Gm-Message-State: AOJu0YynjULTibMFirdokrlUPaEbH16rZ2wxlJwvAMnacx/cTJaGT+SR
	1ClAYVLdComQAl3kJEP/rGADWbSu91iiXQ==
X-Google-Smtp-Source: AGHT+IG/8HuyEUWEG6IyzUnXij1+/sNcjntYd0CBdES0EhUgVJI67Slz2Mm/mTKLZbhdUhuWRHYAEA==
X-Received: by 2002:a6b:ea16:0:b0:7bc:25da:84cd with SMTP id m22-20020a6bea16000000b007bc25da84cdmr6902287ioc.0.1704741406605;
        Mon, 08 Jan 2024 11:16:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b26-20020a029a1a000000b0046e025d9fefsm137424jal.48.2024.01.08.11.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 11:16:46 -0800 (PST)
Message-ID: <9f236a51-8df4-4c84-b8ec-db2fb4038659@kernel.dk>
Date: Mon, 8 Jan 2024 12:16:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: remove another host aware model leftover
Content-Language: en-US
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <damien.lemoal@wdc.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20231228075141.362560-1-hch@lst.de>
 <20240108082452.GA4517@lst.de>
 <1a4f6e1e-9981-4e2d-bacf-3e387addfa47@kernel.dk>
 <yq134v7951a.fsf@ca-mkp.ca.oracle.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <yq134v7951a.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/24 9:14 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>>> can you take a look at this? It would be great to finish the zone
>>> aware removal fully with this for 6.8. Thanks!
>>
>> Looks fine to me and I can queue it up. I'll do so preemptively,
>> Martin let me know if you have concerns and I can drop it from
>> top-of-tree.
> 
> It was addressed to you so I assumed you'd be picking it up. Looks good
> to me.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks!

-- 
Jens Axboe


