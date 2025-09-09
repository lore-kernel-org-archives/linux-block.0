Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2B134F47E
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428652; cv=none; b=UkqxSzGdZDVvX+bO/jlemnKJmRRYBGKGLClARfYruKXHvknd6yYBPjxrK496G1bJ4nE+C5WIST1TFqFHQaAQp81YNqODnyFgN7Stg67LRXj81SVOJ1SChVvZKs3n1ujlkNK8W/uBQXDUp3rMB1xm8kSWtbtzChPCFQItjRvV1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428652; c=relaxed/simple;
	bh=FLvfa7fq92v+sqqn62k81V/o5eNgNqP5wcAxdiLtk/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YD3WYson8pSiUyeee80X4lqVbX5pHVKOswcVvc4yq3rnzRTkH29kWXjzV0diXRbDA9AXXZi6nhABcIjcY11HYvqEa9pZ0HUncwvmXNOTvzv0Nw7hsMll29s/3NLl3F12arFzEgKVvM7RnF2Nx5d/iDgYaEXxAFCOEQGVNg1MHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uMSbsfVL; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uMSbsfVL"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-40b035b23c6so9585055ab.2
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 07:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757428649; x=1758033449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJnzswevlDUuq/OfoxD0pVudGLoTsCpDMKvJC+rT6Cg=;
        b=uMSbsfVLIICn9znjJfaJzX0EzI9htlDDlvRX+uXbaSpQjgcfX1TG4lJgO4PLITIrpo
         pMLon5sn5DYWkRWHWLkJhskWwKSGklfeQOuQAP++62MRXfUpPjkNWZVEy5qNLDcJfZZh
         R7oNxauWVw+rlIDhJu7vGa+oITK9XoWuiYLCRDcfQOegAYvy2z3c3WNk20L6wqoT/ofg
         yuLMogVaeSnK8F1ValpoPBDhno2wnwAJA1VfIsznZhO7gjZQ4US6EjhiiGeLvXSsXxtN
         Wxim49H8gM81f3Fte3cFNFbNXhTYdLwh+2aMrDIz1uCuaiTVp15oPqxaCeoRF/fJS66R
         d8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428649; x=1758033449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJnzswevlDUuq/OfoxD0pVudGLoTsCpDMKvJC+rT6Cg=;
        b=wJj3nQoORNaEqyTjUPUxppJr2yTbkrHNb+OsnVZvbsFz1SExX7kzzWgAuePF6YyMHq
         kOnKkcNYP7KY3LZkm1la5l/w4NDQUv1hKfSBbcPjtpDtqAn2RVtXOjV484xphT+Q42f1
         EtUybzOTWdV0PmzZ8eTpae5evh57axOTCdp//O43cV6t3kFTA8u6JfWMqMKRDA5yJbCT
         YOwYbCqfwz4bGOs031g5z7mpCPGTcB8VG/gNkdKJHGM7dOd+NTCohOx4bE0Qzk5izsLJ
         qOKiCa1ccE51nqEd7/+WwTH5imuFCJVjhCHtwRaRnicGlyWA6qZ2bwY9YA2OPgIz8tan
         rE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+Yx/0iNf5Ya18zhGI9J87k7k6OrazUrGzCI6vE3UvpoAYxiNwguJ99W0ca+GjhCEy7I9yN9Jm9n4Qig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHUYhcaksF69K3pr6KHNC3uXV2v8pkodZu2yWRmTlEJUY6C6X
	EsERLwOoYN3zgAKaIlX/rnzKzTvYhVlvIZz68XnDCejNWpVYqcVNJ+NVJgcP7LbZBkE=
X-Gm-Gg: ASbGncvdpxA2DHeayS6nMWhZKNN98ykM9pOIy9mYJ0QJeJ1lbi8zmjbTQ6R/2kU4moZ
	vcjlIpAGIXxceKT1wXWC1Rt9ygqqwdqU2Xd8Qr0KJy2RnsoMeMksH2K8fuXypvfQeBc+vcpCjKj
	aOA38U7d6/yk7TZ7HAcP6JuXYd5x4wwhFH53CTQohnOxY+gv1YoqAGVLy3Ue5YE2mXNR6Umkmgb
	5cCBGinueIoFvzoiA4ZeCon5G+loKwHYKCD8wH84CBXMl5hp7Gb8bzT6/NLsbbkRbUm0r5okqoT
	iN1zkJqolRSGe4HqHmWNNMQJtILeLMsCmK2CDTLYOwGEYbweuufa5CaeBi/4GS+Vc/5TL7r4zHS
	aD6W6R/bWnnRyUP20P5QHKJrXEgJSYw==
X-Google-Smtp-Source: AGHT+IFFRSb/tnom+YwXf9uhxtCm5e69yWnLr+MwUSsv+r9w/hXHhYam53Z1HpV1oSqQ0qe9EVHAew==
X-Received: by 2002:a05:6e02:1a63:b0:414:cb8e:a801 with SMTP id e9e14a558f8ab-414cb8ebdffmr10529905ab.29.1757428648340;
        Tue, 09 Sep 2025 07:37:28 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ece96399csm9130641173.20.2025.09.09.07.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 07:37:27 -0700 (PDT)
Message-ID: <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
Date: Tue, 9 Sep 2025 08:37:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: Eric Dumazet <edumazet@google.com>, "Richard W.M. Jones"
 <rjones@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
 Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 linux-block@vger.kernel.org, nbd@other.debian.org
References: <20250909132243.1327024-1-edumazet@google.com>
 <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/25 8:35 AM, Eric Dumazet wrote:
> On Tue, Sep 9, 2025 at 7:04 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Tue, Sep 9, 2025 at 6:32 AM Richard W.M. Jones <rjones@redhat.com> wrote:
>>>
>>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
>>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
>>>>
>>>> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
>>>> made sure the socket supported a shutdown() method.
>>>>
>>>> Explicitely accept TCP and UNIX stream sockets.
>>>
>>> I'm not clear what the actual problem is, but I will say that libnbd &
>>> nbdkit (which are another NBD client & server, interoperable with the
>>> kernel) we support and use NBD over vsock[1].  And we could support
>>> NBD over pretty much any stream socket (Infiniband?) [2].
>>>
>>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
>>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
>>> [2] https://libguestfs.org/nbd_connect_socket.3.html
>>>
>>> TCP and Unix domain sockets are by far the most widely used, but I
>>> don't think it's fair to exclude other socket types.
>>
>> If we have known and supported socket types, please send a patch to add them.
>>
>> I asked the question last week and got nothing about vsock or other types.
>>
>> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com/
>>
>> For sure, we do not want datagram sockets, RAW, netlink, and many others.
> 
> BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL being used
> in net/vmw_vsock/virtio_transport.c
> 
> So you will have to fix this.

Rather than play whack-a-mole with this, would it make sense to mark as
socket as "writeback/reclaim" safe and base the nbd decision on that rather
than attempt to maintain some allow/deny list of sockets?

-- 
Jens Axboe

