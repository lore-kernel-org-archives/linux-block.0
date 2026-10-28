Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198641;
	b=b6R+H1Nezgtqbw8iszAIs8QxXuxTdngM2+i6UdwBNhi4ruA4NVAWHP/NzSKmNDFGhIzG
	 1SO1LOExt4GaoSH3szALBAUT0kqC5iNWGghv2txQ9eOym/qZJe8Te9SVkf+NTj9h5xBI7
	 dyYhUR/nm3CoJ761dbEa3YgTqz4HwVSlfRxNMS0RuLa9GYzWozoSOCDjqUH+BZk26zdHm
	 swx04Am7fO1oe7YWitoeaSBayyS5mCPj6zKFlVZm4G4ABp7EB+1y8Y+Pglu+GUK+woqgW
	 a+T6zyg6lDijIVgj8wQmLoQKkIwC8M4vS5N3xtk5yOLfewY5Ij0uNUuiRa7FlBvtqiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=u6p5i7xRIayhYi1BwXBZITFf6I/CHvZKMf7Z8x1bh+Y=;
	b=VOlu6wHslKBr5T7Ecs81HvyPfAeOFHlLJsx4dHrRRgczSRAranSrjHxxweX9w5t+NIZ2
	 yElGCrEtwKSpZJm8YGh4dM9Dl5hfQRzeo4yS6v/SikmRW01SDzqyU8m4Re4zadRxIGkyz
	 UijPa6boNknJrJn+nfU7JfnYXM9FuXG6cqUoPULW6vxe97OgIgxvhL+3+OfrPAf+88CYu
	 AzU2ir9PhRtwDyGVbYEkeRkpAAJqqDTb5GruXXyi6VEuBVgQg4OCJkMnTYOc0u5hMEiBj
	 8UGMJ96Hc4Rg+is2CGqa4VjX3efgZ8OyBu1iG4NfPYT1pqqdvc8WTVMRzcWqFWEZOew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nzrvvMru;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5C606A31D
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 14:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C5C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nzrvvMru
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-714d57774d8so161194eaf.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793198640; x=1793803440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u6p5i7xRIayhYi1BwXBZITFf6I/CHvZKMf7Z8x1bh+Y=;
        b=nzrvvMruoyhJnKNtM5HMsI9rVCIWMnTp+pgbfFe5C7jG7Sj/lfHkK6Ml8Rs9bADDW1
         XG8D5ingERv+WGKzaaZ2eyYiB7Elt+BPJ8lKuzLSTw+n9l7kXnkC5Z5o56BiUDFzyqNA
         gec1K7kBkjmrH3Vg0Vj+GztM6jWHnAqxT5mG2QYMMwyq0SzGwKeF3lkwZ9mApr/tqmnu
         bCWKrncnY8/Xy08VMukXPMRhs7ybokGvcaepUjAllWPjNTYtylXVB6NSBt9RCZQxbqQ1
         1Xl8CHdmXEI0fOTW5CUpZ6w+jTx8/WAjsbuG2wEakGX1UdJW/8KiUsqJZSt7C5sZQheR
         zbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198640; x=1793803440;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u6p5i7xRIayhYi1BwXBZITFf6I/CHvZKMf7Z8x1bh+Y=;
        b=hxqLuz+EE6ueERTGFQJpSfs0TXzgIw7rOi6eKZmzs2ZdLBpjOR6pSiC8O1I7xE9wT2
         HFG694CrHNrkr7hdwZrUvn0fnTGoW0b1iHe1oInhuiBgqtrLsOdNIs4HZFo4A/cLm0ep
         8ekLeTROEIMoTVCYSQEESeaHf5nkC+kO/afu6yAqkOE0PFsp68HiDjmSPiRm/aAiIQHX
         7zntWQGVY6tQJC901vsJurEJheqdXFFkpyv1xOhxokfp9mvU6+c9SypoCvdAUVmBleVy
         Rkcg0n1WP4HOKRX961u9xv0wfmEohnwzkkrYIJAyv+u4AJMpNvTNSy/NHUbZoRWVtFG8
         bqvA==
X-Forwarded-Encrypted: i=1; AKwUvBz4KbuHizFaiV5oKA3RzYcp3D1ALJ2u8z5HdhofYCwpVFv4sFotfK+hlXqRzYhbyZvYThbxGgbVLnsiiw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKflb1Ihk0nnHpYtvCMIHeuDdGdRD1ruZMN3lCSOm71LsBblPWO
	XVKXuoMqLoTtuDp03YIdBDvl3nR4+02WN3y5yH2QjOKvmuUOEm9nDTgf
X-Gm-Gg: AYBFou3YEzihsDMPaqE4ouxWr6BEBQglJef2iEGnBnLx5KtdGIVy9Sfbe1OfXO4PtIq
	RMyWglu6j1UYA/xSv2BGb/pbwCD+8+AbFUpdlXgNHnFWs0y339rr+TR6uxQfBOVR6OzyDleBZxi
	1qhQvCkbBPHkvP4dZb5BwYOZDSlBOW5+lnH4iuuY+sM7PK5T6HOrQBlX2q+4jFx4iAqF1kZaNX5
	flhYcMc6ran+5/TybHUK+0q+Gpzx4TCbldK/GC1SAuICHHyUDJIpM7z0S1HCA5otjm+kkZD2DeV
	qwK2E5yVkbqT/0d3q7anOGntIAlgJnft700Hnn1XT6z3U3Wktm0Z8uSVw55ZtG6OoaS1/ZHl1TF
	0O1N/GDrYA0xRCixwscc7tK5jAkDi/doP7ahRqG0FB86wilMlNpQC30JjXOQPSFzcReDKfyWXhu
	5xNOmPrjcFaanY7h+y4dpfDoEFC4L0LapecIU4zlr7g+NcvTVMPdqvJsXcXZRgPBBeGbsfGjU+q
	jamXg8eTShB7jHBbjP+0rlJwaJaDRhzj76hx/TThVxqxTIq4BYjV+sP3JJQHCPwJFCMy275aAkt
	GXkGPF/ndpbyMmjeAyJo6LCgN63NSJ/Oc9jtIsr5/w4MNBMlutkONXQzFScfoReDyRirIz9qSEy
	S4b2fZPicAdQQ3yKf9EWWKFRJZVSP95Bn9cjNLBip33cwp52A+Ineocw=
X-Received: by 2002:a05:6820:8588:10b0:6f8:728d:cb4 with SMTP id 006d021491bc7-713ec806450mr1067609eaf.3.1793198640055;
        Wed, 28 Oct 2026 07:44:00 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b1d4580b5sm1744242a34.3.2026.10.28.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:43:59 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:43:51 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	csander@purestorage.com, jholzman@nvidia.com, omril@nvidia.com,
	ofer@nvidia.com
Subject: Re: [PATCH v4 1/2] ublk: honor rq_affinity on request completion
Message-ID: <auIKJ0CucMnDEMiQ@fedora-laptop>
References: <20261028131829.45803-1-yoav@nvidia.com>
 <20261028131829.45803-2-yoav@nvidia.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028131829.45803-2-yoav@nvidia.com>

On Wed, Oct 28, 2026 at 03:18:28PM +0200, Yoav Cohen wrote:
> ublk completes requests inline on the server thread, so rq_affinity has
> no effect: completion work always runs on the server's CPU instead of
> the submitter's, unlike NVMe and other drivers.
> 
> Add UBLK_F_SUPPORT_RQ_AFFINITY. If the server sets it, a request that
> completed in full is passed to blk_mq_complete_request_remote() and
> ended from ->complete(), unless rq_affinity is 0. Partial completions
> and errors still complete inline.
> 
> Servers that don't set the flag see no change.
> 
> Signed-off-by: Yoav Cohen <yoav@nvidia.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
