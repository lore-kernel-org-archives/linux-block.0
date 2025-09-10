Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB6327A3E
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519758; cv=none; b=lb++ZXP71gmZYp3s9qTDl741BtG3/NOplYuO4gM9OoQ6Sw2hC1CrJn9ISK7jMZmmrCGAqK2HBTN6LlFXFQMWE8rGlWg3cZdZ9RxsgwtC5fVCYcX82fJgt8XKs5g5UaW3NnhyD8X4MucW0j5UPELoHDvvD0ZBWCi6fKilC7+u98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519758; c=relaxed/simple;
	bh=JbkGbKmGymGSLLsdUZaBOo51FNEi13jYTbdjLpf1unA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIQ8wUZ0jdva1hOu70ej3+i3IYAfgwTehVXxfPs4N3nZTCiZ7Fb6ZECv3lsPaLfTuK/qMWcCTR7ylzCAvmKru0nV1rLBCbOLNt/ohqHqAiWkT/5SbjBZoTM5VCxPvZhjeW45nQ3GkaxVZta+DitQmPg0OdmNXCwpRVDqhroyA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZpfVRhf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZpfVRhf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757519756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RAbP5UJcO2BtVVPAKVuEh/4gKQck7zOlT1pd89BKDw=;
	b=LZpfVRhf+TQDh6yiv16sYtGmEJnkDGT1RnqhUlSuUG0ifVhxBXLFX47Wu6qQosiJ4CKudj
	c2uQsUSJprvsQOMI8uq2xOeMv35nrBIKwoEBHq+Hq7+uDCAMUspUN+pG6eC9h6V6dxMSdu
	M4pRYcrj60tB5HblmvuFiyMouohq81c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-6DhDCy1NPM616F_MIQDJjw-1; Wed, 10 Sep 2025 11:55:52 -0400
X-MC-Unique: 6DhDCy1NPM616F_MIQDJjw-1
X-Mimecast-MFC-AGG-ID: 6DhDCy1NPM616F_MIQDJjw_1757519752
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b04206e3d7eso70256366b.1
        for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 08:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519751; x=1758124551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RAbP5UJcO2BtVVPAKVuEh/4gKQck7zOlT1pd89BKDw=;
        b=GYKkyw06R5s9Q6vF8YzmV/pAs/c4EKeybjDYoQC9CMLHycYero4t/iqcWsrUqLkWkQ
         UpTLao1GU/hOBafDQko+yLyHgR3ctSrAlX+KiAK2tvwj4CgWU8ZqcIcA9CdgO4pLuu7f
         mkL9M6nwGEjy975wI+g1jcM37hcMm/ipTt17dpEg6msHnrPAvmBHUEYIR3SlryvGJ2Hm
         HE6yURMOXEnB/fDMW7FwoxgRFNbtgjgEWkjVXIBbpU+h0DfR6Xe3MTnKEpBQAtc2O8GX
         49pVovUaT85pktLeRiqrutHMffG4oo8vQVBGJP9t8hrt4OqEoaLAuTFbtcZnAnCRJ/x1
         iaxg==
X-Forwarded-Encrypted: i=1; AJvYcCW8J/iFeR1M026lzmKLbVLQk33WqYNfjE3ZcbaSLSlq30K2IH7lV865rmstUNCnsTq0+2vwuqwohIzOeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2m/JIHSLBzZPhfb+nZUU2Afg3iilM5nAG7fyCueZp4GllvjSE
	lkPDJTSsmQk30ItvB7Q17TeF6KeMZiidwzTCSCE8UhBjH5/MCApfoVH+NSbviI7r2a2GawyuX8s
	AE3c7Y1uqmvoG9jwfrEdHacxTowYTd/QEAPi0zNK44Ecf/O/xmY46/UHKOdViDYXT
X-Gm-Gg: ASbGncv2R/cDQ/4rWQuT0UJxFWUKfXO/92qO83rgHNL5SblGnaVE19CNYM4ANIdmN8Q
	qpsDLH9h/HpHqhLeqZg7BWjRRaU4c0RpiEcUSVKO2xWPpTGRX26L0FFVNU60olQXjGWtnqRTZPD
	sTMY3rmdkUmCrpNfMRP4/CmY+SKqyIoHNguxYVfrlfwgcmJPvfmPlYHQvUknqNrglaRZFQ4Lvb8
	TrPtqgrOu0ryPNOrKWarVrpO9o3G2EvjlIuh+XtmLBORD3SmmE94kDOwixH0mYJah37+shbd7pX
	r/jCI6NbjrZedAxBe7rtuKW5qsFTdGMxcRTty3LmL2MIFDxsiZ7HJyxNJhj8XwXqQOY5VF6FU3w
	k2HdlJ85YjIOJ+UiM
X-Received: by 2002:a17:907:6d20:b0:af9:70f0:62e3 with SMTP id a640c23a62f3a-b07a648ed52mr11275366b.15.1757519751570;
        Wed, 10 Sep 2025 08:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4scsY5n/QsLA6mG0sjvrsfoCoD0h3ZgLanYsu42CsuN5gQm2fBKl3Hy6FexJBMaEtSlxTnw==
X-Received: by 2002:a17:907:6d20:b0:af9:70f0:62e3 with SMTP id a640c23a62f3a-b07a648ed52mr11271166b.15.1757519751033;
        Wed, 10 Sep 2025 08:55:51 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-93.business.telecomitalia.it. [87.12.185.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334dd71sm180635766b.61.2025.09.10.08.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:55:50 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:55:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, Mike Christie <mchristi@redhat.com>, 
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
Message-ID: <p43lkbkmsgnztlfbnrebsnnlkdvz4lt53vmnenoarejg6lhivz@cbia5lxat73k>
References: <20250909132243.1327024-1-edumazet@google.com>
 <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com>
 <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
 <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
 <20250909151851.GB1460@redhat.com>
 <CANn89i+-mODVnC=TjwoxVa-qBc4ucibbGoqfM9W7Uf9bryj9qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+-mODVnC=TjwoxVa-qBc4ucibbGoqfM9W7Uf9bryj9qQ@mail.gmail.com>

On Tue, Sep 09, 2025 at 08:33:27AM -0700, Eric Dumazet wrote:
>On Tue, Sep 9, 2025 at 8:19 AM Richard W.M. Jones <rjones@redhat.com> wrote:
>>
>> On Tue, Sep 09, 2025 at 07:47:09AM -0700, Eric Dumazet wrote:
>> > On Tue, Sep 9, 2025 at 7:37 AM Jens Axboe <axboe@kernel.dk> wrote:
>> > >
>> > > On 9/9/25 8:35 AM, Eric Dumazet wrote:
>> > > > On Tue, Sep 9, 2025 at 7:04 AM Eric Dumazet <edumazet@google.com> wrote:
>> > > >>
>> > > >> On Tue, Sep 9, 2025 at 6:32 AM Richard W.M. Jones <rjones@redhat.com> wrote:
>> > > >>>
>> > > >>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
>> > > >>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
>> > > >>>>
>> > > >>>> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
>> > > >>>> made sure the socket supported a shutdown() method.
>> > > >>>>
>> > > >>>> Explicitely accept TCP and UNIX stream sockets.
>> > > >>>
>> > > >>> I'm not clear what the actual problem is, but I will say that libnbd &
>> > > >>> nbdkit (which are another NBD client & server, interoperable with the
>> > > >>> kernel) we support and use NBD over vsock[1].  And we could support
>> > > >>> NBD over pretty much any stream socket (Infiniband?) [2].
>> > > >>>
>> > > >>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
>> > > >>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
>> > > >>> [2] https://libguestfs.org/nbd_connect_socket.3.html
>> > > >>>
>> > > >>> TCP and Unix domain sockets are by far the most widely used, but I
>> > > >>> don't think it's fair to exclude other socket types.
>> > > >>
>> > > >> If we have known and supported socket types, please send a patch to add them.
>> > > >>
>> > > >> I asked the question last week and got nothing about vsock or other types.
>> > > >>
>> > > >> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+ndzBcQs_kZoBA@mail.gmail.com/
>> > > >>
>> > > >> For sure, we do not want datagram sockets, RAW, netlink, and many others.
>> > > >
>> > > > BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL
>> > > > being used in net/vmw_vsock/virtio_transport.c
>>
>> CC-ing Stefan & Stefano.  Myself, I'm only using libnbd
>> (ie. userspace) over vsock, not the kernel client.

Thanks Rich for cceing me!

>>
>> > > > So you will have to fix this.

How we should fix that?

IIUC GFP_KERNEL in virtio_transport.c is used only by workqueue's 
functions, but we have GFP_ATOMIC in the fast path that can be called 
when the user is sending a packet.

This is basically the driver for the virtio-vsock device that can 
allocates extra buffers to be exposed to the device.
In this case the allocation can happen in virtqueue_add_sgs() for virtio 
indirect buffer, that IIRC virtio-vsock is not using currently (but we 
don't know in the future).

In any case, we use GFP_KERNEL also in virtio_transport_common.c to 
allocate the sk_buff, so that should be the same issue.

Thanks,
Stefano

