Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8814A4CC
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779165750; cv=none; b=qSUPqFhKB0yY19Vet3Qn0dDT5pgGlR/PK8AO4KxlzWFkSx3CJ0TDN6vC44clAm+VLbcTS0wYJOKhplkNcnIBArLjypyOcC8N9+H/wWo1m5w3D0CmQ61CuspjKfRISaLU4WAbYsVYztDJ+Pxw/sjczYRsZt5N+4VOrMdu8+5C5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779165750; c=relaxed/simple;
	bh=tURMS0GwphKFYnw665pEN5bMyWsejHQsWQRXurQtukY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAfpgBV3ryTsjO8aybwuYOSmAwxr/NR89Cu+t95JRI/Mp3O79f0UW80uzJSG099ImcTjclqDZ299mv1f54NX7WAOE+AWPSTjCSsIXOo820Fodzc/8WbofxJvNEvkSVN+OI34FUX1VZQ1cgEhjaHiFXcXzrp+XzMgvCHRMJ0uIjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJInCqpH; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJInCqpH"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7df05fc49e5so3283191a34.3
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 21:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779165748; x=1779770548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1VVcF4UdAb/7a294bhC45ck6UAQRdFSDxy9gDTpmnG4=;
        b=DJInCqpHcDo7kqAK6jkt+Ge8y8XWrULLx4yXOQ4EmkT51Aku6vILKMuzbgxfgzEq7v
         b2hW9kvkCIFN1Nhs42wFcGEmBDdrHOdsKjNRPaDNbycH42w9teE6IK1hRgTeDsoBc1NK
         KHjcxhLWXP9WAZ9zrD4pl9WIDtEynjYJoFvwrPIf2ip94yPR2qP1ztoL7T2b+IH4xMda
         SWdtm2tHIXaXrmg2WXLi+bAegh0nONQczAZ4JCme2Xg9igMvRaJQTUumdRCY/CLg51qV
         2dWjztAcVqvfyOCVXsZy0DxYJ/D65Q4R1eO3HsQcMvCGpaUZ4/3eDR6GyoO3zWm1F4JF
         m5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779165748; x=1779770548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VVcF4UdAb/7a294bhC45ck6UAQRdFSDxy9gDTpmnG4=;
        b=GmAgG7ItzagM9r8ftA0NMruOMEAWF2pZE4Q7hcJQFVRhCRs3qByM5LbcaEmdgLeptx
         k3tuMfNQV+FLfHylgKySSTaCk4mNKwDIwUB4a3UWg2YBZPIW7j2Jk/2w+dLRG1mne6+u
         BGte2rSzthPh9+Jhb1OGfYLk33i1hech4hStOYFQAoLFib/FCxPAd4CYOWAYVvT7dvoK
         RxED31bgBrWap5DhR/WjawP3BgCyiHyAUntSk7X0VIuml8Ai8finKj76cuCOfERVcGKY
         rf1Nd4edj8jxZ/fbYC6973AzCG2ApKqEzai5aN5W4H6fPInlqXRXx+cDArfaR8IJzpvg
         Ww+w==
X-Forwarded-Encrypted: i=1; AFNElJ+B3T4W2V/qsy8TZLOuypblTzVi3mhR5nPl/Oi4w7Bx1uF8CNSloNoqLxRYsHeflFxnA5qOuXXBA+b8dA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJC9ZL8s1iz4aOKH1WfPxforLxKAG6XGXnceAKVDvKB1u3vxf
	yWVT6r6mMOUDxdq7UgIOrZ3t/K97gsBnNwSCX/TWcKcFQ/6SZG6xC3LG
X-Gm-Gg: Acq92OGvjXFrLulpjS1B1JiQakOiCUSAPdo3OkUMcaXIwRCnKeJzm9piGwB+4IcxCH5
	b+sONpnlY4X0TYJQkUK93cQzEyK9xY6mmFRjIOJ5tBAfCyDh4cldSsZrR1eNRpcrI25ZtrsVNtw
	s+UnmfYGn8jCwn0y2cdggSJEXMGBMdmL3vtR1JZKdFsp4Wun0DVFS24o3CdP0TpLkwPydX1uxac
	QpvsTtGVmsOCArfW0X1vHStm4JjcQ8EmX1ydbUHwJ7mkg6a8PV8OIB+sxJ+cnEZBb0U9TrN05XX
	fnvPbRQQfruzfg30YcnNuO8pepdMYVZz5BVdXuOhnyFalfv+eRwzBALGcExIXWQ/YU3roxAIvaN
	kSOQs2Al/Dtp0hyPiEhhR3q1yWRwKNurNDWYc6wFQ6wa+PkZwRWrz261yg8keLuesE6VYJcdCr/
	F0G3QBM7UJTL16lrVEF6hxLJRwkTPJayZqP5qjzAXxPCdzxGKZjhOSMHGqrES8dLT0ZDmzn48Ps
	RngB2nR8oCRqvjrKdW7sJMBP6wFePQ=
X-Received: by 2002:a05:6820:4b04:b0:68b:bc93:1de with SMTP id 006d021491bc7-69c9436a14fmr11760341eaf.35.1779165747811;
        Mon, 18 May 2026 21:42:27 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d045e6fb1sm6210411eaf.2.2026.05.18.21.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 21:42:27 -0700 (PDT)
Date: Tue, 19 May 2026 12:42:19 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: axboe@kernel.dk, ming.lei@canonical.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com
Subject: Re: [PATCH] block/loop: Fix NULL pointer dereference in lo_rw_aio()
Message-ID: <agvqK_4EelxnXUvf@fedora>
References: <20260519040103.22776-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519040103.22776-1-zenghongling@kylinos.cn>

On Tue, May 19, 2026 at 12:01:03PM +0800, Hongling Zeng wrote:
> lo->lo_backing_file can be NULL when the loop device is being cleared,
> causing NULL pointer dereference in lo_rw_aio(). Add a defensive check
> to prevent kernel crash.

In v7.1-rc tree, lo->lo_backing_file is cleared in __loop_clr_fd(), which
is called from lo_release() only, when it is guaranteed that there isn't
inflight IO.

So care to share your stack trace?

> 
> Also fix loop_attr_backing_file_show() to use PTR_ERR_OR_ZERO()
> for correct NULL pointer handling.
> 
> Fixes: bc07c10a3603a ("block: loop: support DIO & AIO")

Can you explain how the issue is introduced in above commit?

> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  drivers/block/loop.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 0000913f7efc..d8db1b0d8018 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -397,6 +397,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>  		cmd->iocb.ki_flags = 0;
>  	}
>  
> +	if (!file)
> +		return -EIO;

If lo->lo_backing_file may become NULL, it isn't enough to add check here
only, cause it can be observed in lo_req_flush() & lo_fallocate() too.


Thanks, 
Ming
