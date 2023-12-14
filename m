Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE26A322
	for <linux-block@vger.kernel.org>; Thu, 14 Dec 2023 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7b6fa79b547so504553739f.1
        for <linux-block@vger.kernel.org>; Thu, 14 Dec 2023 11:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582335; x=1703187135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdEjRoCMZdJgfwVDd5XgJJHDwhMzyt1PmP27vOEzO2U=;
        b=dVKcRtxxoww7zc3MeFhOOz2U/3xmT5wNNS5S/TCMb6xqO5rvbuYP58HF77WYb0Cpdv
         oBV2zAY4YBLf9uEXM58Riz3aKPDXVvNAJPsQ+NSF0bnkUN123s7B8pVfuZy7m9KHnkJ3
         btdX02yX0NQSjYV0RNbk5W7o61u4aaNxij3l1WDEH2zdU0Ta03MxaCRsJyZFgG58DCsS
         yDD8TuAiGymVm2cZK4vTxSMRQrqeCUPpdaUuCrr+SZJaHkU3QgyRYJvXTeL5ljNh9o1V
         7LDyTZ31HEAXWbY7z5JM+Ar1ZvmjFp9KxFC6nDmMwZ2SbZFeD1+LBNVf8Et9xbotxJzK
         1pzw==
X-Gm-Message-State: AOJu0YyHZ3ygu5kdrdeUi4gUiJaDfuMzH+sv1S0adkBADmlO2T2C3/k7
	WBRnxZQunjaT1OLRe2aK/Bc=
X-Google-Smtp-Source: AGHT+IH3C2sng7WveXNNwbbETxrX+D8372wzOgW5r507VBQh/0VzxqcBurOSfWr/EnyBsunGg7O3Og==
X-Received: by 2002:a92:c568:0:b0:35f:88ce:814a with SMTP id b8-20020a92c568000000b0035f88ce814amr289254ilj.15.1702582334722;
        Thu, 14 Dec 2023 11:32:14 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:bae8:452d:2e24:5984? ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id c7-20020a634e07000000b005bd627c05c3sm11750066pgb.19.2023.12.14.11.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 11:32:14 -0800 (PST)
Message-ID: <ac5c16eb-3be2-44fd-913e-3b894859b5d8@acm.org>
Date: Thu, 14 Dec 2023 11:32:12 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
References: <20231212171846.GA28682@lst.de>
 <686cc853-96e2-4aa4-8f68-fdcc5cdabbba@acm.org>
 <20231212174802.GA30659@lst.de>
 <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
 <20231212181304.GA32666@lst.de>
 <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org> <20231212182613.GA1216@lst.de>
 <ZXiual-UkUY4OWY2@google.com> <20231213155606.GA8748@lst.de>
 <ZXnevBo4eIZEXbhK@google.com> <20231214085729.GA9099@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231214085729.GA9099@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/14/23 00:57, Christoph Hellwig wrote:
> On Wed, Dec 13, 2023 at 08:41:32AM -0800, Jaegeuk Kim wrote:
>> How that works, if the device gives random LBAs back to the adjacent data in
>> a file? And, how to make the LBAs into the sequential ones back?
> 
> Why would your device pick random LBAs?  If you send a zone append to
> zone it will be written at the write pointer, which is absolutely not
> random.  All I/O written in a single write is going to be sequential,
> so just like for all other devices doing large sequential writes is
> important.
Bio splitting is one potential cause of write reordering that can be
triggered even if the filesystem submits large writes. The maximum segment
size in the UFS driver is rather small (512 KiB) to restrict the latency
impact of writing data on reads.

Bart.
