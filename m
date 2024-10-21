Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA921CBEB6
	for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533263; cv=none; b=r/9CyDW4ylU3mka9zKbXeT1AQBoPZOoL571+bx6kXE9X9lbyGWNU4BuA1vv/qSLoNyfGerWVTawMCuJ19VwQOBokp/6haNM8sjNQgUfRIJOQO9Vtfc9SCDUqEJhvZUwSkSakZ/xWJa5SnyhSa8S5DaTaDd3/7FhwgQvf1vPTsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533263; c=relaxed/simple;
	bh=tZdRz1xucUTZO9ZYxqFDmlhFq1aqXmo/ZcpsK0FkmU4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E7rUxKLpc7sJ43a0gTg+OB9ahpvDjU9pDX1UE54VgjdZS+IfEUl2YCoovWOGnkn0IZ44Vzso+2HzADsB5jp5W16lEoRg+o2iqx4Zwi8gS5fpefrp0FnJPNmIok0ZCfC+Qn4s38osqe73D+ipPnQdOzJmV3AnGPAqbNN+raRQAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh55OoFN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh55OoFN"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so1748239f8f.2
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2024 10:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729533259; x=1730138059; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22rD7DD/GRO7+PSceXgmf0Mw6HnthvFB+SlEuISWwXk=;
        b=Rh55OoFN47hipWvL3cgmGH7SnVS5EKflJAaPT9Kc19RWXxgYc5WEm0Fg1480R0BEKw
         qtz0ngcRE3kmIAmTloN7YezsU/QtYWP1E39wMMIjHXzknOcOnu2q9yf41Z8oPey1yYzZ
         k1uU7fKNx3qTVsBqWTh4fNhXJh1qi/Wi35vSN/o7bNPGdVB4HJsaOLT8t4dmn8d0Jguu
         zVFJ7ZWCQ5bm+VepZb52WR92E+bXqmzADS795PvGExJ1prDW0gvQD7+gFLNAv6cuGUmv
         otefkPpADUAHNUFMtErIXQISpsACuaPirzpA9eTd0662t9FD6UEQTB/dHT+MKbkN87Bb
         a/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729533259; x=1730138059;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22rD7DD/GRO7+PSceXgmf0Mw6HnthvFB+SlEuISWwXk=;
        b=uEHezH7k8O/mAB+Bnglqt5NdwhRuZoZ3vpmGVw06cp8POKufpfvFRDL0XG6UQTLpb5
         6tjYfQyeN4jWjFLHBhNkichhR8jB5sxCsZNswyKYRzJ6zxDJcOQwzPsES3lrSMVRn81O
         TcMV9O9S5jfIaJbkwVBtIBfYiPzKo+8mSCi1ht8PXthhTxH3MMhsI1H69ZmcE8j97yQ7
         hHPcFCNUe5udDaRL0Wdg40oPelGooxulzPZxHrFG42IoDYveZ1x6JFIMCfg6Xx+7l7LS
         +3hB8fiNj9B/UEPeHHT4sAtdgWe+FFZN/6CAqIYlI8AaQgXQODhANeIY78MqxhLsSjIM
         Ti4g==
X-Forwarded-Encrypted: i=1; AJvYcCUyC2a7nzoO75VvkJyJn10yqpfkqgGpCp75mkVOclibLjc+mnFNhBN0/6BMJO66fgpfaj3ZljGCnDSZcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFi8JpEyI74QUhNt+yqGkC6pIlfUl7HnH8Lj2PdoDiL3twSWbv
	ePkp7JrEUS85PSxJu8BaLvDwZG9udwrRVQqCEqUkck1lr3b9EE4c5miR0Q==
X-Google-Smtp-Source: AGHT+IEoWA47hLnYWB+2HPrPK8DAOdm6v6mSqKieB64FSWQYiZdt35wvIJ2iqTAvwsdu4vBhWdQRug==
X-Received: by 2002:adf:f34e:0:b0:37d:94d6:5e20 with SMTP id ffacd0b85a97d-37ef213260bmr8228f8f.4.1729533259265;
        Mon, 21 Oct 2024 10:54:19 -0700 (PDT)
Received: from [10.14.0.2] ([217.146.83.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94066sm4850721f8f.71.2024.10.21.10.54.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2024 10:54:18 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: UNSUBSCRIBE
From: Simon Fernandez <fernandez.simon@gmail.com>
In-Reply-To: <Zw8i6-DVDsLk3sq9@fedora>
Date: Mon, 21 Oct 2024 18:54:16 +0100
Cc: Kevin Wolf <kwolf@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>,
 axboe@kernel.dk,
 linux-block@vger.kernel.org,
 nbd@other.debian.org,
 eblake@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A16BADF4-B587-40B4-8C5B-1DB67E6FAC58@gmail.com>
References: <Zw5CNDIde6xkq_Sf@redhat.com>
 <CAFj5m9LXwcH7vc2Fk_i+VhfUA+tevzhciJzKc1am49y_5jgC2Q@mail.gmail.com>
 <Zw5b1mwk3aG01NTg@fedora>
 <CAFj5m9+x+tiAAKj3dX_WcFczkdSNaR6nguDHm9FXuYjQHd8YcA@mail.gmail.com>
 <Zw5nMQoPrSIq9axl@fedora> <Zw6S6RoKWzUnNVpu@redhat.com>
 <Zw8i6-DVDsLk3sq9@fedora>
To: Ming Lei <ming.lei@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.7)



> On 16 Oct 2024, at 03:20, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Tue, Oct 15, 2024 at 06:06:01PM +0200, Kevin Wolf wrote:
>> Am 15.10.2024 um 14:59 hat Ming Lei geschrieben:
>>> On Tue, Oct 15, 2024 at 08:15:17PM +0800, Ming Lei wrote:
>>>> On Tue, Oct 15, 2024 at 8:11=E2=80=AFPM Ming Lei =
<ming.lei@redhat.com> wrote:
>>>>>=20
>>>>> On Tue, Oct 15, 2024 at 08:01:43PM +0800, Ming Lei wrote:
>>>>>> On Tue, Oct 15, 2024 at 6:22=E2=80=AFPM Kevin Wolf =
<kwolf@redhat.com> wrote:
>>>>>>>=20
>>>>>>> Hi all,
>>>>>>>=20
>>>>>>> the other day I was running some benchmarks to compare different =
QEMU
>>>>>>> block exports, and one of the scenarios I was interested in was
>>>>>>> exporting NBD from qemu-storage-daemon over a unix socket and =
attaching
>>>>>>> it as a block device using the kernel NBD client. I would then =
run a VM
>>>>>>> on top of it and fio inside of it.
>>>>>>>=20
>>>>>>> Unfortunately, I couldn't get any numbers because the connection =
always
>>>>>>> aborted with messages like "Double reply on req ..." or =
"Unexpected
>>>>>>> reply ..." in the host kernel log.
>>>>>>>=20
>>>>>>> Yesterday I found some time to have a closer look why this is =
happening,
>>>>>>> and I think I have a rough understanding of what's going on now. =
Look at
>>>>>>> these trace events:
>>>>>>>=20
>>>>>>>        qemu-img-51025   [005] ..... 19503.285423: =
nbd_header_sent: nbd transport event: request 000000002df03708, handle =
0x0000150c0000005a
>>>>>>> [...]
>>>>>>>        qemu-img-51025   [008] ..... 19503.285500: =
nbd_payload_sent: nbd transport event: request 000000002df03708, handle =
0x0000150c0000005d
>>>>>>> [...]
>>>>>>>   kworker/u49:1-47350   [004] ..... 19503.285514: =
nbd_header_received: nbd transport event: request 00000000b79e7443, =
handle 0x0000150c0000005a
>>>>>>>=20
>>>>>>> This is the same request, but the handle has changed between
>>>>>>> nbd_header_sent and nbd_payload_sent! I think this means that we =
hit one
>>>>>>> of the cases where the request is requeued, and then the next =
time it
>>>>>>> is executed with a different blk-mq tag, which is something the =
nbd
>>>>>>> driver doesn't seem to expect.
>>>>>>>=20
>>>>>>> Of course, since the cookie is transmitted in the header, the =
server
>>>>>>> replies with the original handle that contains the tag from the =
first
>>>>>>> call, while the kernel is only waiting for a handle with the new =
tag and
>>>>>>> is confused by the server response.
>>>>>>>=20
>>>>>>> I'm not sure yet which of the following options should be =
considered the
>>>>>>> real problem here, so I'm only describing the situation without =
trying
>>>>>>> to provide a patch:
>>>>>>>=20
>>>>>>> 1. Is it that blk-mq should always re-run the request with the =
same tag?
>>>>>>>   I don't expect so, though in practice I was surprised to see =
that it
>>>>>>>   happens quite often after nbd requeues a request that it =
actually
>>>>>>>   does end up with the same cookie again.
>>>>>>=20
>>>>>> No.
>>>>>>=20
>>>>>> request->tag will change, but we may take ->internal_tag(sched) =
or
>>>>>> ->tag(none), which won't change.
>>>>>>=20
>>>>>> I guess was_interrupted() in nbd_send_cmd() is triggered, then =
the payload
>>>>>> is sent with a different tag.
>>>>>>=20
>>>>>> I will try to cook one patch soon.
>>>>>=20
>>>>> Please try the following patch:
>>>>=20
>>>> Oops, please ignore the patch, it can't work since
>>>> nbd_handle_reply() doesn't know static tag.
>>>=20
>>> Please try the v2:
>>=20
>> It doesn't fully work, though it replaced the bug with a different =
one.
>> Now I get "Unexpected request" for the final flush request.
>=20
> That just shows the approach is working.
>=20
> Flush request doesn't have static tag, that is why it is failed.
> It shouldn't be hard to cover it, please try the attached & revised
> patch.
>=20
> Another solution is to add per-nbd-device map for retrieving nbd_cmd
> by the stored `index` in cookie, and the cost is one such array for
> each device.
>=20
>>=20
>> Anyway, before talking about specific patches, would this even be the
>> right solution or would it only paper over a bigger issue?
>>=20
>> Is getting a different tag the only thing that can go wrong if you
>> handle a request partially and then requeue it?
>=20
> Strictly speaking it is BLK_STS_RESOURCE.
>=20
> Not like userspace implementation, kernel nbd call one sock_sendmsg()
> for sending either request header, or each single data bvec, so =
partial xmit
> can't be avoided. This kind of handling is fine, given TCP is just
> byte stream, nothing difference is observed from nbd server side if
> data is correct.
>=20
>=20
> Thanks,
> Ming
> <static-tag.patch>

