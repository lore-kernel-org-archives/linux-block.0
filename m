Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A652340280
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886886; cv=pass; b=TPlh+FxwR3Y8XpAKLRQTNvayLbRW7W2SHQple0TEzuix9aazjKhk2LoFC2gGrakeiYlA/XfPAAStVY51UK8WaR79o3G0Eit6RX1eSIOnjdd6HMChxaLtdyMBsW/XW9Rf2098QGNNk+El3VA6WteHpXRhz1znmu44ThKjtKHPjMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886886; c=relaxed/simple;
	bh=/tP8QJO4XxFer8R9zOr01Ws0DEPyPjyl7D6kzr/3/pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8wTdRGGF4/GDLIsvi3UyTB7S4dvBeQSGWz6YtW9xhY7nUpPpIX9mly36hq4MLvkhuW82OpUCMo/+fipEuCwFDOzslz2DhlXnrTRSi5+Hyaq1Fn90JZZBicWqXUuKj9Ro/Jf65FIf8iUe8QDcBgDnAEA0rRcFE/mU+geXgZ7cWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eE2ImoC9; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eE2ImoC9"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5fe086fb0baso2530617137.3
        for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 14:48:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771886884; cv=none;
        d=google.com; s=arc-20240605;
        b=X1Nd08/Mt6eu2rGa/bZUdZda5ej5i6tdY0mmYHJxi4mP4hNOn0FswXKKU1sHQe8xmg
         OCgLFrzUOQqCnSkKLcdd8TcXPbQq7EdDKj2MeCpx36e+/2BRTKznWRr1sipnEhmqIxhS
         top2XTEMoAcKU5melmCLNDrdDeSZaO+VjawlqnFojRgtLrJ7Au8FSfktPP0+nzOg7zXP
         iKMI2M66nhwgU97gwSRu+w5Xnde4TpLm7/OGGvvXM+vu01NwzhPx0N8S7NMVDsYsV1pr
         uG1JiOMqw67dM5P3ZKsiCdIPjTVLIP5eCZ2OZZ2e7xwxNsBbQbpjpkiC1+EI69oJKu7E
         JNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iBuYoOSJY9Hyc0i9ySfF9Zvb8e5aaVAM96Gdf7QaP3M=;
        fh=voomqqKWNUL73tNUdSQjRLLEb1Ca9n0alrZr5x1I3ZM=;
        b=fgGbFruKY0sKVgnoGhhF0yedz1QnN2SMev4W8skIcLRw/j+gT7JU/Oi6WjpxfJD3U3
         ibACpm3KsRSNGdmQ7nbiSLIf8jBW3iwV2kmX0dUyzu9WnKHhleGxn0zzs+QiHXpl69px
         aQ/uP1gdkMMj1EUacmCc0Vklr4wAzh5NeJN1oa8E1CgmO3i9iJl6MTNdjvbvQA65sMix
         cI7LW9LIFdpycBx6u+9gKhZmu+9ss0tLEQghZgJRY99EX5waNEjm/zN/KS6Hrsdp3eAy
         DJi1lbk0f9g/dwLcDO2YGuVSR8WpDQ4fmLGAxrylCrVgV8ezrs1vG3SHARqciGsb+Hw8
         mm7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771886884; x=1772491684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBuYoOSJY9Hyc0i9ySfF9Zvb8e5aaVAM96Gdf7QaP3M=;
        b=eE2ImoC91Kq97U9UOVOUbBFj+6Jz3TS6nT6kda3Pu7ebRGT005IKnIBYbtqPkshAwb
         1EQpbO4PULMKUg8nHQhlJt4Sza1VGT53fV13gCg7nU08KcmfUJVE6ubmr8aKsgdgs0e5
         H56uH7FgDzBY1quqnfMfPQBz4d89nDxJrp6Plm4yqdgm0rqrcY8dtHP428/rhjEVPUgn
         D84aCztOmOFlYHk3V3ehejR+3m4zoiw5I4sdxeYKSOctOOQcTMDIzimr55Rtr0AdQjr/
         9zp4WNvzh2qXgARws2WB3cDnMXIrTtfK6zGvCDmqZRIKPp1DmnjI5tV2D1GicN2vmGPp
         010w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886884; x=1772491684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBuYoOSJY9Hyc0i9ySfF9Zvb8e5aaVAM96Gdf7QaP3M=;
        b=SSYopoNikBYPyq5/yoKUJhiQxtXVsIjLk3odNNXUNYHw4LmULVEF/ZeQnAGdnGv+Xh
         kiTO6lgEUPwD7l/Wu0bT7u8voy46Rg5kj5iVch2yuw6Ry7LARuixNxqcTYrAwS62Dy4f
         OhnCoEanJTG10WLr9rJMM+pgES+43UU6/PWo0Q0RCaYRduAdE5e+wRNPmUIMjN858jFR
         rj+VBFCFOoOhswmpzidT3h2w65fF0FCAK+XE5Iern7g1shmgbCa3jST/cs7d0uZNWqOY
         /MtGNBgyJw7diDkAqRhVHyLBQv+La+d0KfR5+f3coU0pXIu0U1GixpRuTYpFlQIrimBi
         RBCA==
X-Forwarded-Encrypted: i=1; AJvYcCXluPbNzN72f+PxmeEUGSiZCXfNMBHzkqmEQnF+Ab3KgkOuwP2lSAExD1L68vDZYp9sm7uadoc8tR+U1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcBsEVDzEZ+pEl/ZGqt8Ypl79Ioj2Lq8mD7lV2D4fesSaWjWVJ
	wDon/zx8NgofYU7bOLVdrwG41b6MUiZKeqVBv/waIJ7ONqIeG3K3XHzJxX6vj1RQ/7QALfB7k5I
	2lLYrVXwA5QEifNT2AeRIWeKdXB9uJ3/hNAZBB3M=
X-Gm-Gg: ATEYQzyCmZwpAu7yuj1AEzHtloUfHIJXWecy7NPFBKfGnkOEUWNdgHNPfKeO1ZbdQ9r
	WCbVrgwJfGmZ7Rd12rAIkhYqm5+zwHnZrMxYVtW4fKUlur+rtaxQ7/dIDCloD46NtRr/aHVixt6
	v59L91iTtSlHPQCIWSRg4NARLljJc79be5wgz48btoqGqnXzq0xUiLJUJfQJ09I49aEc7RWVzpr
	Gq53x7decywP+eHeQ+9AxnenBKS4AT07QizBUemgogzTtf2aWo8hSrLhNPFmuGjvus5Z9d4dupg
	T+3ORMqxp95uuAVb7WdYgqpSDUSFB2OG4ElhahKZ0kZKPFOL8DfMhuACLEPoB9wrWjYRgw==
X-Received: by 2002:a05:6102:d86:b0:5f5:773e:a555 with SMTP id
 ada2fe7eead31-5feb307aab2mr5001150137.20.1771886883735; Mon, 23 Feb 2026
 14:48:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219004940.2594201-1-morbo@google.com> <9b7a107e-bc07-4a75-86b0-2685d4c78bb9@flourine.local>
 <CAGG=3QXcA7et9LmZ+Cu8zn1yBXrPizL7BhYFvfFZpWA7aUR3xw@mail.gmail.com> <e3c0a209-56f7-4ac2-b089-e0600672cf25@flourine.local>
In-Reply-To: <e3c0a209-56f7-4ac2-b089-e0600672cf25@flourine.local>
From: Bill Wendling <morbo@google.com>
Date: Mon, 23 Feb 2026 14:47:47 -0800
X-Gm-Features: AaiRm536ShiNzQuj0N9eZEOEHstb8GfCVlxXtBScqQiEynlSyJYcJqZNezOrc7Q
Message-ID: <CAGG=3QVHKmZzL=C808qnigYDC1jiNSdwCODYdU6_2_yXSLAaSQ@mail.gmail.com>
Subject: Re: [PATCH] blkdev: Annotate struct request_queue with __counted_by_ptr
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Kees Cook <kees@kernel.org>, Gogul Balakrishnan <bgogul@google.com>, 
	Arman Hasanzadeh <armanihm@google.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 9:24=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> On Thu, Feb 19, 2026 at 09:02:12AM -0800, Bill Wendling wrote:
> > It's normally fine to change the queue count just as long as either
> > (1) the pointer to the queues is also reallocated, or (2) the count
> > never goes over the original allocated value. (The second one is more
> > difficult to check, of course.) The bounds safety features that Apple
> > developed, and which are slowly being sent upstream, enforces (1).
> >
> > I'll run the other tests, but I'm not familiar with the blktests (I
> > downloaded them but haven't looked too deeply into them). Do you have
> > some pointers on how to run them with a newly built kernel?
>
> blktests has feature detection and every tests figures out, if it can
> run or not. It will print some info when it's not possible.
>
> The block test suite has at least a couple related tests:
>
> ./check block/029 block/040
>
> This suite wants null_blk driver.
>
> And for nvme/048 the fabrics parts needs to be used:
>
>   NVMET_TRTYPES=3D"tcp" ./check nvme/048
>
> and the nvme-fabrics part nvme-tcp and nvmet-tcp.
>
> If you need the exact config option I can compile you a list.
>
Okay. I successfully ran the tests you indicated above and they passed.

-bw
