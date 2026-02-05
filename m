Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9C52836B0
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298946; cv=none; b=r0UwguSLA9m6gk43Zf0tvgc97sI+BIjd8jDF4eWAUR8sPfHYCWM8DGSjCMK1emtPv/p47T33wWNnZB0VT6qNbHMYSUI2gAApMkq5PyPvyM1+Z3f0R/m2BPoPtdMUqkaQu/BrQblj9y+zV9Kaj97M6ZbJCXndNn3WPl4QhMgKYHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298946; c=relaxed/simple;
	bh=xIx81HrAdepNOt09t94202ep8WkrBqZ8CIGLzoa0bq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDEiSOXuia1X0HGkdcArhIetz0Cv7goFlJBtdYWzst6oVW6MDh52aX3WWw2Haq/SxLbHgoJ2cQY7lqDbehsRSbPjmTQto6XAMeBblGXpe50PZzJ2p600ZejY6E5nemJw4TMaMG5Kad2CLe0O4gCjQcFkuhtx9ls/n20au6uRnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ILwBHZvo; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ILwBHZvo"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-408199852c5so917920fac.0
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 05:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770298944; x=1770903744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZeINKNQdVEKrTfLswXkJRH1jAKC3+hNj3Wq8FHgwG8=;
        b=ILwBHZvoer7VNIIlB1ubVJOnFAUPRBR6+XvQ/H6fZ4wJqqJC0Bv7u2UmrhYLJYqXsO
         1VbLLYkPD74kWmXxkQdNOr+rpDteEctLX21j+H7Hy1smBZP0IAJFWOkp7j2Wn5VsA+k5
         chR+harbe7X5yuB1WIb8N9bWPwMYldWbYRtF+BK0uMhwXj6C7lx4WHv4ni++rpENlJwH
         V3LASsoqFiBi/yZrUxaKoTEKOy3gi1MChcstSVeQPkFB+cCa7sPUi2SxSSyQQ1yFj4Mo
         WuArzWF/2la4oDnt4iKY5UVmg5mO7o6kR/6c3ZoQhO7zYP/WkvHlKw19TN+hfdDpZsYh
         gAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770298944; x=1770903744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZeINKNQdVEKrTfLswXkJRH1jAKC3+hNj3Wq8FHgwG8=;
        b=LdB2hgBS9zhIMcJ8PKAAdVraYEcBZL9BfMgLtPXmgzTSzYtCgtBL0UQy2PFyZPrJ8X
         7+8RTajbi9vCDB0ruWZBbUYrDlDkkiN3oMlMyoLxfkthi8o1FvaJrJ+lxNYyK6Go86ZG
         eTQPY9sU6WZsR3YGvqgF4OvzmXqaaAxTNzbtoifmHP6Q0ixSurzLwyKK6Qry9qC4sZ8N
         PcBykNSZPIwbWAd3/GnwPADc828b2WtWOP4ZexjJHvUJAkvCaxZr7fjq26FYZgjwiQ5v
         PSb4bhquFRckhlxKaFpHqk9YJZXiXnS842hsCu46EZ8qodsMjufpqfeQLZpTeihfr8/A
         yodg==
X-Gm-Message-State: AOJu0YzG7MNJmilqw6ZnGi8CrecBUzJQMsJ2R/IUTppH0bqpI6SQ1D2X
	fHT7H4o29d71xXFLcENvWxrR6xPrCA/ePTivTCtgwZnUhCEJKoHHF+5sTIJsNTsG7Lw=
X-Gm-Gg: AZuq6aKna2sglOI2ODuXcyQ7qFSvOTV4jvACy+95d5N0VuSRYBE1sTkvlDfZopEsaAm
	lKPMq4J1yaBBElyxsUVL/2A4JJ8YivvHRFzU6KcOtMjN9/moQmY1posL3EZB5XHwzjMIyDOWnsE
	Q8XAbazjmv/KAEB3auU7ix3EEzc9yI/uipvp9ajZaPbmV5LDv6g6Dg62iSsNh6HCPrxEDa/Aizt
	GqTunyGoPcef6k52cgDXZbhOxIUleudgZWgPF+WighDNcRZt+uaeyBU+3CGYFH/CU9KEmWIPEmo
	qRGNGZVMU+lbnq+tSrglVjgnaOXDv3cxG8MlhxESN/9Ot/I7MAVPVoTFxUIisz6ZuQOSKigDScr
	T6U7FLGGFI1wFh5lq6IYXfEs9uG/xJIe5SilgaqUQG5xlDBcj80E3Y8J5c522VqAZoflXQVXesG
	iarT8cT8V/MOMtA670Cy3+ajtZpePtMVCNncGvu+vhlgkPKHQF4JihaaopVDObTp01D4eFyg==
X-Received: by 2002:a05:6871:4b0e:b0:3e8:8e56:6717 with SMTP id 586e51a60fabf-40a540fb025mr3618579fac.55.1770298944180;
        Thu, 05 Feb 2026 05:42:24 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a541e222dsm3942638fac.8.2026.02.05.05.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 05:42:23 -0800 (PST)
Message-ID: <f8e86beb-5025-4d33-9ee4-0b9e8155c345@kernel.dk>
Date: Thu, 5 Feb 2026 06:42:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch] bsg: initialize request and reply payloads in
 bsg_prepare_job
To: jonghwi.rha@samsung.com
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>, =?UTF-8?B?6rmA7KCV7YOc?=
 <jt1217.kim@samsung.com>, =?UTF-8?B?7KCV7Zic7Jew?= <hyeon.chung@samsung.com>
References: <8c7399bf-76b3-4902-b257-b85c95543f6f@kernel.dk>
 <20260202120425epcms2p481d034d2a8fc522819673f0bcd59cefd@epcms2p4>
 <CGME20260130091020epcms2p2d85af8781639a17ab517208feb270dbd@epcms2p2>
 <20260205053219epcms2p20a936a2fa681d19d3386fd480c283447@epcms2p2>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260205053219epcms2p20a936a2fa681d19d3386fd480c283447@epcms2p2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/26 10:32 PM, ??? wrote:
> bsg: initialize request and reply payloads in bsg_prepare_job
> 
> struct bsg_job payloads contain fields that are only populated by
> certain commands, such as sg_list pointers.
> 
> Because struct bsg_job is allocated with kmalloc(), memory may be
> reused across requests. If a command does not populate all payload
> fields, stale state from a previous job may remain and later be
> misinterpreted during cleanup, potentially leading to use-after-free
> or double-free issues.
> 
> Initialize both request and reply payloads at the beginning of job
> preparation to ensure a clean state for all commands.
> 
> Signed-off-by: Jonghwi Rha <jonghwi.rha@samsung.com>
> 
> diff --git a/block/bsg-lib.c b/block/bsg-lib.c
> index 32da4a4429ce..0fbf8e311c03 100644
> --- a/block/bsg-lib.c
> +++ b/block/bsg-lib.c
> @@ -234,6 +234,12 @@ static bool bsg_prepare_job(struct device *dev, struct request *req)
>         struct bsg_job *job = blk_mq_rq_to_pdu(req);
>         int ret;
> 
> +       /* Clear stale SG state since bsg_job is reused as a request PDU */
> +       job->request_payload.sg_list = NULL;
> +       job->request_payload.sg_cnt = 0;
> +       job->reply_payload.sg_list = NULL;
> +       job->reply_payload.sg_cnt = 0;
> +
>         job->timeout = req->timeout;
> 
>         if (req->bio) {

The patch is white-space damaged, tabs are spaces. But I can fix that
up. Do we just want to do a memset(job, 0, sizeof(*job)) here to avoid
any oddities like this in the future?

-- 
Jens Axboe
