Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192A7F7F6
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035104; cv=none; b=GlBcs+Af6MZZHjPJjmNxq/Q6ROwwsUp0D9+BIlKt6izhThuAZ4CgYBpXBsDxXHrgEf4DvfUbFTqa2iAGr3jKiLCoClrO2zrmL5kY2S9AjseDGqRbhdrWAtkpkog3ELKMBJkjStvqR5vGlEDz/6y9+0NH6F1ZE+Z/XpOpmeqLtyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035104; c=relaxed/simple;
	bh=pEEJVvDq+S94XRKk3XINy3RA/vP0RXcEoYxdPyuCWyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BvPkITqTez2TUp6lHAJq57YzYleApAHPLdeljNOeHgfkaS5nxqNoednQRiVyX+vyptsoY1Colv4kn36x3LrYzHRyK0yoEMI+61RywFcKVd5mgftGGIYH3HHqquJV7pr11h7EQSMtqsdjO/bg+TgUiXWPOlZ0ko/9ajxgNeqMiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d70b0e521eso33813545ad.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 10:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035103; x=1706639903;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEEJVvDq+S94XRKk3XINy3RA/vP0RXcEoYxdPyuCWyk=;
        b=U2HEE3Mxvmtvym2rCLbvOvuMYHDP57slRPZ8jW2OrA1QscjRRNVf4jhw4vo5YlzNxr
         91494g7sTINWlP9PjzmjrCdXtOxaEGNsNFpmW9921xG4CsSa3aq1ofKgWHo4QEUe01Xm
         fjpy7ARSKvi1RRWXHLuOPhNlYzl0j0SWhhOjYWuRQCi64AV+/F5rYsOLKA6JpfQB04fy
         G3Cgu9pkSQQFxn1Db8ez2RInUHReaBX7JJeWOEkt/sSin3wQ0Xo+J6qQkC0dyHd05dW5
         sy97ABZuxT5HqBAe6NmnvkPRFIFvjUP2kasWkKMauCth/TjclPBgyCIYpb2K/gV2MexK
         EGAg==
X-Gm-Message-State: AOJu0Yybxw8blh4pRs37jEi+rmNOUFklEBRlMeuooHXHdYTIUafVb7mc
	lwu9z6p60Snz5b9Pt290+JWG3BtQHib9i41ALRtzhfYNKi29+jrP86aH0Qh/
X-Google-Smtp-Source: AGHT+IH+A2tD1R+73OrSqODpjzc2Yg1syuE2cZO6ersMiq6iPoEPkImWu5Zr/WAq+xwknk78tg3ECQ==
X-Received: by 2002:a17:902:c409:b0:1d4:c313:8081 with SMTP id k9-20020a170902c40900b001d4c3138081mr8567896plk.129.1706035102764;
        Tue, 23 Jan 2024 10:38:22 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902d11200b001d766749e9bsm2090141plw.156.2024.01.23.10.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:38:22 -0800 (PST)
Message-ID: <2f55c3b6-a70b-40f7-a19d-42c597eadc6e@acm.org>
Date: Tue, 23 Jan 2024 10:38:21 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] block/bfq: pass in queue directly to
 bfq_insert_request()
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-6-axboe@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240123174021.1967461-6-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 09:34, Jens Axboe wrote:
> The hardware queue isn't relevant, bfq only operates on the queue
> itself. Pass in the queue directly rather than the hardware queue, as
> that more clearly explains what is being operated on.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


