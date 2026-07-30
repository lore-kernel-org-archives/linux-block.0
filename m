Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1B3EC824
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452353; cv=none; b=PFDQ+YXxJnXTXKvphwJmWCofBDUFNPo/TqsKJDOTAIfLj+uFKCLNT7FnP6S2ZI74w3qmJZVmkM5EzOj5HpP9008+u88zaBkcIbpTOxH9rwKDYOVjNjmdXgKOcNwCVe9LnVQ1E5Y3KrdlomThsn1DQRRX4hd3i3ItwnHk6IIxUIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452353; c=relaxed/simple;
	bh=wpO1t/7FGPKrcFhoNcA92Vi0PmjZQCcIGe0oiSegWrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRG+46nAQdJZuSAytedEEwTc0HIWI1NaWnCls3WV3oyXvtU3liTLlqov2JaXuobSYu6v5WE1RJPUopPIO8KkqWO8iWxew78PGGLZBPNAX9NHBb1Ej6L/WCbJKaCiWOhZeq1P+z7WGrsP4To3fSHosFcUaHQwFjfrJuZpxNZ6VMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UapOI+Vs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSo1hEXO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UapOI+Vs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSo1hEXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785452349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sx+8dGfrU/EPbcECFTxS2R77qIQIIRmUdLHbVGAEsZE=;
	b=UapOI+VsibK5Uol4nHBOSEdTA9wpIfbmOJE9owJgOqj18oejfhR0tdhrOvcPfJWMQakos2
	0zbpMqx75FTdOZffgUEjJbveET9kAJqCtCUPMdHPuYS7P4eye73rqxP/rep2jPYTgYKEr0
	ueZjqCJZR4wqGxvJ6mv31xHhOkZs3Co=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-RCiTUlKNPfqtEG7aAvjwDg-1; Thu, 30 Jul 2026 18:59:08 -0400
X-MC-Unique: RCiTUlKNPfqtEG7aAvjwDg-1
X-Mimecast-MFC-AGG-ID: RCiTUlKNPfqtEG7aAvjwDg_1785452347
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso2123315e9.1
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 15:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785452347; x=1786057147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sx+8dGfrU/EPbcECFTxS2R77qIQIIRmUdLHbVGAEsZE=;
        b=XSo1hEXOb3LtKVNxsec/0HaM3v/PCGYYphLYn3mS0cAteWMTyMZ3SFA4G8E9af7GBP
         WiM7cNqAwP2b3kOgGdrwAhfkukyapsm/189bXSJL4tkMeGFlkPanRxHyQ3iJc3bA1RIy
         lam0FQQefX8nG8lpRdjSrRpMPqaam7aarbi051z7FSSztYF+atKRr0spaJNxDxQqSjiK
         tHMEbT/zglU6wZTUptL7mrKYIW8pH9em4pqVVTgR+kzWMGE+UvVhZWBqa1MJRcOUMc5g
         TWtXk/6U5Vh18Q3ZFyDHAs/iQZrF9jgryJgRjmMYNHiDGLW6J1V1ygHCKCS/Evd9RSqc
         PvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785452347; x=1786057147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sx+8dGfrU/EPbcECFTxS2R77qIQIIRmUdLHbVGAEsZE=;
        b=VEFnXSREKvRHhux8+awTp4lyb6xDadru+bICRhCiaoOzs2QqyhATtH6d678ppI35+3
         5KqfyoNGfSKXURY81j3dAIX3ww9HUBu+oam1OFR6CLtWTGGDKJGjTuZOLthfmZX2rpTS
         5GWydzVjBVggeavbr7PaiTfBR2AU2umEsC3XeHDlRviP34Fha4ba/d51OjB6OLOFe3SI
         iikbFfeUy7SESFUjX1kMUsKFvUNCJFqFMIVtx6PQSjwnxn0Zm08LGkqzmt8VciwWJ5Yu
         RWax90IN0ul27ZEfrzEr3aLzbWVy717KNZ0F8oowHDnELxDqVzzbhh4Z1dHNhij/17DS
         VlIA==
X-Forwarded-Encrypted: i=1; AHgh+RrTY4QZxcUj5h9SqUKKROswl36G6fGGZPZ14knF6I5FrrVFZvikmhTHS0xCmghpKVGUFtatwnXh9GpiXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgtbSinbylRUFdPXODfCZ7y8YPXEfXVEOWqYMPZSgUTxpjoi0z
	vBFvigo/YnYHcKfO1y4T7yhB28WaIdhnZ3klNVW9UOfLEzSog2VpyesUrZAjdnuxt+tQZWSVmDp
	BHmdHMx5YxPqpaW3SyLjS1cv9v5pbeaGqimzjjMwlHMe0v9ATtibjK/Y5orPDLron
X-Gm-Gg: AR+sD11NeTt0FA8bAwj4EWFrv8G7JTIyr36pwz+MOi8eaq8fRa2P7hoJVAkcGa4iRA0
	qZATx0zGRgJYxWJv8b0XVXf2P88TdI2pBgHCAeu6p6gWinthDmnSoQVZDBBI81aodSBchYn2/jw
	Zatwor+pO4L651MnHgTAIhOXORfTFu4Ash1Yg7cK13+ba9Rv2e3eiYV2u5wKmXSBhhntcVCq21j
	X8ZhanyNIqmyErcHWH4wtwTG1bwMSmdlje4BmQaJxvbhz2Nu3p3hnNzLiFh0XxTBWH9MfQG8MuH
	BX/rKMnYZugSNp1Xze6ByBg7jSmNJ9csjk40YnmXqrDTc5Ac6CiSAV11ZwXs6NGa2rztB5IbAsJ
	sqh0agrZh/nbKP+G5AOt+AkY=
X-Received: by 2002:a05:600c:1d15:b0:498:490:3bbe with SMTP id 5b1f17b1804b1-49804903c27mr34934985e9.16.1785452346897;
        Thu, 30 Jul 2026 15:59:06 -0700 (PDT)
X-Received: by 2002:a05:600c:1d15:b0:498:490:3bbe with SMTP id 5b1f17b1804b1-49804903c27mr34934755e9.16.1785452346444;
        Thu, 30 Jul 2026 15:59:06 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49800f1a91fsm89806315e9.6.2026.07.30.15.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 15:59:05 -0700 (PDT)
Date: Thu, 30 Jul 2026 18:59:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Octavian Purdila <tavip@google.com>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH net v3 1/2] iov_iter: export iov_iter_restore
Message-ID: <20260730185844-mutt-send-email-mst@kernel.org>
References: <20260622222757.2130402-1-tavip@google.com>
 <20260622222757.2130402-2-tavip@google.com>
 <20260625-erstbesteigung-mundschutz-invalide-3b0d4cd4cbc9@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-erstbesteigung-mundschutz-invalide-3b0d4cd4cbc9@brauner>

On Thu, Jun 25, 2026 at 12:43:18PM +0200, Christian Brauner wrote:
> > Export iov_iter_restore so that it can be used by modules.
> > 
> > This is needed by the virtio vsock transport (which can be built as a
> > module) to restore the msg_iter state when transmission fails.
> > 
> > Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Octavian Purdila <tavip@google.com>
> >
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > index 273919b16161..f5df63961fb2 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
> >  		i->__iov -= state->nr_segs - i->nr_segs;
> >  	i->nr_segs = state->nr_segs;
> >  }
> > +EXPORT_SYMBOL_GPL(iov_iter_restore);
> 
> At least only export it for the module that really needs it. For
> example, see:
> 
> EXPORT_SYMBOL_FOR_MODULES(__kernel_write, "autofs4");
> 
> -- 
> Christian Brauner <brauner@kernel.org>

Octavian, you wanna try?

