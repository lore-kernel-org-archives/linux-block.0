Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E183644C6
	for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235632; cv=none; b=ei7DbI4GoBsUp6bSubk0Uikhfe7IUBmI9Py1Q2SeSVMwXu4QXmeVwVhmbS9Kw8n+2Rg+rR3KStTQ7gPWeZHEM6UfyXFlZrMRspjWE3vMMJ+q2T9ETLSrwdIOgf6xsbAvqAHrwXNCmCZSPEQBuowgQ40aJ8CGF1TOg82jwDWXSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235632; c=relaxed/simple;
	bh=L55BpD/zju0cKQTZyeMSV8mqlYTdNoI5Y4bLrhsQAx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDRTg993PtMhHG+X5Phj07AJlvdmalLQ+nG/do9/HHmaLVIPRPrLb5U2MCTZgANrlf+v7b/PUmQhJUcMgXhd3IxagqucjAldxtUZ8aXQqs83h63RNlWpexLy4xrN8AGVOcs5V+nzl0GAKUuQlwsCS/y+FT1HZF/7roZtGT+ajoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x2h2irjI; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x2h2irjI"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-459993ff4fcso2440841b6e.1
        for <linux-block@vger.kernel.org>; Mon, 12 Jan 2026 08:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768235629; x=1768840429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKk4AZb6xaelRv+KRVOnPIpGWAmlcOUw5Jn5AR9gvV0=;
        b=x2h2irjInkx3xt1k8o6Is9d5FC4NqdbsPHWVT+lu534dmYYySCiQFo5WtNu+nmK5vL
         YLOZwpeHOS1XfhhbJJujReyqtOF5W9B4tR2qbZK9AD6pBpprPLEy1HH4fGEq1TKXdfzQ
         SnrRXhXV4uVYXaYNDy3xvuijzfM1jlIE3w0n0UAV8dzapX3rYTHssT2j2WlVmf+P0svi
         EK+ISMOl3UUjI/C9QC3RIaDdC63seS2wcK7r/LpKZEUsQ/cDbODXxjpoT1pZJpUNM7mG
         8UbSgELjV8cMqdpGRhnp+A3rw98Sd3myn+ga93v4gBQ9zlTdEn5d3kSNeJ8cUp1YNO7Q
         e2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235629; x=1768840429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKk4AZb6xaelRv+KRVOnPIpGWAmlcOUw5Jn5AR9gvV0=;
        b=JCv+4fmKyrz26iPgv9jW528GLFtjwKQyzxt8+OnU2inKrDJR34Khd8uPt4IYv/D2Ik
         wE9CzCl0fQZhI0PrvyAkZLW818Fpn9PtS/LtCAetjD7ZJ4WBM/rf8LvN6lT8lK+23Pdb
         M770pjiuP5kkeXH0bDa6ClA8ORRSk5aI7ViTovosBTtAC4MCUDzrotZ8yncGW/fFDcCW
         wSvIlV/A0znTYG/cyp/73c23L32hYC/kiyuBByA7MFcGXo4YS3KVrAmpu2IYW5ZJf4jV
         +i3vt3QelxNNpPwUWRyxQZFjqh2IYhr8S780BXXe9DAAtMhr1XgWXsPLbopbp3ePw7+G
         0lRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX76dhVfGtCGanEKZGA74s9u2gOFPGqJ80NIKbLV8KfXd9RQt+hONoNoALd93EsEirXmhJMvB8XBJXDZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eCgiXOXK8AMqgtZQN+Mzrpv6tEp1qXOCW0v/0EPrSe7vrx7x
	AhB6yPIlle6HLNg7zmwP4VdVpkpxF7MnG8wz8CbnjtaH1EPhLZgy10SNgKDl5pkM/Bo=
X-Gm-Gg: AY/fxX4PgETdXTX4UjNMXX+Gi7vpImd4Paekt63VJlw1IqslWwV2HiCXZv/++tK662o
	9olG8EIcXIwBCVzn5JEgzZfTA04sous/wWVRpEfvGZ6v+aHA2m8U5IewAIqq/UxRihzN6A2u3uW
	39feLJMbB+bEaF90yCknnQeAmw9LoIC5sx7YPsycLu87A5ot6ofSZbStviIExRbBXirl6ih6jTZ
	bWX/z3P9p0CwnFZRrAOfBpxhtJ3NdziFE6n6zJoTo7+HJDeLCLQdBzX73xLqBanbRdOy3Uefm1n
	bkj4CE7AE6SjhZLkCPSnwfTjEhYP7XislyMwF+JYvW/PDl2OVNWL1nQImpH5xuOF7NvzwMr4tqB
	ivOfZyRl81XDvpOdHg1/g/j4R3f9BE9ZUeuiGxIx3NCOdgAfLJsA1ddpr4EPMhQadhDis9OGnwM
	so89+Ac/g0FmYLLUzcsWo=
X-Google-Smtp-Source: AGHT+IE2hUsIqRUiyfrJTvCoyt8gwlZ1Ggk6EZz3zjvoTDqFp00pIGXysZkqhRi7RoTyKT+3BzuClw==
X-Received: by 2002:a05:6808:19a0:b0:43f:5c61:448c with SMTP id 5614622812f47-45a6bebc4cdmr11883999b6e.39.1768235628720;
        Mon, 12 Jan 2026 08:33:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2e8fb1sm7810629b6e.21.2026.01.12.08.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 08:33:47 -0800 (PST)
Message-ID: <5447c8c4-da12-4497-8d74-4942101ba412@kernel.dk>
Date: Mon, 12 Jan 2026 09:33:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] ublk: introduce UBLK_CMD_TRY_STOP_DEV
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Yoav Cohen <yoav@nvidia.com>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, alex@zazolabs.com, jholzman@nvidia.com,
 omril@nvidia.com, Yoav Cohen <yoav@example.com>
References: <20260112133648.51722-1-yoav@nvidia.com>
 <b784bf25-78aa-42cf-bf3b-0687d9138139@kernel.dk>
 <CADUfDZrzAdjf3PT0M7Gh0jQshKKRdAmb8Ce39dNUfj378vvDTQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZrzAdjf3PT0M7Gh0jQshKKRdAmb8Ce39dNUfj378vvDTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/26 9:28 AM, Caleb Sander Mateos wrote:
> On Mon, Jan 12, 2026 at 8:22?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Please rebase this on the current for-7.0/block tree. It doesn't
>> apply at all, and hunks like:
>>
>> @@ -311,6 +312,12 @@
>>   */
>>  #define UBLK_F_BUF_REG_OFF_DAEMON (1ULL << 14)
>>
>> +/*
>> + * The device supports the UBLK_CMD_TRY_STOP_DEV command, which
>> + * allows stopping the device only if there are no openers.
>> + */
>> +#define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
>> +
>>  /* device state */
>>  #define UBLK_S_DEV_DEAD        0
>>  #define UBLK_S_DEV_LIVE        1
>>
>> is a clear sign that your way off base at this point. Why else would
>> STOP_DEV be 1 << 17, with the previous one at 1 << 14?
> 
> This is due to being developed in parallel with other ublk patch sets
> which are using feature flags 15 (UBLK_F_BATCH_IO) and 16
> (UBLK_F_INTEGRITY). UBLK_F_BATCH_IO is still in development and
> UBLK_F_INTEGRITY was just applied. So I don't think it's fair to blame
> Yoav for not having rebased on commits that didn't exist yet when this
> version of the patch series was sent out :) Should be a trivial
> rebase, though, since the value of 17 was already chosen to avoid
> conflicting with the other patch sets.

At the time v6 was posted, it did not apply to the current branches. So
regardless of how it was developed, that's not a very useful approach as
it means I have to hand apply it. Which isn't too difficult for patches
1-2. But now we have the integrity bits in, which means the selftest
bits take more work. At that point I just threw my hands up.

Hence please repost against the current tree.

-- 
Jens Axboe
