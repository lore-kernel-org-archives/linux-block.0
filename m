Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5044C27FD76
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780350614; cv=none; b=W/I9o5H7gyrGGmi1EYEr6z8AeXDX2+zg1x6X6Q1kzAiVMlC6brR8Hz+qphlGk5HTejkqOsOAnZHubpZrJfrQY9xbe7Sy1o9LYqnnUOyEDbdpvW+LmsmbzRAr3aa56BzX4BT0jOWKd9+VE2TPb55O/SB5qzyBnY2Hjz4VcpbDZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780350614; c=relaxed/simple;
	bh=QGQCu/eNaZlnrKLQEL2ExoyI2dX/QL3H3NIMaVkJdRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqizo8mmGKhlOLM0OksW4+9PvIxVzTwNUw7afTU7l85ftIglQwuEmMW8V6c8CfJx+M7eR3gmcdHsn6dgCeBWa4QHQjgGWFAo0r7oqbkxkerht+ujgmX0uYOHQ42ewGsuyiov88Kwa0Hx2BrxhoXXY8uSlBD1Ja7huCbLKW8cZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQI1vs9F; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQI1vs9F"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-307263ad0cbso1550583eec.0
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2026 14:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780350611; x=1780955411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gI4VySRAqT6oxO3oOc5l+Z3YU9XMtBGUdfSYPJs3Nu8=;
        b=ZQI1vs9Fik4Nj78Xpyg+/0pWyaZhNTgksaqP6qtI4lvJMfxj26exw/Re4ITv5mn9Ty
         afsI4pTAL4eCVD6/nJJ9cVBjsJHs2Iaw33QLSGRttgj3TRUTRjL1lSmUtRVBvTmK4m6S
         OWXkVWWr1WnnZoVJ/yrY+U+1E3kA5EGGggQDWQLA6vHQA5SefEJwj/cN433fm2Au/R2c
         eB+szdl/5i8MEtOhLIR7sON0T2ubw18HJR6j952KOcUl8YNqmRWXNwhFDDOY0HYB0z6+
         1oj3IwYjNROQENqUWGY6JKfLM6VvOeTvTbAv8zVQukgg8S3vGVl8Goq1s0eou6DcpMSd
         CQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780350611; x=1780955411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gI4VySRAqT6oxO3oOc5l+Z3YU9XMtBGUdfSYPJs3Nu8=;
        b=CN28w2efATK7I50wvE6kP5yhrM1BiVe+mRo2esPmSKG+4Al72nF4PrKRELIvj/MxIN
         bxDKtGfmSCXZxH0ZJelBKPWr+g2I6FrGjhSwGXL9CO0ishN1nUGTIugTOhQiUb3NcPSX
         jdY8ddb44rTctZ7FZi6S06Q4xEC6ZcVNWGO4lJSoDqZGC5bcGwjygPim26OIfNLOEvNt
         k++wffP5RFwqgfPmWwYFlt07LpiOhuW1wm848FqN01dBkpGYTjtbxfg3qmdUp+R0AbRR
         +4hqHRuYrr/CgiOxEK1W9RGFfrsEVSEI4O4Sq34HtBMP+MvS/LVnjMnvoQYKFIsdv0K9
         4LeA==
X-Forwarded-Encrypted: i=1; AFNElJ/15njJkx0DUC9Yse5ECXtwYuPGSEIe+SEKRoFHB2o0eFu4bjbYFphsCfIakMnWmhMvC4HJfhR6loH6eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxswUzvE/g/g+rYeS9c+T2YLveELqu6HCMKSDBWF9TJyU2/WFcl
	N5G5y7ns4xktUpko4QaHarLAzTp1QtfMrCAoQY1ix3Pl2rD0GOkZpssylNkH+C5y
X-Gm-Gg: Acq92OECds6iBxbzfeF9jSyjoQ6tCA/paRQwlyQQ1PHYdnzOPd00B/uOGi58Azp9bEL
	r3fQIuCfrSioS0TySprBIXgWb+VTjZvjszpGjbainQaPxYVzjpckPDIazC2okpI9x3xHfHvmK65
	VcaBPXBzxv7wjzWnoUWg23kqesSLEkotxyPUOn1BeUDSqOPu5OYGEkYiMcUxaqGNGiUXl7raDLq
	SDZ4W1wyO55J4a19DbVEwZFZ+3NmZ6XYHvuRveMWpPlAlZFxMCWV20a+nWLs+C/QBI7K7mi/1uA
	Ndf9z5PP11rSK02gvw+01ombvQjiYSJBQlo6P1+yAg9RvWdG8wDWRDATJFYr12HbHeG+VYxhoaj
	MDoC5zuAaIKjaYKL4t76jxnJvyCmo0wKFsCKntT1n8lryZNsvPulLJG2wOJ2lO9/zZGFeaYLqJ+
	FzZJMc2kyO6/545gwbhWqVaR6370HEQ5sTSYoQbaPuQTG+qzUtmbILc4kVYAlpJRB8+INKgg0ND
	DOtcNejWPvuOPKtufUwIUnL4fQZmhYcXHQG1+EGO+PnnGMRAIwji57FIfFbh/7KmJGi3widkn2M
	CNvC+NkNOhmPgeKG2LyKKBB5I72jYalEWA==
X-Received: by 2002:a05:7300:3b07:b0:304:e6fb:f2f0 with SMTP id 5a478bee46e88-304fa6a904dmr6494564eec.34.1780350611354;
        Mon, 01 Jun 2026 14:50:11 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:b83:4858:813e:dbe7? ([2a00:79e0:2e7c:8:b83:4858:813e:dbe7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d26d1sm10147252eec.30.2026.06.01.14.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 14:50:10 -0700 (PDT)
Message-ID: <8709b8e7-8328-47e8-950f-e5726bd70dbc@gmail.com>
Date: Mon, 1 Jun 2026 14:50:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-iocost: use irq-safe locking in cgroup handlers
To: Yu Kuai <yukuai@fygo.io>, tj@kernel.org, josef@toxicpanda.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260601061312.896801-1-yukuai@fygo.io>
Content-Language: en-US
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20260601061312.896801-1-yukuai@fygo.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/26 11:13 PM, Yu Kuai wrote:
> @@ -3378,14 +3378,14 @@ static u64 ioc_cost_model_prfill(struct seq_file *sf,
>   	if (!dname)
>   		return 0;
>   
> -	spin_lock(&ioc->lock);
> +	spin_lock_irq(&ioc->lock);
>   	seq_printf(sf, "%s ctrl=%s model=linear "
>   		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
>   		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
>   		   dname, ioc->user_cost_model ? "user" : "auto",
>   		   u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
>   		   u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
> -	spin_unlock(&ioc->lock);
> +	spin_unlock_irq(&ioc->lock);
>   	return 0;
>   }

This change is wrong. ioc_cost_model_prfill() only has one caller,
namely blkcg_print_blkgs(). blkcg_print_blkgs() calls the above function
with interrupts disabled. The spin_unlock_irq(&ioc->lock) at the end of
the above function enables interrupts while q->queue_lock is held. If an
interrupt happens on the same CPU core before q->queue_lock is unlocked,
and that interrupt tries to lock q->queue_lock, a deadlock will occur.

Bart.
