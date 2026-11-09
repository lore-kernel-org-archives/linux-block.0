Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244960;
	b=zJvop6KMV1jfo/S1IGl4D2TXRevAcTboTizkaC8PDUOZb0v4VxKEWwi475ZotZCbyIVa
	 kXQoZkzkqm5r87NKCW0jCzWRJcRuH9+vkYl2fCXl9bo9YzgkOHd1LBrj2tpsi//R42sLO
	 Vk5wk27hUz9/DwVq9bI5o/7vvD2hJjJu8hxM3+vRpy348Asyv3ZSmvrML4CW8AueOKmX9
	 +YyQlmfETda8GYewzwnljFHdeSghJ0p0oC+lSHNdJGbkjX2TvDpyQ4b6FIHEFhdWVXWOG
	 shz1q63rKmzUTbyVJcVyJ+8timd3r1uwJI6T84EAmNQlWxPg3uzRfAKrA2tSejLylXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=b6mHS43xjC7bUToGiz9ZtsTkKl4SjMG7SXbvThwI2D0=;
	b=CgBajcCTqfBuNJp6wkeiEpC/R/SfpNDfYFpeIgs170Fu5ep0iHoMVq/YHwCf1gOvBWk+
	 VAztKl+FSJV1RmWPJvf5akrfB/IPlCKc5vdFnhTImcpYQg6eBAHbn44Z7vJIKK3JSLOeO
	 jgT9N9bqqHhp5+IHzxfdjJ5QKLNG3bHcednwpF3uSnz9QAJgRkLFCVG3jqSL/tjDXLPlF
	 7uGwjsj459/kOygRWhSOLYap5L9CBB1isCD/hE/Zjr58ViOK0H5XADuUyL9c3jcbpeHpR
	 g77PmcILpjta3xzZin0k6Fxx+wM5qw6yCDmInyIV6r7D6WeQ09X+ugwG2W8fefJSQXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=U4v0mlex;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E7606A33B
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 17:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 771E7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=U4v0mlex
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-491971ac844so1116078f8f.2
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 09:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1794244958; x=1794849758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6mHS43xjC7bUToGiz9ZtsTkKl4SjMG7SXbvThwI2D0=;
        b=U4v0mlexhWlX56e50vl+rHtY0E4bzai4WnqBSNUoQGJvDFH+jhJZG+QNgLf/ou8Qhj
         c4HdzeD9/Rvq4PLSw0i0SegdfnVBgRa09/CSARvygTBgoCOGLU3+zQutEf8u/FiuhFMW
         qBH/0nEA6GfUKokeDCAqKFvRKRJhW6xSfRu1F9jQNByvFJtRvrszHUpPhpxL0oH0zt5E
         8pNyo3s7ARdiyEuFvG4/2nP9ZwebN7wu5iKRFeejPNZ5YO85nvyWIXBcKsBeNIq+iuTT
         LCKGawt2Bobn3BYRN36mW64rBrcAtzymMoS55QOhqALvVjMm8F7KHt/4h3QwtQ4mb1rv
         Qaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244958; x=1794849758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b6mHS43xjC7bUToGiz9ZtsTkKl4SjMG7SXbvThwI2D0=;
        b=Ps0hDqkqLIShLd4p6nowGdX5MpLKpQcEdL3Jj0azL9I7pk7lelRtSY+5zVZh4/sTJp
         xjsd0FfUDckIbXI9MHsFedRPO9g7RoNrzrMB1tiN3zndhzYx7PxLk1BrTNnv37l4QIN0
         e5y55FABczA+/pPkBYuo1r40DpMMph6BMStxm8gRIhK9u9abwmGgEvNl8dJDnMeD8TUW
         MesgeuosBedbVR3MmF7UHr9seDoixehUVzQzsuPML9O3N1M2MgXcD/FS0Avdcf4GDMCO
         jqBs6Ij9gJ1brl4CUdcISEOWe1yUXTt7k3JLUw4Fr8+Tqmu3w7ds8M2I1nIvh6TgU4G9
         uzkw==
X-Forwarded-Encrypted: i=1; AL+hErF7nTngKtm+lYChjktpPv7crY7uKeDEbd+01GiDWcLNGgUQEh8mixoYFdaYgTMn86VVU11E0j5t2fFJbQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ixB4w+//Gs4ejLokuz1Bv+eiW5xH/mmCEfwPW9pUE7bBFZgNT
	l8UfSKFfkTNTnDKHwdDZ4zXIPwG11w2PvjQpgeVbbEwQ6zrJNF5IaSugxx92OjB09d8=
X-Gm-Gg: AYBFou1pbUXRcYc9GsZcH0hfP+UoqisQW+I+aFJzaRrFZkUBx27jQfMhvGbmbBaVvdh
	/ahWynUDHwbOHJdNFdLzJlE0kfvfyDZV5oXs8HNN2xJZ4C0DV2kJUq4alQ5bh7J+TqueOGCM6rW
	Jlk7w6ixpGpiWV6NDR3EcJO3Vd1IFR+jcGbIuiTFbfMkOUFOjej70Fh9DVEg8GbBnpG/BWIXgo/
	kHPWl3XumliC8iWkleHc+lN/VZrTaK2i8uj8hA5xBSglG8CxZ61pTPJjLlWynPFAYnkVqIvIvny
	9cvagGtuLJeKdLXdGmfQlZWxrGjFe2OloyrTouWceRJHfd8QUjCq77kpI9s+rexm+3q54h5CpYe
	bVaAzxJLFC+qi8pnv4ZEyN896C2h9XMr9FkdrX0Ht4eB7MOVdxvyJXlb4i33ee8NFJy2nR7zzww
	QTaIKgbxaa93k9K2ub+sz1/I6Ensp3ao3RKDiLuUdCFw/7++UcfK/t+9fnHhez7oj9d0/xXk9ea
	IXLmxWvDDWsnLap4om/JF/jA5uTQSYQWCB7w4Pd6GEmw9wzKBzh/spU6YuUG/HieYF/HIypawKw
	WP5+nPZEmicWgw6vOUfgRqOofWAFSGRNa8fFs38ZHQuqcfJ+VnwueUn+e8f+hT0Uw5qOjPlSJmF
	YrL3q++tt3YEtBCkv/w==
X-Received: by 2002:a05:600c:470a:b0:4a2:1655:87db with SMTP id 5b1f17b1804b1-4b943f76fdbmr96705385e9.0.1794244957763;
        Mon, 09 Nov 2026 09:22:37 -0800 (PST)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba015c1e31sm4470385e9.1.2026.11.09.09.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:22:36 -0800 (PST)
Date: Mon, 9 Nov 2026 18:22:35 +0100
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: Re: [PATCH 0/7] drbd: preparation for DRBD 9
Message-ID: <avIA1j2pX46pzOr0@linbit.com>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>
References: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>

On Wed, Sep 23, 2026 at 04:06:01PM +0200, Christoph Böhmwalder wrote:
>This series contains preparatory changes for bringing DRBD 9 upstream.
>Each patch moves a piece of the in-tree DRBD 8.4 code to the form it
>has in the out-of-tree DRBD 9 code. Doing these steps separately and
>up front keeps them out of the much larger rework that follows, so
>that rework shows only what DRBD 9 actually changes.
>
>The patches are a file rename, comment and internal cleanups, and two
>higher configuration maximums. Defaults are unchanged, all existing
>configurations remain valid, and apart from those limits only the
>wording of some log messages is visible to userspace.
>
>Christoph Böhmwalder (7):
>  drbd: rename drbd_worker.c to drbd_sender.c
>  drbd: modernize the file header comments
>  drbd: raise the socket buffer size limits to 128 MiB
>  drbd: raise the maximum resync rate to 8 GiB/s
>  drbd: replace the drbd_interval bitfields with a type and flags
>  drbd: move the packet name table to drbd_strings.c
>  drbd: rate limit log messages per object
>
> drivers/block/drbd/Makefile                   |   2 +-
> drivers/block/drbd/drbd_actlog.c              |  16 +-
> drivers/block/drbd/drbd_bitmap.c              |  18 +-
> drivers/block/drbd/drbd_debugfs.c             |   4 +
> drivers/block/drbd/drbd_debugfs.h             |   4 +
> drivers/block/drbd/drbd_int.h                 |  59 +++-
> drivers/block/drbd/drbd_interval.c            |   4 +
> drivers/block/drbd/drbd_interval.h            |  55 +++-
> drivers/block/drbd/drbd_main.c                | 106 ++------
> drivers/block/drbd/drbd_nl.c                  |  15 +-
> drivers/block/drbd/drbd_polymorph_printk.h    | 256 ++++++++++++------
> drivers/block/drbd/drbd_proc.c                |  10 +-
> drivers/block/drbd/drbd_protocol.h            |   4 +
> drivers/block/drbd/drbd_receiver.c            |  61 +++--
> drivers/block/drbd/drbd_req.c                 |  40 ++-
> drivers/block/drbd/drbd_req.h                 |  12 +-
> .../drbd/{drbd_worker.c => drbd_sender.c}     |  42 ++-
> drivers/block/drbd/drbd_state.c               |  15 +-
> drivers/block/drbd/drbd_strings.c             | 138 ++++++++--
> drivers/block/drbd/drbd_strings.h             |  27 +-
> drivers/block/drbd/drbd_vli.h                 |  12 +-
> include/uapi/linux/drbd.h                     |  12 +-
> include/uapi/linux/drbd_limits.h              |  12 +-
> 23 files changed, 534 insertions(+), 390 deletions(-)
> rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (98%)
>
>
>base-commit: 85bffad4d2fea373a72d68bed8012e8cbccb8ee7
>-- 
>2.55.0
>

Hi Jens,

this never got a reply, and neither did the subsequent v2 drbd rework series
that's based on it [1].
I think this should still apply to 7.5, would you mind queueing it up?

Thanks,
Christoph

[1] https://lore.kernel.org/linux-block/20261006154607.3936501-1-christoph.boehmwalder@linbit.com/
