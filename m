Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050466;
	b=C16H4tEKTJuhiunkiqjbWkx4GxFk5k+VQo/8yOswddSWqlDwj6pdrAs7i/miMWhbJFZC
	 fNiJ0QpzZUKibXMfFJyOR9U5yeps05GqrTs1iQeSy3n3bKqZbPLga3p5NTcXpy2KLUNLL
	 4huLe/gcC4242ZOcNa6DIW/65XR6/BFPhxPaNx0czZuj4ltA+JQQPKlu/URWGaEo76LyK
	 ion5C5YGhFiXFVsoaJcpgdGvjPQcKrQjn8KMJHh34k9QXZQHRmOBYDJEYJRqsHwCKC/Ck
	 +In0JJypXZhrY0fVeyacah8OK5ZHOJJKmHMPzjdo8een1VK2OFRULOHerbYh02/5goQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050466;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HINsME+iXYJtTjFPv+yuivxQq/X+Lpd6mIVAkSLmihQ=;
	b=WBkG39D5OoHPdRzSh9s3mtucmytERFA5PounZliB4iauwgBc8mK1CcQ//AnUFCLzmYx2
	 uvplTYjVnIAiyKxfnV33JNYbo9NqU9dX2aXYLtQ4E6J0d6SGGBWnnwUePdpLK3MgKJQg4
	 j771F3SQiBBvIFdd/9xXepqt2GBXbNiANGXzqTd6Q3/LGZ5Y4rW2T9erBM3COOdeQBQxI
	 PQE5zgiGPt+UyXWXQIRV4jPwKaLFl7soMVp2XKRfQxN9PjxDxyoHC0+JFyfCLedxWE3Ou
	 v+u6Dl2082zGeMBMYMbKu27L67vLyUcbkH7kKRavLRelLjEFAa9VRSx08XT7sQF5P2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XiHBymb7;
	arc=none smtp.remote-ip=95.215.58.87
Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E6606A320
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 01:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 485E6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XiHBymb7
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ev8iubwzB9gJIKDmBRQcGMapM70UHKFSQ4HST5j9XkA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795050463; v=1; x=1795655263;
 b=XiHBymb7+evCbuL7RUwbRiwejYVNNR/hnchCub46hbyquGO1xF1WwAxEgQrPYc26MeSRbJsn
 XO4ROre2E0r2Ueutg624X66Idae8Z/W6LPL1rdxgocOGFtoyp+r8tvjyRSIUxqbko3WpJeN3r4d
 fE+7lKT6EE2zXxWOXOcibNik=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 03252fbf95683bbe;
	Thu, 19 Nov 2026 01:07:43 +0000
X-Mizu-Trace-ID: 03252fbf95683bbe
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Qiliang Yuan <qiliang.yuan@linux.dev>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/2] block: make changing to the current I/O scheduler cheap again
Date: Wed, 18 Nov 2026 20:07:33 -0500
Message-ID: <20261119010733.7312-1-qiliang.yuan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179501805754.17649.16701221943802051712.b4-ty@b4>
References: <20261114-bug-block-elevator-unchanged-v2-0-5a1fe7d72fa0@linux.dev> <179501805754.17649.16701221943802051712.b4-ty@b4>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Nov 2026 09:07:37 -0700, Jens Axboe wrote:
> Applied, thanks!
>
[...]
> [2/2] block: return early when the elevator doesn't change
>       commit: 375a88c6176ffe05e521c2df31b1ceaf4ae5fbaf

This one went in from v2, whose Fixes tag Christoph pointed out was
wrong. v3 changed it to the commit that added the freeze, with the code
unchanged:

Fixes: af2814149883e ("block: freeze the queue in queue_attr_store")

Could you update it in for-next?

v3: https://lore.kernel.org/r/20261116-bug-block-elevator-unchanged-v3-2-cb4dda2dadf4@linux.dev

Thanks,
Qiliang
