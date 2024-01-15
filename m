Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12B1758F
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KoexH+w2"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6d9bd8adb9aso1236859b3a.0
        for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 06:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705328725; x=1705933525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BTyVfmz2hJiEVhEw5q632zLaT46LN9kFqtDeoZ21t38=;
        b=KoexH+w2oSte6g5cT7KETen9CTcd7grY2LqVcfQlZwKJwsloGdDXVrgOuT+PX/8z3d
         lDFTcUCucjEzcnt3E385WfVmT4SzFbLTU3Uh2nQlmhVg24xo7uHm9HCwXNFhmSVt16Q/
         Ip9ovgLD6RKVEunXVKeYz9Pc0Bz8I9UkyT+iZqjcZHryeYmj/8lZx+Vn1MQAOeagkB1r
         S7uAYVyv5yCukNdf5WTYKyc01EV/nRw07MAm3eK+9fB74bh3VtADF3pNwAvp10VIQu4k
         uOHUQqttILKdjN6wgDX+e6n6JSegUUcFcuBg43t5JEqNj9MWcat21SmVRs3ABSftalfU
         GU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705328725; x=1705933525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTyVfmz2hJiEVhEw5q632zLaT46LN9kFqtDeoZ21t38=;
        b=t0nRQTb7o3ZWdPJXdDp/UlrMaAE0UDDMB/54Za1Ajf0QHaHl97xnxIP/+OPtMkguj1
         7/jAxXRlwrUv+AxHGTtCF81TQsjf4IGrd0SR6IxYdM4XPXFLLRI3REbh8/IhmhIr4ZAJ
         qtnqVBvwnHsDzdb3JI/ENy7VY9f9h0rs02rV8Q2ohndqI8ZL5p/4kM7aCq5ZtyVDXYoX
         M3BrHDEzxYccDnq4ZtAv1lFvHfVUFOSl7ifG+acTVW9uh3Hf4lM3SJC5/+0ECmn215V1
         ultNli0MIuHgFHDlrezrx3Yl3XdwvF86bDSJ/3CeAYZ7u/qqGhNyu3qik3/MzqqJ9+6o
         fuUg==
X-Gm-Message-State: AOJu0Yw8XPmCfKVzhlZAUGqRhvDWZ2lSSQdOLPi6PL+u6nQvwAw3qnhG
	A0LRjY1uOZNHY8iJ42bLdbUFeyOHXBzx7w==
X-Google-Smtp-Source: AGHT+IEMmMZ+G6wxO5aJo2jFS6EC5M2q8MHX4wmy+6f5xjeOWbzyzNji9fVsN/f5iY+bMwQpNo1Ovg==
X-Received: by 2002:a05:6a00:2d94:b0:6da:83a2:1d5e with SMTP id fb20-20020a056a002d9400b006da83a21d5emr13067220pfb.2.1705328724591;
        Mon, 15 Jan 2024 06:25:24 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id j5-20020aa783c5000000b006d99f930607sm7895860pfn.140.2024.01.15.06.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 06:25:24 -0800 (PST)
Message-ID: <603ce174-4307-4425-a597-60236c237fdc@kernel.dk>
Date: Mon, 15 Jan 2024 07:25:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: BLKPG_DEL_PARTITION with GENHD_FL_NO_PART used to return
 ENXIO, now returns EINVAL
Content-Language: en-US
To: Karel Zak <kzak@redhat.com>,
 Allison Karlitskaya <allison.karlitskaya@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
 <20240115125722.bwumutabu4itbrho@ws.net.home>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240115125722.bwumutabu4itbrho@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/24 5:57 AM, Karel Zak wrote:
> On Mon, Jan 15, 2024 at 01:13:49PM +0100, Allison Karlitskaya wrote:
>> hi,
>>
>> [1.] One line summary of the problem:
>> BLKPG_DEL_PARTITION on an empty loopback device used to return ENXIO
>> but now returns EINVAL, breaking partprobe
> 
>  Note that partx from util-linux also assumes ENXIO, and this errno is
>  interpreted as non-error ("ignore this partition").

Can someone send a patch for this?

-- 
Jens Axboe


