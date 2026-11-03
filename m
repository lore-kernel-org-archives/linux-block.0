Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716272;
	b=Ob7j2ct+RGde0QTMvVA27FzoGKjpwSiZN0a6CQnmqIPnURKod6LO8LW2kkDegWLk97Vq
	 9gsCR3I+SPFmESjHFDG4vJDN7QNj1OTNcuy+K18PlgtMbnGfy4xPx6QXCE/lPQzf+48rs
	 QiA+bi9kZbHE6Xzqg8vigKeGiV3iEYIW9lKREHcR6/qY3E2bf/XdQpayH45TIlE0msLlM
	 fbLmTSd4cugwjgkrfQ23mPHFsAkg7XIMxaTsozEoY6L4ynGsEFsKHUCLH3aHtGZtkbxJq
	 YSGULaD0Zk3fofAB4W8Ia0drFxLwjLnfABc0+s8FjptoJ4DvwJjLEcURwFkWtvIKnZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=gJM0tAyN19ozTNsT7Q0jTKA95QkMzgeT7FdAvzFKoO8=;
	b=4obh1VXjr4CpUOth+6SQSLwh9YoGM0QGhVYim7XsCbSphvV1tTfBo33vZjNtiMdVAv6X
	 Pd8i3clnJ7Ez2CXCPf25Dil4pYz/tVJAlrYVdDCFmHyLrEgXGBzHGtBhMIzY1HdqBqFAX
	 cwzkV04qscK2HMHk79SVzQdvmH5gdJzhG/2KmH+GrCpydnyfmJ1RW3F8lVy6TEuw2oyQN
	 1Ig2iPlcxopaauZIzY2oGG20mgS0HtY42CYd1pbO0W+5xhD/V2VvhOr1DTWqsuBOWWY05
	 EEbQmMKZUxfyvO4L91E0Op9ifEVRCupCYXshGtPaB/d/n+MFZ/aKhAVK6trobUaWZiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HYVg+187;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553E7606EE87
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 553E7606EE87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HYVg+187
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1931ff67a29so8730725c88.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716271; x=1794321071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gJM0tAyN19ozTNsT7Q0jTKA95QkMzgeT7FdAvzFKoO8=;
        b=HYVg+187klIeAraNWiyVZReGzRaGY/e6YwDtTbyB2Tck2TpyCThRjKLq+Uo8Wo0IKQ
         DIKD+nujRFX3AcHca4WQ7S7CBhjH3/xV/ysHisRDVa0LcFOSZSxEt6XjP3rdS+P7zrzd
         Xo0o6GJar/C+7JX2twQXpKRAKR6YXLSumaT8dQB0mvtHcEp2mVlUDxVZfDWrXaTTcI4+
         BFZLcI17ZW76aGen483FikYu94knodxK4McQg43lw7tAB6PqAsXH4R+Xzlb00vLTJHp2
         JDZHibl1VEdL5gGeBqC/UIwmDyUk392BWBPB5VBbuGvBL0A/oniU0VLUQ3fk4qZ7xjuY
         mI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716271; x=1794321071;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gJM0tAyN19ozTNsT7Q0jTKA95QkMzgeT7FdAvzFKoO8=;
        b=GBNAE5z3iATDzbP+RRzDxMTyPwyG7u7jAFXEIh8qOmXvEIQjAaFmhxI3m4n07LgQDN
         PmdOsr79y2FMXYEzwGJAHfAdpYX9N3BB4o3s/RBsS0vSHBU70lhAv28yRWoOWXJuLgi1
         /yQREf9DXeSaydkyiq/UEn4xjgnZyEWIyF2vTfxfkPXSHVjhX032laD/I17HO4jM9+oT
         Tregvp6Q0T1rVkRthITb9oA5T5Cg9ELzRrK0NcAhuO/Is9yFn7MOM5p0WFElXM0IbgRl
         sN/69gvLVCbXI+ZRQ1Lkhhf/BBNyEKL51FLogfBnxrSZEIEws8bNB9Okd8/BLQ2swEN3
         QVEA==
X-Forwarded-Encrypted: i=1; AKwUvBwvR40sqo9felYkeWbfm698SWylsLjMwFON4cS4oAUtvK5XOwT4hrKSHMYSfwPmqG8BStTztv3M2gQLPA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/AjZyWavfwQI+ut6uNqNZ7JL90wr/Ht3lej5LE8HI8b75S32UC
	njBsLX9HsrATNrewdcXou+oKG0/dKDq5fYdB18XLstQnucpTKSjJi2Roo1SLy3kVMHw=
X-Gm-Gg: AYBFou32mRGX571Eebo+1Lb2AGOAHaGLmh2OP8tkiXc9fCufTxiFTlm6WJa1lgUSF/E
	yEN5Z3qr4r7VR5BKo9hvqf56HgYmqMjH0ikCSImEMBGDbWQwG3EZk258+NsqumCY3HctveQrK16
	Ttc8WnOymrJZqNTuN3hnUz6YANY6ar5nOqXVkxhLZkUdlhPqTVw7QJjneBqrnV3gKK35BCben1O
	TmADJXEyd3U+z8pDgIegehYCdBT2Tdz1Bq0YIZulTLAOzCTbjPUeEUo2aBWlirmbZsRTuMFHU4V
	efYdM4PXGnOy7M0HGmGMafhBWzYJH1ZWCp/mKdmXBCug7NTVYmQt1F6MQAZrsUQ7InC0lgdEpJL
	++XuS5aQ+Rlef2RaWBYEV95yLcvfGF7djCfph3an3GexZ0rXY8oy2hh1ICvEPnJxFtpL1sx4b9z
	NQuRDzniDecN+vJe46AZ0zS38BPRzbulL280b1hIS4Ltbkm/GoHSMj5IkLvdS9nvq9Aomi19heF
	6i+neP22gh6lbDXXoRUYHS6UFzh0+COdUZtULMnq7nZD1skJKxonZfrF6H1G0Bml4iRYFEvHaSu
	lIo4c6iG+ts2BEHKvhgpUnybe1MV02VffIFmwjgK4Uo+z+j/q2vdu2r9dK7Q8mJqSa1WXhHoSd/
	oJ9pN6Qk4hOhK
X-Received: by 2002:a05:7022:258a:b0:18c:e014:6f1d with SMTP id a92af1059eb24-1ac55f2d3cemr24516668c88.1.1793716270505;
        Tue, 03 Nov 2026 06:31:10 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: mst@redhat.com, jasowangio@gmail.com, virtualization@lists.linux.dev, 
 shao.mingyin@zte.com.cn
Cc: pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
 hch@lst.de, dlemoal@kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
References: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
Subject: Re: [PATCH] virtio-blk: Fix zone append sector reporting in
 batched completion
Message-Id: <179371626856.3691261.9118119964005322830.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:08 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 26 Oct 2026 19:55:19 +0800, shao.mingyin@zte.com.cn wrote:
> For zone append, the block layer copies req->__sector back into the
> bio in blk_zone_append_update_request_bio(), so the driver must update
> req->__sector with the sector reported by the device.
> virtblk_request_done() does that, but the batched completion path used
> by virtblk_poll() only unmaps and cleans up the requests before calling
> blk_mq_end_request_batch().
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: Fix zone append sector reporting in batched completion
      commit: 08a6572441a4e646c96c2b8d8ead9eea0e458332

Best regards,
-- 
Jens Axboe



