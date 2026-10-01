Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8AD472F91
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865807; cv=none; b=ca5wTJptmFqSW628b02nr7d7dz5IC6nylHY9KAIpmVVWtqCK6/GkhwifLRWiFraOqQ2Mq2DtKbQndhWu5p1ZEVzLqzjp/0GIhmkPOe83b45KqJnGL/XSjuzUkgROmZwZ0QYFC50Iu1rBR6v7Kx1hI8qmeGOWnnlZkLpJiGOTd+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865807; c=relaxed/simple;
	bh=WH0W2bauQBm+nb6RVbNhKWX+y2F7TVq4fXXOtXLmF50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k8PXok+XQMV0T870VNDe0LmD1WMnBhDvR3T6i61LpRqro80sSTiiYutLdcI3C0CPzYxvO21YxkolmgL4aejjIDQWvlxOV/vhPsOieKiUHS0v6n0sIZplw5bVZphBpD40lFyU7Fyg71XNz+C8vZh9870xyfgDYAcaXm2S9lnkvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=lCVMYI1o; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="lCVMYI1o"
Received: by mail-oo2-f38.google.com with SMTP id 006d021491bc7-6dcb3b240c0so1013802eaf.2
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790865801; x=1791470601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9cDEpol0QCzqiYvdJjeguJwYsx5jQEjffnNf3dXq7fM=;
        b=lCVMYI1ouuwjToGsvjh83k9l92F5a+LMA532/iUQfoeP0Gd1pkkO/K8I8FqmkDG5Jc
         QXOb6wkEEhv2bQoAUacwnmJZa1UTe0Q1/5i/vHhTyL80RKm3aCNm8TNtcpHLYm5IoXeC
         sXV5nhVjQrRgza3w1qBUvkvMtUYcApGxephgW2W1XY8lAcOjCakkqzahI4NML1mmzyfi
         6UUxW9xmM7L386Z6YM39RYcltIexO+lLHKayrxj+SJw8EvyIolAriU0AJZp5LqKbmk05
         AOoMfV6Lcdmi138Bkj9OlVdBW77XeHhIWS6MRD7wKj6GBFtnxd54jCQ0k/NcQtsq/7Xk
         ImqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865801; x=1791470601;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cDEpol0QCzqiYvdJjeguJwYsx5jQEjffnNf3dXq7fM=;
        b=RfJgM9uxnm7RtnKx4Yw/1EIdq395uCR0lPMgtDmAW5oiyxLKwLmRvBpPP/STrCVAaB
         hPtnV1e3yhKh5jXhWj6wm0YmCWjFQdrc2Ela3cCOxwSNlyMO9acATBqDk3VnfbO0/Rc5
         xcQEM13oHPJPAOfDCApTdnoHD0TyDMvIGvtstPbjlYSfcxXXqm2Im2LFKDYmM4W+J73w
         faTIRNpAXH85OmrHI/8rfcaaXGObZuaVrbfR/h/g2EvUQ5ffjLkBoKQ6scCnFCGu9Hz4
         j3x9UIFdCaXQ7dkZ3Bz0mIqFjprHnh7/spU3+suR4VhLNDDH3Se4Cc53eg6XeP/xcLzO
         co5g==
X-Gm-Message-State: AFuF++nydoc51gEHVDqYmw6Ams0NjZhLvn0IK5U9yg/hiB1TAgTybV5S
	eC7pIiV0bgg8jf9/gPyI7NbCVsXIoTZrCU1uGVBI5IP9sdTUyy5jqLLIFVXZauzxuD5CEwwd/p/
	Wi4Zf5N8=
X-Gm-Gg: AYBFou2YBiikOJEZ94PdEJyWMSQ0Z86aB2QQqPCn+Rbmdl8JnT6TPvKP0XyjKuVou9C
	UEnY4a/U8JGWlkw+fle/3+DyVdJnCXPQ/A7sEaR1Y4kebTYA0Iy5zwM+bGDVI/zRL/D5iowYKDO
	ZC0BArnqfW846xLXFg8k7CypsljH/dKV7fBmQa+oZWkQfMQavS8g9dl9MD2U7XfcM65w+ECwPVR
	4y2qeqTR4ZmCxv3o9MyDJnJM+jD2OGGlPglkJEOFc8VApoUb/G/KNH6b8RxxDrxn9s65hNrBeQA
	PN2xyVBlcXGt7dOUx+IICkKDTKKJytIdJVlGBAX2biRcq1dh22j1T+jh4hZcfRssfgIc1FWDBR5
	wHx8iH4FhEXfpuX0x+q4Kt8H27gqO8zB/pl3arYRx/ES7YNqMv7L8pVjp2vPCqq5Upt/2VxotBb
	zqcvnlE/wVyh/Wn2sPawsnPUN8vXn0l6lDZTTG/vj8+dLjIvNxl63Fbfgnz2KUOlJ5NFs90ZP/r
	/1CY7EHe+KOhfFSDk4YCgUheZpcZgn4dBj3SPUVBNDNnM1ojZ5aQpynFbQJCTYwsw==
X-Received: by 2002:a4a:e913:0:b0:6c9:80d9:5e6 with SMTP id 006d021491bc7-6dcf4e626demr4261656eaf.39.1790865800818;
        Thu, 01 Oct 2026 07:43:20 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49ded14d8a0sm2638009fac.5.2026.10.01.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:43:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Qiliang Yuan <odys.yuan@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261001-bug-ublk-del-dev-put-unlocked-v1-1-18e9bb9be727@gmail.com>
References: <20261001-bug-ublk-del-dev-put-unlocked-v1-1-18e9bb9be727@gmail.com>
Subject: Re: [PATCH] ublk: drop the device reference outside ublk_ctl_mutex
 in DEL_DEV
Message-Id: <179086579981.1687323.185182661206896039.b4-ty@b4>
Date: Thu, 01 Oct 2026 08:43:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 01 Oct 2026 11:10:47 +0800, Qiliang Yuan wrote:
> ublk_ctrl_del_dev() drops its reference to the device while holding the
> global ublk_ctl_mutex. When this is the last reference, ublk_cdev_rel()
> frees the tag set, and blk_mq_free_tag_set() waits for the pending SRCU
> callbacks of the tag set with srcu_barrier(). Every DEL_DEV thus waits
> for an SRCU grace period with the mutex held, and deleting devices from
> several threads serializes on it.
> 
> [...]

Applied, thanks!

[1/1] ublk: drop the device reference outside ublk_ctl_mutex in DEL_DEV
      commit: 812485c8ff2609489b164415befc7189965e1b38

Best regards,
-- 
Jens Axboe



