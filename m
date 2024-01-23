Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3B3129A9E
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035637; cv=none; b=uPX89q/fo4GoP142ZTrAUgPc9sFySPCWN4ISjurQMs0hsUAkwIKIaEXDJXsU3c5+Gdb4RUJR/wAZnyIuEGIqZF2w9VOaw+mumcyEf/b+/cUTFx7X0l7fcQ5VLSieet2MtW6VcLd7zG0cX+x8dWX5Y5Hc8oNC7c7KT78tgTO+EpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035637; c=relaxed/simple;
	bh=EBOEITjKipbpLPMtwdHzYPT9xq5i4R3pf4nEG0d9Bqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q6pE1iWj9c3Y2Vugjw1GTYp8NJw4ETm5SQjUJL0HnAiwqtM6UQoBQq7k/GAVf5umQdNLVI95K+eQSODK3FYJQVzV9lPsMRjS9SZ8eMN71o1BSZhbWiWLSzaSQWRZS7GK1ZXRb17Ri91b/mg/0qQcz59e3QJibwQd/p5vQaAf1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d6fbaaec91so38375685ad.3
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 10:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035634; x=1706640434;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CKQ/fqk5fZYUbDCkkGaF+xWY+pTgHN24WzJtVqXN0A=;
        b=pVIgAqlrEbSWqnQqqZoz+IXJlwgecBb02SXXR8JQw47wkwU569FcS7aBnDMtlFVkdU
         QfgDYcQDe8lYwLjgDmk/Avo1S3dDdG8qANCx6qF4oE9rXScPzfyNcQ8jvRsjEab+usMw
         +xkXY0DDLt24mNklaypH2wOesA6CRtW+sSRKzn134MQFb0V/4VRABT7iUwJyOzH7idKK
         Rqas3PFPozI6dGUw9lrVs+r/usnJsnHGPg7kkI89RcsNVwj/j/GmaJBGKzhH3MA708pH
         Mc8mt87kRW2fG2QUp+N/ayK9ainYWQpSeMFQ3DfA+wahdjKKLDP6OA/vCsgnpdrCbSvy
         Fo9Q==
X-Gm-Message-State: AOJu0YwCPIyjDxnHto5Ncyus2iQk/j+nMQdbSY3ZpU/xqdytMTx5s29H
	XH5vdB6fu3i9kdKRPhRwA5+kbl5uBww9itMsjdw2WIhTMcFXURDRN2qnCyks
X-Google-Smtp-Source: AGHT+IGEE9kD46UnT5FwT/HK/Xu94f/QgOsPeG/mtoRY8GcSHp/EBPGM9ELxDt+w+I7TiMqU27sPnA==
X-Received: by 2002:a17:902:f80e:b0:1d7:389e:325f with SMTP id ix14-20020a170902f80e00b001d7389e325fmr4778819plb.13.1706035634449;
        Tue, 23 Jan 2024 10:47:14 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001d77e3c59b7sm207069pls.83.2024.01.23.10.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:47:14 -0800 (PST)
Message-ID: <5db987f3-9f73-4ab8-856e-a4edd74d10b4@acm.org>
Date: Tue, 23 Jan 2024 10:47:12 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] block/bfq: use separate insertion lists
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-9-axboe@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240123174021.1967461-9-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 09:34, Jens Axboe wrote:
> Based on the similar patch for mq-deadline, this uses separate
> insertion lists so we can defer touching dd->lock until dispatch
                                            ^^^^^^^^
                                           bfqd->lock?
> with ~30% lock contention and 14.5% sys time, by applying the lessons
> learnt with scaling mq-deadline. Patch needs to be split, but it:

Is the last sentence above perhaps incomplete?

> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 56ff69f22163..f44f5d4ec2f4 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -516,10 +516,14 @@ enum {
>   struct bfq_data {
>   	struct {
>   		spinlock_t lock;
> +		spinlock_t insert_lock;
>   	} ____cacheline_aligned_in_smp;

Can lock contention be reduced further by applying ____cacheline_aligned_in_smp
to each spinlock instead of the surrounding struct?

Thanks,

Bart.
