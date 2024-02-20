Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6676400;
	Tue, 20 Feb 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708449146; cv=none; b=MtX9krSkSXjTMxcJGDh7TRkyUhhrZr2G0Q41qjbINb5zTA5ze3/q4hJDzv68cOAdVodzjDJB4U08+6kyRfzN/kelk9gplzbVyQ3PsUEjZJG+Ckp/WrH1oLHmwR2ZmnD3idvh/48LfVJ2AsmswpKY/VWJA8vcUjopzJEFPFgD2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708449146; c=relaxed/simple;
	bh=JbisBTtw0UM/EIrMQXtq0glLWVtyA5VTN8/MgDFpU6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gnvaIE6qyN1/qyZuYSJEuUa58K9MwYDHx8e7sfGlYKfvSsqfE08UnyxmUnk8Dl7OEtwjb5dXzJP3F30IqrHYu1T7HTFnzPqZ3+aP9vYlBCPZIkOwyMzlorrNva0/I31EzOezatcQxK/n1UlsJU0HlvX/Arn3wQKl+xe6yJv61SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce2aada130so5030989a12.1;
        Tue, 20 Feb 2024 09:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708449143; x=1709053943;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0+1H1CS5imkuXW4qIVhFp0ILJQ8xT3FVRwc1X+D/jY=;
        b=YbVoUsU9Vs9xVd6C544pXztX/6/7YYHxHtGYlDngTzsHSLg4pxtcvb0Y6WSbd+DyFD
         8wvNnEX1RPJVneEWzmKGrzVZIs94cUK/ycearj2UyjtiVrfYJyKIspEHN/0GYIEs8IEX
         m3ra3yT41imZrqArUNwOWr0Cn/EuTqaqwkD1KvPDZzoK7nxkNvqLa8j1DGmRbZvAqApA
         PC3swNl4sCF3hVQEcw0yfm39gVLEsT4igaB0Yvdkr/tegXdvqy1tjR9cqu6rDzA1jQnE
         LN7vmws8JslY2jCz1yMMrS4zNbwlWB6HEDVCTyRLstkCCA+siutbmeE5QvEx97fkplIo
         o8/g==
X-Forwarded-Encrypted: i=1; AJvYcCXrcx2FnNRYLJPaNNl4qTylVDnihepoC1p2xxA0xKCHHk+IiCF/S1NCeTlsYIsxKwvFR9yYW2nygSJMXgPl9ijJK207gVtyA75jPg+axDiuR1/1I7hrs4OWdMK/fJ8quoT3ZJit7/YXrPo=
X-Gm-Message-State: AOJu0YxokpuJflUqnkyE99uLJjVttaHWIJdgge80CE8Ns5n6UTMO/cnI
	+yvBSmAS3O7KSKny3kX3XkSuy22cZNkvk2mqfv69XJb9y+Mg05Be
X-Google-Smtp-Source: AGHT+IEjQTqB84zkrDXFP326djvX9CVyCrsGkBTmn1KJhLzVOpUMCoMTTwc6tbGSUFG8GDmkGsY6MQ==
X-Received: by 2002:a05:6a20:c890:b0:19b:a07a:344d with SMTP id hb16-20020a056a20c89000b0019ba07a344dmr15459887pzb.7.1708449142396;
        Tue, 20 Feb 2024 09:12:22 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:455a:b76d:46a7:7189? ([2620:0:1000:8411:455a:b76d:46a7:7189])
        by smtp.gmail.com with ESMTPSA id u9-20020a62ed09000000b006e469a6ca72sm3690126pfh.15.2024.02.20.09.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 09:12:21 -0800 (PST)
Message-ID: <cd332ec7-2e29-419a-87a4-e32852ad96e7@acm.org>
Date: Tue, 20 Feb 2024 09:12:20 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] block: adjust CFS request expire time
Content-Language: en-US
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
References: <20240220114536.513494-1-zhaoyang.huang@unisoc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240220114536.513494-1-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Where is patch 1/2 of this series? I don't see it in my mailbox.

On 2/20/24 03:45, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> According to current policy, CFS's may suffer involuntary IO-latency by

Did you perhaps mean "cause" instead of "suffer"?

> being preempted by RT/DL tasks or IRQ.

For which workloads? Sequential I/O or random I/O? If it is for random I/O,
please take a look at patch "scsi: ufs: core: Add CPU latency QoS support
for UFS driver"
(https://lore.kernel.org/all/20231219123706.6463-1-quic_mnaresh@quicinc.com/)
and let us know whether or not the Power Management Quality of Service (PM QoS)
framework is perhaps a better solution.

Thanks,

Bart.
