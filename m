Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E981DAC9C
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087733; cv=none; b=ryFUYiQeSHuvdepnp9on8muJPIengTQXPmcYS1aIfaBcTMH6+92IMM1sX7tj9HZ+2HR52dJWeFUSiL8TGP74Y56GMJBNoocz1swb11IDW0HzhXXCAddTDweMNYhQndJb0cmhH1+X0GYNh8QbzISfpdKrz6X+p1b1xAOfF7PNLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087733; c=relaxed/simple;
	bh=LJ6kyCAdTOGA8kL19ZQGbzu4tfizaDgX0Xs9pQozxls=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WL59srw0TE4UOsP9bHvF4KbNNqn8bUC7a4c6ZNXA/EPGoiUGr+XCocO7fjcRYg+GVrW/sJnkTxMRNkl4NP3nDWkGJCeIZcwDrjeC6faVEbfnJnl8qRsruwD/Kj7a+mLAxGrh/YJXsEDli0H7oGDBOEcd+Qqb2Jg9mMObfZTUzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ULOSi4AX; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ULOSi4AX"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83a98e107feso37941139f.3
        for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729087730; x=1729692530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xgrle76UhYTPJ8zHhkNXFtNRb530+tWPePdj4IUhfk=;
        b=ULOSi4AXLKIBhvOB1rNXovGYPFYcH6YICYVBitD0KvAACHANCvdIwowwWglLRRX3Ui
         EVe8dpthokR1C8ePxJXZ9t/adxyiXBxF+pRyS+vCy/KtC1b51Ki90BIpR5sPnp1GrUGZ
         lxU+OcgfMaeB8Nfkl82nPsoXVDIAJY1csNrXvB4g1ruXYIG9k1ZtjkECYrNr3FGs5aAD
         HHYIYGlnVZTB0CKoS6DihGY5G9kGsN1Oz4CB+G/xJb6P9/yJnhNpbFzBSyoG5NgXsiO1
         JF46d10ftu6lpjnLwiYiTSPkIbR95I6kyUSkuljetDVs63A+ezE9AM9VV0GMTX8X9z3P
         NGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729087730; x=1729692530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xgrle76UhYTPJ8zHhkNXFtNRb530+tWPePdj4IUhfk=;
        b=cZ1fLXnDVPB23n93JrfhBb77fk1pA/8oZnBnVSxCJkVg1WQWYCfa+1FBxG5L5RNhI1
         72eE3+1FrMOUBUTQ+5b50Jf28n3jYwGNXsm+SIhKzIDEq0fAv4MozWt9wzwRHoLnWxrF
         gxmWxSspmkZUtLh3B8OyaMStOtE0/+gYC8Lvr+dlAenlRZS5rY7jHcitOiLlMWVpEIJ/
         zO6Bga4KWdCwR8ozgiKeP9W5hx/PZM8vd3a80J/DcT1qJV+qRnjc9BvTqMod8I/3L4bL
         lzhXaYLvQSvGJWcJPUOtf8CNPBCOuFbsSqDd1hnXaF8y4t76qDbidqRabk1vcjjCxnyZ
         rPbA==
X-Forwarded-Encrypted: i=1; AJvYcCWmC+LbHTOrYJUb+KARiMK9TOPhHZGs8Y+c3g1263v6E9WeL604feg2tUwdcxGxLRuTeJ+a1rfaDxD8VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1ryzUS/VyGFb3bLhTiI+x4/x7Mssqf7Z6Z4Q+DksBk4zuJY9
	7WTfepo81nTPu1U60UMMTXKGA7qahPS4QoywOPrtLd/bXjrHIO5Of2bmKuD55ISDphn3QpDfMuR
	V
X-Google-Smtp-Source: AGHT+IH0DlWCca0XU4Pz2vOuAY4KeSanD7TstsE1E9QSXBMm1pGxR7tPPtCNqwazfjy6IBt9VlSHZw==
X-Received: by 2002:a05:6602:3fc1:b0:83a:a4ff:49d7 with SMTP id ca18e2360f4ac-83aa4ff4abemr162961239f.9.1729087729997;
        Wed, 16 Oct 2024 07:08:49 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9b11a2sm793103173.39.2024.10.16.07.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 07:08:49 -0700 (PDT)
Message-ID: <4cc684af-cf7a-46d6-8880-ad645862df16@kernel.dk>
Date: Wed, 16 Oct 2024 08:08:49 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: don't allow user copy for unprivileged device
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20241016134847.2911721-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241016134847.2911721-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 7:48 AM, Ming Lei wrote:
> UBLK_F_USER_COPY requires userspace to call write() on ublk char
> device for filling request buffer, and unprivileged device can't
> be trusted.
> 
> So don't allow user copy for unprivileged device.
> 
> Fixes: 1172d5b8beca ("ublk: support user copy")

I marked this one for stable as well.

-- 
Jens Axboe

