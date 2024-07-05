Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E417995
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720161756; cv=none; b=AcGc08VfKmA+FeoZzbTA6ClHwt3h2lho8+G2M+8cDgm6Sc2674ROg0zF7bOU5LvWl4xRsMqx+2BSQ6VBWHQX37KwzwPTwFauSw5xTv4LAIluFztLCzzq4uVpeFXxjZErRp/6vHxvg7Q/xsjBrnDd75yf8Hy6TK+MHFJA9xW0n7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720161756; c=relaxed/simple;
	bh=MgOyEVH8zLIN/MdxvYOFmjuDQVizpXQaMEGoerFmwSg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=osCxFGgJi53XG7tSZux82K9AjY9nKY1xo7r9p+/jTtv8Dc3c+6CrdXaPW68mFD/NncBOD3IzqoZi7em7rFtXQJbKMY3ARECqNTjDKBqu0XbJHOx32YFZD7YpRi7g6L26Namh1hoBoloOIrqP13lRjZxsRULVgXmYXq8dnn8zZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DFsC9gsr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DFsC9gsr"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ea3d00253so24681e87.2
        for <linux-block@vger.kernel.org>; Thu, 04 Jul 2024 23:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720161750; x=1720766550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUW5IyFkCIPLp/iI4ppqZzUGYDTZpovySWnDwLagTug=;
        b=DFsC9gsrIn6O23ToT9YZscbhH+Zv235GsDYaCbwvthL6odQHv0flX8xP70P5A253bP
         c/fQBlcrOyZ2dPF7w1tC+g4kEoQEJUy15LMrxkal6b5kVewo4Vd6rBkWf1rmmgepQK/i
         Ux1ZmbzgX4b1R1BTj+PcBnxbwigzMV1N3eXt5fGEf1h4fjp+9JFjlhedFoiRy1vVoIy/
         U9We5aP4XB1XAoNCz29RfKfVltbked9s5t0GhvFWMgaGjyyyi06U+xP0ww1oIDBk/sWN
         3TyZYTpzuCZT4eiyeba2gPIO6icQ/IY5eXNE4G+6ZcANSsyzGpjwuoxF5SaXzfwvH3us
         AYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720161750; x=1720766550;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUW5IyFkCIPLp/iI4ppqZzUGYDTZpovySWnDwLagTug=;
        b=XiyK+QqMGPFO7GX8Sp6i+iQN77Iad5Eun8OnA8/1/tasR1pyo63jpqCmlIUXus/MXA
         9AEvvhTfBazRcuFva2Vd2z+q43gUeTtoiypdvkybnaE6uI9gDNsM5QLfVkkBwk6pg2jH
         lfUNYuaSsg9o7mi+jZxFwJFSNZ/rBmmV3UU726gtYCNwwFG8v6gLhclYZLvRO+A1/5oE
         7YXJdUfWqm4TqhbjmwWjLqOnlrwZvTXPusDR+F/YMACtglNg66sQhgOsvDkb2bEmfH2y
         QYazHi3vfeRplbgWs40sK+X0wShwR+AYCoTius+Z5K+mvRImOMEMBxmKyGHvXhXDNnL7
         FcsQ==
X-Gm-Message-State: AOJu0YxsF7a4ntYQ0qL4ozEv9pukjrZtHu0r2qcie/tEnQeNdP/kdtbc
	cxPGf4QwZ2C/Kj3xuPaBq0IqFAhqkZXg2T28kzNpirMHWtHZK/nYzjD++7PoThE=
X-Google-Smtp-Source: AGHT+IEKc6BE/oGboB8EhZ5VEOOCUHqoxxxdIrStDir31lZOXGeWNkGc4JlAwfN8Ac/Vg0QcnGnIhg==
X-Received: by 2002:ac2:53ae:0:b0:52c:9ae0:bef3 with SMTP id 2adb3069b0e04-52ea0759c99mr2163069e87.5.1720161750096;
        Thu, 04 Jul 2024 23:42:30 -0700 (PDT)
Received: from [127.0.0.1] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea69513e4sm88226e87.289.2024.07.04.23.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:42:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20240705053114.2042976-1-hch@lst.de>
References: <20240705053114.2042976-1-hch@lst.de>
Subject: Re: [PATCH] loop: remove the unused inode variable in
 loop_configure
Message-Id: <172016174876.242380.4058681366810140600.b4-ty@kernel.dk>
Date: Fri, 05 Jul 2024 00:42:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Fri, 05 Jul 2024 07:31:14 +0200, Christoph Hellwig wrote:
> Remove the inode variable now that the last user is gone.
> 
> 

Applied, thanks!

[1/1] loop: remove the unused inode variable in loop_configure
      commit: dd54fd4e1780b349043f2d74784b8b702dbd84e9

Best regards,
-- 
Jens Axboe



