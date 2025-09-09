Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1C343D9E
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430577; cv=none; b=IeyEVBwsBf9ZJ20+AVZ+UwRwedJCuq3Oi7kfl4dLK1rlP6Esq/u+qr17Yr7vMUB1lWcXNfGP9Yr4vEq1PUX4PhSKkKf7hXLYduBNKljplWIFOSjg6XWDvT25IizVI0ht1XlD422Uq3t7o+xMfGjNJPOPjbe91Pty1tHdJoBSeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430577; c=relaxed/simple;
	bh=G+q6VqDJLdzvmfgD7q0CGOEn2+Nfgn9RD17Iuc+VVi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPa7conCbs8iOXDFHny+U06CFMhTPTdkOZXZvs4haNYjccDCLJjfdnwfRNXK+j+0nl5TF2nuux2yB1w9ukl7kw8HEAzc9InwfRk3ZFiSOcyuVIa8CLji8LlIzI/QbN2XQ9ME5maULpWC4jrctOFkjNtV2de8tlTnYy/S1xnXWZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gEsZQx7f; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gEsZQx7f"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-410c884decfso9363635ab.2
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757430574; x=1758035374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBkHzWz2WSvAv3P+4fdRCtFI9r1yFcrUi6CJvq5A8BM=;
        b=gEsZQx7fFDPkJK6aZ1I0lahZmlTwQhO7hJeLSYqfOUsvLY34FLelVHfp4Jz33GM+DY
         j/kP3Y/MzgbWd6zo/E7bZM24pBwzMquyNxtkgcW1QXdzpij6oaBgIOYVGIUUZ1faA2fZ
         QoMiUrOE96g/7QgRt8cEQSvOSFqPHcz1TujNnWFkRRPyqdQj/exqViTeAF0TNxbsGTzy
         bQYlYkKHWE3WRdOspxSRmKKxpUVzcaUHugEMWxWpaCAbWFCOrDYi9OJF3t3Y9v7+1xTg
         VJYb5smNZeMhae/zIVBz2Y4kV3tx7fDnGd2RgjqtZVeA5+il7f46Vo9Q202F//hwDEXQ
         5NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430574; x=1758035374;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBkHzWz2WSvAv3P+4fdRCtFI9r1yFcrUi6CJvq5A8BM=;
        b=LNjenjU0Am1ZwSO/RlSqzKR/02wAaG+fFfd+a4JqTRYz2+7b1WY5lU47pZVWWedRok
         kvkkDT5YJaT1tdBJIJ7YfmLU9jhB/B1BxethAeoqq90eJHLOhFBcUx+ZPqyG2BiliMqX
         2U0rcBnRmkkolJxfjPRLOcAZHXPhF7FE6qg0AZT8w4vEfdU6GYrMON5SrRijYZwv5Ddt
         V4zJ13w83jGLfc0Y4MO5V6N0jBTOsf55DEYreh0DQJS5teSeGm2C1ZeJSH2cfOHpwpf1
         S3kbLpAUmlSxlCKt70yv4fmBa5LUY3mH0h0kqNnmBUgk9q+fxzRKlsd6cguqbNVUJrOL
         MFcg==
X-Forwarded-Encrypted: i=1; AJvYcCUmu/+Fo80MVOl5q3OkgawkBMQRosqr6D/Yud7FB6WsHkrYOXegsKUVQONv6HiH34D148fbE7hcqWjyzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwogNbUiNorz7ZOA/3HJYCwjtQOuIG+dSXVuhheTSkqsx6DM4v9
	4zvJvHjbXpWkh94dI+Mh2SEQo9+2GoXwRyrRh7/ecUTS9BO6+n2QF9Y4D4ydJ6axwkc=
X-Gm-Gg: ASbGncueknADPKFP2eV9r/tLeqxUJO5GiRrI5EAe7XuDySARCLGbUWUIXpQNOT8ti5l
	sQwXu2fihwt5R6MMkAIe4dl9BZvymJ/N2WWSck91pr5GfZZy7HKrIs19pjvULM4bxVgls/qskGI
	2JZGicGBAS4//NEP41PqPjIvNXy83kwL+EXfMFDfyscTNCd5TvCtVaCCRJEEyp0HyUelpIxieb1
	zgv5JTEZlr68m3KrrGv403eAmmPVr4/4q01PMmWrwhcxqRkOU3ZiRUwCOFSI6FAoJvhnKOYvLrI
	zLWxdB7eZ/YpSXSkuvlUHI58h4CnU1N8/LzrIpVzcTzflDB2sG/KdAl7jzHh5vWRuLA4b1Z4Jb6
	da1r6+yCCjBhtgggisoehLkKFzA/ODg==
X-Google-Smtp-Source: AGHT+IEaLNl8zaGVmv/a45LKfh9YWrlicYBfVn4ysOSEgq8X+b4uOPf1vxmee+GBDunypTo5Eyf8Ug==
X-Received: by 2002:a05:6e02:1d99:b0:3fd:5836:2318 with SMTP id e9e14a558f8ab-3fd8e98d323mr176147975ab.11.1757430573191;
        Tue, 09 Sep 2025 08:09:33 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-403952954dasm31357415ab.26.2025.09.09.08.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 08:09:32 -0700 (PDT)
Message-ID: <e1161184-e2fa-49eb-8093-0b754dc362c1@kernel.dk>
Date: Tue, 9 Sep 2025 09:09:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: Eric Dumazet <edumazet@google.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
 Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org, nbd@other.debian.org
References: <20250909132243.1327024-1-edumazet@google.com>
 <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
 <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
 <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 8:47 AM, Eric Dumazet wrote:
> On Tue, Sep 9, 2025 at 7:37?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/9/25 8:35 AM, Eric Dumazet wrote:
>>> On Tue, Sep 9, 2025 at 7:04?AM Eric Dumazet <edumazet@google.com> wrote:
>>>>
>>>> On Tue, Sep 9, 2025 at 6:32?AM Richard W.M. Jones <rjones@redhat.com> wrote:
>>>>>
>>>>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
>>>>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
>>>>>>
>>>>>> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
>>>>>> made sure the socket supported a shutdown() method.
>>>>>>
>>>>>> Explicitely accept TCP and UNIX stream sockets.
>>>>>
>>>>> I'm not clear what the actual problem is, but I will say that libnbd &
>>>>> nbdkit (which are another NBD client & server, interoperable with the
>>>>> kernel) we support and use NBD over vsock[1].  And we could support
>>>>> NBD over pretty much any stream socket (Infiniband?) [2].
>>>>>
>>>>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
>>>>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
>>>>> [2] https://libguestfs.org/nbd_connect_socket.3.html
>>>>>
>>>>> TCP and Unix domain sockets are by far the most widely used, but I
>>>>> don't think it's fair to exclude other socket types.
>>>>
>>>> If we have known and supported socket types, please send a patch to add them.
>>>>
>>>> I asked the question last week and got nothing about vsock or other types.
>>>>
>>>> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com/
>>>>
>>>> For sure, we do not want datagram sockets, RAW, netlink, and many others.
>>>
>>> BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL being used
>>> in net/vmw_vsock/virtio_transport.c
>>>
>>> So you will have to fix this.
>>
>> Rather than play whack-a-mole with this, would it make sense to mark as
>> socket as "writeback/reclaim" safe and base the nbd decision on that rather
>> than attempt to maintain some allow/deny list of sockets?
> 
> Even if a socket type was writeback/reclaim safe, probably NBD would
> not support arbitrary socket type, like netlink, af_packet, or
> af_netrom.
> 
> An allow list seems safer to me, with commits with a clear owner.
> 
> If future syzbot reports are triggered, the bisection will point to
> these commits.

That's fine too, either approach will result in fixups, at the end of
the day. And followup related fixes to solve issues with socket types
that we do deem useful, like the vsock one you already found.

-- 
Jens Axboe
