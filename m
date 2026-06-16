Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365A1FFC59
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613379; cv=none; b=IWU/zz6LLYTxxLwWQLYHDrsDpdcfjDaWnk+oZ0gaMsh7235nJ9Qgw8fDZDa+I0lijdDo8I005KKssa5KSmZjvBVBXoPiURs9vDN1vp4kX5TG7/05akz6Eygk+bd3zvANVkYjT8zY3VMbio91nOjqf7x91w2lU0QE9T6oDGvhKY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613379; c=relaxed/simple;
	bh=We5ZGXz91oTGJ0dJSujyq11OFk6rNuSPRZXQZ0H5xKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+rCgPgmk5TTdVXB6mqW5KOBXRuEFenwCwKAVXvFBKr4EYMYqcm2ZFHbvJxqwWQjryGNAknxleO2wFm9ct6vf9LyttBJGi9dXhrWJVLDTkIG4nEAPqnEulIHjK3+mkpK6RhkIHUZUzTV84actpbkjquJKdzjxbsZEWFDe3xeC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXPnzvPB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYMhyVu3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXPnzvPB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYMhyVu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781613377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
	b=TXPnzvPBpkEmkYLCg85Yy1ODSms1dHWNccf7BU9Y+JclWjAklRtSnju9fzfuJgd3ckZyom
	/kxKSZCetfgHQ0ki/hNYh3oSXAdG7/Oa0ZRvUqu06Ebjs43o8Kb36TLfRgEng1Xhw/f0TB
	hujsSy7qzFqogkCj5c6LzfoOba0Ys3I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-b3Jez9HNNjGh9aqd_hb9cA-1; Tue, 16 Jun 2026 08:36:16 -0400
X-MC-Unique: b3Jez9HNNjGh9aqd_hb9cA-1
X-Mimecast-MFC-AGG-ID: b3Jez9HNNjGh9aqd_hb9cA_1781613375
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490cc1ae292so25816755e9.1
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781613375; x=1782218175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
        b=YYMhyVu3nTzaTKbDfbDYkxig4jYoF1IvceRiBk9iLHnvaNC6saZoZc1eNGHCGMvYuB
         e/Ko3XsVhkNLOSyZBB8+cYb4xezr/Oqbdyb5UK7nhh9KQq/LxsNhke9wwSxDg76mQ62v
         195gFQ1wLWO0ikLuPuZ2NyxMzsruoJzmo5srFoe6AVa8aAfJY1rr5VO8yDJJj6/1i3kH
         PKNhAZmuuag3eSTMkFvHS/IhsTkB81Mi7k/NuxIbZJgBxIv2T4QvRB6Ridy18dvxQ/QR
         Zufod48sKOeAKe87UbCePT+BzTlWEMXYJhsyHX9QtKMPpLVg2a/SWC/gCHF27bJhq2sp
         yatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613375; x=1782218175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSnkO0gt5pvplCuR7CfDwnBPmu7f4V6aR0qzT3FcJKM=;
        b=MdbKBaOwHWOSOtrqznjfGb7pmUZbOimqjruxUtWp7QIiW8y55cGJ90jNyNRJBq6gD/
         81z2fNx/fzm6SiYY9a6VNrTxBgGgU0dkslKf/UgAFqdJY9C8rMecYcFPrBOVxvC9rCRI
         0hxDa17TkcVrYIzA1om+Mo3iQ4hoH0O84sunFnLm+21sY9L3hD5Enw6RrFla/xFRDcfo
         EmSwpSXzshstTKOUhadIkbQUP5Ngl1u/cKxuQbsn1S0rAaN10bLgYjVHsIUIez9PNrtv
         +0sIA7CdMMEjTOWJb3GAKTRvBailbMDGl7QGB0xyAhiVJ3CmOyZ8qoNINYe/c82yJ38D
         tENA==
X-Forwarded-Encrypted: i=1; AFNElJ+U90KD3vN69OP9Y+Mo9fnkSLBwfmferurg/J8fXo7vqos/WL5u3eqMKYWQEXeUVIR4w3izZBo/X+Qdtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj6FS/VmaJrDYEXAhiWEbEiwLKx4uUNO2kJuzPrNNEvBagor/1
	v80CwV20MAlKsXYKmKcq+gAUqkZIgvAY6nVMDbnaPXiluI69NNK6YJuVaxdJICnpg1S1JehTE6p
	bfBTLofe1Ax0IWtH6kOnlKyA39k3/R0GqHtPZgGjiJWtzjzPe2CZvDYXyaHB6S2tz
X-Gm-Gg: Acq92OHBAnEX3jiMYcbn6N1mmdhUqkdbasFsEZTKZgr19uIxqLKWblkn8yMhnwzpNlu
	Bo2p9f0wQ0IcPz7Rd+F+oWu7X99B0CfTQPy1gOOWrAjfuo+2i+HUYP+BWbIdP6GFfM8Vpy3d6TJ
	DDsGrxFAbm1SwZeKHiaTFAhSl8NkOz6g4MeSlki2Sg5ZgZ4FGh546w63K+Q+MEWvsifjxs2eYnk
	OF/0qXoTFzPF0QZVn5atn/dm2W7QnGBX8gZBJU/vABQZZifBe1yw+FxlwgIlkBFbpI/m1EXwLnZ
	yd/lRTreoG3Y2HY3ma0glgbfR+lW17IU/0LFp8oAt/tsz0CacWcec48wXq6fXnVTLhOa8HCf8XT
	jKswnUTijMEZ3rpp8AWGEMNTUAwhIZFzZFAF1Gilpx8hJH2vclRcJXWQZbigqNoYMDMta148=
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr52204645e9.3.1781613372190;
        Tue, 16 Jun 2026 05:36:12 -0700 (PDT)
X-Received: by 2002:a05:600c:6215:b0:490:e180:2e0 with SMTP id 5b1f17b1804b1-4922fab22c9mr52200315e9.3.1781613368029;
        Tue, 16 Jun 2026 05:36:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a8ec56sm53027215e9.9.2026.06.16.05.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:36:07 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:35:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Octavian Purdila <tavip@google.com>
Cc: netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
Message-ID: <ajFDIHuKC31pumnY@sgarzare-redhat>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-2-tavip@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260613000953.467473-2-tavip@google.com>

On Sat, Jun 13, 2026 at 12:09:52AM +0000, Octavian Purdila wrote:
>Export iov_iter_restore so that it can be used by modules.
>
>This is needed by the virtio vsock transport (which can be built as a
>module) to restore the msg_iter state when transmission fails.
>
>Signed-off-by: Octavian Purdila <tavip@google.com>
>---
> lib/iov_iter.c | 1 +
> 1 file changed, 1 insertion(+)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>index 243662af1af73..067e745f9ef53 100644
>--- a/lib/iov_iter.c
>+++ b/lib/iov_iter.c
>@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
> 		i->__iov -= state->nr_segs - i->nr_segs;
> 	i->nr_segs = state->nr_segs;
> }
>+EXPORT_SYMBOL(iov_iter_restore);
>
> /*
>  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
>-- 
>2.54.0.1136.gdb2ca164c4-goog
>

