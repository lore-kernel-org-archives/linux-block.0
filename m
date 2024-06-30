Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732727B3FE;
	Sun, 30 Jun 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719735897; cv=none; b=COKaVhvHQbykgwLtm3qbU0e2nQK3LW3/4zg2W2srGwUm/FRsqch8fldgyPasQnj78P/OP9th/YUG/4exh9+mh7tet7kFdfark8wi+WnmKVpSM4zEvCKBPnBTlVHnJZL+Vqq4DJcSsz1kMZBFKPyGwh9ecDIrG3hIzqsKO/uJE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719735897; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKkYCrhwOvJpL5qymmG0e5VnZQdKm9lHV1wuaruZQxQ4SOhStw2awxYGWA8HXpfJM8AVMnVzu3i3DG3XyejVSEazc1EKPvF7xwfWPkdr80w7+tQLY84Qs9A53S/NiouTKPzP59q4aNYYxsnDdqy1HOcej34f8pBwhcUAi4+250o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3635f991f4bso111878f8f.0;
        Sun, 30 Jun 2024 01:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719735894; x=1720340694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=h3+k3y8/58kY1WbZDESYLmrqsdM8kWQ9idr+7LGhaI/ZqacmPCPtq/4icmgXsyyK05
         gPAr7zAwelufZT1H5cUblQelIUckjQHLTKu8XqQY5XlDi24AtleZ4qTIVMVU5aIEhO25
         XTYUFcEavdt5lvPxSRwY0LIB/Sp45IA9VdgweXJByQdg4erLKq8nI+g8KAahsfITsrNR
         6pyTgYYzku6sb63rDBk/sSR/KbqJ222VZJKvkk2Na9UZIkZTdICVNAPjRCCZob2ll7de
         QEnUY0ZW5qMUQ5I39t42t3aptZlrQwbCmHT3lmq8mAcBF3as7Ft3PcfiDczFjr1FEY+C
         2Njw==
X-Forwarded-Encrypted: i=1; AJvYcCVgmVt6HDXOUkL9Wk9afjP1MPCW4bF0w3ASnAVcc9s9uxfIKUv8h9/z18Fy2SqT8cXdk8HdGiA7prc/cdChSqldbZi/j8BTdBr37aqJLAfbmoTtithsAlnnIZta+G78ybts+xwk6hpQ2AI=
X-Gm-Message-State: AOJu0Yxb2SaKLsBbNwpxi/KjmZjvCi3Y0KOqoaPY7ZV4ofUIAsZxvCh0
	CjGjZjU+jdJCXLb+pVufWl5kn8KwP09nJyNNg4cdC5JmN4bhl7t5
X-Google-Smtp-Source: AGHT+IF5j4Vvn/c1MwtD4Sq5KqVqB2yPZ6w2Wu759kgeCpnor3yzD4Ab/b8p68qtUYiSQzSM/GC5fQ==
X-Received: by 2002:a05:600c:4848:b0:425:7ac6:96f7 with SMTP id 5b1f17b1804b1-4257ac69876mr15928965e9.0.1719735893588;
        Sun, 30 Jun 2024 01:24:53 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b097b77sm102371405e9.33.2024.06.30.01.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 01:24:53 -0700 (PDT)
Message-ID: <f9790913-fbf6-4a05-bf2c-56051ab07eab@grimberg.me>
Date: Sun, 30 Jun 2024 11:24:50 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] blk-mq: add blk_mq_num_possible_queues helper
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
 <20240627-isolcpus-io-queues-v2-1-26a32e3c4f75@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240627-isolcpus-io-queues-v2-1-26a32e3c4f75@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
