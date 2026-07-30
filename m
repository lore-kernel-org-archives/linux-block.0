Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3595432E94
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424262; cv=none; b=G/pDZUw8L8KLSJKJDxyn2LP+gaI2TUpGLkQqqcC56G6+0lLt1nGtSkPDutl9FNmrGY2rqHu6f+eYDdRosSqEVgAg744OUOSpIiilp89SYrZcYno8TkZBYTclm+KvaDAVEXJB0g5SUhx+ICYZ42Jh9ITi/d3SIs71XOOuxZ7l+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424262; c=relaxed/simple;
	bh=xirIpBqCCyBoBBoy/v0IT6Q9Vbwmez8qL3yBMeT7334=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nd8I/XxU6NW11GYc8DylSEuLXmEYIBgPkx8uOehdVMXLb4klUtZRQQdE3dLuLKdX2n9VUTZ2Ry7bGuW6LLJ3vQAP2HxflCUqPghVXPP36oPQdk9LLracsGYBYnEYU8rrvGAF78tH0TW6IMCk4b5kcyuPkdX4N6i7zZHe+MY6yWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGId40OR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGId40OR"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-471eeac43bfso2067618f8f.3
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785424256; x=1786029056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ur1wZn3EllTmAAL8HehYvjqEjFBHKpODxClktTn6wPw=;
        b=gGId40OR18EBORvT5/DMAMueZ422PRp6xR4/YgANbgaMMfRZGE77J4uUiNMkw4QOP4
         C5pqEcr6UyEIGX5D6FLNYyTO1VFdlTBWqRWTOsTzj2sGoZe4IHZXtfWJ43+JtSKMHdXr
         kP7MWeNs4G31bcRCajxkm5xNpYpW/flJ010obn6KEBxmsI1cAmHrfsbir20eEgjWYruU
         1zg+FAVWJHVj3ZGGGaTYetcHmu8w5wOTcXiIbdhIzw1luKihE3B+UAGydbR9ImVz8yh/
         Vf7F3XP+ZSnZ8eL4l2IxzHMY9SCfR0RZMyuELYTIdzPCAEml/FE1DxHWSYChwqDFsSMM
         Kcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785424256; x=1786029056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ur1wZn3EllTmAAL8HehYvjqEjFBHKpODxClktTn6wPw=;
        b=Ife/VR5/KvO/sN3I0dcexcFBoKa4euPnt3cjwf2WRlp7GKPD13hU1doeWmDLy1lScd
         qUN3TinA1Ar1Rfoyq83ue3nsOH/7ZOag28BDPQTJAxmA4FHQD1xy6XkwYLQ7IwlmE1LR
         hPlcHHsjmINH5iTD7uS9RBKFNC82XqBjSEBhkre0q7aCtoLPJc2y4MJp5Pi2jZARxLcw
         65jTWP2tOVs1HT5hoayiMudm6Fmc1lUu+WV9Sfe/CQHxIgXjGWp24cg8PkViWpwxJQ0H
         MJuPhbq4oZ3QaYH1MIQqg8yd1oN9gofPz6lzK8TDwV7Dj9PuUX2yET6FUsMS6vI/g0Qn
         7RiQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPCWHNoMN6qyE0u3TPvWULlaw0T4sniGMvpZGi/UG+6FzQ92HpESaT4FI2L9g7gDR/kY6J42IMJ5vfSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWrywRYI3xZ5ASVrAjpH3lHNroo1Hrex4Q8z41GojLBa5QxFHL
	BLi07Ros/5BQc2qz7hhWRsc8GjB3immmgkTZPE4xJqtPzkevNzEXIBTq
X-Gm-Gg: AR+sD13bkRuRoSKfB2xTrowAIzMVGcVdCSGOSpHllSDeBSus/tfl5Ypvq2fdp8kZCvY
	wyl5uHpe57wkyfbJiCRvy4Rx5baiN6TUUEXEYve3qI76Eph1gku74ZG2xtOGGaZ6eNX/6eqlifK
	ErbIfj1soDpnfRkyocOyYcP6D4b3ge1Meo1I9Hzg2tuC6PLjs4MlUHAiVzHesN7YnW14F5bAwyz
	2tzXkoZ+VQ0/y+LeXjyEA/TpZlB4mzSs0oKz2sPUv/XFKLeifaOViuufnVoF0F9SZ/mxPWBvRel
	KPqo4gal/q4BbJc+mt03BvH3raeKca3tzZeG3SHjhKhIA+QWleR5ZlKJpCNW1/Q6JlhoR27F8bM
	/43KtL90op77vUT9m0A1PdImMXbeF3WFzFK9+BawgtSbkDXsWg8ziFTqMKHwRfFnwyViBkShX5q
	7r1PIUK+kzeBMg55suel6Tg40yBPaifo5VdWrbk+jW6UhO6bTagHjSe8GpLRPQwqgnqabn2OI6c
	Ay5spcjeeLMYn77O9dieoQMC7IpmanJW0tOvQEwV5Ff3wNiQOixjg33ZDhGFaMPxCLb
X-Received: by 2002:a05:6000:41ce:b0:47f:8f8f:e494 with SMTP id ffacd0b85a97d-47fc80c3328mr4307244f8f.2.1785424255901;
        Thu, 30 Jul 2026 08:10:55 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc892cc3asm7729052f8f.23.2026.07.30.08.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 08:10:55 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:10:37 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] ublk: initialize io_desc on daemon task
Message-ID: <amtpbb27v0BlRYV5@fedora-laptop>
References: <20260729012951.3744582-1-csander@purestorage.com>
 <20260729012951.3744582-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729012951.3744582-5-csander@purestorage.com>

On Tue, Jul 28, 2026 at 07:29:49PM -0600, Caleb Sander Mateos wrote:
> ublk_setup_iod() is currently called to populate struct ublksrv_io_desc
> on the thread submitting I/O to a ublk device. However, only the ublk
> server threads read the io_descs. This basically guarantees a cache miss
> on both threads for each ublk I/O. There's really no need to initialize
> the io_descs on the submitting thread. Move the ublk_setup_iod() call to
> ublk_dispatch_req() (for non-UBLK_F_BATCH_IO) and
> __ublk_batch_prep_dispatch() (for UBLK_F_BATCH_IO), which runs on the
> ublk server daemon thread before dispatching the I/O to userspace.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks, 
Ming
