Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6464F887
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pCPA+Q+Y"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bed82030faso25347539f.1
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704989004; x=1705593804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kjngVWe2nV5WKLg85Ym8RGlf6nTLubv9sNiVocD+uE=;
        b=pCPA+Q+YOZwg7LZXi/t2lgmbz6pEdvH9oNfaqKbMzYa1R9WheSAA37aEp2dhGYdlYg
         TxusZz6UgbDYHW2y7yci0jr2OQIUkUd607Im6wgscqdAEP5O3PiMpiywpwNlh5rJI//R
         V1gL2/btmf5CGREGidAlGZx5OWhqy4nebbVFeuxTgwMMvcDoAo6aIxicrwq5COsSkZ+a
         ugMAq4Y0Yc6UfJ8Qwmq2aVoKEw01AWzIhiDCbUdFV7na76FOT/dAYiOFxOBYwZPnDfBD
         3HtfhO09hOb8IoOjCWxHk+3CG8T9sV+CzTobrBfrBm6SJ4niaOxy53CiwjaZl9jjVCeJ
         u6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989004; x=1705593804;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kjngVWe2nV5WKLg85Ym8RGlf6nTLubv9sNiVocD+uE=;
        b=neSR8u6Eb7sR8O6eZc9UrKJkjH9p/pRDLu4KL+6f+TdRSsL9FRLI7rbT2jzPjKbU9v
         pbwETMYu0PlL1wQVlH+uG//hvyhvCt4VOcsMjx7kIOpNVu0gpdSZ9cP8nExmdTz8PPqr
         d9LRb+RJceTmVQ49HuLMjMWWFpsM1nYa4CpcMrEvaOlAjE1PigoTLNlKdP+ONVni+oDb
         RmEmEKrYZsG/iEYKCC2HAtzPPyMKkaKIEjXj85FrZylGhgQZYbacY+V3QLtqaSw7S8Zx
         iNp8VGPIUNP2waUGj73t6cmhc9P2NS56oWSRVhTcx40wWWNylKWn/19TdAx3I9hg9lUo
         49jQ==
X-Gm-Message-State: AOJu0Yzwr3rv+6jLsIon4fHHX4XoNFJ3fE8mMp+8c6JiLXvVN1wbt0XT
	Kt5wZfnV9zALlanBWCnA8ywgTi9kfnqzJKZrP9JMOtwLN5t9Mw==
X-Google-Smtp-Source: AGHT+IE8BM2rMvXKzJPyg2gdvDAT3u35pochF7OOuoTJSPLe7DyxASfEGT2JmqqFSkiooKBINh+nNQ==
X-Received: by 2002:a5e:df03:0:b0:7be:d855:4893 with SMTP id f3-20020a5edf03000000b007bed8554893mr2686400ioq.2.1704989003910;
        Thu, 11 Jan 2024 08:03:23 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cb8-20020a0566381b0800b0046e1ee9bf85sm389785jab.19.2024.01.11.08.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 08:03:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
In-Reply-To: <20240111135705.2155518-1-hch@lst.de>
References: <20240111135705.2155518-1-hch@lst.de>
Subject: Re: ensure q_usage_counter is held over bio splits
Message-Id: <170498900326.1937794.17919960796467791893.b4-ty@kernel.dk>
Date: Thu, 11 Jan 2024 09:03:23 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 11 Jan 2024 14:57:03 +0100, Christoph Hellwig wrote:
> current blk_submit_bio can call into the bio splitting code without
> q_usage_counter held, which can lead to inconsistent limits beeing
> applied for drivers that change the limits at runtime.
> 
> The first patch in the series is a small comment and naming cleanup,
> and the second one ensures we always hold q_usage_counter before
> even entering blk_mq_submit_bio.
> 
> [...]

Applied, thanks!

[1/2] blk-mq: rename blk_mq_can_use_cached_rq
      commit: edc2e480a9f242c91fc7bb64d6de77af75bd59b5
[2/2] blk-mq: ensure a q_usage_counter reference is held when splitting bios
      commit: 744bdfb30b119f011d800e865623f3eb0a28c949

Best regards,
-- 
Jens Axboe



