Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E6158524
	for <linux-block@vger.kernel.org>; Sat, 10 Aug 2024 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723300018; cv=none; b=E8haQTez97ESYhcAGvNOpCDUSmCHVd33F2qzcGFxwg1PDXnrkCjt8kZDrxkaSlhI8ox9yl/GXTDSd+fOO2v7XJ8TtLL6M4g8Fp8OYROP6JJb+BmQe2SG/Gk3QJ+gSve8LqW+loNvgDlHow25/+jjVGSpZEK39J79Ssbc1QW8sME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723300018; c=relaxed/simple;
	bh=IJp2AjlCbDDMAxgFElz/+oD0a/gSVGG9gyoKqu/gdaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTAaeVKgdG2cMPgNVBcQVCW0cThJ6Q/PWjiatew+QGe9sF78Bsjpgdb5dYstPeoRwN39EcT9facQLGmNj4NdWsJFzOmNNe7qTHSsNhyRJTbmSVi+8Ht4ijFiZ0imQnuahO1Ezy5En2GWeMUNqThCDz0dZ/hXXDwUjIbDhguvNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=knhQqHpt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="knhQqHpt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc4b03fca0so1065965ad.3
        for <linux-block@vger.kernel.org>; Sat, 10 Aug 2024 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723300014; x=1723904814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9hrNrZucd6ueEvwXG7IfGc0zmVsa2VOceWwqA+nd20=;
        b=knhQqHpt/Sz8mNniBVMiqU1EFlytA20IAcChh8bfb60+JuYC+NVpfX6xl92o9ekKzM
         9HBao/y+X0+7GzfxhkQLxmidYBkl9Tb6Ug52r0DtlkTvq3oXSkGyd0FrYP4jeuBEGGiv
         cUs4GpBSj3qPJOfKqaDFIKRO/pfkMRY7sjsjz97WuJaX8J6hIgac8LTKt/2bChk6zybY
         n1xutFYmv6kcNu7btFDFYKj0DN+NeCM1oA01g14LOJ72fGm7dXfDp7oaIpFAoGUPA5Th
         1rR94vjuoBvW/7xXDaFyOw5UdvSorp4giPPUMhJbnXUXeXnPelc+1oZgRClog8rq8yxw
         oQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723300014; x=1723904814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9hrNrZucd6ueEvwXG7IfGc0zmVsa2VOceWwqA+nd20=;
        b=q0SKZfCa9xEXVJwE4o9K4B+gcoTeDg2juR0xU4Qm1cf0vBNT6hylD1b/NgquFAGBYS
         lNKEti7QeNfN3dqCVwTvyriJzHkhbjunNI+HdCWz0S6d7wdBXrQOa+odjNFO8rFnWb3F
         vxdHpmo7NorsADfs9CA/VnYFKaTHaRYWzXTUmxxzEmasoVOTFlnYGUbHEZ7SxENT76WZ
         PXXXkeUqQEhSWPUW3qXCzWpVfpCzNOds3DLbdroahZQVzOLjW5nOPhlp57y1uy6anAHR
         Bjr+/lyXM9NcqscCyFLifKWA2Y/9v9bcfW0fr//CL1+jCd7G6WT0igwQwdfRrL47+GdB
         7tdg==
X-Forwarded-Encrypted: i=1; AJvYcCXkLRIXds969otQRP2b+gqork5hK5XvvrAvz+KytgiHcgaj2SbAnX2WwvzGkyWJgAiboW52ZXE22sS3+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY+gcwxME81GYASuL139LLBoMFIQ5MVwExedXlZfsshb+yrkCC
	/HpZHStKkiRJ3Z5rgQCQFYkQsz9ANH/WKS+izJWs8U3QJ92+qK8n//oUtE3JWcA=
X-Google-Smtp-Source: AGHT+IEwTDx0LNxYlSvdNLNK+StLPiVAkwaH3dREOyjG9CY++jrQOwbxRHAJHFpecktNqnAGeaYc8Q==
X-Received: by 2002:a17:902:c948:b0:1fd:d4c4:3627 with SMTP id d9443c01a7336-200ae5f0142mr34076605ad.6.1723300014489;
        Sat, 10 Aug 2024 07:26:54 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8f8f88sm12438385ad.63.2024.08.10.07.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 07:26:53 -0700 (PDT)
Message-ID: <7828bf84-ad8b-4fd5-b55e-0cd3fc320fc6@kernel.dk>
Date: Sat, 10 Aug 2024 08:26:52 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: move zone report data out of request pdu
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
 Andreas Hindborg <a.hindborg@samsung.com>
References: <20240810040239.437215-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240810040239.437215-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/24 10:02 PM, Ming Lei wrote:
> ublk zoned takes 16 bytes in each request pdu just for handling REPORT_ZONE
> operation, this way does waste memory since request pdu is allocated
> statically.
> 
> Store the transient zone report data into one global xarray, and remove
> it after the report zone request is completed. This way is reasonable
> since report zone is run in slow code path.

Oof yes, that's a lot better. I think this warrants a:

Fixes: 29802d7ca33b ("ublk: enable zoned storage support")

as that's a pretty big waste, especially when most would not even be
using the zoned support.

-- 
Jens Axboe


