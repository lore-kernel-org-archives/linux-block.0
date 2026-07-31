Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E63B6BF5
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514448; cv=none; b=hiyz0F09t9mtAs+r1wTsQyq1/0vXW9ZV1FnWsJUe7H3dV57BNtoGroV0qwFW2TDChhmDuFnhjMZUWY7wGfnZMLxuCClk+g+cl98WMiiwwdMNK+aPMsSNufjiEmt5MQyFTEaP5Tr/A8E1saTs9yMIOmp5DQEOEmkCNlwR+pjEx6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514448; c=relaxed/simple;
	bh=t5WPc0vukVLNSnRJ0X0x9xjzAoX7ywREHbC9ScrUbIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcsrZRaxQpHo8ACSvQccn6fjJGfoeZCrN+jVpvk4/K0+vo8ezvQ2dnmewrH1Yz+Ex4oq7Xn/P7ve64O641bmifDdfspyaKFj6EEG254Ruk0Vp7Dfx+egDByr4zcfhFp9VzPTWWFEpXtfYAmbAC5kPVqImaU9Jyl0jfd5ntr88zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BW8F+rwz; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BW8F+rwz"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8143daf89c7so11688367b3.1
        for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 09:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785514441; x=1786119241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BiTQpXHZYhKqKfQHPNZOGBTLmdJuUbgI0LpBj5VxyKA=;
        b=BW8F+rwz4nJznVq1YhWfyPP8Ot4rRyEA4g/PgHvyZbg3WYv7WNIZckz1DMKPyBJr+v
         MuZpSLQJzaRGd470m3YA9nxWj9CamoCGc08T68BwDD0Kblpap+frjMPDmjabZNtKutCQ
         338K1sleRi3afGzZUsjyAjF1ww4jjdAeA2eqxswLIexUPagkqAe98b/Wnqesz1xdSXow
         DsrrFWA3SozBbDBJ30VnFc5Bje2opwmoeAu3HULdkT2EqyeYKLBXbpsc3KzPfUZi4766
         N+yDE2HGzQM5hxQN/UzusrfgN41OMsBZ3B0ahIO2rrosR0Hwf7X/TIx973Igx1DCCdsX
         wgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514441; x=1786119241;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BiTQpXHZYhKqKfQHPNZOGBTLmdJuUbgI0LpBj5VxyKA=;
        b=aT428BebCTTLp0hjXqtaJvV7sE1X9BzJD6biQzf1S1Hs8KllMnn+Me4feN/OqR52Ne
         EmEgXfGqNMbIo6tNxm7PYsIiEmKfS9tiwA/9xNG7r3f4OUgW3ht5qL0KQ1h8v7vp8UC9
         Aah1VrxRyIUtnH20xUQ7jyy79+Smc+lcEQ5kWbWpauiZvuFQk1RD1l5Tmee4JmxNHtLP
         igA0MKIYmBuqQs/gNfjlLsUlc3fTzhGCgNQ/65b39gearSRZ8ysb6wZIgtwD9D9AlKyj
         VxB8xXXO74nhjyT1jaGJQXtzRxgdORlNqVUVPhz47B+QhUP5ufcms3SjtEzE/nAW2QOa
         STwQ==
X-Forwarded-Encrypted: i=1; AHgh+RoyhweRr0aTEkRdopmwzZaGUDklMsYAPs/qP3ZUMwnJhUzSXbKTHkGtwQ8o5k/WPE20KJND+okKwyB8+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4jJuVbhUgO1MqixJZoWIfB7HQOM6/zCwBO/dVxr/c25j0SkWb
	aMyzut8z3xPMuTtKN56QYcDQl91/aF1XCoj+NrzdoHEcclMf3UJh28Xt
X-Gm-Gg: AR+sD123Mybr38fE60a3N8Xk+ekamuhpEy925ZcMCXtTmmr/TlD10/rVP5IjYBZ2OEE
	p7hSmsjx8rkmlK3xQHjI1LiQ+adb8LgC2zqNqsN5C7TE/pVzvOnhA75ouMUdQUh+aY5JpNVO2rm
	pM8QdbN3R3KSgVg3T3AdUlUgmw1c5BTT2gwQBprSa9P61gueDiENlW/YBl4t34SjPKtco5v89fp
	6+weQQhRk1Lr3Fa6Nc8Fq2KLeCxr3Q4Jhj7GoQrugYBOEhogIttj44H8apgHjrumUufQ9Gu12tO
	IVh2pADfFDh69tUTQ9cJPNlY5yL5noFd58WOiYOOQO6oQO7xdU7YVUGoCF7+3I2qQ12tP1XAoZm
	QnQl96Uq6A7afR5yWhSM0aPUbo85ZA+T2NaerHOyV0JX5EoZoUu7I8qAZEIiivQfVE8ZYzW6tXp
	GBjsQPjt6CXdkGNeb8gAxmnPkGhNHKxQSqVWlD3LhUU/kZeIX1gdhjwR/k07OQEFFhomnUXK0UM
	dA+JIAeMtOK9Cbp7j6Y7Jb6Ntw6gGiuNCLC5xuH9nzyVK302FleCiTKQojzj9Q5+SnF
X-Received: by 2002:a05:690c:4b89:b0:814:4755:2b2b with SMTP id 00721157ae682-81fd49b4a2fmr6594197b3.3.1785514440979;
        Fri, 31 Jul 2026 09:14:00 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd133d96sm9003417b3.44.2026.07.31.09.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:14:00 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:13:42 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH v2 2/2] ublk: clear auto buf reg before updating io->buf
 in batch commit
Message-ID: <amzJtuw3YMgfLcl1@fedora-laptop>
References: <20260730010910.799346-1-yangxiuwei@kylinos.cn>
 <20260730010910.799346-3-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730010910.799346-3-yangxiuwei@kylinos.cn>

On Thu, Jul 30, 2026 at 09:09:10AM +0800, Yang Xiuwei wrote:
> ublk_batch_commit_io() stored the new auto_buf into io->buf before
> calling ublk_clear_auto_buf_reg(). Clear takes the unregister index
> from io->buf.auto_reg, so it could drop the new slot and leave the
> old registered buffer behind.
> 
> Fixes: 1e500e106d5a ("ublk: handle UBLK_U_IO_COMMIT_IO_CMDS")
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
