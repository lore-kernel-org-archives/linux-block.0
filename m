Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059551DB1F
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865310; cv=none; b=C1LeHXQSFw/PE6RlQz8mbmk+tkRj5Enx1f/29fMzmYSotG8wePID9ZeYeGah5UMDXnuBYb47t7IuscL3aVfi83by6HE2GU5lKXQIp8X+29a4qZMbUNO7TmALkboy+ji4Q3E0phNfhIyBMH3Is6FZ2n80AJdtSMGowzJBM34L0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865310; c=relaxed/simple;
	bh=8bNBonel1eiwJmzEGlZ12+ywTpzur3cAUUr7r6NablA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ah5YrGSAawWVIVKzhVlEj4/sC8R5I0WyhZagP4UvVNIDsVFqh9CA0Ux6sYX/tvzYf7HkzCmmCWKyK0/54B1kFbUmXG6juxjjk5RjjimKAJmVqHmaymq51e8jaghPGvpXQkyc/zwjL/O9hyv69bDEJDnpbkJo0h5zK4omw7XBLmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx5OEGYV; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx5OEGYV"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c5b53d710cso4207268b6e.2
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790865302; x=1791470102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cUAcFPVvp9NmtmeivTgTtb3I2BaROQYBORbE57S0nb4=;
        b=Nx5OEGYVX0/QogaBBHIp27XtHq9eNT9fld1Yxe/fMW8JD2hScOqg1T4Y3AJXSWVT9E
         YlqbQLQ3uiMaLkcuXHFnz8km0e5qtAdF72Izwl8AXQDpvP7HHT4fOsFvKuu9ajCbed0V
         vCrXa5bYynaPFYyUxHcZJUoXQReKYAkiJCiKx5N8Ra5X8dBHDQ6Mdo3TAXiLFGFFVYqI
         CDYfn+F2FXZ9gJdL4gbdH56I1d2RteSDviJNTsRExlZdVwL7FZDHABnlZHn33hro+rdY
         ra6Oi4BtS2LK43oFwx2EuMBsnzkiax70KbP1Jl/ya4Ya1cCjRHFw8bEr530nj3BnCTHM
         pRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865302; x=1791470102;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cUAcFPVvp9NmtmeivTgTtb3I2BaROQYBORbE57S0nb4=;
        b=G8+ZtY2U514ZOVoX9jRy1Kh/YCZBnaYw6yubFueVmuL8jw+mJks8OEh4+XO5BQ9+gq
         beUpKZ+An+zhgGyipyIXJVy8gh1LJyJ/K6zCHrHi8TT33r84y5sUeUfjkzLPVnkOEHEr
         UH/n+VAINMHl+8g0LiFjqzP2+z1KoNjURW1f3WBmjhjqVMQeUZENpmuVzWlGoAtT8yUd
         s/aiXUG9GYTPInfCeItQhmFq5byiCQDG8WIKOBXj3QqGqNV/2ouoOO5gBJpRWRotjS8m
         x9wI6Pg5bPL735POXzmS+c6saw0GEF5PN97t1dXXNr6xyz+Q1TtdjDguzrI5ojQpLV1T
         fPnw==
X-Forwarded-Encrypted: i=1; AKwUvBwFPaN358AWKGpYTXbySL3AltDnBQ6dBLoGD7LCH90abmqim1w48asgCOMSjkQZtAhZQ0P4V0cuIqAL+A==@vger.kernel.org
X-Gm-Message-State: AFuF++m1ScV8F2R7iZvsYgixTg24WzOwsByZgW8asOs4JNBrupiWv6w0
	2SvJvzLoMG5Q5tKpVHCADeS4aOYB/ksmYu4fip4bej85ZZmVaAvImRLve+A4jw==
X-Gm-Gg: AYBFou0fxxCDH7jIhOLrGKJ8bhcfbZ2c/eiJxWD1BJ8KnpnK/uu0knmi3hGkrV8OwoW
	6pISO/K3hSrHVx7FYe/3p+nkrFzOXO93lHelvUeYsDeKWbfWfO6qm6QKRTJEl50K8RxpXtGH7ic
	wcvtpDlvhYBVFqVB1gf/yJtgD+lOd9RDpA2AUV0D60buJAFSg37nFBmZQelSxKK21b3U4FnZFyB
	r7cJ6p5RVTnawt3CVIVXa9mY+5nM/UdwyqIDtWm6en6AOQ5VycnoYsqVFkwUSpG90KPoQBUOWXu
	ze7VTgPWhVDM4SFkfHp7PsdVx4ZhTXMULRaCHqTpuGncLiNxidT2w5qNY3mEyyG4iMzXsBJSbP7
	USuKB1aYI+t9MXtFYq4w2VBrsk6nKk+1JFWn+Jbne1iRpFAkX1s82RrISIiHz7Ow3g4MGbz0rSF
	haamUla+OnuPyWx9SrZg1yuCgOzgTB+kBwKgwpc67n2OjvYeWJ9FbrjISz3hdw6qXmrrN73teNW
	RwrCDR+j+qzA28uCHkkcxPyyxQhzRnA95gIcVJexLoHgXB1E/az0+/Q9DhGxRugZq3XzIROZp85
	vuwseriTIJBpjw==
X-Received: by 2002:a05:6808:508f:b0:4e9:3412:14ac with SMTP id 5614622812f47-4f1b87b67cbmr6198251b6e.33.1790865301709;
        Thu, 01 Oct 2026 07:35:01 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f34b8bc733sm2445476b6e.10.2026.10.01.07.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:35:01 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:34:53 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: drop the device reference outside ublk_ctl_mutex
 in DEL_DEV
Message-ID: <ar5vjRR_I4Vkd9h5@fedora-laptop>
References: <20261001-bug-ublk-del-dev-put-unlocked-v1-1-18e9bb9be727@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-bug-ublk-del-dev-put-unlocked-v1-1-18e9bb9be727@gmail.com>

On Thu, Oct 01, 2026 at 11:10:47AM +0800, Qiliang Yuan wrote:
> ublk_ctrl_del_dev() drops its reference to the device while holding the
> global ublk_ctl_mutex. When this is the last reference, ublk_cdev_rel()
> frees the tag set, and blk_mq_free_tag_set() waits for the pending SRCU
> callbacks of the tag set with srcu_barrier(). Every DEL_DEV thus waits
> for an SRCU grace period with the mutex held, and deleting devices from
> several threads serializes on it.
> 
> The release path doesn't need ublk_ctl_mutex. The device number is freed
> under ublk_idr_lock, and the last reference is already dropped without
> the mutex when the ublk server still has the char device open at
> DEL_DEV time, from ublk_ch_release_work_fn().
> 
> Drop the reference after unlocking ublk_ctl_mutex.
> 
> ublk null target, 4000 single-queue devices, STOP_DEV + DEL_DEV issued
> from N threads, 16 vCPU KVM guest:
> 
>   threads     before      after
>         1     77.6 s     77.6 s
>         4     20.1 s     19.4 s
>         8     19.3 s      9.0 s
>        16     19.2 s      4.1 s
> 
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>  drivers/block/ublk_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 66eb55e7162e5..5d237aae51b7b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -4901,10 +4901,15 @@ static int ublk_ctrl_del_dev(struct ublk_device **p_ub, bool wait)
>  		set_bit(UB_STATE_DELETED, &ub->state);
>  	}
>  
> -	/* Mark the reference as consumed */
> +	mutex_unlock(&ublk_ctl_mutex);
> +
> +	/*
> +	 * Drop the reference outside ublk_ctl_mutex: if it is the last one,
> +	 * the release frees the tag set, which waits for an SRCU grace period,
> +	 * and holding the mutex would serialize concurrent deletions on it.
> +	 */
>  	*p_ub = NULL;
>  	ublk_put_device(ub);
> -	mutex_unlock(&ublk_ctl_mutex);

Looks good,

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
