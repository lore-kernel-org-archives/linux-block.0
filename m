Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32012C474;
	Sun, 30 Jun 2024 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719735931; cv=none; b=E9Z7JofJJ75qOImC9cxduejkTGT2GZMPX7PbJUB2pIxqYm3WhsmeuqGPYSTEDsHz4aSu5wNpoZWQ+BhoZu+Hh5naahq05EBIIsGMy422OUr33l20yBfMSEN+1U7KA8+AJQ+ww243n85L+XikZB1movP4G5bSDaJD67tcmFWtHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719735931; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiI85XKXeGacvDwYCyUMJ1iKuaST205JXJVAUlBbO/Y5EVdK/ngP1Gi5HtsGj+GGP2flG5kPDc++g0f6O8e60FoObRp7eXTuWAkuEoLaffoT4te4SjDiEMkzb8RwOkYrd5cU+HScpAq9tBqXGfSYb4kuA2cOW3IUeD+Wu2lPdig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e7adf4debso185907e87.0;
        Sun, 30 Jun 2024 01:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719735928; x=1720340728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=G8zxcGNVoQpdyfpvlH7yothBqY0tY+67POgNSwlVNpvTDX/BuyaTonRtEFSUzCFfJ6
         3+9QTIBGqCP7yvs6LQP2DGGGFTPSfi/XHyIPFSgUo1w4gFCZxvxyzo80qFSnTeZZkqTL
         djtqBJ5FNlT2bVRmaa4bUaRHDGbIXObIDdy2yBWrhntTLcyJKPuCjw9fp8ZXrn/QjQgA
         Sftqikv3sw2LF/oQ5UA6e/iP51qWG+8o1+mVYeP1VU9t7O5Ec5qaabyXu4IjtUootx2J
         pM6sFkAsugih0klNb7nigMOuiHa7g2ReXTqlfKQ6uETbkr45CBxvTC5aQblFrU7iDUkJ
         m+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWessFK7szUT9YIm4c+ZVq/mUc0tM3mKvdJD7H2CIu4bCy/ONtscstRiym2mvA1YOdiHK5vs9AOlxgSqWGpG/hIXkrN/Tllugz7HbbTijENOBZsVKRzGnZKxAXQZH8igdho2M/6RIEhRcs=
X-Gm-Message-State: AOJu0YxkHytnPo1DxkomSC9wJ+xGL67ZYZsS6iW5Lo8ZPxVKuAGW+tsN
	1rM6Kivke3giwM0u4KBxMytr6yyPqNGoTcPmJzOuZwM29TU+sYrG
X-Google-Smtp-Source: AGHT+IESUjeAFOhpin+AORXLQ1ucUyymLVGh3HpTXyH2l5Sz6D0B8lqJqtGoTgJWatL/imKYw89URQ==
X-Received: by 2002:a2e:a267:0:b0:2ec:4f41:501 with SMTP id 38308e7fff4ca-2ee5e337d17mr14893491fa.1.1719735927753;
        Sun, 30 Jun 2024 01:25:27 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675f9dfbdbsm6468852f8f.103.2024.06.30.01.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 01:25:26 -0700 (PDT)
Message-ID: <f790f4eb-231b-46fa-8347-a0ae7bd6f1c0@grimberg.me>
Date: Sun, 30 Jun 2024 11:25:24 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
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
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
