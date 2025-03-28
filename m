Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0A1C173F
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743189664; cv=none; b=fXA8vr5AppECswCW+GedrFgapGWtuXiwA7tCrAEldIK4HgjMhgYjIZUQraTnVh5H3m6x2yAMPp5cKf4dGYrFwftPpxG9F3I/LUlYk1rNNYbHQ3gDnatq7QQrlFbTz407QphCMm+qW5FA049TaOBYU5azKT6c3WaWz72rPbM9N/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743189664; c=relaxed/simple;
	bh=9Esyej47MXyXzcSAmIJ4EgIKMmSjGEuUuaT0dcSkzJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtAgF7YkJbAhXKR+EhCpu+D/5aKLX/EQd3oz7zpHUjZOH7Yz8ei0/lfY4NhfY1m9cAPL/6mVCYyBIijuvWJV5MdERq44+iqGY8l2+xWvMqrAuHbP4IJUkwmxH2CjM6cOwKg6s/s2GNe+FrXo0NAhoIVHbqbzXEiDXxCk26EHbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AimN/x+5; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AimN/x+5"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85b5e49615aso216773839f.1
        for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743189661; x=1743794461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lG9dZo5ZH0RsJOu3eXzt0yKhbFMrsHY9cwC7gax1O9I=;
        b=AimN/x+5ziwROVNt0fmrXcdrtEuJoi4GAeJapo9cMWnYOoVOlbw72/E2K6gYnFg4TJ
         xI/DdxHRN/Cl15FNXmcisNrSbC7q+vFcjujQumg/DOIkAp1W2i2iaNr8KKwflf8hLeNG
         M+nH9vjsVPWmOPrjNJvrK94bnmZ49AYj7lSDvZbiQavOvf5AMAK1DdcUflKMAnIoxc4q
         Aexu6PEG8P9+3yb9jyE28XSUb7Q71TG85tH2Jk3N+G01REEjeD+nK6DIpcMc77L/p8EK
         MgfWHrV6WdIOF6QeDVPXbSr+UOz5EeOsjxTf+1Gj3H7YG4bNyLvyu6Yf1TTvHnuckC0o
         ihgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743189661; x=1743794461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lG9dZo5ZH0RsJOu3eXzt0yKhbFMrsHY9cwC7gax1O9I=;
        b=cwi+pIb8ZgrP0EXTlky+hFihF3PLdMawN83CkNrmTlqWM358zp2Zp2++Gl/yJN4cTQ
         +A3Jaq9k/v186D3CbWG7kq2ODgkuMw0yiGYrfkDRYyYVxE+uaGXnflpA7habs3YIBhyV
         7TKLo/qrPz0MFuOBEMGBNPBtETskWFLoivrBRG1Hy7Z7JRtUmeEm+ufT58bmEImoN3ay
         I81Z+5t1/L9zE95GTc2DdFMWLjaMd+A1afhlV9KnJdTHnWT8H5TGxrK5k2wMURCHBYmO
         HESF8vFEXHc6T71f9PqiAHd1EWcIN29Vr6bvwcE50MB0PFNwbefr6gcALK6p35OJLkso
         38UQ==
X-Gm-Message-State: AOJu0Yzf+waqPQq4zoTCgwLMOzQE4RvOoNl9Q9Bvi39s5yJwaLlcM3aN
	71z56xl7WD99Vj7ayf5QsoekWMMldNGluQbSCveT/EsJJp+lQz78SHfp4f83vxA=
X-Gm-Gg: ASbGncv3qNxU4fV8xvciAbfjGB2j51T361i2zlhmlx4j1i5Kvuw1hEjGLNJ+fOwkdYO
	fU+4ZDNIR5RfsoV8ov9bG4Zmq6hV+8nvLc2/M6m2Ghf2xAjnhE7DllAF/hDSMZy9QqZH9U6kLsa
	50LnhBFX/UvFBgSX8RzeFAzahb8uH9YMJrgyqAHP6mHqC7zKSZOXMh49jZvIEOcerW8dSrsrnWe
	s6xm218jO87zCwj4xMtC+zzRz1s+tAclXND2CUNdXzkBhHXFCA/otD8lxpcg7VTYVJm/5ovwa+i
	K56JYEzdsHouvT2JQqTibckp0RL7a4T+CeTi8c+mFA==
X-Google-Smtp-Source: AGHT+IEdoUiqLHpxteaAmvVOy+f9e6FFbOsTplCGfV+RJGis2sI0S3KCmLvvUpHS294ydDErNHXdkQ==
X-Received: by 2002:a05:6602:358a:b0:85b:5564:2d51 with SMTP id ca18e2360f4ac-85e9e90b88amr75155739f.11.1743189661154;
        Fri, 28 Mar 2025 12:21:01 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f46470fcfdsm577183173.24.2025.03.28.12.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 12:21:00 -0700 (PDT)
Message-ID: <31fe911c-7340-4687-a384-c67cfc4b6380@kernel.dk>
Date: Fri, 28 Mar 2025 13:20:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Minor ublk optimizations
To: Caleb Sander Mateos <csander@purestorage.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250328180411.2696494-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250328180411.2696494-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/25 12:04 PM, Caleb Sander Mateos wrote:
> A few cleanups on top of Ming's recent patch set that implemented
> ->queue_rqs() for ublk:
> https://lore.kernel.org/linux-block/20250327095123.179113-1-ming.lei@redhat.com/T/#u
> 
> Caleb Sander Mateos (5):
>   ublk: remove unused cmd argument to ublk_dispatch_req()
>   ublk: skip 1 NULL check in ublk_cmd_list_tw_cb() loop
>   ublk: get ubq from pdu in ublk_cmd_list_tw_cb()
>   ublk: avoid redundant io->cmd in ublk_queue_cmd_list()
>   ublk: store req in ublk_uring_cmd_pdu for ublk_cmd_tw_cb()

All look like reasonable cleanups to me.

-- 
Jens Axboe

