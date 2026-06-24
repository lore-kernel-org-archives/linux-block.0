Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232D3BFAE7
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313805; cv=none; b=Dbb5xk9lJ4V98lFUsbrU8Bx1xP0I9BYhn63LUwI2AGp/qt/+9xziwhbk9C5W6FvHPTWHTea62sZdqQe1hhoZOkj5WpoVTlDQPoKQQmuPx38eEbHMofxENxIzOdBF9erhfs5Kr7EePmcTMAJMSvypA7cyC3laRkTemo2S1QhIoos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313805; c=relaxed/simple;
	bh=TMmaIx3erApkdCYxKGQAiOLnY7LROACCo+P0YiIoosA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm6rU/Ww7AISdnrrsPvvikpBdAvLhlx1i1f0WcAc/glqU4yfiybo2cIaxAY2y1NPExUExRK6+KVsFLLbjDuLA0P8K8VF7I4+PQqBjkSlxUJCCyOVxpVKcFumJf+lA7Ov0YthUzpU7f5HcLVeEYkLmAjWs+EudPDQ12qJ0XYIB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8Sf8K18; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8Sf8K18"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-808cdfc2d34so9656187b3.3
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782313803; x=1782918603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6KADXu8NtacFXidogjf1X9Fv1eYdBXSvAj1mQKHRXc=;
        b=k8Sf8K18EhkQ4mPfN/5CCkugvPGZ0VJUsKdqgbw1GNHidS66mR15YJj+OfYSZuqQ7H
         I89RJVhmupsWTxb2bgDx3Cajd7ejK7FaZbRuhY2CaY/bDjisWt7ApyVRae6c78UPExcJ
         VVtizanEwAB49391BXak6saOuo6dF0KBvvs1w92HFjDLThifkIT0wwV9KWFCk/ejheSA
         IHY/pJjq2s8EadVnL4Z+OU1Oy9jiEyxnWGli2w6oToCTVbhycefgK5eQWsh+5ZuMHQ5m
         yoWzkBeZEymRQRfr2qxci5NCDPxS41SAWXq+mUjbtuDqE0gh7MjfVg6NBmvZSmb4huKZ
         24rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313803; x=1782918603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6KADXu8NtacFXidogjf1X9Fv1eYdBXSvAj1mQKHRXc=;
        b=XR1EThtS+lpYh6l8NIUOuBhoyze5gR1IHL9axtsCWPeui/Ra/nmPoaXuFDNZDAer+9
         48gYw8xU2gBhGa5dIarSmrVyJ3jvQpLFKIxxNPiUjvoWFkc9vHl+kgKtkbTZfq50ZIsY
         3rxzjoX5HKTqUFXVSsxg13PvFY9kXACXX//YkWzTA6o2AQ0n62gqEzW0HpdyBG1j2o0k
         /SpqQR416hlVah38rTjIMWQtbi8GX+FFx85TKjvq3fLeaOTn2TtCblNTY0eqUOJ3fat1
         47GTDELW2yYCikUPhAtP4A88QIkFcVfdlLdqeG0rhb8Bv9qODbjLDnflkHHSo8FA2MR4
         ym6w==
X-Gm-Message-State: AOJu0YwI9CFhAjZClpXpcXdCUepD9kZup5vIBq0000CyVyanU33vTtRz
	sFz1wRmgM0AciJkNegDXPCQJ7R05OWtQhIUXGTk1krPgLBg/VAyQIysJ
X-Gm-Gg: AfdE7ckIQtCXbYzdEzChcktAwFTm09lCTiWEkGLF48eyyfalst+YJuL0IUE2c872JPp
	KkPra4J0Vefwn3RK2PCkT9/bHGiaXR8AAI2G3XgX9vd8xuoqH1Wq7XRIcCycy1uTkJM6/rZc4qL
	awkkNyqY8+92NYYmy2URU69qAXrBW1qJIyK8gkS408zBwWNbl1/LJ+P3g4A2z8okfQgX9ndnhji
	YMdnBjGRubTc0wf1BpbzW4cYW2vYG2yHAnyNR8v/jPE2g8q2yM23Hv0Tcu8ZIXBxvwz+0Sm/91a
	jYPYuoQPGQVuatx87jkMmXJffxLjpDDP4QPPcXpSDy3xzpPXzoSch7lVfuayvUxZ/YGykNHBEZ4
	cjmoev0JVzD2aDnYIIcXIXbYvoQDP8Y0oG3g5GjddehTRZttS9e0JXuZr86HwtvvUznwm2lLK2s
	t5J1OyoBM4RM6bJ8DghyRXekATWqdIu2U8EZ4T84tL3jPLuipJZ2RR9A4bNGg8kYBkJ9ntdHlp1
	gonblQz
X-Received: by 2002:a05:690c:e732:b0:806:e2ad:534d with SMTP id 00721157ae682-806e2ad5685mr63025537b3.7.1782313802899;
        Wed, 24 Jun 2026 08:10:02 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025f8de144sm59467307b3.25.2026.06.24.08.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 08:10:02 -0700 (PDT)
Date: Wed, 24 Jun 2026 10:09:56 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH v2] block: serialize elevator changes for the same queue
 using a writer lock
Message-ID: <ajvzROGGO-9JWFHk@fedora>
References: <20260623013238.642052-1-shinichiro.kawasaki@wdc.com>
 <ajum7l5BPDRoeJgi@fedora>
 <ajvCBkxdTCNt9JWI@shinmob>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvCBkxdTCNt9JWI@shinmob>

On Wed, Jun 24, 2026 at 08:48:16PM +0900, Shin'ichiro Kawasaki wrote:
> On Jun 24, 2026 / 04:44, Ming Lei wrote:
> > On Tue, Jun 23, 2026 at 10:32:38AM +0900, Shin'ichiro Kawasaki wrote:
> [...]
> > > Please refer to [1] for details of the failure. Also, I created a
> > > blktests test case that recreates the hang [2], which I used to test the
> > > fix.
> > > 
> > > * Changes from RFC v1
> > > - Instead of adding a new mutex to struct request_queue, replace the
> > >   reader lock on update_nr_hwq_lock with the writer lock in
> > >   elv_iosched_store().
> > > 
> > > [1] https://lore.kernel.org/linux-block/20260611074200.474676-1-shinichiro.kawasaki@wdc.com/
> > > [2] https://github.com/kawasaki/blktests/commit/8e80b3ccc0bbbe3f209d00eacd138d020de97fc6
> > > 
> > >  block/elevator.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> [...]
> > I feel this is still abuse of the above lock, which serves writer vs
> > reader wrt. updating hw queue.
> > 
> > How about the following fix?
> 
> (snip)
> 
> Thank you for the idea. I applied the suggested fix on top of the v7.1 kernel,
> and ran the test case that does the concurrent write to the sysfs sched file
> [2]. Unfortunately, the test case hung. Before the hang, the kernel reported
> WARNs in sysfs_create_dir_ns() [3]. KASAN slab-use-after-free was observed also.
> I also noticed that another WARN was observed during boot [4].

Looks this change isn't enough, and it is a bit hard to deal with the
two-stage switch by re-lock, and it may require sched debugfs & elevator queue
reg/unreg refactor.

Let's fix with your simpler way first.


Thanks,
Ming
