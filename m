Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3771C5D7E
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700970; cv=none; b=hzliLx9YwmcU1Zm5/sSIev+R+hthw6a/5nzJ1clLNBm2d3x2ToaMurpBUxBorF37lO1kKEst1DgdrUuRy3TAPJTjVl2tIoNMqxTk2IpRrrmiFq7cjRSxsGFtPsBo6KIXJj/P57ZwyhDWWlOZS30DFIf0HOdeJ4BddmZyJSbpIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700970; c=relaxed/simple;
	bh=szBVGBATHmAoxSvkaJnA2k09xrdAhYDfUBkWPhXAyTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RV6SH1GmwNytRhYspzVQIcxc8CQlmmJZqICoxNos5Y6imNa/liY1BKf5tw5vhckPmg4WF2zLPBw2H31FZyr7KlrFFo4qxa328ctm8+ynwYf2ymce0lnXgfZMHfPoRqirDPJOD0v26J4rWZQ4M1aYF2Mtg/3bJdV7Sr23QA4hI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MvFc3vCB; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MvFc3vCB"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85b44094782so90166139f.3
        for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741700967; x=1742305767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15FhpTy16DxiOxuCUjxYZ7HE8WR5eqNgpOkZavgiv/I=;
        b=MvFc3vCBO9+Dp4YPUJa+WSijgHfo/rPVZ1MvU8PX87VFiW3aSv5L1DcjDgX1/OoGFD
         /6XGm9ZL7xHBFxqhPH7KI7cK9/9rt/epgoHnm4qkjDHV4PholU8W8p5dti3vEUp7pJEu
         3uNhtNYatdE5wDIf7Wimb38B1D4EAbYJ4oUfWKUZ8dS/JH+yDXilnO6I4ZGok2H/6DtO
         wUoPxUM5N5Gmq56hxGVBRM5Mrjy9wCTqXonFGO5V5iXFLmOe/7YELEyzsRwRl2pcOjvw
         8lF5Ttfttn6ZIqxV/3TcVEedbUeo/tksl0Kxz77NKsiIVuyXcZqh6itGpWNf7kgI0WQE
         mdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700967; x=1742305767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15FhpTy16DxiOxuCUjxYZ7HE8WR5eqNgpOkZavgiv/I=;
        b=g9iwVmASdqkKfUgGsWCH5B1aVER2vJggKr+Xns14yz8s0pjxjqYyZu5k2QPXjzWd7x
         5KIh0hGDQgz7PlGYXpWeUnwXFuN3h1aOgrVF9h47pqWc0GY49gIytmDi99klF5SVNu68
         fnuoQpJa52/cyFzYTXz8Lxy57JI7R79sWuagwITUieBj97vIYF7HhFia9jl6K4S79iNd
         +2bjc8I4aOnj52c2u91v6lAfS8hMjhG9622EoFkYWa8gIES6R8GoEeXrUK6TPDzN4APv
         hwuB2SgOJjcLykEX6nN6NlvrtKLh9xu17wgCGWQjiBuq9LS1HBZSFO0JnNU4oBQHt7Pw
         h0pA==
X-Forwarded-Encrypted: i=1; AJvYcCUstvR7B0gIUwZWM03GSHm20G66RQARMukl0qs5Qs7R1VAX7odYQIUp7UD90YKOCYg9aXoGo1aFDfsvqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70IOBF4+VQz0ZjEdGrGUvE2OkIAo+3qfffF/Oj7VYZhHwfH0R
	yJtcIAKFBDlBv/Q+C1B0mq+j19Bk501UJ7WSU/g6SWasNhYQvk3CacDb5pIPAaA=
X-Gm-Gg: ASbGncvP2Y8FTryvOV4buJWbt2UyMl1B/7ivu8juUjWl+t0dY82N9a/JMsaHJCtXA78
	c5Z1wVBcJ1+/oaNRDPx7B0nINqmoKH/kKLMVoskhD2+lV3mA45phL+YbelksUADvnVf7+r5GEqe
	8xW07JbI9toE48Xi+OfIEu75BBwxnK046Hqft8aO5RQ6uftUuHKhoM5wyQ2xd+EemBELrWEDX9u
	PhQLx4Z28UiY1PDBWtRUSmo71wDBf1TmwKUxCUxYIH5wIjpCINhKd78rMRnzXLmWrIgDsZrNEk9
	9bNiRLUYjbADiWZfyKYtl0WW10xPaIubAAFZx6J8
X-Google-Smtp-Source: AGHT+IF9VOkMgxNVu1F60lVcFqCfcpKy9OE2LoUEIM37eUdSf+tjRuA17mWqs6+fEo7uJIQmp36ZSA==
X-Received: by 2002:a05:6e02:174b:b0:3d4:2a4e:1272 with SMTP id e9e14a558f8ab-3d441a46c62mr203305475ab.19.1741700967289;
        Tue, 11 Mar 2025 06:49:27 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2221c1d6dsm1925186173.95.2025.03.11.06.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:49:26 -0700 (PDT)
Message-ID: <3369329c-13ac-4b18-9923-1a24e1243035@kernel.dk>
Date: Tue, 11 Mar 2025 07:49:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] block: nvme: fix blktests nvme/039 failure
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alan Adamson <alan.adamson@oracle.com>
Cc: virtualization@lists.linux.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Sven Peter <sven@svenpeter.dev>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 4:43 AM, Shin'ichiro Kawasaki wrote:
> Commit 1f47ed294a2b ("block: cleanup and fix batch completion adding
> conditions") in the kernel tag v6.14-rc3 triggered blktests nvme/039
> failure [1].
> 
> The test case injects errors to the NVMe driver and confirms the errors
> are logged. The first half of the test checks it for non-passthrough
> requests, and the second half checks for passthrough requests. The
> commit made both halves fail.
> 
> This series addresses the test case failure. The first patch covers the
> passthrough requests, and the second patch covers the non-passthrough
> requests.

Looks good to me, and better than the quick fix-up for the problem.
Thanks for taking the time to do it right!

-- 
Jens Axboe

