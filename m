Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4D29115D
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745620008; cv=none; b=oaH2aA7z9CAuOf7EVoBj7qhKcbkhQPSnZtqGagZCwzYgVrUfbEWrKTb1Seo+BcrpfgDrOp1yrhmd/YCOO6Qd4BUxxqY+NJsJT0z1aZZ5RgkFEQVhvd7Y5fq8yKsrMQo4l6ZkMv5HIjiWpY/j/jWi9NuVaS+We3WfZ+KrlBy+0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745620008; c=relaxed/simple;
	bh=+pyyE6E9MZ3bsJ8rbwbvAEuruoI7mO8Yq1I3cHWo2sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6XMFDtACgt2Ax3euCIw1gHVWgr/Zn+nbcd3g//0xZ1dOswEEwzzu0h2goqh1KiHQs0H0EW0dz5GU2FtzjTMwqXtQE5fGaiRjJg/Mnlzm2NxYK7f7Nl3vi1opwGWXWCEhMKDULJz5DwiN9yqfkW0VQ1HBpW/NLrqLqU1g1vUacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso24729405e9.1
        for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 15:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745620004; x=1746224804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vv3Lcuk2zHbRg2A1c34733cjx9f4A8lRYudhuogEzGc=;
        b=PzLHUQortGq3k+21mVGQ95NVqE9Q0BZ9TKrXP+a40N/4x+ArOx8GbaVCM9HkHhTtWh
         zQEKsO2/PI/7jBpNsWIf418C78Ft3Z8VvGzfYjPO2ac9r580XqXoTCTBYoDiI4gTUazh
         u61Z5JVNuXEqi1hKizewAnie4TBsziQepUqcNeINtljAhL6TwUAYUfa9Fu/4oJBISkrB
         REObL6BKc08jz0Ob7TjmiNh28t1C5DkHTaaxc+grHnfycAIdcscnsAtQ/Xa/TCxaszvm
         71P56Eqgo3wWQrd0FXh6FDEn20ksYxRKWwPV7/ZBCAc4lKouTpXUM0nwcsAAP3jvLUso
         yDYA==
X-Forwarded-Encrypted: i=1; AJvYcCV73syxCZzhwkRF+TMXqFUQcOC3J2Z9C9pK2Yfz/vrUuEsNicLPX9rluV5jrIqgTwQO+mz523ZBNNJOuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTClPGLmez7lJwg0jah+BnzMNqDumaaeYLTre1arKznzDEODBV
	PJENogZHm6BKWb+lRgxkRatiJHjvjHld7r8oe40aTI3B881ADgyw
X-Gm-Gg: ASbGncv1NnSJAvcEedKC7/7LPR+VMs7oXfSQFf2xG0DCVAPQx2oCpowaVw2YGegMzed
	Thp70mq+/BmzmUgOGJI+LVLUzVFAHVL2WjCk82F2sGzDzsf89jXsKlhQcUmQUdczjXtfIxycKF9
	3i297Jb46/LJDvdVHxq/E3gXDd/BDvTdCkwkzXIY5Y7RlguUYn3v6skm9kHab0zNkMIUKQpBluW
	r495eOoUZtViREITCwPJG9k4f9eY6J6fxY6OdpbWYf1g8mLDuggMglFmUXEVDoNtLSRKGG0FIvy
	gPqyGnSzAVObnhftCNov6kUwNANUHcpJi8jiFzsI
X-Google-Smtp-Source: AGHT+IF/hntH0u4F3AtrTN8I/iKUCb2J5R31WaVPD84iqfJWy5SW4v+i4wSyHBLjvVFqRVV7i8QoPA==
X-Received: by 2002:a05:600c:a418:b0:43c:fad6:fa5a with SMTP id 5b1f17b1804b1-440a66d91cbmr31165025e9.24.1745620004423;
        Fri, 25 Apr 2025 15:26:44 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a538f691sm38542595e9.37.2025.04.25.15.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 15:26:43 -0700 (PDT)
Message-ID: <859e8758-83a2-46d2-81ed-c5199f326508@grimberg.me>
Date: Sat, 26 Apr 2025 01:26:42 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, hare@suse.de, jmeneghi@redhat.com,
 axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250425103319.1185884-1-nilay@linux.ibm.com>
 <20250425103319.1185884-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250425103319.1185884-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   
> @@ -3688,6 +3688,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>   	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>   	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
>   	kref_init(&head->ref);
> +	if (ctrl->opts)

While this check is correct, perhaps checking ctrl->ops->flags & 
NVME_F_FABRICS
would be clearer.

