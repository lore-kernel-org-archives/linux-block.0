Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BB3A962A
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129006; cv=none; b=eJcxupz9imv8gxR9KBWCU/zQxyV6bsD4Kp4/S/RJ4aDTPclNtbDEkr+d9Lq3B4nrkxToLAwmvajqvZaBOSalSSSGOuP9TeqftxNm3pUomlLkI07/hsrMmNs+TOhej9BPAeVhtfIrnVt3wwL7FiFzYjbWZkREQTRD378LgT7bDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129006; c=relaxed/simple;
	bh=UvTKWk8LbeBFHcVCJKpU20JLBXsp+tnV9NPm1OGKUwo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jSg3HzTU8O0UP2O5mkvVy2gao5uhZFNMWZk1K3ilNb+whwONOgjo6CH7vVrRW8chdMkGKDkQW9paqCQnb+Kge5DfK6FD/oHdtFaHkf8CL/SWh6GKmUacOdDv++JxVdaHaAaT1wz00epJ+V3neaNuz8VJBenQoWlNEVy+B6qWOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2AAA94f; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2AAA94f"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so4645512f8f.2
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 06:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770129002; x=1770733802; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehtdN2dtUUyw8t9CF8LW9obJiHb6WlF1A+WpekGmvjk=;
        b=U2AAA94ffPnCSzAikW5yA04x32mT/4Lhm3A5+o+xOc+K9spDhUGDCYtDpZMmjdnAXE
         RUcBTopbhWNOiqj0kRzDHaQouvB0y2xIBtIlW+itwdPmB6joM5Qr8Fo2u0qCVQ8h5Ort
         gg6UXCJuwbbtLf3oVpiI5o3X2VKrKDdumySLRcRGnKXXhjvq+5c8fzN+zG7hspXfupij
         uclb7juGF9sSTyScKiXLjNsD7ZtJR6iIsczy0egNElhIHYjHZcCqw/MzC7TW91X44JGs
         b1S8bu4ljJtqOgYX7OPgldm/O4IF1ps0kyDR7QI/YfCBcY9JF70cKviIDLB2/y3Xs+b5
         9ChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129002; x=1770733802;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehtdN2dtUUyw8t9CF8LW9obJiHb6WlF1A+WpekGmvjk=;
        b=iiVzwJr556OBJCGKN5wfG6fExpaemLvHxnLjoHQ1EzXSGuCkWbGM9i/1byFb4ZuYqF
         PToTOzY4FN1u92R4frI5D3T/5fZEa6XSZxAT31CFF/geJCKj00McOvr+hIptn0fOEu8m
         sth5LT5CLkp7DZsItkghBeKtV2CrdA1nHHXzTj0l9/ujE2yI7LOM97NnKoba4jY/iyj1
         r0GzDOh8ysGE8cv3kG6tpwZi475SW8tu8My3Q2X/sDTn6afvYPIFA0rOcxj0v6M3VZvm
         mFeKrUKcUXOLxgiZ7Umx1kmOfAkKYmEnw7HE5i2LgFEIdtqw3lhhQphWTkY2pOo0gvQd
         m9FA==
X-Gm-Message-State: AOJu0YzmXUYOkT9Wmw7hrV07K39/bRRdACk7FJihEcGLy+KgPnaznffv
	01JwfSpNizJZQK7VxGUggiB3QGwUQ2mX/BrtObI3r6GOYKDnv2A2IRAhmCnoWA==
X-Gm-Gg: AZuq6aJcpVcejDNw+r8exlhNcwr8p6agRT1wtPlY+TJyOBk/VcP/YSZdt2sqxkEjDV+
	tbuCJwG6YgXsZQpL7/bvMeUKJRSBqhOEqqnzlgsyMXvSK2rSroOswVfiE3HBLyekbqfNu2LTkkk
	LKr3fz2/bhEmAGso0Hx6wVTNFu+/fEdsFe5iaCv9tCpKuvpPZSwUdKoQKL3l7IIUs0B/Qj3VjFZ
	XUlddV17sGJqkklcrsBE/OkNOVOo6zP3BmfTwFjEnpocxr8P7dXAL73oN2QbiBSXYovm3jbuY79
	1zcjhsTmEOZPjnbDar3K2kzqpmPku25YOOxUZi3zGrNSAp7vQQfYLFVuCLDRK6OzuTciQNseEvU
	uvLAmLlGkKww7wYLUosAL6PUtdt4WQLF51B9dJlMgOrqV+WFvNjlPhO9qekSV0nAHEWXqNDH1Qs
	Ev41MUhAvmAgJbY1iiCoQ58jbO+Vx/cNVDQ6N++KNjF4y7VCReSYAoBPOaGDq+rzmyFhv6eFEib
	98XQnVe5dysOd6DXyuiq0cREtoGr5MgZha3o4nhKVF124OxdoRL5upd17ShtI/iRRERpQuA81re
X-Received: by 2002:a5d:5f54:0:b0:435:95c9:6895 with SMTP id ffacd0b85a97d-435f3a72dd1mr22421934f8f.18.1770129002134;
        Tue, 03 Feb 2026 06:30:02 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322dc7sm52615095f8f.37.2026.02.03.06.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:30:01 -0800 (PST)
Message-ID: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
Date: Tue, 3 Feb 2026 14:29:55 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-block@vger.kernel.org
Cc: io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Gohad, Tushar" <tushar.gohad@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: [LSF/MM/BPF TOPIC] dmabuf backed read/write
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Good day everyone,

dma-buf is a powerful abstraction for managing buffers and DMA mappings,
and there is growing interest in extending it to the read/write path to
enable device-to-device transfers without bouncing data through system
memory. I was encouraged to submit it to LSF/MM/BPF as that might be
useful to mull over details and what capabilities and features people
may need.

The proposal consists of two parts. The first is a small in-kernel
framework that allows a dma-buf to be registered against a given file
and returns an object representing a DMA mapping. The actual mapping
creation is delegated to the target subsystem (e.g. NVMe). This
abstraction centralises request accounting, mapping management, dynamic
recreation, etc. The resulting mapping object is passed through the I/O
stack via a new iov_iter type.

As for the user API, a dma-buf is installed as an io_uring registered
buffer for a specific file. Once registered, the buffer can be used by
read / write io_uring requests as normal. io_uring will enforce that the
buffer is only used with "compatible files", which is for now restricted
to the target registration file, but will be expanded in the future.
Notably, io_uring is a consumer of the framework rather than a
dependency, and the infrastructure can be reused.

It took a couple of iterations on the list to get it to the current
design, v2 of the series can be looked up at [1], which implements the
infrastructure and initial wiring for NVMe. It slightly diverges from
the description above, as some of the framework bits are block specific,
and I'll be working on refining that and simplifying some of the
interfaces for v3. A good chunk of block handling is based on prior work
from Keith that was pre DMA mapping buffers [2].

Tushar was helping and mention he got good numbers for P2P transfers
compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
previously reported encouraging results for system memory backed
dma-buf for optimising IOMMU overhead, quoting Anuj:

- STRICT: before = 570 KIOPS, after = 5.01 MIOPS
- LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
- PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

[1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gmail.com/
[2] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/
-- 
Pavel Begunkov

