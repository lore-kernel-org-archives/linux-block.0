Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034CE12C473;
	Sun, 30 Jun 2024 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719735912; cv=none; b=iCGyezGhVS4xhXVQh7pYhv4DqARfWFWsQjMNQDEeCjoD6lrIivVgnvPxyXmq35yUhDXODJZZGUBOTzJWzpZWuJpna9oE7FMTE1BYInqodUZcqUt3Wt/BegJCTZiOmTlS+IXPWO1wR+4xgFIy8sIoYnlK4wU4cZt8q4AyUkoQZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719735912; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GeV8KLM0cwYoAteCLLgX2JGtz3Ab+PlJ0uzCc3x9x93rBfgxG9cVS/6KCwYXvY94XrB9Ur1UDLhfdJrrWX2vHAzfVj9m6+KFKNK4G6BVIj9orjoYpI3nJ/Ux5d6SnuJHGboxPICOEnwzNADTntNs7OyBR+B4KL7VwnP7o/Mz4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ed5af6b214so2396201fa.1;
        Sun, 30 Jun 2024 01:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719735909; x=1720340709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=NSz1AU0ubaQq/TlMkB6p4FtEafXfn+VFQRbqP5MURxuhJ9/r3YRJtP30989QauufRa
         eeEoD75WypGC6UWPwj9DG1ea+R3z2sKaK4SGzbmlefVj/HyJlegm0Qn9x/WJYybZ54/x
         wO3qVui4cPN2G4T0d1Q/MqFPRhxNFz13FJMgSNNXtbPSyCms/mzcMbut//BwY1c+AFEq
         XbHlVq2hdcIPWL0dL/9k0i+5VIK+fJxcucqFMUpSlX1gSvwlDcu/z/9FWXIgnNpKGD64
         Z2o5FfiF1Zs69EUH+eBT7uvcHOsS4IrjTS48arXMFkhpByYYqyPtrhx/d2tNyB1C+d8L
         u48w==
X-Forwarded-Encrypted: i=1; AJvYcCWBzwBOxpfYfhw8d5ugkYeuodZnQ/jtkavDmJT5PXtKLJ1FBpHK9+F+Mbd7ri61S8dfk01O78jnynCCxtX3uZdkVbZa2SUTWW6ti+Fp2lQsAjirbwVEj6QUsV5apBNkXL3Ijaq7F5PDlqs=
X-Gm-Message-State: AOJu0YzIRxFed9LaDByrs/RbBRh/Y+BLgiS1nMsMkrf9KYX8vlJtlRRI
	D9gY5eSaK+hE6VQxt7voWtEMmwZA+bUFsNEnO5XHhH8gtwOf2DO4
X-Google-Smtp-Source: AGHT+IGC9jwFb1286Lb4U1VLu0C/tJIWCa21LZBgCfVnza/d/EPdH0MLLKsWGZuqGeYIwyVrnHoK5A==
X-Received: by 2002:a05:651c:210d:b0:2eb:e6fe:3092 with SMTP id 38308e7fff4ca-2ee5e6cd8ebmr19581701fa.4.1719735908801;
        Sun, 30 Jun 2024 01:25:08 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257a2f7451sm44159775e9.0.2024.06.30.01.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 01:25:08 -0700 (PDT)
Message-ID: <4d27ebd2-ea48-418e-9d05-5118ace68ad9@grimberg.me>
Date: Sun, 30 Jun 2024 11:25:06 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvme-pci: limit queue count to housekeeping CPUs
To: Daniel Wagner <dwagner@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>,
 Hannes Reinecke <hare@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-2-26a32e3c4f75@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240627-isolcpus-io-queues-v2-2-26a32e3c4f75@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
