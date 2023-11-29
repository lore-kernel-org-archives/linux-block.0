Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79E8B0
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 10:05:13 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1cf8c462766so454885ad.1
        for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 10:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281113; x=1701885913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wt/fBnTFQo/duADcHhxXB/8hVBX4sLwHIw2f+cwmBFE=;
        b=Cyzn9VBqHs4JHvSC7WzQil5cZSU3YgPvG/JpbY5hJ+ovdpx/86ceuVK+P9ZWj1h9ZN
         MHbt6qcBQE5X/VmMgWafjXWfltJ45tGLI0z8Vs9WjkGckkedwTqt08tbkSOioPa801ei
         Ft3wrN/oGMwG3//tpWFGJcBYC/QrCSk/tuR3bbWySZTqEH38746O+FubHgBRu2gQE0bK
         zkBmMT1fbpDGiuMo1krH3Zw+wt37lY9Sl6V9DKLQTZ6d2EeJXoNWD2S+3IeaMiir6rA3
         63qf4FAwfhNnfvBcy/TQtK9DIYhSwGjEV4xDlsq2gUPk5NIe6tSnTYB798GFPV6CQgIR
         MioQ==
X-Gm-Message-State: AOJu0YzByR78EZDr6QLj+/d4FVsYSOHragkv+WsxjN5iMwWo5fwQHL9j
	IxAtMiS4rxCloPg78BWrfKYRC3NgJt8=
X-Google-Smtp-Source: AGHT+IHD1N9nbSl+F8JVjNCjMeklGQw6BSdFx/charjT9OFzTvu7BwKUiy6SnxK+kfbhqXIcQw/BRg==
X-Received: by 2002:a17:902:f812:b0:1cf:b18e:e414 with SMTP id ix18-20020a170902f81200b001cfb18ee414mr14997939plb.38.1701281112913;
        Wed, 29 Nov 2023 10:05:12 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:af8d:714d:9855:3f9d? ([2620:0:1000:8411:af8d:714d:9855:3f9d])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b001cfca7b8ec4sm6672136plk.101.2023.11.29.10.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 10:05:12 -0800 (PST)
Message-ID: <6acd5220-e053-482e-902c-a86297fd95e6@acm.org>
Date: Wed, 29 Nov 2023 10:05:11 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 1/2] block/011: recover test target devices to
 online or live status
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20231129103145.655612-1-shinichiro.kawasaki@wdc.com>
 <20231129103145.655612-2-shinichiro.kawasaki@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231129103145.655612-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/29/23 02:31, Shin'ichiro Kawasaki wrote:
> +	if [[ -r $TEST_DEV_SYSFS/device/state ]]; then
> +		state=$(cat "$TEST_DEV_SYSFS/device/state")

Why the separate -r test and cat instead of this?

state=$({ cat "$TEST_DEV_SYSFS/device/state"; } 2>/dev/null)

Thanks,

Bart.
