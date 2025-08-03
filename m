Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9AE2BAF7
	for <linux-block@vger.kernel.org>; Sun,  3 Aug 2025 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754222253; cv=none; b=i5Gfm/ThJFvAYx7LlxMoNhJ+ZeVmqSW3GE5cmJ8BXH0Y9ymOfEWtmjZleaZDABGCJ7D+snbJPW2BPUxQTI0DcRgL+KlgrwpJWl6figNLHS67gK+Sgjx5d9kE2Z5JbJKoKVD7EwI4MeEV6LPsQQPCvhbnSMDCkmGU/C1X4VeJNGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754222253; c=relaxed/simple;
	bh=KMtHpjvblsyuQmr2lYhjoPbzfAzk1x/uHsIkhxYqklI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmJpONYOCKicZ2AsrLdIf1Pbpv8WJQXEeuCeozaDrfJEAy4vV9X5grvV2ls4n6lGzgc1qzqw8zhHeoyQRIj0NKQWRYRNVVyeLrZN8OG8PqLgJMyTCEn42CD9z58AWLt5Mkift5qpbUUJZRXH7c2+QfOrmI+TODyJc5Mumroy4KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mzdkh0Rs; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mzdkh0Rs"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e3c34a9b4cso41747755ab.3
        for <linux-block@vger.kernel.org>; Sun, 03 Aug 2025 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754222249; x=1754827049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ofsNbCZj5tls+/tEVpAghufUCo4CXzEz3jPRdMp1K1I=;
        b=mzdkh0Rsgx5tCg4KQ6Y0e6KrGVR1SHWtLvfGWqqQUHZElK4bcP7QUaIRG+6p0T+h2p
         bSwCc0FzZEiYEDXOvWLdUHq2/9TG+P6SKLcrlvG9UKFbrq6nfKwSGE6ffg8F0fl39WdV
         RSWMVGQWFDEOuMt4rkozzGr4KtEp8155gpDDidrRFMdJk+DD5CiPrhbL6H2iMivK+Y8m
         1VojDnZ1cGYtVJkYfPYQIUntypMADoRdDPj7YAIHW8OXVSqs0Zh2HVOAvudDULUEfRCB
         OVjVYMMof8+IEYbcKvim2qF5jLmcr87durdFXPQvHRfTnP40n6wQWwRL6yB+1EfAncAS
         eHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754222249; x=1754827049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofsNbCZj5tls+/tEVpAghufUCo4CXzEz3jPRdMp1K1I=;
        b=IESQqBpFmPtZJsetRt9fRLtGUrGIqBG8RjpBtB3QND28MGabGsbb/kJgk2ep6z6Qor
         gKLcvbGL1AuNhIBvMet/J/ou3T0GuJ/26rAVapG6U4tvzQeFk7WhnkI/5hp8E6oEPR6u
         Ip+E9PARwwjrnNSx7sJjiH3AUOsUiCsigZY3mh/QGqVWQtbU9hsp1u8XFtdp/0pOF5Er
         WkU0xicN3hRZEx4XK0eZrS7DgJV+3T9CW4osuGzwsgbX1IUIkLmRibvAkN/9xSf/OEDW
         dc+ZJlK382sOebrrLFVl1gPqh1LxEOvcvBJ8vXHFX7q2qFmtnmjsGIgplUoEw5irIn8C
         q2lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWqzCenjSauvRXeic/NgPH/XgSLXAa5KkL8fA8l50oKdsUyBE0Ib7W/RtmRf9IuFtOi8A0CXGmiUB8MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJ58AMq9CPJ6T8i146tqqp3Bgl9AqWnDCYYf3NMVead1zWS6X
	XnPvJQVtDYG5GnMewhoAxNPMSGdC2vk6eLVfInV1HotH1Vj46f7R3EGgSmHAjj/89MQ=
X-Gm-Gg: ASbGncs57c63z0oc1rhQVrR0riO+oVBxnMzMIEqaB9uuTpHFGWNiGLWKCj0/kHgl7dE
	xG27rwKXsWgmyoDClne11rCjgSgo2GHjVwqaWgjZPtjNTWnbIA+d9XGO9WSbktHVhQ1/H2Rih0V
	aQNAkGOntk5wYxbNBcfF6HShQ0nAVasq68g759Uel2tRHUljcFeEvGLeFP2UT2u1hcbVsd3/C/t
	SkBOjcJqU8cwZs5XXiyKXmRjvVOIw3lGnsMk6Sgbv1SGwbH5gdhC8xiF8b20CjxiZ8nbWYEmAJh
	PBWukdmg/orIU/+BeS7hd6Dl0WcFgJqvXFor6e5FuY3trISqgucozSs01G1mrvtb2W8OywgVrX8
	sUonMyJZ5RGcRg3DntIY=
X-Google-Smtp-Source: AGHT+IHHnt7b3H5HXSJ5lDjaL/RoMihKrREQ7Yf6KOVCv8t0IZ8mN+l1/fXtPZqvNFDD/n4IIbBvVg==
X-Received: by 2002:a05:6e02:1485:b0:3e3:cfc2:7e55 with SMTP id e9e14a558f8ab-3e41612776amr121218635ab.7.1754222246829;
        Sun, 03 Aug 2025 04:57:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a8dd608fcsm627351173.85.2025.08.03.04.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 04:57:25 -0700 (PDT)
Message-ID: <c9411b09-f84f-4333-a46d-6c691af93582@kernel.dk>
Date: Sun, 3 Aug 2025 05:57:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-6.17-20250803 v2
To: Yu Kuai <yukuai@kernel.org>, linux-block@vger.kernel.org,
 inux-raid@vger.kernel.org, song@kernel.org
Cc: yukuai3@huawei.com, yangerkun@huawei.com, yi.zhang@huawei.com,
 johnny.chenyi@huawei.com, xni@redhat.com, heming.zhao@suse.com,
 linan122@huawei.com, wangjinchao600@gmail.com
References: <20250803051145.2861-1-yukuai@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250803051145.2861-1-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/25 11:11 PM, Yu Kuai wrote:
> Hi, Jens
> 
> Please consider pulling following changes on your block-6.17 branch,
> this pull request contains:
> 
> - mddev null-ptr-dereference fix, by Erkun
> - md-cluster fail to remove the faulty disk regression fix, by Heming
> - minor cleanup, by Li Nan and Jinchao
> - mdadm lifetime regression fix reported by syzkaller, by Yu Kuai

Pulled, thanks.

-- 
Jens Axboe

