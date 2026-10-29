Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271567;
	b=IazHwSULWCUaKhiFJb4lTdB9FWee9AUZEL/JeixPdQyx0TVASjUovnfOAv7h/MPg8G6Q
	 8zMAgxWnp9tB34aRRhkESfOy1bKtdKO0qx4AE2r0fqZ1drnivHnc+dJWo+8SgZ9JMg3fw
	 jj7EiOHMc3A1ST7SjYDK295imJ7+t4TRiDObz61n3KPiw/X1NDfavG+c56kkaUh8oVgek
	 utm51hL40/w3HDwnHQWmbhVT+iIV22/tqGvyQTFDEA72UIhwrRcGheP2afKKwVXyTYpjP
	 bZsaynNk9ZXzonpgA/MbJMhRjtByo1B/hZM9B2XdX/NiCzlR34+EJDEbSqYepbL8Eiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271567;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BjLzw1kM6LZTzUaUxJhqUTMufk3/F/G637drKyKaiJE=;
	b=Sl/fsJiHFKHxJIn998QB9vyAub5daSx0oYh39stqMe/pbWUlOdKOv6uLhlheBdBH3snf
	 7TfzZg+plg9KfcYzq3uKijqJisRm+wTTg5Noeaw7qT2cfRqjnpqDVDVwWlxRySxtU9LpV
	 TR0Ipj3OzCeO5Z+QgY37mW7z4r57NmcXB1BzVwp3DKQxYZHriM1h/uTj4pGsCIp6WMt+U
	 44VjmEtvO9hDqMAwFlVlWG+fm5LowFNePnZmERAZD8VirmqN+5YhHmlDqiv+CQElsquG6
	 mWwn5fyja2bVLWZ6CxzOqr1KhvoFMZ5/h9X5m2xFNCMmtxdcDqHVXXe8AmGP33I9ZOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="p/QONaBU";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50107606A31D
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 10:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50107606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p/QONaBU
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a4dc547987so9810075e9.0
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271566; x=1793876366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BjLzw1kM6LZTzUaUxJhqUTMufk3/F/G637drKyKaiJE=;
        b=p/QONaBUeuWz8ele7CgjVKq2RtfloFiauiV98PyQcOH/LZQH6jHOetr6yagJOYtMUl
         U1YtJGLhpSHmKRtFecnJbcTk54YPpHMUaqCMMFdyrVxBNn6EosuSX2WN/D5tNqtutHgk
         W9OsYWZQSpV/NKOSfCBOurFMr6wNFE+4CgRjaWrhI66qcpSQfxiVga0/CkWzGPI0cwx/
         yCucYOlC47cPL9VNX7PosOHYPolW8v5+1x9wkBF+bXv+pDpzZAChsjjB9MrcK9I6UEVD
         GXz+Ns6XSlqwvlwjqn3oaBCKeTht+Vk11lmzuYCghqfw8nILm3+AI86vOVzmK6p93dhA
         hYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271566; x=1793876366;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BjLzw1kM6LZTzUaUxJhqUTMufk3/F/G637drKyKaiJE=;
        b=caX/5LA4tzRkh9V2vsIexdpEXJXKartT1HpbSWxTCxFZ5pjw/l/YcjRh6Vv11KX0MR
         FT4KK1bpyNOuzS4u9LKKAWKUiMg7v4BVRgbwKPYQranlH060jqUEqRrCiTP3AhvJtNQ9
         lOcLJc4DnGw+9YeXn/WiiA8KdMKUtQE/aNB91IZLfhukYfxb/mO3pLrtu+pzHwnbOH8m
         L8A3hPdfF6lgH2jLZ5YQaTBlaJiSe8qMMLQPX7kSELOCa0SQkdSGIx1t2aijyQZOp00h
         Za1Bm0QdKmd6ddM9AjDSi1/U9q+/fK3HIGNSdZ+gKKXPXtZrxbfkUCAU8OPXmZUK5daN
         +L3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxlOxr9Vw+hem+MRcgK/LGWSz6dOTivnYdpa+gfrWVe6ZZkCY6V/A7acLKL07ZZgdb05z9suS9PcI5lZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJeZyQN5tIb3KE+dOoUUzlAGPCnPD8okxTMrw/UJouNkmyIo4bT
	RAhschaHMQZA+hDM5ipo2OI44V/eW+uG5YDJsZFQA2q5XjcBk1LElEoS
X-Gm-Gg: AYBFou1MFnkm/XWllqmEGjdD4PBnObTStrILV297KYoa4flhG9ULTnbMSCGDbC4nP6/
	PAZtkqJ1SSDjBhzSHRG0IuBVC6xDd2Gp7H+XavSjyRrHvxMlFG9betBNHnmZ0vs9JNHpXmMmlKW
	rRADaGweqRULIa6affseAGeWVILTQv3R65no4qkxTZScJUwotufe8HFJC3WaCKz77qMAol4yT+s
	X5KJPBjVOzTpCIRcqSEIXEkcSMulYLOCHiK+ZlMuwMLAo9vjOdiB2VIzaNx4MdxewvWxcabF/QL
	oc4D1cYR6fuUP43SWtlGlLGCYkf/oeaaAd2SvN/NHPOvyHi8z3hbtN16r0i1MK0hlrRsxlB1E1b
	7tbaRmJg8DkJ8+V99afAdFcTGc2Wvq717uZ6KVpK390xrlhHHkS8b0BvbIy5NYxE6tPo+lIHfzK
	Jyg2oyuvYzk5hd3aIj3wynDN2wZinhSm7omxo1y1a/hQ7DqkYWOVIAayYq8nkFphOs35zWHb/gg
	OOSX09YOxaRoBr779Gd57fgjxMAscJa+uMUaa1tzBXEDmnA5mVI0m5sNgvGzFXSsGlnmv34D4wB
	WYIICagtfEsS1Do5N13v8I7NQpZ82VYVa5UNDdR2Vh5qRf3WuaeswTJdJMlqgniHCQJv3Tjermp
	FZ0FNJXY8GJMFqU0qv3pfaXyORbXmJlEPXdCfhDR9HZFnWXF7BUjKH2SPJ3NbVd2QkCS0uruPJI
	N0dA==
X-Received: by 2002:a05:600c:4f89:b0:4a1:c6fd:4db0 with SMTP id 5b1f17b1804b1-4a966c41836mr125002085e9.19.1793271565710;
        Thu, 29 Oct 2026 03:59:25 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7ee575e2sm58301065e9.1.2026.10.29.03.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 03:59:25 -0700 (PDT)
Message-ID: <c4acc3b3-be8c-49c6-b1ec-b25431d28d8d@gmail.com>
Date: Thu, 29 Oct 2026 10:59:26 +0000
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] io_uring/uring_cmd: support dma-buf registered
 buffers
To: Anuj Gupta <anuj1072538@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
 mkp@kernel.org, bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
 <20261022144501.2478417-4-anuj1072538@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261022144501.2478417-4-anuj1072538@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 15:44, Anuj Gupta wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Let callers of io_uring_cmd_import_fixed() opt in to dma-buf registered
> buffers with IO_URING_CMD_IMPORT_DMABUF, and attach the current map on
> import.
> 
> The map has to be dropped at hardware completion rather than from
> task_work. Add io_uring_cmd_hw_done() for drivers to call from end_io,
> which drops the map and queues task_work, and warn if task_work is
> queued with a map still attached.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

