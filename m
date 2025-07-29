Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8A289E06
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792037; cv=none; b=iRCe8BfU0eg3pFJiCZSn3/Y2/o4pcabVxrlb+zPjrbwXQpIQitlc7rB1gOo4PgQYAHtenHZWult1U8cWadroEzU0UEdAUza9OhEB1a39HKWSVZFUeldpWpw8Y7cATHt11L29BVpHqktrGKjsTDVVkZ3VKQy0yYedTCEQfCMprMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792037; c=relaxed/simple;
	bh=cU0T+k4iDJ8heF+HkBlpmOZC28gyHm7IQ7he1InYds8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K5nB1LlPvwZeZC+siqjl+tD/aFnMwMuIW5JiT5qpvEvRxBje1e7n7/akKYQJMOh3ZKARhmfr9GIVlrSVq91Ov99OpLkprpmpYCST7hvGoJnqeKA+JxtKOZt8W+fzExP3fUeg5ePOp3AO5Xi72ykYg23cL77VkekHyyPuV5SmTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kPDABJxF; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kPDABJxF"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-87c04c907eeso479267739f.0
        for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753792033; x=1754396833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPYmiWbqrxYv0h/LcYvZS7437WT0DywF6+Q/trIB9gA=;
        b=kPDABJxFxKaSDfugRwNxKvYFhKdwDjJkC2MIFX9K8Gb4HSyUZNfSfPytu00FxBztNd
         kWW0qoyXeJsWabNmXib2V7UWCCTRAQmZa0inF91e0jTbBVqDR3+W6lBDdbnf/yzExlg0
         sdZ8PkQuEiTyFNsjcTtBB2xmy3D2XpLnLuAx9gUhe57Hh8wmAPnV7dW7VVk3n5Co8qHE
         XNOG/ZHhXFFGShDFB1D/A3iK/xp2PD/2H6m4e1wUavyGMoCJcckpB8T5k42NXmupe9dH
         V55PnMDdxTYS6lQd/9GZ86+JOacQiJdApanhh3/6PNMUMTjOXj9JLceEF/5dKa+cpR5y
         Z8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753792033; x=1754396833;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPYmiWbqrxYv0h/LcYvZS7437WT0DywF6+Q/trIB9gA=;
        b=dOW/DWHLhTZdWVPoMmbbJFJJEEV7je2uLDtePYdP+SO3id9YSAbvpG9ylH6MICFr4b
         UxiQ64aZIGu/hjo6Iz3hSpfgqK2PnCKtD1ZbqZNXTqp2PQ2TC+iDPI1094i2jN1GYQTT
         jvyK83pVfVpq12ihoB6MAYBIylZx7pEFTe7fRekvDTmZvClJxttyVJfPFThOZNHauDrp
         dpWijOb+sp9alZsyUjOXr4RkRTb3BNjf6rmzNeUqSlJY+Ri9wZnatHwgfubRXoGmfXyy
         0nHd7uWzs8CDuzYgdgweCqJjDGyX6+RZ/lC9Pggktfbyeil5nmzSpYiKn0sdQQBYza2U
         9fTQ==
X-Gm-Message-State: AOJu0Yz6H1tJ5ZvQRFbE5b2WDIkQsLi1F2S2zxtb8naaXjuo3mrG8lcm
	aOsUJrA9zMv02eoCyYl2TT6MNQigrn/4NvNQAaIfwQBXrnx7j/oExjXV2hx8/9iaZgY=
X-Gm-Gg: ASbGncvZI6bXAenEQx4iWDzWBZhU0Rq8hLsm5gHQbjpknyCCIBI0+rRXj3MOtuYU3jO
	V1c7fb1FYsDuipOVhiCCmMwrRwGAnVhclcApawI9aQf3sbh6Ah7Gqhsw+vSerRq1CWGIOSRH5wy
	eVA+SK8HGSigg1aBG5iz5FodwP4GbBEJth0pYH23Xehmbhuxf/V+yQQ6TLb7bhajK5J3bZgOYdB
	ormHstxykzYnndTXaHrwMV/37YHpulA7LpNJcGnTovhY5uS4FjC0RiRO/G+ZiV59XIJh/v/XBCQ
	Od0qR5fmdqxH7bCw6NTr1JZYW/2YuxYJyOh3yHVk4miSUJ0eSwY797Fc8Elv6n4N2gWmQDWxxwO
	0zMSv/nA/BwPJ3k6351W3POYU
X-Google-Smtp-Source: AGHT+IHWf7ZaXC2jAuVccLjbMHyXhx8rrLBvBjsI8QV8g1kEZLDDI8UbM0UIhmtIP5rnLAmQ+q/p3Q==
X-Received: by 2002:a05:6602:1352:b0:86d:9ec7:267e with SMTP id ca18e2360f4ac-8800f1020ebmr2606945039f.4.1753792033484;
        Tue, 29 Jul 2025 05:27:13 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-509002ae794sm258067173.45.2025.07.29.05.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 05:27:12 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de, 
 hare@suse.de, bvanassche@acm.org, dlemoal@kernel.org
In-Reply-To: <20250729091448.1691334-1-john.g.garry@oracle.com>
References: <20250729091448.1691334-1-john.g.garry@oracle.com>
Subject: Re: [PATCH v2 0/2] block: make some queue limits checks more
 robust
Message-Id: <175379203207.176672.233936006737329867.b4-ty@kernel.dk>
Date: Tue, 29 Jul 2025 06:27:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 29 Jul 2025 09:14:46 +0000, John Garry wrote:
> This series contains a couple of changes to make request queue limits
> checks more robust.
> 
> About the change to enforce a power-of-2 physical block size, I audited
> the drivers which set this. All look ok to comply with this rule, as
> follows:
> 
> [...]

Applied, thanks!

[1/2] block: avoid possible overflow for chunk_sectors check in blk_stack_limits()
      (no commit info)
[2/2] block: Enforce power-of-2 physical block size
      (no commit info)

Best regards,
-- 
Jens Axboe



