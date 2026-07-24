Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160D431A52
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901781; cv=none; b=EUPJaFDNPHoo8PlJhgUJrW6M1qsC9Ze1rglTf3WM5xv53anS3XRRIUVXJjUwSQgp8R7h5P3ov7vPN63BWzD8+HOd0m9y36YOZmpKnDvSNGa0LNZ80xxqqJdVPW6m1F+H1rhi+lOK6W9kCPxvTX244XucxFLwNNc7WIa06m5zZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901781; c=relaxed/simple;
	bh=5QQ6S5gtlaOoBbz58TgOJhlugFcCf64BDQrishMnZNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iK7O8zuKt0JS+SfGOsGrKxf0ZtOhMUETJXK6MieKuRpuFN5j+OVULTqmBloL3Hs1aCq/4aC4vtc2mcwQMEVC9M1HYVgg0mAvTF+oeLDhd293sISPVteo6NDSHiZ8QieAMofU8Thllm49X4KNZNTvikXqr4ioUM1rQYXQ/rdEzj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so446319f8f.2
        for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 07:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784901776; x=1785506576;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u+yCT/Eblu4UeNhqNTTlhHPJBitOg/WHKTObkURtwP4=;
        b=bh/UZj0cSWs38xAZKB9ACoHlcY/KZvI1hIsxFA8aAELpTBYNf1jiqXlzJC5QmW0QGX
         6a8pt0A2GVhoE1JiVfgqL4Ma/SWIxyrZjSWHDXGofEtvCwyiMdL9ROgYaMxbFYkQdqWg
         rlAWaryaOLWDq+bYYJ9CIyf1022D6he+CLn48Upwjt/k/XT0tbdr3z2++oS3S9c75hI5
         ntTVxz/t91OPynZtIbaSVqY8we8letAWHVLrUWvfpa3xQaVfzcis8qzTGJlDXPd1UMed
         KPXBognl7tXpCX6NTdgFR6x4/FeRuLXAfOITQHqoSYPfJocVvA9MWFvsDW0DgHfnBuEF
         NdeA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5ijDLjHEeygm5P+GA8i9aswhE2M94n3fBP+207WAbh5LMWKvQf1O/oQ9oeoWE2bShe3cSduQsGczE2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+ZB8jRP7B+UXi7mCJQXfSamVG634a2dZoMIweE4qSN4MHbA9
	WGp+01Hk60dK1873PlSlu3X+ArwDGbf3czZjGsvDPSzoabVTOiR3bZWZwR62vjsq
X-Gm-Gg: AR+sD119w1RaI/ZDpuy9+yRa7MsGt+ng085QibHQW3Rr4RE9JqQIVq1fmCm0xoKWpf8
	LMe+cZ13fDKYOlFRdTiKevzvsAtU0ymTKVUB5/5FVA/wMQhD4eeKg70f43gKK8jSZcN5N1BKowy
	r3JthmgBzIoCHFW6b2F9uJ+dIU6R05ZhiNHIYYCk0uCI3gUPJKgCnTkb7UQpOXEA4JWBxXotEXb
	WFbyJJAIQBjxj8xV28F4fVfWI/VhnJ+NdS0/fXZWl+7pz132NS2ke6+k3jAmxzfrI3HUiq1/3Kt
	Hhq4v7A4IlpQzPD4E0aJpD58o5aaSp9WZxV8SiW3h6N67FMqMeKSDT9aPcC6PPi6M2MGZwJqf4n
	+4zDooai4LfqBvDfyJyRZ3xPaqvJPRpQqwPUturohS/0CMjNU/Du0kzlXj2szGMWbh9hTHlaRFg
	==
X-Received: by 2002:a05:6000:29cc:b0:47f:9096:3c57 with SMTP id ffacd0b85a97d-47f90963f93mr6578833f8f.40.1784901775974;
        Fri, 24 Jul 2026 07:02:55 -0700 (PDT)
Received: from [10.68.32.41] ([5.194.84.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bc62basm24446636f8f.13.2026.07.24.07.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 07:02:55 -0700 (PDT)
Message-ID: <c1270448-e13e-4fc3-a8ce-e0cfa83e8107@linux.com>
Date: Fri, 24 Jul 2026 18:02:53 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: flush pending work before releasing resources on
 init failure
To: Karl Mehltretter <kmehltretter@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Jiri Kosina <jikos@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260722034435.13432-1-kmehltretter@gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20260722034435.13432-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

Thank you for the patch.

On 22/07/2026 07:44, Karl Mehltretter wrote:
> do_floppy_init() probes each FDC with user_reset_fdc(), which queues a
> redo_fd_request() work item on floppy_wq that may still be pending when
> the probe finishes. When no controller is found, the error path calls
> floppy_release_irq_and_dma() to free the IRQ and DMA channel, and only
> later destroys the workqueue. destroy_workqueue() drains the queued work
> last, so it can run after the IRQ and DMA are already gone:
> 
>   floppy0: no floppy controllers found
>   work still pending
> 
> The flush used to be here. Commit 070ad7e793dc ("floppy: convert to
> delayed work and single-thread wq") renamed the label out_flush_work to
> out_release_dma and dropped it. Restore it so the work drains before the
> IRQ and DMA are released, as floppy_module_exit() already does.
> 
> Fixes: 070ad7e793dc ("floppy: convert to delayed work and single-thread wq")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Denis Efremov (Oracle) <efremov@linux.com>

> ---
> 
> Noticed while running mainline on an emulated Acorn RiscPC, a custom
> personal QEMU machine. It has no floppy controller and rpc_defconfig
> sets CONFIG_BLK_DEV_FD=y, so every boot takes the no-controller error
> path. No disk is registered there, so the drained work takes the
> empty-request fast path and just unlocks the FDC, leaving only the
> spurious message.
> 
> Verified with 100 QEMU boots per platform on v7.2-rc4, no controller
> present. "work still pending" appeared on an unfixed kernel vs with this
> patch:
> 
>   Acorn RiscPC, rpc_defconfig: 100/100 -> 0/100
>   x86_64 defconfig, qemu -M q35: 6/100 -> 0/100
> 
> With a controller present on qemu -M pc, reading and writing a 1.44M
> floppy image still works.
> 
>  drivers/block/floppy.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index f04397b8e381..6cfd114d27df 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4744,6 +4744,8 @@ static int __init do_floppy_init(void)
>  		}
>  	}
>  out_release_dma:
> +	/* Drain the queued redo_fd_request() before releasing IRQ and DMA. */
> +	flush_workqueue(floppy_wq);
>  	if (atomic_read(&usage_count))
>  		floppy_release_irq_and_dma();
>  out_unreg_driver:

Thanks,
Denis
