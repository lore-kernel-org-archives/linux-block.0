Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FBC3644BD
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535161; cv=none; b=O92xOEIm5Wj9tYfGDSsITaHve16hCZ04eT+5LnR2/zr+naQx8IFEs4HOZUVvPOLu5lT+aCHMvXQvocsJW2LOn1DpIiYU97peagBJqQqyuFbeIOrTahvcYOePKLT5ISX2DLRdwSmasb7XRinoBK8/Wy/OPibF+7+xTXZMy1VvTDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535161; c=relaxed/simple;
	bh=ynKWuf3nHGVwOS5IrpnQGgsmwizBxziaipo82MmLZzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EydBlFRaB+rlEarK/kwSN/YA0W+amqEMqr+T/BE+8hLUWzts7RP8Nhqi/xAhhvlEhLAdGhayyBiQYbf3miteljCys657yj+iUEELOjLUXzNGKkKnHbBiPA7/y0MsR6MMq6PBZG7JrSNhYS8tPuN7F+w+Wsep6vtXv/IyBl+B8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=xdz+/kQ2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="xdz+/kQ2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso11207175e9.1
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1774535157; x=1775139957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDKMEMGA1dLorZrQtzBtCoFtQxCUON3awe40726T00I=;
        b=xdz+/kQ2Vmq2dIKuwvb/lsfiS7P0n7QLv9olmVNXs8wZ68DHMk3Ax8SteAYud8AcVi
         htXytDXID14xqs4CURn7uo1l2phJ25Mjbc9mXlfVgiGxBsL3MueQ4okDUDjegeFbDdph
         PdgDpSBKDRnNjYv+0+jv8V7nx4WVLk8yVmOeoqkfGAQBoFt5gvG/z1q8luRwNBzflcdt
         rHry4kFXfBru57zsuKEqRk4LwDwoFm6r826+WjRyRnxUiNyJEQqZM9/JFfJD+KQZqPBb
         7CTXuCOfnxlMS7fNdYjXIm1x/AC/LfjG4nPfsrKuprEhqSryRU0vZk9AF5EH3QrwBZYv
         wAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774535157; x=1775139957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDKMEMGA1dLorZrQtzBtCoFtQxCUON3awe40726T00I=;
        b=ncN3RaR4GZFvlDloEoZG0QSlYgHYG0JerbR8S4RQSLFE+EbR8wf0Q05U7rS6+o/BIj
         0IaitbNgyK2usAfIk5DxAbmRGOeXyuKZ2+h6+lbYB4gUmKBk5hFbAuTeM9qOCN7v/2Z6
         lNLINHtoqfhX5/45m5z2Sv9YukYnZUZP/voaJrc18KNuEdJqs8p5nA6cnJcrSEDE3I7J
         Z0oCTUrCWw6Es2Zy+jrKbYiacgo6XmRwYVVVUFt0BOe71akZp+9p/f5VqItu2BsTfVre
         3dtYDneFs5UTECHs23hY2/zDsfN316GJhwvsdTNEuvVieBVT/JU2+64lWsqzsVo+lIo3
         +QnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmNyPuPVJBsWNUQPc+gdi4KPuOjbyYXENH13SXWOzfInxWlI/vUyayiqtDXcTPn7cB7lNZNdUKkEnJkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOFFZfX+OZfYmO6KUsL4zTOlvytJOQnNw9mRS/dA4Z97p2s4i
	UihzCIWhAQupQKnJZA0vYyMgSNbIesQU3r4nyZVjl8ouTCENcA9MfTFmYScNZBRLEaYROixDvHG
	gI01r
X-Gm-Gg: ATEYQzyKxdP4DFF37Rcla9CIXKK5hkznyjxvIwKF5rbZ0OeSy68nX6f8O0mVdg906dE
	6tcgyaAQ6o4ypA1bG3w1WroFaCLnRTzgmwy1O89c748eaBS5arHVdsLPoNweaTT45DcL2l35fly
	3tjC9+HcNYdIKkPgufCx6W93vUTWP98peuYbwL/Tc3BJDXpCZF1Q3MbGUwEULH5MchOUqIpe3Bf
	UTtOxg2x+i3VvLM8koyd9njgwNy+VqdIIhmMZl2cgkAA/sd0+nhUDCeudc0vNH7LWzaw4v6ZdG9
	hq5gOoZbIdHuEeNegz0ZC5oXZA4irPqXq2TuLmBCArnJRKPk9FkXB2jqppZ188yVunRm1tglIzE
	tReg47H3fuVSFCIczBMNDyT3LUv4dO9DIVjQNpnpV2hfxvJ5MacqaLRrjbFm47ZTzl8J6MbjHMx
	XoSHaSDI2v4legxjNjFWb2jBTFOb21eiF29FaElBels4nYbrJa9TDjXeKIjB7K8LQSDQjE/vgnE
	d2y7RT1tXSPrMG4emc=
X-Received: by 2002:a05:600d:16:b0:485:3428:774c with SMTP id 5b1f17b1804b1-48722ba90cbmr21105645e9.4.1774535157471;
        Thu, 26 Mar 2026 07:25:57 -0700 (PDT)
Received: from [10.43.5.171] (62-99-137-214.static.upcbusiness.at. [62.99.137.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872090fb74sm20030635e9.7.2026.03.26.07.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 07:25:56 -0700 (PDT)
Message-ID: <d7c66265-5df2-40c9-830e-57df5924b271@linbit.com>
Date: Thu, 26 Mar 2026 15:25:53 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drbd: A few bug fixes
To: Ethan Tidmore <ethantidmore06@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260317232318.18923-1-ethantidmore06@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260317232318.18923-1-ethantidmore06@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 00:23, Ethan Tidmore wrote:
> Here are 4 bug fixes found with Smatch.
> 
> Ethan Tidmore (4):
>    drbd: Fix out-of-bounds access
>    drbd: Fix variable dereference before check
>    drbd: Add missing error code in drbd_main.c
>    drbd: Add check for error pointer
> 
>   drivers/block/drbd/drbd_main.c     | 1 +
>   drivers/block/drbd/drbd_nl.c       | 2 +-
>   drivers/block/drbd/drbd_receiver.c | 2 +-
>   drivers/block/drbd/drbd_req.c      | 4 +++-
>   4 files changed, 6 insertions(+), 3 deletions(-)
> 

Thanks, these all look good.
I'll squash them into the DRDB9 series to keep the history clean.

Regards,
Christoph
