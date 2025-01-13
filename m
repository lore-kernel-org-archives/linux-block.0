Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565223ED54
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777513; cv=none; b=SC+JGVMbeVbB4nEs3og5bE7kDl5OswnxB9v72LTx2vdTXcNstAuHDs+4VAqqgwV2/YvHLWAQMDujyYa+DlUNuhPK1CcGaCeg1Z6KxESdXP1OT775z8/ZDXsqBOGenro7QFGPJpUyAN14JH42pB93i84HevpawwC/zu/MdoBTw0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777513; c=relaxed/simple;
	bh=CITCKbSohSrjpd1dhmKYEIAmwjOlz4Bl3bKE74x9T94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oM1Rs4K7i4aW1l3ZkPx9VhNTo0xIojZBNtnI5nNPjdsREXeJk8231sqhXP+oLKb+18SaIywniO7iCCACx8mvE3UhABoeOF9XOUw1Lw/4obTDjTnmCKH90gGTr/6dsAfYhhI/iysFsp+sgX0YljpLsrfs5LZpBuGWVEI2+BbFtXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U4bJqmc6; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U4bJqmc6"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso9968645ab.1
        for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736777510; x=1737382310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkF+tx3Zdf7fEQjB7x96B19ZdO0tM0QqjoFam5UqG08=;
        b=U4bJqmc6t5UHP250xrrQU8OpBtpI6yLcXRXLFlcUvJMryamkJLaejCYltxC7QwNAGm
         EmB9R0sw6V6ka58KIpOROsMmuECc8S72c3PSua1eEDuH5tFH9DiMFD6rjebSpxNc6iIX
         POmqrXgqIa+lmejsv7IvUQouqZgrGCAWNMVOufoEkZ9oUOwXScnmeBI1p4eBw0CkUiLG
         Hi/aNcLyaa9DR87V7mm/QJO2CX9mz3mPdnQMBouk4zWPaMrJSQgWMWygA8fyL+27VPTn
         B3CDYYHkt6JQaVGq13gXRs/EMQYisW4q9xTpjn6p+cZm0pzsTsGegxeqQHvXCTvnhnj8
         E8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736777510; x=1737382310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkF+tx3Zdf7fEQjB7x96B19ZdO0tM0QqjoFam5UqG08=;
        b=FW3cxs4UMTbg4Thn0hLZrFdeY3RhISdBeMw/ypzR2Qma6avE6BcWU5pEUzPkn1x6ej
         hnhKgchfmumxV1fSjUoTycQ2lh9lkcZWeHA/lbm1rNtVZwfcvkbIMDPi4vrHbMlZd9Y1
         rSoGSjaruVylXKCXsOWIE2ErDC/JeVc4g0cXe89zNGWy5ebATMtUuvQiO7i3RRzzueYc
         Y0QSb8C/BuVjtruAcbMsB6ExXMkPjb3nHmy1P6haI1OvUHXGVZZb+pGDpHV2kmzdcu2A
         TsP+Vz0E81Ssp7JBCvg0HDKvjq7A5WSwsOtcnjBp/u0xPt2hafJMutt90AuegvHjr6Nd
         CvDw==
X-Forwarded-Encrypted: i=1; AJvYcCX4r2mpREh8ER3rJxqPApa8e9rb3XYfDyXRfCwLOAHUQI+Pm45ZjZd08aTFvya2AfDQBI4qXvDGUXIQ5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzJzu6MK98Wz6sOExSYA+sXPkkzWe+EtdX4xQT44VXNP+D+QXs
	iT/Euv+8NHVEcS1kkwC76Oa2jrk2OvaP9HtApSuWzzum4C/s5HUtjc1ezloan4I=
X-Gm-Gg: ASbGncvmaeziWfg8wnaZUhwJQ/iFBlUaGbZZhwkPp3Pdy86plJZL1NaHMmf7K4xnrtv
	MnY46pKzirlHnS1su5dLQdWQvs+aR+lqarJW/XevvbvGuMpIZ7NdKNLnuTWtjq7OYSBqXETUjPX
	aXl7awSq66aIUYUzkvM9rZ7KBSy07UI+bezelhGqEDrrI0uVoJHOfvP/I0fK49GwadCGrRaBUG7
	0Asfli0HzP4wU1GfGO74aWJN0dDpU/RaIYucdQT/BsFJ8kV+87j
X-Google-Smtp-Source: AGHT+IErqDdONMGNYb5aIsrvlJ9Mo7LjWyNWe/1sDdXiUkJcdc6j5r60f1YEeV/OOCooDIGRQNFNwg==
X-Received: by 2002:a92:c9c6:0:b0:3ce:64a4:4c44 with SMTP id e9e14a558f8ab-3ce64a44e2cmr43977615ab.1.1736777510602;
        Mon, 13 Jan 2025 06:11:50 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7459e9sm2749780173.118.2025.01.13.06.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 06:11:49 -0800 (PST)
Message-ID: <9c81af73-df8f-4735-97af-edb2e3544e48@kernel.dk>
Date: Mon, 13 Jan 2025 07:11:49 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] md: Add missing md-linear.c
To: Song Liu <song@kernel.org>, sfr@canb.auug.org.au,
 linux-raid@vger.kernel.org, linux-block@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com
References: <20250113061308.101069-1-song@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250113061308.101069-1-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/25 11:13 PM, Song Liu wrote:
> md-linear.c was missed during manual fix-up of a git-am conflict.
> Add it back.

Gah, please resend the pull request. This is too broken to live
in my tree, let alone the main tree.

-- 
Jens Axboe

