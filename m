Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08BC407CDB
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679254; cv=none; b=mqIM2GWX2rr5aIB+Vf8/IGTw3kwI6LJajYNoEbd2Wm6Hg6SUYiC07YzzCHpjJQzo0Trblr0/igqqFWAfmj2GmO2NApAzN0DnWP+P1DSGkOXO/zb2kaOddQraMoKRtrUvLa4a+0Z79nwK6ue3ilK2SnjbvxdIirTKQYUroqftGtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679254; c=relaxed/simple;
	bh=mfNY5/wKTualPtKnvnjNxkREzGzIwpXhaTyFMqtYbU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnUc0QWOxaLl5CdFBstrYmL3HPjtJSZ77gwlMT6QjEan11mLwqVTdX8XbI0gs1tPlK+ktuTW6ahceaVz984m7oCAfpNjwbdX+LWV863y+Tz4HsA4giV2Fn1Js2gQH4FMkMTviXeuEktWsc4e5VSDVWXJkYm6WEj7jsqt4RjXrNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=UDWWXhEj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="UDWWXhEj"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so5172985e9.3
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1783679250; x=1784284050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfNY5/wKTualPtKnvnjNxkREzGzIwpXhaTyFMqtYbU8=;
        b=UDWWXhEjEySI/46O3mn9BH0s891rfEAeaEM6UAQsbavsnPZnMxGberXusYIlJfIuq5
         m/DA8Ik7L2esnl+exMLpYf38NvbqALB59xV625vxMuUuwKy4ye0y9C+sP8q8xaLZnJ1O
         eOvBIyoFV9J9sop/uZgzaX1d+uu0n2QXdLiwz9mCG5d7/6T1TwVVUAFKE0G+9JgL7Byg
         85rPV1ud3HAaCJzmz1WRLVspVZWbqbpKfAzuHZzSIoBZluMXHcwF8kgps53wc0e6B67g
         YMIDchQ2qDrqbFW4AbfgIVOsw2Ll27WLJ9kMF1nYCFtaPzfaoZ9jXFITloZVpnnXrU0R
         Ux1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679250; x=1784284050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mfNY5/wKTualPtKnvnjNxkREzGzIwpXhaTyFMqtYbU8=;
        b=NCdsD1YNkMshGi3wmt9XRcnu7/B5uzeqgaYVCJT2mbnvXyiPQz0rmDhFfTEJawzrRG
         bzTT+OxypKOeP8djvKSo16e7zQrE+JWS3HOScOzAVPGEFV5yllCIfMuACrQXoZxQakrd
         Za39ezMvQ+cXBzL5VKi8XpQrycfyXdfUUj2tQWypOyEjewxCSu17mD3YybIhOMlcHjL5
         PzuIF8VzIJeUZ6YM24np48YUB0Mp0kWk+WvnTwp3XUMhbwNI79tQeI6OvnlJCOhI0X6E
         SVlkvFb4DCGaWNXwzGJJFx7EPSUwMw8Q6ZAcdQYk4g07w2PdBuPlGkNbaj5KHhMTxyjX
         XFdw==
X-Forwarded-Encrypted: i=1; AHgh+RpHseD4gCbBMeoT3oeQa02zQTG30gUACpJv16VB8RTJaHHm3wKMuZrJ4AC4isaROpG/z1pFpFDW6uHPZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy73FzO77yrJYbuvS23wn9MgZSfXzZmiMmOKPK/qoz24gMfo+xa
	6EdmiPHZNqJ90Ci/PTaP7be+G+y/1tvdfSQxMGVvxjI4raXc3/QcD9CHtb7XmMFzEz/H/tu5e1r
	ZTtix
X-Gm-Gg: AfdE7cnHRfgBHFzkdh8ugn3FbqU9qpIMX7NWemCGkr7CXhYEIjB69jFEy99PnbGExgS
	pVHkvT9hTvfhKFMkHHJ+o0NTtw6nPiMjVUFTB6uMalL8RaJnePS0whzRy3oSJpf5KlztzmUPNu2
	9ILP03sJBHqML71YkCF+Lu5KUgsXVUxVl17wkGfM70KNz2hYqJq9tWrDzWCMvnp8yjjNPZqRmK/
	z1DEFdjp0dLeTK39v13Xp0FRtvCIaVLy9FvlA7zbygrf6sROCfaWGreKwjwiBqWDbxrcO8relZB
	eXdtlhkre8UAEH5gg1LEGUruM0skDvua8Qo0KZK72pZEWomFakludt6Z1zcT6eScKnPA7pGKDWx
	Br2njnpwwgf8vTZBX2RIvu7P74N2KQE2CfMYXzfAcVYmDIISZYwZJdTYXpmnffb/BT1Wt3s5dgQ
	UU5TicmzIB2sjqVqBT7tIO7xGdkKp0EA2ebeQ7vQeUMxmWRH3t2qOf/SXn
X-Received: by 2002:a05:600c:4fc6:b0:493:b729:3a9 with SMTP id 5b1f17b1804b1-493e68cbf1dmr111119535e9.27.1783679250286;
        Fri, 10 Jul 2026 03:27:30 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm57826881f8f.33.2026.07.10.03.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:27:29 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:27:28 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drbd: reject data replies with an out-of-range payload
 size
Message-ID: <alDISEFL7wuNO_VW@localhost.localdomain>
Mail-Followup-To: Michael Bommarito <michael.bommarito@gmail.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20260710022837.3738461-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710022837.3738461-1-michael.bommarito@gmail.com>

On Thu, Jul 09, 2026 at 10:28:37PM -0400, Michael Bommarito wrote:
>recv_dless_read() receives a P_DATA_REPLY from a peer into the bio of an
>outstanding read request. The peer-supplied payload length reaches it as
>the signed int data_size, and two peer-controlled inputs can make it
>negative. With a negotiated data-integrity-alg the digest length is
>subtracted first, so a reply whose payload is smaller than the digest
>underflows data_size. With no integrity algorithm (the default) data_size
>is assigned from the unsigned h95/h100 wire length and drbdd() never
>bounds it for a payload-carrying command, so a length above INT_MAX casts
>it negative; this path needs no non-default feature. The bio receive loop
>then computes expect = min_t(int, data_size, bv_len), which is negative,
>and drbd_recv_all_warn(mapped, expect) receives with a size_t of SIZE_MAX
>into the first mapped page.
>
>The sibling receive path read_in_block() is not affected: it uses an
>unsigned size and rejects it against DRBD_MAX_BIO_SIZE before receiving.
>Reject a data reply whose size is negative after the optional digest
>subtraction, covering both triggers.
>
>Impact: a malicious or man-in-the-middle DRBD peer copies attacker-chosen
>bytes past a bio page in the receiver, corrupting kernel memory. A node
>that reads from its peer (a diskless node, or read-balancing to the peer)
>is exposed in the default configuration; data-integrity-alg is not
>required.
>
>Fixes: b411b3637fa7 ("The DRBD driver")
>Cc: stable@vger.kernel.org
>Assisted-by: Codex:gpt-5-5-xhigh
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Looks correct, thanks.

Note that DRBD usually chooses to trusts its peers by design, but I
agree that memory corruption is a bad enough consequence that we
should put the guard there regardless.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
