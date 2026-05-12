Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667E4ADD92
	for <linux-block@vger.kernel.org>; Tue, 12 May 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578233; cv=none; b=LkpJLFPJxyx0rvo8p2yL0lgEp+faWnXkV/G8y79AaNmEjk25g7isDIIdyTxUQwzcEUQ+/3GKdI4b0sAplfJdUMTrJsmY+XK4mamzaWUp1/IzIubHLZI2aR1/f4WxLlkmm1oGr+vEJoQnIs4gJ3YJkins3yixyIfsUJkekUUwQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578233; c=relaxed/simple;
	bh=9ZVEYWiJ8mfJhHSDmdYoWsnzgviWs338ieiJcp1NW8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/rz5zkX8do9ewyp8cGJxwKIPRjgDtUwNy/6cBBOs5NrKhYev7oz/mr+7g+Y0S5pMJiLP0NVdI96pRwIT+fO8GlZ7j1mtc7BSHuQYVJyGdEiZnuBrmH2N5XWR77OzOhYSx1K7w/k37Hobnm5hHI0JG+WQk2drzhfQytEnNPyxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2CAUCIc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2CAUCIc"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd2d8bb1068so57266266b.1
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578231; x=1779183031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGZAkcM+ym8AsbVGOAJ6+xeqYSrWcyKvdgdcKQ4eIYE=;
        b=h2CAUCIcRb1DusSV3M0DsVMKaSnFMzQWB6BN488Z0jBqWbmUCtiTejmJ++7kPmu9az
         GBKb0ygNhV2hiSnqxDsOYc4Z4bZoFQNS0sIGhGkJOhwnEXt056MHvrdx/cJoM0ub2HUN
         NOvpioQrJODvqUNhlzDTfCE7DGx/rnVg27HjOsNWBMVHOWkKkLp3exAhuEciaqbO6r9F
         qRqgLy8MESUqxlcORPoWtDDbcIV9/tbZe41qBYHOUhIsPqYoAtcBornYvNJbQBmrrmQa
         gyfnctFEo/U/XYK9lRLVL/m9QMQM7poAmGO/UeuMf4Zlfs09jO9HRptcF0fqlDrExe9g
         iAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578231; x=1779183031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGZAkcM+ym8AsbVGOAJ6+xeqYSrWcyKvdgdcKQ4eIYE=;
        b=F9609rW9QyWJqXpRxthnp5uAj5j+JEtLdkbx9L0k6YOBnrUAkpYfjltFCnNyraGjcU
         xV17J7yQ45mHSZTQQqK1k2JK2os5NaxWKjG2ZlqYzf0LeW51pyLgH+/Bt1ndDs1uJ5xF
         l1Bwor+nUnhlfv+c1LA05Xs+XR4Ut3l918eMp+l1q72HTbSSkffpwkmvnVLbsmRgGarR
         YjM5icJR+Ml3/lKAh/PJuiqvvpNAro5HB5YXccYPwm69WD87yulV+zuMf57x+2OJ+f2Y
         6sALCoTykYfaYClcQEsqQ6fSmL7qkseI9Xp5wEU71u12wxm6EXPRrMN2f6m1BUtgGG3G
         Xk9g==
X-Forwarded-Encrypted: i=1; AFNElJ8MPmpAqZPdIaML4OAXGxlxSvnP8U4OavOMjW6/7xjt0m04mYqClBjLpRAgE8je3j29D5xahKkA0RKzbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaJa4dATH8xjvkTCXoR3QnqGcGR4W9G+2YLyzY+nzgxeqm3QrT
	8niGk3aTRqmwSHu8XnJ1CqEoXBHtQVIqnZsICYhlj5P+nc5FQXc3lCQj
X-Gm-Gg: Acq92OGx0+ohpDl0BYcBvmHnlRwXOur+Ck/SEAT3MSbXrpENIfvPMo53WaOJQUUDvo8
	fKCfBq2R2HMwJBeSJiKUpb1Stl28bugtL5wmLLxNwbpfAiaZVFt5dDfVko9Aqm9CUQhKPX4gpZ7
	Ikvmn43Wp7FRFTbnPguqLpFeGYRQMhXOk40fJkYYIoOm88imaZdt9SAp+a3xZeIWx9lZvxvpBXv
	sPypJ00DGIPL6YddWnV9lOY/yZYlDL/1auZr1h+5zwmSeaDbpdW4LU8CMPemUN8w9qFy5wgF+b8
	VTXbb+ZSo839j+SRyZy4RF1ynrZCgbki7cWkDToiCktBbs+1hbWx9WboUpBnL4w2l04eIIGs3fZ
	j2PhAMd1UO8zFmXtjv0IQCvGOopbKINc4M2FwY9pOx7YW8Esfq4ypj2A2+7oHZOqP6xBluYQzsS
	V4XAO65VHcten8/ar+yXXYjp0TVjuQrBNO/cDDnD9DPS2jMelNuRQPrO0F4QornkdZSIVn/TQYF
	85thVjhpT1XoL3p7QpM9gtVWqnx90764h9gY7F5w1LrkHQXYA==
X-Received: by 2002:a17:906:99c3:b0:bc4:f3ef:e43c with SMTP id a640c23a62f3a-bcaad52246cmr973369766b.45.1778578230560;
        Tue, 12 May 2026 02:30:30 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::372? ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfb7b17d1fsm303492866b.41.2026.05.12.02.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:30:30 -0700 (PDT)
Message-ID: <a4748a29-8aa1-44c1-a1e4-b82f4f191d4a@gmail.com>
Date: Tue, 12 May 2026 10:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <20260512070045.GA32030@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260512070045.GA32030@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/26 08:00, Christoph Hellwig wrote:
> What tree is this against?  I can't apply it against the usual
> candidates, even accounting for the time lag in getting to it.

It should've been a Jens' for-next

> Can you provide a git tree?

git: https://github.com/isilence/linux.git rw-dmabuf-v4
url: https://github.com/isilence/linux/tree/rw-dmabuf-v4

It's a wip branch, for now it's just v3 + 2 fixes.

-- 
Pavel Begunkov

