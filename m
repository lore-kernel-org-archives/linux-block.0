Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463832D7EC
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873150; cv=none; b=owlQh7KHohixxFGgyN/9DlpGR4nrxhaS/3zQfAJfuicgGRbqrfj6T8PSE9LjHEULqehMVSz1k7+jxNRHf1mttusavbZ8UPKyJ91FsMlhLsTJWf4VeiSJmezZu9MavapJu2RajieN6Xp73WDpsdYgHDitS+2f4pWz5chqygd6Z5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873150; c=relaxed/simple;
	bh=qEaGkMfx5VUeXh74134wsNL1eqERWxMH65ur1KtXx+c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YDBktqyzkCZnWyEWgsHfBX5nCZWVco0ADvaXtEzxDX6AIBhXJ0U93bTK/QeRP76jMw954HtG324GZqQoAIwciEZgtTcZLta1pqhaIhc8V98gINGXYCcOfGyla8iczr37FwZTflus5RgirqAocdCS7P3GWkWBmAs6SiyI8tnUJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M4yTZ2ks; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M4yTZ2ks"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-93e7c7c3d0bso361009639f.2
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 06:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762873148; x=1763477948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94xYHXLcLodrN9S6cw7XBT6pZAO9PlVXvEyYIw4z5vE=;
        b=M4yTZ2ksXbafiSQZUxcns1spl3p2ZU47JyGD3Z9O7EjoM8nsugdCECSrKy2ARpWQD8
         0WdeslHlSoM4NMebpyUCf/Owmue5ITLnFyEDt314PZ/kj7ax+BEtyxoEmp5C/sUXu96T
         KBWjCKZIkDM5x1xPeoqWazPwdzGYcg/i3ZsexPYTLrwbifTZSssdG6l/20AJKWnoXCgR
         /1ay04JVHzRCXY3/fKIbsZSJNYhcSHyEL0Wj/vVAKEFEtwIr2jZ0UPzSKK+wd47XdGiJ
         qfhf9LUBvRKJKOdvmfzDkykQK9ICO6jvZqu7TjKkkLdb1Xu5ixQKgYL4oCbzXe7B1Hj6
         hY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873148; x=1763477948;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=94xYHXLcLodrN9S6cw7XBT6pZAO9PlVXvEyYIw4z5vE=;
        b=E5HOEEYqL5OTL9cdIl/LtT+m7Gx0KGhk8lF9MHVlH5Dz8nt/BnsUXspWyW3NYfxR33
         YZ+rBA4Y6zX5MVapQsKzCP8T1Mc4AA72OeFVHviubdUK/o7tHqS4RDbCHNo8mBgIl3Vc
         Zg3X6Bc1utl2SoCDzLExO+9XIwwbVPGHvBuLDYCwYr0YEUq9iyUgXrMJ81+AFHXLE3IQ
         +O8iHZaYIwVlaOQrCnQqEDJPr4yp8jSOvTRls+yQbT9sppahwK0To0v/AwIv/uTEZ2Ep
         fzV87BhGpVJ26pSiLhBLoc8it+9yaW0+bcVGCOg3GXXKrrzwt0Cq9Gzu7Z6ljtmt2cm5
         0wTQ==
X-Gm-Message-State: AOJu0YwNC0avIKWRpdr/l7DCEWpkkGEvAMNyDmPgrpqfj3lmJ+IoMmOU
	wK5BL5jRloVFEqRAScZwIP3Ez6eu4nX+LPdmrBr7PK52vz+WRpsOTfUgS5JDx2+s/xxEMJDxT5j
	5MAME
X-Gm-Gg: ASbGnctQ6Ds0e99DbCKL7TCblxgp1UlqI/QYisHXrjuoFcSgEc1K0Zzfhdw4WVpYwBV
	3zIvju0i3iaLYvT1WDltq9BujaPR50DWJcLwUBhba3S7i4MqLU8hOH0EI4vzVHuUpCUO7xqPW2w
	SEa95vs8ez2+uZ7Ds06HZ/p7lfC+rsanVFm5FI0JnJ6JWMeT8sqz1Yqyi3WLREeeyO/HyNlJRcg
	JKs2UIK2DDC6ISxTYKRwno7F/Gokv2fd/wORAW6F5rhuWQqnFZPeKeq1YcyMl5g9FrIeVasKLqd
	v4UaQni0JWN8YB0sBBQeO2PM52mlZ8TUU5G8Z5vJ07HWp/vxNtCVSdZhFoQ4xJAmkYBcvBj8y/5
	KzN0jlUHOUu0T9RK9wIS161ZQIeiSqcyP/cvpSEOykDbf3GbAVCn4whALrRwoCeZgC3aC
X-Google-Smtp-Source: AGHT+IEFxXJKTMjulTBKec6Xg/99gfA1xveksPSnu8gO/2YQsLRPJr1wAxMDhBajjcAMNaF4ebrURA==
X-Received: by 2002:a05:6602:164a:b0:948:7ba6:345d with SMTP id ca18e2360f4ac-9489601ce74mr1756377939f.15.1762873147984;
        Tue, 11 Nov 2025 06:59:07 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b74695d420sm6036612173.46.2025.11.11.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:59:07 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251108042317.3569682-1-csander@purestorage.com>
References: <20251108042317.3569682-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: return unsigned from ublk_{,un}map_io()
Message-Id: <176287314689.174455.14830424717777782580.b4-ty@kernel.dk>
Date: Tue, 11 Nov 2025 07:59:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 07 Nov 2025 21:23:16 -0700, Caleb Sander Mateos wrote:
> ublk_map_io() and ublk_unmap_io() never return negative values, and
> their return values are stored in variables of type unsigned. Clarify
> that they can't fail by making their return types unsigned.
> 
> 

Applied, thanks!

[1/1] ublk: return unsigned from ublk_{,un}map_io()
      commit: 727a44027815aea13d34c28254d386562efc3bab

Best regards,
-- 
Jens Axboe



