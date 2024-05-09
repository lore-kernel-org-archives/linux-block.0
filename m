Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87CE15B130
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263377; cv=none; b=HDctA6DbyerCl/trY1N08oWpnSJBN+VGe/gkZdQKXPmKvnH+cTBaPMS2aVHYNzmWW2ZckMTdSpzjHFHDI1pNgHnuoB/GKEvkXcpfvwdyFkcwx5juZLiuN0m3pPiTrtk+C39S+PJkO4YWFCWcqHS/WlNeUYCMxKdmw/8dlG07Q0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263377; c=relaxed/simple;
	bh=Zrya0cLCaHTIuELWgr/YU9F71gFAmb/XIFZi25lG1IE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cjikUhjbu42BugPe4r87IEuJeSXToIukZz6RIdt9+mLBrMhHsQyTmBlKQP1jCrSCH/angVYIPFaSlqSEULcbP1TnxYOWxJbGddVh3I9a91DuATOmIb/GLVUd4qLsTIBHgGQd/2GIPDyCpVR8sa+CeW3RHRdfIOWisbrDhyOX17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TFX7njie; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TFX7njie"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d6b362115eso7287739f.0
        for <linux-block@vger.kernel.org>; Thu, 09 May 2024 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715263375; x=1715868175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufpbLodsc5WaXfeBOdS0WL27KMSEA0vI+DAfiOcwlwA=;
        b=TFX7njieFmrgmDYbyMoFiB/A/z4GsadDMdr+bCifWUOQ7VT6Fb9LHIBfwL9OGHxZVC
         QgvDHwV9gWXOerzwxu8JBv3PmJaXvQyzM4tEu2i7+xmSHy8QLfTQNWALwBr+qPgBpTUH
         8r5uCZLMcRBbXQG/lbB7WSPfXIW/7EuFFOicstTEdzYzLULq45fnQShp2nyL3BsD6a0U
         Or6dCa/e9QBHDgiUrYuMVgKaC8oX1BN9JW7sXcC7Sz+HINVeVv8QSqHOTcQBLdt22bo3
         ou95/TrpswTkxuJpt2QdUj2gc3m3YEe+X8RwzzHu8Nz3Ki/kUR0aiZJeL3IXq/EXBwPC
         AhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263375; x=1715868175;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufpbLodsc5WaXfeBOdS0WL27KMSEA0vI+DAfiOcwlwA=;
        b=GbihsU87SCldsgugqAm9gsr/mvAkku/d+WQMHsFcF4gc5xMy8RfP4JTB66V/CSU6ri
         WFrW13it/6yFJug6gSMzIIkyToLkui8klAj3MMUrgvMf+GmuEAtuTtShhgs3Cw+rRSX5
         uQ633wEfPQZfWAOjn29lMQQl28VAs3MiNx8Uzuk0XyVv0AGXTRQSHaWMjyGAq32VnI+x
         vp28WoGJrp05WPjRHeKN651CljiOBnVP/W4d79XVFMY4+orOcnBuyWxj8l4iVRTM26S8
         dg5IsinBdFo+gSjreaoVQ0/hXOYY16QJ+7VX83z0g3J+JYqBZnnERPO3hpDp25UxnHz1
         DIxQ==
X-Gm-Message-State: AOJu0Yweg06hYaUogei9Jbj5NPmsvEk+yDXdmluZt2WJ7K6qdr9q5bAw
	cTWZ0917zuDa+eYI4bSldd77Q5MXyXPx19K4yifwBlKSOJT/eJWMrEBIYPp+wxQ=
X-Google-Smtp-Source: AGHT+IEawoo9hWTqQm/T2m38iKn3A3hDEkv//CtPbk54RYHBwdvBENkXLi3LZfeVu+Fh9LJT1Y7Q+Q==
X-Received: by 2002:a05:6602:4f4f:b0:7de:b279:fb3e with SMTP id ca18e2360f4ac-7e18fd85e4dmr568382239f.1.1715263374782;
        Thu, 09 May 2024 07:02:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376fb1f1sm371961173.163.2024.05.09.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:02:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240509123825.3225207-1-yukuai1@huaweicloud.com>
References: <20240509123825.3225207-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH RESEND for-6.10/block] block: add plug while submitting
 IO
Message-Id: <171526337415.20280.2523884400522839177.b4-ty@kernel.dk>
Date: Thu, 09 May 2024 08:02:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 09 May 2024 20:38:25 +0800, Yu Kuai wrote:
> So that if caller didn't use plug, for example, __blkdev_direct_IO_simple()
> and __blkdev_direct_IO_async(), block layer can still benefit from caching
> nsec time in the plug.
> 
> 

Applied, thanks!

[1/1] block: add plug while submitting IO
      commit: 060406c61c7cb4bbd82a02d179decca9c9bb3443

Best regards,
-- 
Jens Axboe



