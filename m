Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA032B105;
	Thu, 25 Jun 2026 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384208; cv=none; b=Zh7FHszpbzMh2OKVCHULoY2RRYugaaKba4+ApjW9UoCo3iigGwQtmNvFLl+2CXabZ2mu23Eow7J2hnT4nXdoRjrGv6gXFDGK2Zq0bdVuDnKBp/4mPGvrJicsOuTsPt0XNwf8oAIDw1iXfzezrc8fabyu6rNM+NRmkK3Bjc7Yqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384208; c=relaxed/simple;
	bh=UjrUr9JyhWSPsRrVGWFmbeJ/i1JdU8zynCYVhgLqGXg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=I2+vwOpZ0GEU0ryCMa8kecnz8mYefbOu9d4NFcdxz6U6HOtCsoD6HpAH1OE8foFiiGWSs3sRPVGs1pGwaajw4sahIr2dXCS4fkUAtrO7woHZoJA70Cac8jE/wxkaULhAhDFhNF6vohq9KLfdMwnNlRuSmo/iCW6RIfAB4Zc9740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUzARnuu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUzARnuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466001F000E9;
	Thu, 25 Jun 2026 10:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384207;
	bh=589RF0+vWh1NzozOpnG5ilghF2hslk/czCRYDKKGC4w=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=RUzARnuu0h0jnVHIdThgs3WVMsYsdpqLGtXwF4HecxRhL4ek2PKwV5JmNkGT6YgIu
	 hXaBbs3HI4HAtNvUzT9+5cvNvgvFv7UiabvCUdCzYEJdWU/2ZdegrajykC7IsKJJFv
	 spx+7IQKoRCrqwJtvJFWSt5dzFZTMovJ3tR+FpPvBwJcJQ6kFWPj91hzTey1oqa71/
	 uF107IVIBBxyZ5sFxBa/6RuDCaL06OA8mCC4Te1Wn8QM9OpG6X2/cjCNgK6hpnmvQT
	 G8eFsYVcx+0UBkbyq1W85Eqm9Se7lCKUiwtZoFylz8l5L65c+nLK9o/ZHcnm4RH+b/
	 i9c3zMkll6jEA==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v3 1/2] iov_iter: export iov_iter_restore
From: Christian Brauner <brauner@kernel.org>
To: Octavian Purdila <tavip@google.com>
Cc: netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
 kvm@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260622222757.2130402-2-tavip@google.com>
References: <20260622222757.2130402-1-tavip@google.com>
 <20260622222757.2130402-2-tavip@google.com>
Date: Thu, 25 Jun 2026 12:43:18 +0200
Message-Id: <20260625-erstbesteigung-mundschutz-invalide-3b0d4cd4cbc9@brauner>
X-Mailer: b4 0.16-dev-d9d01
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UjrUr9JyhWSPsRrVGWFmbeJ/i1JdU8zynCYVhgLqGXg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTZsnnqFouHhX8+Hf69S+uAhEZH18NVT69larvfD5/G7
 dnoPtuto5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKVgYwMrdYxUfdiXnROLX37
 R+Ndw4Ue9aluiksWLfjQUOYtzClWx/BXdMbunRlJXy6W3df4aP73/4XbzR/WXlmnf7T+M9PkTVy
 CTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Export iov_iter_restore so that it can be used by modules.
> 
> This is needed by the virtio vsock transport (which can be built as a
> module) to restore the msg_iter state when transmission fails.
> 
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Octavian Purdila <tavip@google.com>
>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 273919b16161..f5df63961fb2 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
>  		i->__iov -= state->nr_segs - i->nr_segs;
>  	i->nr_segs = state->nr_segs;
>  }
> +EXPORT_SYMBOL_GPL(iov_iter_restore);

At least only export it for the module that really needs it. For
example, see:

EXPORT_SYMBOL_FOR_MODULES(__kernel_write, "autofs4");

-- 
Christian Brauner <brauner@kernel.org>
