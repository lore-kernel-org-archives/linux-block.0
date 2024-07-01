Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E271B809
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817595; cv=none; b=AlXwXRAiv++qX8+npOJwg+eMNUz9FWU5z/jJFwXcqoE9Ep/Mj6CorT+vGDY4MBZ8SSBNlPU/Yr4c4ivSccEYAWu3GKE85hf5MkGGLihUon/VnEUrDu/K1S7iG8Sa2VmST7GHghzdz5uV+OoPN3q/CaZ9SG4HcVfDE72jKPiYS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817595; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwVEf5UA0NRwRVQxiW/eoZBmNbPS4IZDhoXehjWnQXt0KxZdZG2KrqiUZADx8hiXZktSDmEWPqgrBzy/8V5QRfeCowKXw/wTAUjizdN7PGndO6hQgRfamU9gdZsYA1P8hIODbMSdSkHabqmstlowBHH2MSMvHaZmuhhIAXMrwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6fe26fe209so35911466b.3
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2024 00:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817593; x=1720422393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=CZNM+YvqqOnn2B9ytez6j/dd9vxmcvO+PQANfEtxPsS/qtDbKuS6Tl/clM+5Bm1zrs
         oBUiFNlTWqvk1pcNvDDKK1oPMOdGNsscWr9yIq7CaleFFgbDHVlSGNXCA1IBZOA77Lv+
         3PHHdHazfRFFXw1Ti3l7Q3F71D4wSvdAtFV4AMKmCA7O/zLvbVNsd7GZMgc8CvInBBGR
         7CAGmt42O3sPPQw6HV3fcn/tKw+TggV3klKe43Nufs9arQoq2cRVst0eLSwVExu/5FV8
         uYDpkNPVMXLRMl9Jw5ji7rHuekW3XT7xQLB04aPmQI/REbnaI7Wrbv7XG1NI5BslptH2
         /kkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMgrNqWoxZvF8WDm+UgnVT+ZfiJwMiKC3JgNWY+3m+dSML8rgAW+3g35BW+P2apsWZnN3Mb9NiNFlpjlxV0us0/TjRi6w6e3J0z3E=
X-Gm-Message-State: AOJu0YzdHxWPLjO+8sQ1zaWrcDwU5aYtYr1zCQ7xVColLOEH82z2x1G/
	xaQQxgevenhDMGS3qSlda7awvPzbRbgutT/3A58V5XThz+cpNz1Q
X-Google-Smtp-Source: AGHT+IHIHA6mHDhYRvCNSEm5bDxSYrJgukN5Ni9KJQucnj8fodd7vWuNJK0zUsN7mXcrAAxNCQQO9Q==
X-Received: by 2002:a17:907:3d8f:b0:a6f:b97c:ba8b with SMTP id a640c23a62f3a-a751442462amr382131866b.0.1719817592547;
        Mon, 01 Jul 2024 00:06:32 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a32asm140395845e9.31.2024.07.01.00.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 00:06:32 -0700 (PDT)
Message-ID: <1d65fa66-a486-4e7a-82b6-0135a65c2ba4@grimberg.me>
Date: Mon, 1 Jul 2024 10:06:30 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: remove a duplicate io_min check in
 blk_validate_limits
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240701051800.1245240-1-hch@lst.de>
 <20240701051800.1245240-2-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701051800.1245240-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
