Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A3487AC
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fSDqqaHT"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3607c86896eso2613545ab.1
        for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 06:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704898787; x=1705503587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dj+sj/oKRc7hT1H8t/r2ivhN2ji2w5hSbMTw3TnFD0w=;
        b=fSDqqaHTppPIYEA6m1NP0NeoBnRu5oD0H7p3kvQy4DJz82a4r3Z86nVghdefTH70g4
         P/xNsUQNXZQY2FWlFeViw/Vft0Pk/6bWrujpJJWgVIRqG8o/tBUioJP4OFBxT/+zW+9k
         S2ajbORd4BDbTJHb+LH+9J1o4aDwrqbXCycOvYkCiTpB9j4xcN22aYgxQ0E7hjuiptSp
         w3lCmaL9MjA9XLtj1HHEw0DoXtXgYbJ84Sq5s4OwL0NXGMOOMVRG3wX/mibocy+lnT3y
         zM2OxR1dOiN3o4q3ROVdLSBqwYFxJIwdO0HvTsA/qfurZD2pQGTJ/OFgfDoOEbC9C4/Q
         qdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898787; x=1705503587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj+sj/oKRc7hT1H8t/r2ivhN2ji2w5hSbMTw3TnFD0w=;
        b=ujB0MKyb6bXjhtF6QU9ovMOfCrFAn34IO9O4VRqdPArD90+ptKdt2Xpn1zbTHjmAjA
         S/Kf9mtIzsoqPKGAXp/ZQdpVT3eenBnYwr35/o/ukrDzG15uIZHcEURhYzysRdaccZxK
         9HQdQvFyleWuctVQhnyiKY38rRq+foRHwQGYtMCIuRwL++Yi5F3yQrfBuM7nF0NqNiO8
         eBH6neHXOL6okX6hywm9SanPONsG1XVRmVYeFbEvgeaeY59MXYonK498RoZ/Nbq8s64o
         NgIwjCkNq/fLNNBVZOgF9I1tO2AywxxQbA3aejge55o1dl2K/IofbO4jtxlBfpEtYa3N
         h3WA==
X-Gm-Message-State: AOJu0YxhvzvNlPLJU6TKLJOvgATFoiHjKX8hJGVfmg4p9V6aK4X9wnN7
	Sf+Nl/KvdFTUCziHaZVd2Sparx003i7hbJXZFNREZhgpBJ/7rw==
X-Google-Smtp-Source: AGHT+IGgvvy0Axb70/0h2CEq+xODe3ibT4d/qp8S5Q8rds9/724CAIOhf0wBwZfr26iD/nkzprOUow==
X-Received: by 2002:a05:6e02:1d94:b0:360:64ad:cf39 with SMTP id h20-20020a056e021d9400b0036064adcf39mr2758665ila.2.1704898787398;
        Wed, 10 Jan 2024 06:59:47 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t2-20020a922c02000000b0036007e0eabcsm1249415ile.78.2024.01.10.06.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 06:59:46 -0800 (PST)
Message-ID: <d921a213-df5d-45dd-bc37-99f3034a1a03@kernel.dk>
Date: Wed, 10 Jan 2024 07:59:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
References: <20240110035756.9537-1-kch@nvidia.com>
 <CGME20240110062350epcas5p351f5b4f8e27b3c57545b49509d2a48b6@epcas5p3.samsung.com>
 <20240110061719.kpumbmhoipwfolcd@green245>
 <b09c8885-9907-4616-bf80-68ca145a1eea@nvidia.com>
 <20240110075429.4hqt2znulpnoq35h@green245>
 <aa82e427-a599-4cef-80bc-fac5bc517335@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aa82e427-a599-4cef-80bc-fac5bc517335@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/24 1:12 AM, Chaitanya Kulkarni wrote:
> 
>>>>
>>>> Should this be TEST_DEV instead ?
>>>
>>> why ?
>>>
>> My understanding of blktests is, add device which we want to test in
>> config files under TEST_DEV (except null-blk and nvme-fabrics loopback
>> devices, which are usually populated inside the tests).
>> In this case, if someone do not want to disturb nvme0n1 device,
>> this test doesn't allow it.
>>
>> Regards,
>> Nitesh Shetty
>>
> 
> it is clearly stated in the documentation that blktests are destructive
> to the entire system and including any devices you have, if your
> system has sensitive data then _don't run these tests_ simple, when
> you are running blktests you are bound to disturb system you can't
> prevent that by using TEST_DEV.

It should very much be possible to run blktests on specific devices
ONLY, the intent of a test suite is not to potentially mess up
everything around you. It should ONLY operate on the devices given, not
poke at random devices in the system.

-- 
Jens Axboe

