Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55601A3F
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PyOD8stm"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d5595997ffso7277645ad.1
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705018330; x=1705623130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RDR8Pr11m33UGsfaCe6Ai28GS+cdafGrto8H86VV/I=;
        b=PyOD8stmN/7L8sDSpudWErBJP9kf4r96jY3hg3sxtEi6tiVNA1vd6Xn9GjeKuqEAjV
         L6tMtJg6OKEqY1o+dN4i2/EVjnZwf7abF3J0UZzwsxaRROHUJF+s5ItUreBww5IQurU6
         9HnIuGOVGrfHR7EtLgrZ0k/GNjD0TXQGKnAYR/o0zT8RuqeIZ46EZuP5KqSv9+k8cv3y
         Q2VGqkSJg8K140ux3JfvcQmHDuq1ZlQ0+y6iND382kOCNavIY1blQZbJdvEXlzvYDdzR
         bDggueqFsgg5PEOz5cCewXFJBXtSyUYtqr/6z9n82ArqNWSSGkUUeXa1U9sKjynvSytm
         3OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705018330; x=1705623130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RDR8Pr11m33UGsfaCe6Ai28GS+cdafGrto8H86VV/I=;
        b=SnFSkMHoT6r37BKJRkYEr6VVrGurnpxdwd0CHuxemFBpKF/9V3ddEDzSDYjo+Nu1RG
         A18hTHH50m9ZG2Ulebj6aPHDmwM6+XdFtWfogiTNPwHbdcdU5tHTujhmgMSXQzW+25Ht
         JjJJtvSms4VojFrdlzgYNv61qgWLZDp1b/sLLU9MJ5Gy3IDHWYVM9DG5AdBwEpP7iB1o
         R4FCTo1l6gDYgNEpILOlxwbZX+Q/G66yACjQQmTxdAsCed3k+FOOQ5P53HZesLpjVwt2
         cX5vpmzYTZj+aG7JJEnD3b6WPTinzt1HlzHZGNpP31DDrN+tdK3Ev8+lPpSf3JFTQEr8
         grvQ==
X-Gm-Message-State: AOJu0YyrjLMIEAd23CnALqrmqduFM+F8fDq+GbZsIl6QymffilAVaz4v
	phnL5a8Ued7Xb7jJ9fXoKkjT1uAuLB/h6ZnyBkXJci5EOW9wng==
X-Google-Smtp-Source: AGHT+IHxFW83UA3ocrNYi2vz/x8194P1s3mgzqGH0JNkfyYDo/VlofLsjt+2Gp01BY8atlQSLWp/Cw==
X-Received: by 2002:a17:902:c194:b0:1d4:be1e:f197 with SMTP id d20-20020a170902c19400b001d4be1ef197mr247423pld.1.1705018330342;
        Thu, 11 Jan 2024 16:12:10 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::153d? ([2620:10d:c090:400::4:1638])
        by smtp.gmail.com with ESMTPSA id kw7-20020a170902f90700b001d4725c10f3sm1424866plb.10.2024.01.11.16.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 16:12:09 -0800 (PST)
Message-ID: <13f86ddb-8d6f-49a5-80c8-72e2546b65f6@kernel.dk>
Date: Thu, 11 Jan 2024 17:12:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: print symbolic error name instead of error code
Content-Language: en-US
To: Christian Heusel <christian@heusel.eu>,
 Damien Le Moal <dlemoal@kernel.org>
Cc: Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Christian Brauner <brauner@kernel.org>, Min Li <min15.li@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org
References: <20240111231521.1596838-1-christian@heusel.eu>
 <ecf3adb2-596b-471b-8e35-b8f8124167f2@kernel.org>
 <rqf6ufzzvmrukcaulkhmfwtjon2jwhrb2liwwimtws5r3uqmux@k2p3tccnm4sm>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <rqf6ufzzvmrukcaulkhmfwtjon2jwhrb2liwwimtws5r3uqmux@k2p3tccnm4sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 4:56 PM, Christian Heusel wrote:
> On 24/01/12 08:37AM, Damien Le Moal wrote:
>> On 1/12/24 08:15, Christian Heusel wrote:
>>> -           printk(KERN_ERR " %s: p%d could not be added: %ld\n",
>>> -                  disk->disk_name, p, -PTR_ERR(part));
>>> +           printk(KERN_ERR " %s: p%d could not be added: %pe\n",
>>> +                  disk->disk_name, p, part);
>>
>> pr_err() ?
> 
> If desired I can send a v2 containing another patch which refactors the
> usages of printk into their respective pr_* aliases, but I wanted to
> keep this consistent to the usages in rest of the file and do one change
> at a time.

Yes let's please keep that separate, not a huge fan of conversions of that
anyway as it just causes backports or stable kernel issues.

-- 
Jens Axboe


