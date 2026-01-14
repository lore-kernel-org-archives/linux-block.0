Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD372D738E
	for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768401785; cv=none; b=dSRScR+699wDqtsPO4ZTOzAyhYwm8CwoZq6Z+BUi7sWXZpIXHwD51kPzMczVNgPgUfe5mcC+b9lep0qFpSnA0FjwlzvjKtnoTSOAe+ehlZnop9/6fm47ReKEnXOnD2iZEAvc3Mea/LF/R+Flm93dr4iCvALyddXjX8o6pI2RBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768401785; c=relaxed/simple;
	bh=yq+36RxgiLA3anlZJVBjmHRHnSWV9cYPgwaIXTdjgJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxrlIzXUm0S83zm4dnIT4KhniQ+sdqsg1A96il6on4UIBtR8rGOJERoiPjalfFLQCZPX3cKFzPkaViwvcPBUhWrmRfvEXVUBFhVFKzDCm26Q2mMftSq6vqQmNrQ0t7FsTfvESOyx46T5tLhna/Wnz2a+Ucm4+TigQw5GEgrJ8dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ewkNgRUZ; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ewkNgRUZ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4041c73ab4dso133751fac.2
        for <linux-block@vger.kernel.org>; Wed, 14 Jan 2026 06:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768401782; x=1769006582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpsHOFcvRlIhdag7Ez6clpcIO6xqtLQ/n2fAcm3XRzk=;
        b=ewkNgRUZkE5wxDZyhyH0lPqwglVVSIF7Gw7dPCuEpqdSy+1lIASYWvqVkjDJr9ga9J
         9JEwHbXjlzS0WsiJxWRrDbeZoe/UWEV6j6W2qVLjTxKlraESCDqYnbtq9YWUs2rV2h2Y
         Is8I0ItL6swxYNSY+CgEDurdhFY82vDwWgwgJW4m2Bjs5VYN9PVh8dL8x2tSe48d1T9A
         0wOmO++tQGvS8yg8uinD9JWUrVddPMi2Uyd3yxA7C3ZGXe3Y+hbQfCiohqVVlRBlzpgL
         UnxYKduHvpUC1GHaNPoNtkN2B1uHE4Pe3GiuinOpEhpguatTsnO0ND/sSvWAsAapzkYd
         CmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768401782; x=1769006582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpsHOFcvRlIhdag7Ez6clpcIO6xqtLQ/n2fAcm3XRzk=;
        b=tTFtckvsVKURFWK55wU3REsXZfsFheydpNRQZisBhTaidnYbu/4vNDXHnLG3OL/1ss
         Xb8Rlanx5W4Mo0Kwjdxi9GN3v7kTUpUaEAEPOB3VJyVbs8O7FzdqX2pknwERqMH/t2LF
         ZGf2amBYDrlLjrE398X/+MKXF7nJUtmyxctPeOVskZnJrwKgRMAAi1dq0nL/e3Hf6mwe
         rMX3Z2ndLw1Oq1SLC677otseasEhLccK7gj1ZWe/7XaLCUUq0YPFJUMO9HF8RwJMv/po
         n3NxxZs2JfffwJ+WZGVNz7Do0lWYSXr2yRPX2KNL3pgDct9fPzMT46iw3nRj8Qf2mcb7
         aOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhaNLLXhJVt8Ht11wOFT+LknGR+mEsHqtoKPVL76X3KsD/1g5teuhM9z/g5PKqXACPRAzTgEPiE51iOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEipasazl9mctcdn5Fwi+RnckS6Mv64D4qaR/jIuFLzp8N/UZ
	xecyvmIGdp/gMdF/i7+cqqo141AIRizNw2+s2N0WQjQTzqu6/RGJa5tox4lv0rNbDSY=
X-Gm-Gg: AY/fxX6mPNZ3iODv5qcLshCGj+qE/M3QefqaNMUBI752mlbHO+YAgJ0uARmwsoKWkys
	hnVqmY06Jv8s9NCaYdenTmPv87oyoH8w2n5I6ItPYj6HUu3amivGVWXkG181iLC7dbsXB8cqYow
	jZvaFVHJEJTvY6H/rfemk2YWUKckC85ECWHuuq9DJdy/3ULNIu6azUYTqTiFnXWA7GH98mpOWAW
	gOvHPPUdcXGt4gvPuFEjlV+P4p3PTWpDatcwvGVyyYpGbEfR9fiRJM7vUOkN9Vrb0dDidsT2X7C
	aKShbL28zoCwJE3XtJrKtNHfBKpzDAqgwck5sm83RS47ZGmFusPN8hDVS3XfhcYhKvWsxNUULs9
	Rg5Lkvnzlr2zbEgSeqp/uGzHQ/dwWaw/CNbP5mmyIA2OtERRDolxg/wywAvYwLM1/BdqOVyFZ6A
	eUYLhXvXlt0lQxAqw9lw==
X-Received: by 2002:a05:6870:4403:b0:3f5:b6b7:84e3 with SMTP id 586e51a60fabf-40406f57a9cmr2310839fac.12.1768401781840;
        Wed, 14 Jan 2026 06:43:01 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4e3af4csm16626297fac.7.2026.01.14.06.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 06:43:01 -0800 (PST)
Message-ID: <78ff994b-26e8-4b35-a83f-15bb61865e87@kernel.dk>
Date: Wed, 14 Jan 2026 07:43:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][bisected] kernel BUG at lib/list_debug.c:32!
 triggered by blktests nvme/049
To: Ming Lei <ming.lei@redhat.com>, Yi Zhang <yi.zhang@redhat.com>
Cc: fengnanchang@gmail.com, linux-block <linux-block@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs_SLPj9v9w5MgfzHKy+983enPx3ZQY2kMuMJ1202DBefw@mail.gmail.com>
 <0e1446e1-f2a7-41f4-8b3c-bce225f49aa6@kernel.dk>
 <CAHj4cs-uHD_cm_5MHAS2Nyd1Dt6=sqNPrD4yWZrbykM+WvyxbQ@mail.gmail.com>
 <CAHj4cs_d81+Tbe+kh=9sz-ort4MZnC1F5gzPLGt2jrDJxA2P_g@mail.gmail.com>
 <aWekEgznso6zkgdI@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aWekEgznso6zkgdI@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/14/26 7:11 AM, Ming Lei wrote:
> On Wed, Jan 14, 2026 at 01:58:03PM +0800, Yi Zhang wrote:
>> On Thu, Jan 8, 2026 at 2:39 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>>>
>>> On Thu, Jan 8, 2026 at 12:48 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 1/7/26 9:39 AM, Yi Zhang wrote:
>>>>> Hi
>>>>> The following issue[2] was triggered by blktests nvme/059 and it's
>>>>
>>>> nvme/049 presumably?
>>>>
>>> Yes.
>>>
>>>>> 100% reproduced with commit[1]. Please help check it and let me know
>>>>> if you need any info/test for it.
>>>>> Seems it's one regression, I will try to test with the latest
>>>>> linux-block/for-next and also bisect it tomorrow.
>>>>
>>>> Doesn't reproduce for me on the current tree, but nothing since:
>>>>
>>>>> commit 5ee81d4ae52ec4e9206efb4c1b06e269407aba11
>>>>> Merge: 29cefd61e0c6 fcf463b92a08
>>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>>> Date:   Tue Jan 6 05:48:07 2026 -0700
>>>>>
>>>>>     Merge branch 'for-7.0/blk-pvec' into for-next
>>>>
>>>> should have impacted that. So please do bisect.
>>>
>>> Hi Jens
>>> The issue seems was introduced from below commit.
>>> and the issue cannot be reproduced after reverting this commit.
>>
>> The issue still can be reproduced on the latest linux-block/for-next
> 
> Hi Yi,
> 
> Can you try the following patch?
> 
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index a9c097dacad6..7b0e62b8322b 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -425,14 +425,23 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>  	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
>  
>  	/*
> -	 * IOPOLL could potentially complete this request directly, but
> -	 * if multiple rings are polling on the same queue, then it's possible
> -	 * for one ring to find completions for another ring. Punting the
> -	 * completion via task_work will always direct it to the right
> -	 * location, rather than potentially complete requests for ringA
> -	 * under iopoll invocations from ringB.
> +	 * For IOPOLL, complete the request inline. The request's io_kiocb
> +	 * uses a union for io_task_work and iopoll_node, so scheduling
> +	 * task_work would corrupt the iopoll_list while the request is
> +	 * still on it. io_uring_cmd_done() handles IOPOLL by setting
> +	 * iopoll_completed rather than scheduling task_work.
> +	 *
> +	 * For non-IOPOLL, complete via task_work to ensure we run in the
> +	 * submitter's context and handling multiple rings is safe.
>  	 */
> -	io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
> +	if (blk_rq_is_poll(req)) {
> +		if (pdu->bio)
> +			blk_rq_unmap_user(pdu->bio);
> +		io_uring_cmd_done32(ioucmd, pdu->status, pdu->result, 0);
> +	} else {
> +		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
> +	}
> +
>  	return RQ_END_IO_FREE;
>  }
>  

Ah yes that should fix it, the task_work addition will conflict with
the list addition. Don't think it's safe though, which is why I made
them all use task_work previously. Let me fix it in the IOPOLL patch
instead.

-- 
Jens Axboe

