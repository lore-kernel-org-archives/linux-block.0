Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7D2E3AE4
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186462; cv=none; b=CladPWphHkloIy0Vp0xkGYYJYiGBLhW41buZU26Swn+9IZxbQdXtrRF8RJuWVgfYwbV25fHOLCVIGzKh1Kl67wFMSRFOFnI3Qum5Htm2fWeTlmls+z7FxL+N6NG3VoWPraUJ1wV4hk4uIRCSTUdJK0fQ037698zNIWc8i4vaCZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186462; c=relaxed/simple;
	bh=sf1+T0JcwOlPtAmaW12tuPWOakYQlJPwEqSiEGG12QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMMGdkEHDNilERmPHoD5CYk3Zb/HUzYEuAr6UHTCNzgjxi/HrA+Sp5eZerV0x7K+qWikfxSMT9n2eQwtdmXkYC3F5otLsSzR0oR+WPniSMYy7AILGdmlxYCnkyk97IUChfOqa5ZkE0iSEJb4KxaeSX0mikM/5hv8pDRoyn2X8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KlyEiMC2; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KlyEiMC2"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3dc9e7d10bdso21205515ab.2
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753186460; x=1753791260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPVTwTdFTsc751gaYm/Hhn67W96rQTewFcoGBTIznqI=;
        b=KlyEiMC2gZlyfQCsKckCWISWqfpY6xjbr9ICQsO3Uu5Qc2CyuxQHQ3aVy4MeLvsI8Z
         8BJWLzKFlDVgZGoMON1k7utu/g0SkpkkWKjLrVNr7zG02u3m8vGBgrOFkOVeyLFIVaU7
         cKc47QIreCbAKCtz1ep84VnpebxO2TpkzzGsSv3C3Pz28YMBKU4QPVI4Ds58KIj/tHli
         xTwqymMSicoASwZuev2rEPNiesNHr3Mama25tHBz/JpuryZQWz8rikAU0vMcEwjz+6td
         5stsPl74bYY1QoeCbTwLDz8g5xk4IkQpsgYdm6/IlRyplfruuDDdG+S8Rxz+4zoPnCJv
         A0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753186460; x=1753791260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPVTwTdFTsc751gaYm/Hhn67W96rQTewFcoGBTIznqI=;
        b=PV25a1vqxUykVe+cNvI8PixSYV2N4PIwEWB6USCAPFm0DiXTRwtNKrWeEcATO4PqZ9
         OKVEx74FrxVxHl4NV3bazKbiCsFpF/lWVVfq9kHqPvD4Qhr1TgHSACYRwdx8m4i4A241
         CQOt0S9f8pTIq8R5WZe+5soaxVy5ULnRYyZS76x+HJ7kUqxs5m9TYAp6QYiglRNYK1sN
         8HqoNFq8xAYtQtscpKg+oGD48HVn1zrg4uYtdDzy72PZAeaQUIckFwZUKEYhrXOszlce
         hfcRlIRes0t9xs62RR9Ua+JbX4+NFtbAoggXqQDvCNHsC7SSvsw7JQtW250bFwyOfjfs
         1r/A==
X-Forwarded-Encrypted: i=1; AJvYcCXu32kDJjVVpvBeb4VwFGf2zgk8mgBzNcCBaZ6y2kYbk0/T0shc2ML3CNtx2ALgXZXXFRZ0cUZ9O04uPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhw5/qhDBKNM2ipfqg77lxMUi/5GDfyBLbuWSEGTiC993f68U
	BTaRS4mto49hRlvWAzXJvRj50vW1H/xEQXDEtebrhVZZ0Hi0v/zlWbufUXu+BV/eaiDPEW+fXHY
	cEaVC
X-Gm-Gg: ASbGncsMbTjmXct8PD5jH0guQk3zqZq/cy46bYXPDOZCkErxj7Q9NbHTLKBmi0z5Jfr
	1MtwIvKHxjE+n3kO5wmUc48w/fV6rLoj7zHLMioinN0yrV4oc6FvDWHA2P1Kv3YLBKlNqAeRKU9
	Lts06j5Y4vXdOtGjRCveoqJAeaGBCc9s8eIxTNX4nLoE2Y8OQXX0+G4WQCsZzKSHaJeTyV8MzG6
	ceBIeYurUKL8jpx6tLNJUTBywNrM6MenZqqLACg77lm1Q7xLFR8zpJuwyhl54xeCSybNKZLbWBB
	4Ws94jYeP4Je/oOuPnioFE0xgs3jUb/cXt5yEXmlsNlgO45BBod8QVdcMnkEEpOftacmV9PDQ4z
	qwoNBsHkeAcGLrWl0jc0=
X-Google-Smtp-Source: AGHT+IGWtOls1B66eWDWTPlotWRsVDE8PPR3Zo1JfCpc3xDLAOtrzQLxt3z8FA6rIVPpDcscI4nFOA==
X-Received: by 2002:a05:6e02:3c87:b0:3df:5333:c2ab with SMTP id e9e14a558f8ab-3e282e64ee3mr277030295ab.17.1753186459712;
        Tue, 22 Jul 2025 05:14:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c787e63sm2495145173.9.2025.07.22.05.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 05:14:19 -0700 (PDT)
Message-ID: <8acbc346-98f8-44fc-9675-0c3a7da87d21@kernel.dk>
Date: Tue, 22 Jul 2025 06:14:18 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.15/regression/bisected - lockdep warning: circular locking
 dependency detected when plugging USB stick after ffa1e7ada456
To: Hillf Danton <hdanton@sina.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: thomas.hellstrom@linux.intel.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
 regressions@lists.linux.dev
References: <20250722005125.2765-1-hdanton@sina.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250722005125.2765-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 6:51 PM, Hillf Danton wrote:
> Try the diff that serializes elevator_change() with q->elevator_lock if
> reproducer is available.

Hillf, these seemingly random and not tested or thought through patches
flung out in response to reports is not useful. It just wastes peoples
time and resources.

-- 
Jens Axboe
