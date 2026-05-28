Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74122A80D
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 03:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779939165; cv=none; b=T4RvG4e8fEe+hDyKld9hk4qGtmSbR/fxbnNCcVD0eTck98qgA7gvAJnNqp0R4XcIWGPVE/y49T2uhBAnJCUp407Hv4mmUouGBtybN8vIVvHxhkPVzzMvlkbOsW5KY5clQR5XMfet8pksCHTHEQfsgRa+ULXJ4tHXiU2bCRH04BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779939165; c=relaxed/simple;
	bh=QnwOPqkHUGkwv/OHUllmIGh4fJMrAH/08yz6urN2540=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF9L+EVj5UvORrqDcjqAUYE+X+2U5q33NBnbWn7UvqJoNleX0zOMYxPJYG31CbCNd+zk/z/WvlUrZtn83QOu+Ldr1Mf5iopyVcbYWJPlkcpVOP3GsJeE3AO6LaV4rONvTq3uWS4MQwSJ6zxI7Dt1cYH83e0+7IJxjzfGqVa0G5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWGBR276; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWGBR276"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8cccdf044e7so5402056d6.2
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 20:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779939163; x=1780543963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5uXlb9DClg+oUz25HJ7qILql8lXt55AWGux+JMMJXc=;
        b=IWGBR276xN0N6CtsanF2zndAyKS1IKkH8Ur4BmE2kzJjELjuZk0Z3plHm5QtdI+rMv
         V/D2WjDP7Ge0XaGN3gLqJqxcJoMR5S+dqNrdgQKlDCpiIDqZ6dhvnMcOx9Pl/orRXAjs
         dICzxSyrgk/YsSKph3y6udWNxgOJjT/2UuUm06RFP2BIbiDw20fynCY7v67JpLVJKtZd
         yet5ZAef7DNtlTJuAigAUgZJfbxxRe7jQ2UaR5AiuEXdoExNlOPTffQUwfxscS+DT/hH
         ac/gBH+dGdcTy9zvtAB9g7Ir8r7faRo+ObLWzLa2VK3b2IE149Kqlrq3Cro/xs31tGeT
         wPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779939163; x=1780543963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5uXlb9DClg+oUz25HJ7qILql8lXt55AWGux+JMMJXc=;
        b=kNogUwS8S+3kzhmvkKnIFshYYaLe6HeIXHwrkj0S+I/EksCzxUjoKzrOsi5dSzGEoA
         36jT//FF+9BIuYMFzbvqsObdg6dob063ajCIJoslGAWIJE3EUUunFmGd0n6xWbVcf0Dc
         NsfeInJU5mYSVknEWB/yf1+ggeyEMqQG/yC+rEauvnRc8ASyCvrWO+0WMSVkZ3gd89DI
         Q43/hZM6kCDi1ERVxgA8D3voZF4QMNTU49vtGfPNA+4RLumw0DMEFYFw4aBKKlew4Hew
         zW5WLVz1/K3xyg80do4SuTx9BFsT391HhMqbAz3DLF8fO+cl+Hd6xNYj0q8IKzweBDp9
         Mm0w==
X-Forwarded-Encrypted: i=1; AFNElJ+epWTfbhkbPUG6wiwfT3v918rfl2VQP7puIQ9oZk1l2qAvDpX587GBEuXrbtS7/RhSv2i65+DnZvuBbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVpaDHDHNX9lonCPayVkyFYDVBeKUqvlNjU7nbpmKkomg1QJjw
	1ALvXJNDOuhwi9SYV9gIcyBz/uHwx15fqs0r09PhKs7vTj/wyx1HHyQw
X-Gm-Gg: Acq92OH/NjBNPg1pqLfcEDT9XlGnz6HbsVRwelqkEA5vX1aJbPKH1Q0ATAumcoCKPFL
	LAwIVie4ply5kSx9jt5FegfzgtnesGXuZKrNB9UwPg3AWkKTO88371wjqWOn5kXL9VrqSJns2Jy
	jebhEHOTbstKSEQttT35DQgraAti2EUkGAKTqNH/icBLAPLzQvo9TE36RLNO9LBgzv4uGX0BKqA
	IIiOnh2Oc3yIfyw3LxlTRPwdDqYtaYv+KIGY82Rp8ZaPNn4pfdvdJXo9C9Ch1WvxjwAvktbRLFR
	aHaO1DRGIhVYLlGVyUNrD04L2LRGZoYneYxV3bEELdhiqi+OGsK19t6tBX8tHoBPRayoKCTwOly
	2ithgAGyn8U8FENk1JmIvoiMxd8irnxdsYA/T8zERPmQZNbLEVJIUSB8G3W96fJouETj7+UiulN
	ruH+nx/gW7+A7p6cQW40jqh04/m6WEmPdNgmcXMTUWlCwvU5lwn3hWHHo8YOBFJ6d//jcaqkQO0
	y2x47bwI6ky50Edt4uN87EL9yg+FaHSLOxtN7V/Z6A=
X-Received: by 2002:a05:6214:246e:b0:8ca:10aa:e1f9 with SMTP id 6a1803df08f44-8cc7b5d16e0mr418713706d6.42.1779939163439;
        Wed, 27 May 2026 20:32:43 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccd78d2ab1sm795366d6.6.2026.05.27.20.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:32:43 -0700 (PDT)
Date: Wed, 27 May 2026 22:32:37 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] loop: cleanup lo_rw_aio
Message-ID: <ahe3VevXiPHqxOGh@fedora>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151043.2349900-2-hch@lst.de>

On Wed, May 27, 2026 at 05:10:20PM +0200, Christoph Hellwig wrote:
> Port over the changes from the zloop driver to remove the need for
> the local bio, bvec and offset variables and clean up the code by
> that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
