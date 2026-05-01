Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C472622
	for <linux-block@vger.kernel.org>; Fri,  1 May 2026 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633532; cv=none; b=DB/xBxfdZVrkHCapX3VSeWunSPX58n19dyd8RkYb0UX7KUPny0R1XkV4v6eajqhmWTcH3PJC7jx7cDiSW2DH+rlkEPaH8NZNYAt+Sfau1MHHBhQt1QEyk1+J/cePPI+7nykZvo3LTsIcV2o3qGFEoTvlNm8wGBo1UxFuUAdLz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633532; c=relaxed/simple;
	bh=BHZRIHOR2dJRB8sQbuxw3NghmtXoauZuwlTgzg9Sw/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAv+koBiKI3sxDsRPI/vVB36B6phucv03TXEey8CcXltlvUW+3TRcqGXUKcTPYwTaJBKl4Qr3exdoglfvJOBpn5oHexHwGfs+acoZOMrxBTRt76M7pWG2IO8upQh0B96N7bPE7PzzdRIMQF+3mtTcDc79SWSDE1XXIwkAzH3H2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=IjaKLBCo; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="IjaKLBCo"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dcd89701acso1571146a34.1
        for <linux-block@vger.kernel.org>; Fri, 01 May 2026 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777633529; x=1778238329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAnWfJ90cZriOnbwkhe661eQEWx5lvhZ2AX5ym4JcsU=;
        b=IjaKLBCoUML+Z7FneVsonDoZ7Q8akm78XxSs8cjxZowFRXjJlOvp/phisCb026JPH2
         O5nS2eN1pCdP/k3OEgfau/twvKzONmbQ6K6XCQ4Qw9iZmXP1crmrwF7v6FuYLlyGJOtW
         6nZSqtS3wnn3LF1ZrSK3q51cMqZ5UbmlcFGo0ISJT2DAGt4CbdjlE41yRQ3VsI104fQh
         pxhaxALlAlS67lAIyHXtJCuk34xvl9Pcp1jMtsukyLAQYkKEaQKb4CJRMjwIHaJ6/BjY
         upKqaJDhT19nAqKh6s7jz7gk9H9g7c2DL0u2dn307KPcX9D3kA5wpJ2ap9LGRevYXpeF
         r/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633529; x=1778238329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAnWfJ90cZriOnbwkhe661eQEWx5lvhZ2AX5ym4JcsU=;
        b=dVTaY46kS1mYtQg0PGDiFFmsBrxdhxEMK2HKHwix/EexKrYhHcgcw5KgflaZw8oDRm
         MqJaaHjgrFr8jD0Ks0PVW0GgYWJ8sGEzumQbodk8sX8eKBzp656d5sKLEocASSqR+tEA
         VLJbrM1wkp7movkXiPGdBT1RH1taaPDv1X0g2XwiAaP8vpmjwHcwaQtN3PtyenXLqgC9
         9kDb25JlV87vwx64JBpCwS7MQdrq+ayzPV7Mzul+0olsExohEb5i8dArNF+0U2NPXSmg
         +s+SpHOMytRZXtWmXzrRqqBv/Gf3vBxyOwGNrwG1uvy+/NctjtQxu/cr9rx1uCMezl9x
         Hk9A==
X-Gm-Message-State: AOJu0YwSeHftdzdSb9FppcCF7VDW2RTLJBZDpMg4YvHYh+mYVDssfn1r
	BEkSSeRJ4e7twPQCbVe/Ec0jYCC5UlFhsO0hKZvzVDFEVVK17UPerWL0jmvO6ebvxSI=
X-Gm-Gg: AeBDietDL4tXBEzeNkstsPWEaexNyuRxzPqi795Ig7AcmveOKGCH2EBpgRjP9e49G3s
	cx1Iba5AbAzQ72mNLA3cKOba97kn2cCIYJa1GlRU6v3bqsNjzLe5s6paZ9m1LSbOLl+u7TlD7oL
	x9+XHG2/Zk1u1dLtXNoM9k33OUnArosRFBQu9Oy/D57sXnBmPeAM7jm27SytR19NtzSuDa+kBYF
	YJkr007tu7cZoVuA4ficuT08v7GoHq/+8YCQPLlmjQ3IJVNwfmUSZzTE03KxIkAUdF7I2O7WPDz
	tYO3NkvmmVNkZeRjeM8ugVWNyttOq8GBCPLL25lJr3oW88dqlGpVkNNW+iA6tHA3qlGDXBjOlR8
	cSXlPlpCMgH7lTiGZ3vvmSDuvLcXn2V0m7sCzIhdBkWbOQLzftkhl5ZOrzi24hAT7UYn2wvVEhw
	P1d4nED46uQKYf1TS6bJ9ESytRTDdb0ZR9f5k6kBx/m7vYdSrMhEulHkga0c/Obs3g99sPetVdK
	yx6cupCg28uChAO9/cm
X-Received: by 2002:a05:6830:2584:b0:7dc:e45a:ade2 with SMTP id 46e09a7af769-7deba0c919bmr3904300a34.5.1777633528754;
        Fri, 01 May 2026 04:05:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded51a9612sm839214a34.26.2026.05.01.04.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 04:05:27 -0700 (PDT)
Message-ID: <d8945676-c821-4805-9678-059bc88cc3d9@kernel.dk>
Date: Fri, 1 May 2026 05:05:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: reject FETCH from non-userspace context
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Caleb Sander Mateos
 <csander@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
References: <20260501085216.905401-1-tom.leiming@gmail.com>
 <9efbd035-b40e-4155-8382-b42acff75a9e@kernel.dk> <afSCOu40SoLXQpwK@fedora>
 <c97fe4d3-9b48-4793-a008-4fbf7e72f5b0@kernel.dk> <afSGfdcmtKHpvR07@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <afSGfdcmtKHpvR07@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/26 4:54 AM, Ming Lei wrote:
> On Fri, May 01, 2026 at 04:38:22AM -0600, Jens Axboe wrote:
>> On 5/1/26 4:36 AM, Ming Lei wrote:
>>> On Fri, May 01, 2026 at 04:34:11AM -0600, Jens Axboe wrote:
>>>> On 5/1/26 2:52 AM, Ming Lei wrote:
>>>>> __ublk_fetch() sets io->task to current, which is later checked
>>>>> against io_uring_cmd_get_task() in ublk_uring_cmd_cancel_fn().
>>>>> With REQ_F_FORCE_ASYNC, the FETCH uring_cmd can be issued from
>>>>> task work, which can be run from io_uring's fallback workqueue,
>>>>> causing a task mismatch and triggering the WARN in cancel_fn.
>>>>>
>>>>> Reject FETCH if current is not a real userspace task, and it is
>>>>> reasonable for failing it in case of io_uring fallback.
>>>>
>>>> I think this should be caught in ublk_ch_uring_cmd_cb(), which
>>>> should not hit ublk_ch_uring_cmd_local() if tw.cancel is true.
>>>> fallback work should just be terminated, not be issued.
>>>
>>> Yeah, that is definitely better, will take it in V2.
>>
>> Something like this, totally untested. Caveat: probably worth checking
>> the other tw paths in ublk as well!
> 
> tw.cancel can replace the check in ublk_dispatch_req() for ublk_cmd_tw_cb() and
> ublk_cmd_list_tw_cb(), which is one cleanup.
> 
> ublk_batch_tw_cb() doesn't track io task, so it is just fine.

Sounds good to me.

>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 8e5f3738c203..d10460d29e4a 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -3496,8 +3496,10 @@ static void ublk_ch_uring_cmd_cb(struct io_tw_req tw_req, io_tw_token_t tw)
>>  {
>>  	unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
>>  	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
>> -	int ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
>> +	int ret = -ECANCELED;
>>  
>> +	if (!tw.cancel)
>> +		ret = ublk_ch_uring_cmd_local(cmd, issue_flags);
>>  	if (ret != -EIOCBQUEUED)
>>  		io_uring_cmd_done(cmd, ret, issue_flags);
>>  }
> 
> This fix looks good.

Feel free to just run with it or make it part of a fixup series.

-- 
Jens Axboe

