Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399881;
	b=RMwXb1V1NzKkp29Av1j/OZbaLqSrSPPWMt/+qoOUkV21fvKTrhPaM1MSgbSssT5MekvY
	 C6PqL6LZ+5KeHk32QDbex9M40L/wsMfeyhwZRVhwy86GzHRCIj0QzmcqPz5E2t+yfoTQO
	 bzvBtAtDMUYAAb+TtNma4CBUoh4SVPCKFO6hzen+6sHrzuDTfN73bpTLxA3FeUifSP10q
	 40JHNwl7Px1X2Yy/I8PUNP8lXL2RaVBFKuFZMaOnCsU55dLYWcEKwZjGn2vvMJGq9gQgr
	 9z8npFrZmdFdbTDako893pnVm+YNtKFUk95bA0ek9bUluyUSTBi+Cq64QodOXyfgMnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DdzABbJ3RgjxW/78ek3zCU0rPzdDrV/VzN4+B24AkVE=;
	b=DirekfPdDrdXnBv+H+0fRtuQB4nrYwwlOt7MCMO77YC3+W6bJ/TXsbUfBR8TmjYKvLkj
	 rNZmHeJs84CC4YLLyuDPfPovYiQYV18R42gJYURyd+XYxGcx4pGiBatO15jOTG7o8frIs
	 DnzeGsTeRQTw6GDqNg0IzFCgUZj9aHpC6VY+eJ4UY25qVL8cBPHHhL1VvZWpLh9u7FvzN
	 ODEz+6pfTwdnDXTQJEOOwfMWUXAjmzOn4Mh12A7afSSK08bSTifmVYz9ds+oIV22zeKBd
	 DNuofLXe0TNWq18rTpBFdHJqNHCxtGx85z+fvbjeQ8VUBOV9rtkxzViduQNF5S5jZ0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alVT57eR;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E751606A327
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 12:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E751606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=alVT57eR
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-677d35fd1d2so3644772d50.1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 04:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794399880; x=1795004680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DdzABbJ3RgjxW/78ek3zCU0rPzdDrV/VzN4+B24AkVE=;
        b=alVT57eRRL6E2px45UvVQ5T5CIGC/a21x4+yb+XK4/5un2R19jNsbDZsIdfIdW+pUc
         Qarbx5jjwe9uCps/Te/UGrxdMvSk/8ow4Fm54lcIsPZ5Y34AtasIahOUWMhu6EjOIuvE
         szZAVW00vQHGK78ASKqr2f1JGFzJJ3M1rlVZa3GxF83wFgULdyHiXRVKC7wn8ZZonzrp
         5FitUDVZfrMpPfTy1bl0xUPfhD43uk++AQWFpPjkDA4MSOc658NqCu2nBmWo78SK1MsD
         yhHJipZtzOWkxa09CVCsZmKjGImKWf6Fd+WfJAuUKRj/5Eua4uaWM4eSf4BN0YC60NC+
         SQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794399880; x=1795004680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DdzABbJ3RgjxW/78ek3zCU0rPzdDrV/VzN4+B24AkVE=;
        b=Ul7Qdl1RCe1lygBE8b6n+zIlT5RuPFMwT5Qx45ON4ug+RLmt6ow0MjxtQbsn+nf2Qq
         ZEdrZrg26yCNo5BQlSUm5wmJiB4B85VNPZlW37pQiSO644qLKn0uabgPjHeOYx24hl6m
         fjGT8pUCrDVJr3xJqjhI6swAP/FsZc5Dce2eb3UfuzX2goQzGarzjN60UG4VEHuY/UCu
         ICX2yP/uF826ywPyoeIA9hCd0sOQB+u0YKsSaSfGrH5vcJ80Oo0gfGs4nDc9/RjlHFFk
         kdzbsoyoNGuqpw3z1nDwvg+62NYhC6PNAXEEWU1gx2s5fc0Ws+6/QSeqLeKK/1tFhFsM
         qHTw==
X-Forwarded-Encrypted: i=1; AL+hErGfrwMIcsie0W6OYNsN3s+l/tos50MetCUJiksZ0yrYvpWOo7xVnq7rp94/ip9iTyVgArbrpd3UBOZ2uQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9v+Uqhriw+5mHdzdU6lwvd8QuJmGwZUOhJh8FF0H/LHqRqCB+s
	u2toQQbNs1dV82FQK3eb5CoMflcQMGnwY3MgY36ZmjDkQh46dV3iV9P4
X-Gm-Gg: AYBFou0DoOvikU/DoSy4QSOi8tO4pePwwkljmI77MgWEclEMDLif3eYGxIx4bNgMv2R
	eE+6wM4yO28VGjRAnUyhSG+CGAMsfymTogj1NIukczfiHXDsqA2WAJlF+4Y9iRgtKJ14L05XUCz
	brmMhhrQqJJ/JvBm/KYVsA6PFivmRbU+czvCy7yGEQJC1PZv3l+Xs9+RRY36igUfZ4tioJxwrZv
	5CBzvDQdl1ghWGNEifC9NBi4tsPCFc7CSwXF89czrgi+dUa9VDYOsOsXqPozrz8jWpwaS08f5jq
	F9LIyEO+6EsJ1xMcx0sQ6lT4ZmCn+3mlwCRLruBI1YPM+NvL8hxvxrOANTyRmc4AGrBfDP+1OQT
	ufE/IhifveekxlPItbJR8ffTjt9xfjB+Kw0RnWRnOE/kDsvTmzcuGiVDgaGKWSrjI+crrKhajuM
	q8+xeTkxXCw2mgQSDj7rmMjdX5qptIUmEMqD91K7StRWY54lLaekX0QOOd0RGRV3JIkPjA10Qy8
	Q2gnzOE5tzqmfmF9BuXeTeySWHwGYfSSKj69681KlMqfBlzeG+xRuKNykZprlLg2Ujlv1mLeoa3
	O/PImXOkRMxg0NJdrzxL3Q6RFrglTm+Cl820jwA0ylc3ujLQCqKwX/GyxdiTxwdEr19nMnHYgAn
	p4/tRgOy5
X-Received: by 2002:a53:d7d2:0:b0:67c:11e0:565e with SMTP id 956f58d0204a3-67c67fe2c73mr940727d50.31.1794399880211;
        Wed, 11 Nov 2026 04:24:40 -0800 (PST)
Received: from fedora ([187.120.157.132])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589c2ef4sm4379780d50.9.2026.11.11.04.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:24:39 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: trintaeoitogc@gmail.com
Cc: axboe@kernel.dk,
	bvanassche@acm.org,
	josef@toxicpanda.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@other.debian.org,
	syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: fix circular lock dependency
Date: Wed, 11 Nov 2026 09:24:26 -0300
Message-ID: <20261111122426.225742-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261111101919.215767-1-trintaeoitogc@gmail.com>
References: <20261111101919.215767-1-trintaeoitogc@gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Guilherme Giacomo Simoes <trintaeoitogc@gmail.com> wrote:
> > Additionally, reclassifying the socket in nbd_get_socket() happens
> > before it is known whether NBD will use the socket. If
> > nbd_genl_reconnect_sock_cb() does not find a dead connection, or if
> > nbd_add_socket() fails, the socket is returned to user space with the
> > NBD lock class. While this only affects lockdep and while the
> > nbd_add_socket() error paths already behave this way, it is another
> > reason to only reclassify a socket once it is really being used.
> current the nbd_reclassify_socket() is called just below nbd_get_socket() call
> inside nbd_add_socket():
> ```
>  	sock = nbd_get_socket(nbd, arg, &err);
>  	if (!sock)
>  		return err;
> 	nbd_reclassify_socket(sock);
> ```
> 
> what have exactly same effect that call at end of nbd_get_socket(). I guess
> that "reclassify a socket once it is really being used" must be done putting
> nbd_reclassify_socket at end of nbd_add_socket() (before put_socket tag).
> Maybe something like:
> ```
> static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
> 			  bool netlink)
> {
> 	struct nbd_config *config = nbd->config;
> 	struct socket *sock;
> 	struct nbd_sock **socks;
> 	struct nbd_sock *nsock;
> 	int err;
> 
> 	/* Arg will be cast to int, check it to avoid overflow */
> 	if (arg > INT_MAX)
> 		return -EINVAL;
> 
> 	if (nbd->pid) {
> 		dev_err(disk_to_dev(nbd->disk),
> 			"Cannot add socket to a running device\n");
> 		return -EBUSY;
> 	}
> 
> 	sock = nbd_get_socket(nbd, arg, &err);
> 	if (!sock)
> 		return err;
> 
> 	if (!netlink && !nbd->task_setup &&
> 	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
> 		nbd->task_setup = current;
> 
> 	if (!netlink &&
> 	    (nbd->task_setup != current ||
> 	     test_bit(NBD_RT_BOUND, &config->runtime_flags))) {
> 		dev_err(disk_to_dev(nbd->disk),
> 			"Device being setup by another task");
> 		err = -EBUSY;
> 		goto put_socket;
> 	}
> 
> 	nsock = kzalloc_obj(*nsock);
> 	if (!nsock) {
> 		err = -ENOMEM;
> 		goto put_socket;
> 	}
> 
> 	socks = krealloc(config->socks, (config->num_connections + 1) *
> 			 sizeof(struct nbd_sock *), GFP_KERNEL);
> 	if (!socks) {
> 		kfree(nsock);
> 		err = -ENOMEM;
> 		goto put_socket;
> 	}
> 
> +   nbd_reclassify_socket(sock);
> 
> 	config->socks = socks;
> 
> 	nsock->fallback_index = -1;
> 	nsock->dead = false;
> 	mutex_init(&nsock->tx_lock);
> 	nsock->sock = sock;
> 	nsock->pending = NULL;
> 	nsock->sent = 0;
> 	nsock->cookie = 0;
> 	INIT_WORK(&nsock->work, nbd_pending_cmd_work);
> 	socks[config->num_connections++] = nsock;
> 	atomic_inc(&config->live_connections);
> 
> 	return 0;
> 
> put_socket:
> 	sockfd_put(sock);
> 	return err;
> }
> ```
> 
> I don't know if this is a really good thing once that until this be executed
> the user space can got a generic lock (the same generic lock of sock here)
> before nbd_reclassify_socket() call leading to the same problem.
> Thoughts? 
> 
I back to read the nbd_genl_reconnect_sock_cb(), and now I understand what you say.
YES, nbd_get_socket() also runs for sockets that are never installed.  When
nbd_genl_reconnect_sock_cb() finds no dead connection it does:
```
	sockfd_put(sock);
	kfree(args);
	return 1; 
```

So the add line inside nbd_add_socket() that I sended previous don't make
sense.

What do you think now? We will call nbd_reclassify_socket() inside
nbd_get_socket() and call this only one time? Or is a better way call the
nbd_reclassify_socket() inside nbd_genl_reconnect_sock_cb() when we have sure
that we will use the socket?

thanks,
guilherme
