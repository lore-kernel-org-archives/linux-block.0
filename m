Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACC73EDAA7
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507085; cv=none; b=s7soA9Lfg5OMgScP8GCuJ5pU4BI1tT+ux5btqt/OScSUqW+w/dLgUVPJ6BthoQoWhJk8FfiTqtFHA836Is/7rkwL7GC7f36ond0P10B2VqciIbH2klY3DMaH6xGR6yqxGYVVaYU+U/08Pbjvjyiw6tyEwN23D0sujpo4flqZVYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507085; c=relaxed/simple;
	bh=HhoCeclU6mcEX5HqCwLQNyLrmPvKY4GVFSFC4NjCjlA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LCVSwvIaxdSuXv0AJ1/0qVdpLePLJY6CBqiNwaNTXQfDtmnmFtWi21DqWUZggRFwEalXqVMkxAVsnONHXW/HESMDriSBPBsJpg5kbsUdVcLaSOz7Zjk3z5rzwxeUPHJWh/KJTaUEq7LceL8vbApwUbglCLanKiGgfXNux5EipVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=QLN/Oc4W; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="QLN/Oc4W"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-47c6f914617so2174141b6e.1
        for <linux-block@vger.kernel.org>; Mon, 11 May 2026 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778507083; x=1779111883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw8OyP3p59+OyJU1z+w4fzPTY3puC6FrPvvMcxdCwUI=;
        b=QLN/Oc4WZ97tJJOv/u6ML+JvCQucXAGfG8rUBNhs/34OqjnQJaB26gE6bwvJnhnDYx
         YFfgYIKWnvFkFGl3//TdsdhtZYuLMdGok3qJc34DlGzJSjl2y1vsWVzt6ZOZleKHGE1I
         jy+4XDvi3ggXi/e4jZ1lmlSfOqCBLg/fXL5kIMjMDRA3yLIfPxhPE2ktd+1f/gVFXMbT
         57qeDy2JFFosIKkecdNoXGtkDoiM7Aw0MAWKQKPJJCwPr7QIRimKoz48AyJiuHEAEztu
         7BE2zJ4IHKpJjXt7DNNWQ+X7IZ7UPSf3o9rkhgSgkuKqBZyMHUALbkbdkbK/AjEdWAv+
         TDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778507083; x=1779111883;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dw8OyP3p59+OyJU1z+w4fzPTY3puC6FrPvvMcxdCwUI=;
        b=Prud5HEsuHZ2R1aTDTh+mTzCI2LEZmrde7DMm+H7pdE5auKCup+ILc1Z/p4fh68Btn
         97H+uSlg7rCZAE7ZxbJUVwnPic+36QWENmTo7bZ8GtOlGvisTQs3tMOmYd4BaZWlXqhj
         TpwvxAcUD7bzzyC3wGUQrIlYtelYASMjJg44JYmAxN/mCrN3KhfsVqLUHqGj5FAIU8g5
         B67uNWnwgxAy9ti7G2dd1SEeaxYN/CarM1sKJw7vD9WupAOkOibIJv81Hs/1pnHnBz8/
         75qr2XBesIooFjR5jPTudyaumwg+k8sFXgeV0oUiAKq2xbsZiRwBoSUwwgH4o3Iejt6R
         7ovQ==
X-Gm-Message-State: AOJu0YwHOrchVt70m/BeH+rdHJVPVLB7n4ZayOZpT3MRJPNjw2Pdqau6
	QDhxDFbDxYtDA/ea+6ZB5AJ8raoq+ohnHYqKalpg0HOAdaFn4GCdPNPjVSFQHGrTFvk=
X-Gm-Gg: Acq92OGgJCtGP67THRJWPafA9SfA2yg5G5t93UoCw69dBh1nZ2BWj+SoOWgfQXN8MHs
	KDcPCw6IxW2tE7/vIVzBd6B8jc5pDHOsGbEq1HK/WE904181D9cdzUtQP7YheFlQWUMtneauwyr
	k5xQ9CfT7KsCMLFoNUUbePIgZtEe6/SrBkKkd9LK3/qOUXj1EOdlNBg1XfJdj549YdNplUxjRjP
	8voI3iVvQXiZlY8hFsegZp5ve++OKqcDWgNgAlHUIfFCNRMRY9ovdKSNdXSp2Hk7vJNVy+cMBcZ
	dd455c2l0IZOlHK3Zhvdx6MO40+1GFF03jzIJPGvBAVX/OO1FdAoKv1reh+vKEQNXyjytU+XI4X
	s3Uq+BCj22TV4qvrsYgRb5v+EgvJLze2F5QqO7UzD/Pe0/FS+ASolnuQz0dQg5wkiKbpSyAHrIe
	eC7f3L5rGu/nY97nUvZ5CgrmqNYCSW033edh+wKVpeYMyPVPLIomEEUayOZ4euKw8jn5x4j8TCA
	ogjMJcgg8Gh4OM=
X-Received: by 2002:a05:6820:8c2:b0:699:b16b:936b with SMTP id 006d021491bc7-69b36ad3868mr5064676eaf.11.1778507083059;
        Mon, 11 May 2026 06:44:43 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435571099a4sm9503962fac.7.2026.05.11.06.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:44:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20260510144843.769031-1-tom.leiming@gmail.com>
References: <20260510144843.769031-1-tom.leiming@gmail.com>
Subject: Re: [PATCH] ublk: reject max_sectors smaller than PAGE_SECTORS in
 parameter validation
Message-Id: <177850708188.123140.14621938925915660284.b4-ty@b4>
Date: Mon, 11 May 2026 07:44:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 10 May 2026 22:48:43 +0800, Ming Lei wrote:
> blk_validate_limits() requires max_hw_sectors >= PAGE_SECTORS and fires
> a WARN_ON_ONCE if this invariant is violated. ublk_validate_params()
> only checked the upper bound of max_sectors against max_io_buf_bytes,
> allowing userspace to pass small values (including zero) that trigger
> the warning when blk_mq_alloc_disk() is called from
> ublk_ctrl_start_dev().
> 
> [...]

Applied, thanks!

[1/1] ublk: reject max_sectors smaller than PAGE_SECTORS in parameter validation
      commit: 1860c2f85922917d8a46f16a6f4bd2298ffa0fb5

Best regards,
-- 
Jens Axboe



