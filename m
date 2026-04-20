Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE62381B0A
	for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668581; cv=none; b=WqHzhJbg41imhYh2GPVW+D7XT2XAZzuRqKTIc5g7s+G3kTkJAXfMr65jrpLbEqZmJiv5SCRsBCf/EzpJHc2dpUVHK6N+S84b/3VbnUTC/ZYtk3NKOFKjYqC5yLLJkKxwv5DZS3ZHgKzIhobw4wh50EbCbGn34k7DX8ChPof1pQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668581; c=relaxed/simple;
	bh=Zr4VYv6zq09N6d7GeoSv9myPRkhph819UYWZ6zJQGos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chuJFSHRpCVbf7frS2IEZUFYMmqFt3XMbrFGCADHZ2W4CvqsIUA5iNL/fSybaH5+HDDOw9L4u2GyBrRQyxhyfWwEEq8oZghiodSbJTl59O6RPpecwrV3mQMw4lBwuw23kNK9+c9oJ2WFuXILz6zQOkGPU+QLmSn1/W4KqIEe6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcKwoGhN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcKwoGhN"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso2407707f8f.0
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 00:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776668577; x=1777273377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ytColbIYt3Rp0RtccuT3actoBUlgarroshZJSkhwQPc=;
        b=OcKwoGhNmGZj+/glkxrAi1e0qRIdQGjc/yBPnNxy5KkwdW7vZHmY9lX5fEgVLG/iwt
         Feu1RjguwOrvKv93RdiYrdFixFJ3+qB7iuZcnaRbNdHZyTSaWYVcBO5f9vvmpk40I6QL
         HzgIilGcZ/wMGjMZQsES4bdT2ArAiR2EAke0f4BNSJxzaVv5x67r6HGVgvgduifRscjQ
         4OrXqYbugxlP1Y0nVI4fo1XL2mQWlgyVYwBOhfYdaFUoBTknVb0DF5wW+FkD/TXCPzND
         jOcnjzwq0rM12lJp8HpSeyJIUz2svW6PmMOyQ0x6PuMbtL58XqP8SKiLZpGzSGHDWv06
         IsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776668577; x=1777273377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytColbIYt3Rp0RtccuT3actoBUlgarroshZJSkhwQPc=;
        b=kH+VWpcbww8DH7TcrwjWqeOg1x5HRwd+/S0vYDE5Up2mNiYtLGfNbdg696/h3JbywD
         JquThVTf9f8UUx4xM4LzpEbg7Z1PXocI2UWStQvfNQSNts/HUI+lMFDzqbQvbDpca2Uf
         v0GVjF6Ze86mRW5ngcYw/rg2SuvLr4TsIeiiqFl2WTcl5DcrXkI4aDkWcFWkN0yIuG7a
         RlJtgMU3iCR/+rnkffCq+lP2Iyq5lXr0F97oX7S7gMXjpRfrACe3iCizEgfimp9o1tXM
         0UZKRc58xu1KKc0Ji99gk824CU648k1JoDb8qxSh7E9NY1mI/jVth5ttv+uUT2upkwkL
         QHFA==
X-Gm-Message-State: AOJu0YyYPCwLsBtw099tTVY558A4qTSD795QnqLlc6FVD8mYpmI5sKxS
	563B8boNit3zhnZK+eiU3S/rOmJP4Lh/CApXh3TKVllvy6B+LwQiYJ1o
X-Gm-Gg: AeBDieuZPMnIiiiW/fdPJXQSS6cxmsvvG6vybihXl7sR4v2eDR94I16rvROXtsbSxSJ
	d0IxcdHgM4OHyuC8RXN/Ri128MHzqzKvq9MWW3jIxHBPzck/XoFolqzood7YO44uHbzf5C42hPa
	xHwYlRW9Ap1xlerCoUU1hgxvpfb+zIRsGh2kWz76AvXdUWbcUWSpIghKJd71mxWbduzXBtCzvwm
	f9CGmm73eZjPyPHhTuP5nlXpB4r494+ZXi8twDQg48lTEg1onlpQTZQOaRJ4GIEyu/OmZZQnHQ2
	25zEyRa8DNOzwJrLTOfNE/MkTxdwflgF03UnDNAX5UJmh+pmAVP3mk677r44XC9x7iYTcY9HGOZ
	k7+3cyep62acrLSeU4PVFkgJxxiNWD0UgGboCzxJBRHxU2auEojhSaIhFwQfxBL4tEpcUjmqYAJ
	NulKiK+TJc/32jFYxnd4SPc5DhbJaXALJ9Hajd8zWYOezfjKCD3Y+vkuMrz6qYMBz7Y0b3cZ48L
	ecxuCSQB0URfzgJyN8=
X-Received: by 2002:a05:6000:184b:b0:43b:3d02:7806 with SMTP id ffacd0b85a97d-43fe3e0bd7fmr19154024f8f.28.1776668576308;
        Mon, 20 Apr 2026 00:02:56 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc24cfsm27212311f8f.16.2026.04.20.00.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 00:02:55 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:02:50 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Michael Wu <michael@allwinnertech.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCH] block: fix deadlock between blk_mq_freeze_queue and
 blk_mq_dispatch_list
Message-ID: <aeXPmqS5lcDkG5R-@fedora>
References: <20260417082744.30124-1-michael@allwinnertech.com>
 <5fec2f0f-97e5-2c7a-73bd-ad2ad95f2e1d@allwinnertech.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fec2f0f-97e5-2c7a-73bd-ad2ad95f2e1d@allwinnertech.com>

On Mon, Apr 20, 2026 at 02:31:14PM +0800, Michael Wu wrote:
> I'd like to add some important information:
> 
> The three processes I mentioned—Task 1838 (Back-P10-3), Task 619
> (android.hardwar), and Task 1865 (sp-control-1)—are all in an
> uninterruptible sleep state. Therefore, once Task 1865 (sp-control-1) is
> scheduled out using `preempt_schedule_notrace`, it cannot be scheduled back.
> The reason Task 1865 (sp-control-1) is in an uninterruptible sleep state is
> because `down_write` is waiting for `io_rwsem`.
> 
> My analysis of the upstream kernel code doesn't seem to have found a fix for
> this issue. This situation should theoretically exist, but I don't have a
> platform to test this low-probability behavior. However, it's certain that
> this situation occurs during I/O scheduling algorithm switching and
> concurrent F2FS write operations.
> 
> In this situation, `io_schedule_prepare` is not used. The path used in Task
> 1865 is `schedule->sched_submit_work->blk_flush_plug->blk_mq_dispatch_list`.
> 
> As you said, this method is indeed not good, but I don't have a better idea
> to handle this deadlock situation.

Now I got the idea, because blk_flush_plug() is called on a sleeping task,
that is why the preempted code block can't get run again even though it
doesn't sleep anywhere.

Can you try the following change?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b7f77c165a6e..4217aaaa8e47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6966,7 +6966,9 @@ static inline void sched_submit_work(struct task_struct *tsk)
         * If we are going to sleep and we have plugged IO queued,
         * make sure to submit it to avoid deadlocks.
         */
+       preempt_disable_notrace();
        blk_flush_plug(tsk->plug, true);
+       preempt_enable_no_resched_notrace();

        lock_map_release(&sched_map);
 }



thanks,
Ming
