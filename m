Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AC17B425
	for <linux-block@vger.kernel.org>; Fri, 16 May 2025 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406610; cv=none; b=Fjze3e6SVv4Xe0uJB92NqX7JZlagIpXVO6n/tndVYHT2Lhy6yWHYk2/KH/RuSceOR3UlYPxWtqbc7ualR8mb63Sau4OBtin5ORAnig/cvN5Yj8I8lWuZ3EQ10KV4XZ74Mt2yCWWegQs5UzohaZ5VhaLd9yhzTAIs2Re2wlc4FuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406610; c=relaxed/simple;
	bh=/NAwgycZl7erk3U9GIadv57Z7cvBUxcnJEGvhZDaVMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7evxWU08Etgu3AyjNvX1fY5VAMpr3Ng2/agDKOS2l9wHWbI/ud+aCzbJnrCpvtM8o9si3bW2cpC8DkzxbZXzmwbWvUSWB05nKsK5ETTJHwUSoOMoqxUdcH9EnCOUzyq0gsPUslvAY3kPKf1hhtEVmXjPP0ybZbvz8YNDlUVNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zqgtEmeK; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zqgtEmeK"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85e1b1f08a5so60392139f.2
        for <linux-block@vger.kernel.org>; Fri, 16 May 2025 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747406606; x=1748011406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prCdQyvnM/rs+FkK7sDF3PvP4+OFyS4++/OPAvNwpL0=;
        b=zqgtEmeK+z3iUC2Js/f9POF94PjPnN7RALGdNY3QHsC/BiqS7gV5EmneEGc2atizIu
         JLUAfyjsrI8bilMpHOd/w+Yuwt5jmIrU+7sqYi5gKwGHzuE5kdhVXO+hanT68i9Lexz4
         Sjcg6j9GZBJz49z20FRenHRxIXYYuUKYfZ0OT7g2I7/+HwtbCC5kGXG86YAHw+XofgLX
         cn3uDfqbIRY5Ec6p5uJU1cGgi0YGC0PlUaJl0oRNKZmn3unV9UEoC6DQYM156tJjhRUn
         /ZG0PmBUliZRYPl0pBPn7oJ3nA7cdsZG3pgZ1hzw3HWmRe7k84GRlOsnp9QQI3kuMFSR
         L3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406606; x=1748011406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prCdQyvnM/rs+FkK7sDF3PvP4+OFyS4++/OPAvNwpL0=;
        b=ZFSvct62MCWU01fd2nXRyg11OMCeSeVpzPtuGERg8Vb2XnNqkDbdo1DTjuT3JhVigH
         0+IY4GJ8L+xRLbDPG1cqt2uZF0ZEBlcqrBGbA2kFCwMoeG6PV4oL5o5mW7SXmMaK7nlX
         VB98h4aeNujzxdmAPvoTuhGFWDONq54Q2NP2jSMhzj8jxdtqQVJbF1rLhIxdpqTTn5E3
         wH7wohcAjpigLMThzKCeIWGhuAyAAAq69g2SPKtUe0JEpsyB+kmFRjZORQQkhqSYR17i
         Eqxg0V/FVHIiij5jjffZklbzTtHOlaofe31unx7QAbMEFUpM4kyRFG4xIsV7SftYb/SS
         z1Nw==
X-Gm-Message-State: AOJu0YzozHgiWgI1Y5MCTJYW+VQuqzz6O6vdghgpcfo3sdCyCOay/kNu
	3/lYovChpcSPmZjSm5RJaHea54siMw+AzbYamwXATWycrO65rb4J185/HdWiO6zGPIuEgyeuW+x
	CkPGy
X-Gm-Gg: ASbGnctsE3kfwXofxLVkv+g7oUUIsxfzSeL8pFcq0iQtL6BPlKyy3dKZyvDSYT/dMyS
	PfwtuJp4LOSY1BgrNXdf3axNU6oTx6+Q2zK+RkBb/FtWb/BMm/hXq+hHsX0ek5wBrpD30sMBdMN
	DtJC428vK6giNq+gNnN20F6+ZtNCRu2EGp2U5qw+8WDCShSvYp4aN7jhI6GTID29SJ6Jw91mE3W
	RkcaJnAc9v8v2xwfG8oqwz3gQzSjKJZW5hvqqqTU5nXrMwYp3ykV/fQYHkc6vI5tP8ngh70D2uy
	EgkSDNn9Jtz5e3qfEXMIDpFHVaqRlOgr4l4ivB7lqiurAQg=
X-Google-Smtp-Source: AGHT+IFLui/5TcNeeGyfjSliH21Rt3SnlD5fOdEShwlWn9BJnqOLtLrqPs/PNsUOaShW9xOztH2YuQ==
X-Received: by 2002:a5d:8181:0:b0:86a:24a7:cecb with SMTP id ca18e2360f4ac-86a24a7d12dmr347718639f.4.1747406606060;
        Fri, 16 May 2025 07:43:26 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86a235e14a4sm41905139f.14.2025.05.16.07.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 07:43:25 -0700 (PDT)
Message-ID: <6cc5fdbc-5515-43f6-81ac-b8ab7cc99684@kernel.dk>
Date: Fri, 16 May 2025 08:43:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] blk-mq: move the DMA mapping code to a separate file
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20250513071433.836797-1-hch@lst.de>
 <20250516054236.GA13922@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250516054236.GA13922@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/25 11:42 PM, Christoph Hellwig wrote:
> Any comments? I was trying to get this out of the way before converting
> the metadata mapping to the iterator.

Code shuffle looks fine, the only thing that's a bit odd is moving the
code and adding the copy right. But it does look like you touched most
of that last, so looks fine. I'll get it applied.

-- 
Jens Axboe
