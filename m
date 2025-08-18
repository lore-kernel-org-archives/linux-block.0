Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22E322DC3
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533922; cv=none; b=F+nf3YNneFGGXCewIB7vix+psQdYYm6bgxhgXnhcGjTEKq2RZEiovGL+laZInANQ7U4yCTpO/rYypG7ZFJwgzusYzWh3BJR1+TgGri+HdlLlAwWun/PVPGxW0RZmCEyAg9IdqcRB/OT87Yn2zf0loRSwncUzxmyExsR9bLZTagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533922; c=relaxed/simple;
	bh=//aetfv37YKeJVqbXw3YpPmhG6DNYA5e4H+UE5ZUcL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfV11jvgErbVXpsAcLumKjOhcKmSr8fYMmpj3i5Pj8T4mKVUvbk9rKKg/vs2ZCEyJ30CD+cDVHw9QRZKl5LHJrGD/TxeN9DCJ4RFVjbzLBWT/JfDOcZRpxBBDvO24IGCZjYnA3Zv6iojleGPPcIAFBwxkr9ikzjjblWROpNICxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AlGKkveX; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AlGKkveX"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74381f39a3eso1971596a34.1
        for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 09:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755533919; x=1756138719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cT+WAuja39VMqOvtGfWBOHLuy+NZyDAiBTg1604nP00=;
        b=AlGKkveX+R98nhjJcwiuRfRbR2KQs2ZOIYNwi/RjlN1GB8CGsYaV1bP2uGsmJIf+cF
         0hCDs+nWJ1DYzcWqALjxXFR2BM+e9tl1Ho4LYeHgJ2F1T02wNCC35JfHHBiETsGi0Aiy
         KzFsjFzTz253YSDRXnFfc7JQdv6RlNjN0quehfa139DY+ztmvcjcYOFR8R1+RAseB4/l
         C71UmLeiy9f4llWYGCJ6Oq0/vziUZJBVeUrm5G23qHn7RL3jFzd59k18u71Ans0nYLJY
         nvOKhNAcMNeOAoPBEqzWz9Kfo7s3U2WO0qfPuvBm7Es/uJb7R1eUfKjyq9isyxbFZPwV
         +1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755533919; x=1756138719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cT+WAuja39VMqOvtGfWBOHLuy+NZyDAiBTg1604nP00=;
        b=Y9ybSd2RNvmwzZS2pqFaZbOvdigfs5UmAQ8ELFHzvbtPWGTs1DLdbLo179o5JSpSpy
         B2BAyxtM+lgxRxjEcunI3VQPCJoMtcA2vxRdwyBB0HnewZ2y74vqUKh5jwVVnIgnz49g
         kQO6SXNaLpUiIv3dRmqPVOn01kNoC8zzWII3iEKBlGuPiQNFE1mZl7nk25AYf0TTGEIF
         bhauXfpZPjn75YHCjFvWgR/e5yVQT4cOLv0B3RZzpVpp3O9AAHvcneNO8B9NoE1C4HmP
         vw1p597utzSawShJZYzSpvX+Srj4Umec9sk1AqCyGN9h0emzaOD2gE888kTDZs5Ljzu3
         J9Cg==
X-Gm-Message-State: AOJu0YwC0HdbeNysVSJ45ewJk9aKFsNerl7vA0f9JQCK2kf7b6DBMmX8
	3dEOhI46ih2cbvpDaZcii3ntfccMXiSj1EOYDvmGQnzkkOtG1AIM51rrMIdvCnN32iw=
X-Gm-Gg: ASbGnctE4GM6KE7TFNBWWbEEzosVx9/rI5tVigwpeREeK8EwZWfCbBMeiaiwbV4MxY0
	D1A4fRDIydA6EgpzyMinp7vVMbIx6JCwImYSaWTWZu+46H+qYgvICvd4ZR7ZURNk+r2o6Dt1Xcs
	dWtBQNSJMK5kHnVKZMJ1EYynEna94lvhgctmT8+ovALRNn+9y1+bjtwKHP+VZxuZUDD7RSPLEbo
	kmNbFri/3b105ITA/wYcda4QvCPdHZV8vP7NB4B+Qyf4ERPXOjHefygXQ9Vwx5F5igpkrihtGoE
	3zY0Ts1uemdMMrBWPFY7sUpwKhSFD2g/PyTLmaxx/M7C5sr77xiXW6itbBHjWwBApJFdyPdKKEX
	m0vLYXREr+2Ex/D1Xbmcvx42JTfytsQ==
X-Google-Smtp-Source: AGHT+IFuPGXBI7xR6Jyo6KTbZ4Vmpd5eT1fuogNq810C8ExVtbCRFbryYTNLHnDSuJGq05eb/xsFaw==
X-Received: by 2002:a05:6830:64ca:b0:741:c51c:9e3 with SMTP id 46e09a7af769-7439248d317mr7976713a34.23.1755533918717;
        Mon, 18 Aug 2025 09:18:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c947e387bsm2602740173.37.2025.08.18.09.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 09:18:38 -0700 (PDT)
Message-ID: <7ed32e97-055a-408d-8c14-1c80c64bfb17@kernel.dk>
Date: Mon, 18 Aug 2025 10:18:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] loop: Rename and merge get_size/get_loop_size to
 lo_calculate_size
To: Rajeev Mishra <rajeevm@hpe.com>, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250814191004.60340-1-rajeevm@hpe.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250814191004.60340-1-rajeevm@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 1:10 PM, Rajeev Mishra wrote:
> - Renamed get_size to lo_calculate_size.
> - Merged get_size and get_loop_size logic into lo_calculate_size.
> - Updated all callers to use lo_calculate_size.
> - Added header to lo_calculate_size.

Please write a proper commit message, rather than these itemized
lists. Goes for both patches.

-- 
Jens Axboe

