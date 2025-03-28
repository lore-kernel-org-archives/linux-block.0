Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D431213E67
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154192; cv=none; b=HbH4OVAvLcRI+mTTc5GrRg2D0KRPVvoO9b6cfb38BXfhxCVbnAlFgphtZYaEvPAqXAsI1myF2q1+y2lXQ1K6/VkhgFjlhK6v2bpBJMbhDM+1qiCqwFoB+4IKHG5B+KdDivstfhx8iJywiNRm9jRI4ME9ZCyJE1fQ4sRSrGRWejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154192; c=relaxed/simple;
	bh=YFPp9WWr4Tv2T63WZi3Pvgti8ml4lgh5//Cy6S6Rb+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWDp2l0j1HcwcRIM5FhzYDqPs7rWM4bYl4haQOSnko1TZu3CNskDUyW1tqk9mEbbXqjqqwEDD+1SvBj5+ldyr2a3pB+gExORn22RMZ/ZtdN1P+TeLKkd+UIu+hiVD9vSldSDRps1rckxsV9GmLWNpEmHgJdHAp46g1R4iIforI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sU4xkTDc; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sU4xkTDc"
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E41C3FE2A
	for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1743154181;
	bh=W0DQXE4Sz8iAfts0R9aUVRwmGkJey3qq2CZOpEhXzA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=sU4xkTDcfTW8JHeMxU1BfmxHlnvndchLBEuRffGwYH0LBy4Flx5HpayNtyRGO51SZ
	 DeryvzcM+0VjzClKS9X8kMsA6zJITV7tlnqwHpJ8QhPHDqwDeoHB4L3HlisJ5Mcbqv
	 orZWuHMddxEYvQmIxemeTcmfqFwMOb/vUFWXRvwrLNMfp9a+vMDdoBHkmOlhp09ZGN
	 DRSQlV1BthX6H4auPqR5RUflB+RCRYF+Op8B/iuR5ao5+C4Giqk228aHD813aTZQ09
	 Skp4Luf7NQyHELuBsgnloYwP2BgfF+JLmlCnNE4JjEZiV9tQ8LcnaRaWVQ+EB71nuf
	 r+EXqi/O2sJlw==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4394c489babso9416355e9.1
        for <linux-block@vger.kernel.org>; Fri, 28 Mar 2025 02:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743154180; x=1743758980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0DQXE4Sz8iAfts0R9aUVRwmGkJey3qq2CZOpEhXzA0=;
        b=Re0kNdU23lUP+IfQsFeUDlSrokJKvJ2COM/4gdAITC6ghp4X0kv3pxSmFFyuFvXRP9
         OQZZU8e/nk+A2QUlnMRvNjr820fjEnIW19nOsGvuMD27VDhk/J3kyNKNf8e9LYaWNWNU
         P3L7zKyTTAYWFdUZL7/0H5av/KtsaG8On8vpw71XjZvYjRravAS4UJC80Ux+ZWFRRnIu
         fRkD7xWh1gcltCoj4RZic4jGNAm/9AKWh+nezGAUVNM+YPBa2cT3a+M0aJZJbfqMAc9B
         SCS0ECYJHZOhSZj6ANt/GeX7N1THa6bkbJzl8Vr4MD3vIiTzVq1S4mF82mSDwhu79urm
         KlQw==
X-Forwarded-Encrypted: i=1; AJvYcCVS93gC4EjzdrXQ/rAk5M8yZS/yIm8KpeC1de++LU6y/+RbTdO69rIZHa0P8ywyiA9crw4MVorGLWa/ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8XcUdTksB7d+kj7DRCSKVB1VQImTksTiKGYpSOWNtCYS9nHlV
	cAdjK8wtIk4n1FFy1i50LPJXmfpGfcS3cRdhO2Th41iHYjRAuALML05AmCB5Cxf8ENovLhUpOa2
	6dHTUW+kOJhv3G3aa5nZ9XeeGX6cWOY31r7KghU6V9qwql1OZmpNqiST8o2cW2c+sHYXVeZTNgQ
	42
X-Gm-Gg: ASbGncuDOrbvNNGlBH4IsC3dmrKUdYWIjN61Tc4DciPRDkRP/zy2Be9xQsdm9ESKaXo
	544+CFhBfWTa0OMbAK4UNMDAkDOxgcI14AgUEpgZCT3TCOwslW9xq1janwVUNgNDEF7CSCm3Er9
	i8XqNxT2ovc/hBCv7ih2ReXF3bMp5O55g4N7liasDfo7XUaN1/Mypo7Z6vfu9p0MiQTbLkwg6gP
	Ll/5N90ke03Ru7YwkWjHeH9BVrnCLxui3JJgolp+QvPqgWoad6VUQG3NTyqcxxGIrQ4WJcPWnAN
	4/Pbd9VAs4mK0buwGFi+pW+ceCiT+Xiv1VzurqoXPcWmoa9k6oKLF+XrWBMpsw==
X-Received: by 2002:a05:600c:6a13:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-43d8522cc96mr65306185e9.11.1743154179922;
        Fri, 28 Mar 2025 02:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRHH6+C7f9WxPlfoclpQ4muAxjcE3H0jmeXlyq7TyVvgI6TU6FiLwynF58/TpV7N3SAbOGGQ==
X-Received: by 2002:a05:600c:6a13:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-43d8522cc96mr65305975e9.11.1743154179563;
        Fri, 28 Mar 2025 02:29:39 -0700 (PDT)
Received: from [192.168.80.20] (51.169.30.93.rev.sfr.net. [93.30.169.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8ff02f9csm21538575e9.26.2025.03.28.02.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 02:29:39 -0700 (PDT)
Message-ID: <7afc3a7e-1dd8-4dbb-b243-75bd554c00da@canonical.com>
Date: Fri, 28 Mar 2025 10:29:38 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] block: fix conversion of GPT partition name to 7-bit
To: Ben Hutchings <ben@decadent.org.uk>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Mulhern <amulhern@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
References: <20250305022154.3903128-1-ming.lei@redhat.com>
 <3fa05bba190bec01df2bc117cf7e3e2f00e8b946.camel@decadent.org.uk>
Content-Language: en-US
From: Olivier Gayot <olivier.gayot@canonical.com>
In-Reply-To: <3fa05bba190bec01df2bc117cf7e3e2f00e8b946.camel@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> We shouldn't mask the input character; instead we should do a range
> check before calling isprint().  Something like:
> 
> 	u16 uc = le16_to_cpu(in[i]);
> 	u8 c;
> 
> 	if (uc < 0x80 && (uc == 0 || isprint(uc)))
> 		c = uc;
> 	else
> 		c = '!';

Sounds like a good alternative to me.

Would a conversion from utf-16-le to utf-8 be a viable solution?
