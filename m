Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A02458AA4
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705705897; cv=none; b=uamKIxPlaPbhW5hja1n8e3etRU9Iu4J08fZ6EDffSr4w8u3RdWkDCOuIVl+TH0ypA2QBaldBmBi5NiCCe8i/gwo+LUbwrMrY0C3YjhQCMb2GN0kzO3ktF4MHkWJMBCwiI2hFtqb8mbSofT1wCb3TKrP3IFbZN50tG+Wv2wp2DM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705705897; c=relaxed/simple;
	bh=bWkIiGGZ1S7TdgOjWWHeUaV9f7b50YSPnO9JLi/Hw6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tDsSFk3pVaunr9ZjP0Uqx0Oz6Bc2W5bX6m4sJsZ65sNIJFrA2beVhK9Zg1tm7+4iRDM1jyAxxn7AzkRCcjDF7QlNOUeJvQ/4mBipww8R+pKf8NA51SkTJi8K7nQPch2dn6DpI7XZvhKIQDGEiW9+psSJK/WkBrShNRxlTBP9IYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-595b208a050so663229eaf.0
        for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 15:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705705895; x=1706310695;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaSYCIz/kHh/iXsbRscjG1xKWRdooT/uqBj1xGstq5M=;
        b=oUq0sQW7uY2G+7bSgeNm1bchiCSdDfOWyomF5QgJElxH8k8tlgjYrvXsAmt+tW3W5v
         XLWQDQzCI5a5QbwAC9xZdzDCs7l7+YEQpNwuEe5csh+SlAufp4eMVY6Lp3ZqvcB6qFuD
         Hn4YAuSBR0mbF4rD+f55dlDam6fznx5hKB9o/MQFbo0fK3djCDayJc+EsUX+seiF6kMb
         308xW4jirzd255UvrLjA3B9auhirK8dJRC+21EA7OB89PrfirdlStfL06KfIG94S/s78
         v8vgSo8N0T++xG8vZdU/7wtZikYr7aLRc6NSGqyzXS/0QxrQjwwt9wZ9xgBnVQ5pinvn
         dsTw==
X-Gm-Message-State: AOJu0Yzslk96MTlNoNfPLwwZlSIwvHDg6cAPEyW1aWv7FVtDzXRuRWoN
	3k7ZBmpKaoSExBSXbsafwiKmhUGYeKs/T+M8t7Ho578AcKKjRLbjW4qV3dmH
X-Google-Smtp-Source: AGHT+IGdtv8GVaD1ZL0LHP8pAVp33Q9RT0gmNzzpBEAgfIUGZutHoMr8DFjRee9KwPHYdgt1EUT+wQ==
X-Received: by 2002:a05:6358:281a:b0:170:f1ab:9612 with SMTP id k26-20020a056358281a00b00170f1ab9612mr580925rwb.65.1705705895305;
        Fri, 19 Jan 2024 15:11:35 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:4855:2a4:21e0:417? ([2620:0:1000:8411:4855:2a4:21e0:417])
        by smtp.gmail.com with ESMTPSA id p42-20020a056a000a2a00b006d9b345092dsm5609318pfh.156.2024.01.19.15.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 15:11:34 -0800 (PST)
Message-ID: <9fd4e85d-d0bf-45e6-8028-0248afe11fce@acm.org>
Date: Fri, 19 Jan 2024 15:11:33 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block/mq-deadline: fallback to per-cpu insertion
 buckets under contention
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240118180541.930783-1-axboe@kernel.dk>
 <20240118180541.930783-3-axboe@kernel.dk>
 <0ca63d05-fc5b-4e6a-a828-52eb24305545@acm.org>
 <c9f1b580-2241-4415-aa48-e4b7e1bacdea@kernel.dk>
 <e4892064-cdf2-4cd9-8033-901d8db07cbf@acm.org>
 <248b7070-a7c6-456d-99be-c3fff6f94f5e@kernel.dk>
 <239455a4-7e58-449d-9450-8297473cb441@acm.org>
 <6f27bf5f-0d12-4bac-96ff-5b7824d8bd8b@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6f27bf5f-0d12-4bac-96ff-5b7824d8bd8b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 12:52, Jens Axboe wrote:
> And you had clearly seen the results, which means that rather
> than the passive aggressive question, you could have said [ ... ]

I'm never passive aggressive. If that is how my message was received I 
want to apologize.

Bart.
