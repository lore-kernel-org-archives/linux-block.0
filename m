Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CA61B809
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817688; cv=none; b=A4oD8i5OTirIMNk6Hi1zboOOmfYMFQs+AeiYdBtKbxQ0zjyF3f6fQxepIP9PWla7d1z24g9C7buZdxKSAeyqoEuhKrmykam+NvemR1qk8QNZ17XToXmHEwVDFKRyYAcg4yyGJ6c1hfoz4HJgHnsHgCC9C33mu/xTU8ikp3lGz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817688; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kx3gBFKvgZBbGJwFxs80SzSR+VYvWfse7Aet3gwsYm0Sxfn0el86oIoKtbVAK1Mvsxcb29wgK0fmByoaYMp1hhhXFWklSaO83bJjMw9gs0GP6TT0rI2qD+er7NYcjby0AshMLsWbaUfim5gPodeDLV9hVoTo2urPDHyddknngGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4212b102935so2164815e9.2
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2024 00:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719817685; x=1720422485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=YlCD5jrp2rL5jcBj540HEudMq+ioqPIaqUG1yuwbb7q5WMGn2siXEHsEv+qzrDbhpk
         78IxQ/wWr1gLoVVX/8OoIef+Spl9jn4U07Wx2JvpI42K0u3fZLUe5taoQOUBP7iwiihh
         9c7NDXk+Ebv6lUzXG9Z7vcFSgVbdUAGg8XBUo3hAttlNOXU7xk1XMImtFbidkno3w7jo
         2lOpj6VrRfaYZZUqEqw3PvDSbv2LAOH2eLPyG0ShACIKxoHf6bAmPPecR3ym8NcVaktm
         VXgoStkv0gHPCddDXe73RoqNkxmIsAap/ec2GMVQ5i/+KF5sKyKEYALlST2lC7W939Fi
         iCgg==
X-Forwarded-Encrypted: i=1; AJvYcCVEamkhmvo5iWirYoZ0NLpKXwCceKUOMHXTIAja70uZip6TDlDAewivNkq/frZHO4aZaKBvYAYAAktDCHB9o/d2aj97z6r5kgCNahg=
X-Gm-Message-State: AOJu0Yw2TNUrvC/fpYc3dZH4PrRf+Rdhf+D9k5o55117XAMkp3QpxSzZ
	VZr+RBvkI2Ng/BcR7XkUw0xppOxm8mz0jL7YdVKoHIgn/2sjgPeJ
X-Google-Smtp-Source: AGHT+IGO+XR/E7wTlwaheKVw2Y3mz+lgUvqCWqjVh/174YlYIe7F42jOiNJ8bV1JGLNLHIDA7vOAlQ==
X-Received: by 2002:a05:6000:1f86:b0:365:da7f:6c17 with SMTP id ffacd0b85a97d-36775733d2emr3630890f8f.7.1719817684673;
        Mon, 01 Jul 2024 00:08:04 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fbbd4sm9223793f8f.84.2024.07.01.00.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 00:08:04 -0700 (PDT)
Message-ID: <f04afd3b-3b6f-4b7c-affa-146a602d64eb@grimberg.me>
Date: Mon, 1 Jul 2024 10:08:02 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: don't reduce max_sectors based on io_opt
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240701051800.1245240-1-hch@lst.de>
 <20240701051800.1245240-3-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240701051800.1245240-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
