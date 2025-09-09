Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F63451B6
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424768; cv=none; b=CeJsSNbOZFiwN/uDOS2WnEcPcKcFjmAeQi5/bV6Wb/yaALH0vzv9dnR4nAFbKAkMlwU0w2ZYq1NGarRuPk+j4UfHsblJdyMxM1tGyBDjdt9rwd95Itye1JP600qTNNbmeNFZHNDtmDVr3yvWRvxpcNH1mLN2OLcWTovf/Ht+cds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424768; c=relaxed/simple;
	bh=MY8eAzyDaP5DVy3awWgMxodlcnWPUFKzXBdeLXpV/pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcWlFzwNsSACUcxoQUkpWs6Z/bICDYbXVmVk5bfE42s52acGCji9FxWtJ3M68RKc+1zTCMjeDNF/W/E3/PveY9kyGHPCLfzpWghR0ymfU1DKLz1Xrjeg1PphDmTkVkkdyzkFPPqlmSqJkVdYXuclJQCsR65bcMlsYZcvj1uyuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1di4U7j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1di4U7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757424765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BXqa/2VkY+MYk3taj1l57EoqmZshiIHmHuWstQftUs=;
	b=U1di4U7jNkqiWrbGMje9tfZ409biW8EVfc2U2xIx2rKT2DxOWydcW0tYNlAUMKLxxWm4hn
	XpnaYKNhHb7l6AOk8k0zzbxdkRdiH04zPl3kO6Zg+5Ejzjj4KHsh3jME59hBmW9C+W4x4O
	rXQYv+WtcvhHnzKL70NTcMMiJ2WLcq0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-2iugDZeIPuO7Vf7gf0CKVg-1; Tue,
 09 Sep 2025 09:32:42 -0400
X-MC-Unique: 2iugDZeIPuO7Vf7gf0CKVg-1
X-Mimecast-MFC-AGG-ID: 2iugDZeIPuO7Vf7gf0CKVg_1757424760
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E93CA19541BD;
	Tue,  9 Sep 2025 13:32:39 +0000 (UTC)
Received: from localhost (unknown [10.45.226.196])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA2163000198;
	Tue,  9 Sep 2025 13:32:36 +0000 (UTC)
Date: Tue, 9 Sep 2025 14:32:32 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com,
	Mike Christie <mchristi@redhat.com>,
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
Message-ID: <20250909132936.GA1460@redhat.com>
References: <20250909132243.1327024-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909132243.1327024-1-edumazet@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
> Recently, syzbot started to abuse NBD with all kinds of sockets.
> 
> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> made sure the socket supported a shutdown() method.
> 
> Explicitely accept TCP and UNIX stream sockets.

I'm not clear what the actual problem is, but I will say that libnbd &
nbdkit (which are another NBD client & server, interoperable with the
kernel) we support and use NBD over vsock[1].  And we could support
NBD over pretty much any stream socket (Infiniband?) [2].

[1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
    https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
[2] https://libguestfs.org/nbd_connect_socket.3.html

TCP and Unix domain sockets are by far the most widely used, but I
don't think it's fair to exclude other socket types.

Rich.

> Fixes: cf1b2326b734 ("nbd: verify socket is supported during setup")
> Reported-by: syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/CANn89iJ+76eE3A_8S_zTpSyW5hvPRn6V57458hCZGY5hbH_bFA@mail.gmail.com/T/#m081036e8747cd7e2626c1da5d78c8b9d1e55b154
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mike Christie <mchristi@redhat.com>
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Yu Kuai <yukuai1@huaweicloud.com>
> Cc: linux-block@vger.kernel.org
> Cc: nbd@other.debian.org
> ---
>  drivers/block/nbd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 6463d0e8d0cef71e73e67fecd16de4dec1c75da7..87b0b78249da3325023949585f4daf40486c9692 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1217,6 +1217,14 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
>  	if (!sock)
>  		return NULL;
>  
> +	if (!sk_is_tcp(sock->sk) &&
> +	    !sk_is_stream_unix(sock->sk)) {
> +		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: should be TCP or UNIX.\n");
> +		*err = -EINVAL;
> +		sockfd_put(sock);
> +		return NULL;
> +	}
> +
>  	if (sock->ops->shutdown == sock_no_shutdown) {
>  		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
>  		*err = -EINVAL;
> -- 
> 2.51.0.384.g4c02a37b29-goog

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

