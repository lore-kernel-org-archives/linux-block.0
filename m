Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6822D4DD
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508473; cv=none; b=orvOK5iSllWQRn9n+igsrT1oBcA5I0tDh3pQ9w96J2lqew+L/+L8dugiQwSp30zhMFrvDVrpcgj0YfGS+lZlP1p7C2P+4btLDV2hZ2NXQLs9BP8R/U3WWxDCZai00F7h7TSgTpM8b+JWwIrXsIML8FjteztYgqOFUa9ymkQgldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508473; c=relaxed/simple;
	bh=cFSzgIfeO3z7fAxhJSnJreoGGPDwgCoTFSfEENULLKw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NI7ZelP89l/3MPUKx/ZeLa81MfgS34TaF/NVRG6GWR3/aGxHKHluAegZX1/G7NFVRrSo8cQmQaUt8UkIwLKNpIDslMOJpBgJBw/RWNsLVxV3qIx+oYNnf5bmOQ17IMG6Cpum2i55XTqP3FLBi8AH5j4PKSeN8z2DT2yyoxUtrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TK8DPd5l; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TK8DPd5l"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-949042bca69so114877839f.1
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 15:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763508470; x=1764113270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc1+eVN9QzOvduRcVGM2K6gpUavSX6aETEfOM72doIQ=;
        b=TK8DPd5l9Yk0m8IyuMtXOGhsqMQ4y27E7Zh0n8tZTK9tCuiamRdW664GyfGcb+vPDz
         n2BNi5MdV/MRxwER9OEP81bi0qIgR2yJpZxKA5GWcxkP0n+/5HNZ4IClLppfHvTZHNkx
         tmibw5zULB+H+4jXUBbHQ0NEmbdEcruOQojdiq68pZQpdoNTJPz2aUXXrRftLYRVY0pI
         VmRL9+32bZ0JZXg4sjFQpbplj3JJE5Cz7g/HPhS3eD3PAkkTnD2WJiYhJNuK9fy3T3jJ
         R9FRjJ+JEoP4nteVZnVJqjsArHAn/bDBMVGQgQ7T0NU29E/dsO6frhvi4TZ7R/TMjrvp
         17vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763508470; x=1764113270;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fc1+eVN9QzOvduRcVGM2K6gpUavSX6aETEfOM72doIQ=;
        b=gUJ6e2hjmufq7IBDJkxoIHMDrxwGjukLZDpMjWBrUXP46AHBDqjDFFBZi9YvQk5zPU
         bsCzXVvf/hjkDb2C4Tk+KFYZMWytRzqdc73gj9g4T4ixPizIPncf5hn+3RPFg2l96Gu4
         eizsplLsyk4YCNVkjRCqv/kiW76u3XTiqNwu88ozYpWRIW8ij9uAZNNLW4HZtb0Z99SC
         5ReyGuc9jrr0gye/1VhR0U29Iw2gGDEMd9J2rc4LpVBiyrU00/Nf8Qb6BljMwWrOR4lO
         cU1nK3pHzepUShlqSy6zo9W3M7yC446oE0cfaXWRqos5J1r7aSTr/WIxoqI4C0qQKXMI
         JgxQ==
X-Gm-Message-State: AOJu0Yx9wo7jB47qB/pDv1KtBhlr8xdqa1t3Iio1kghpJEi6bc9ICLSy
	+MXDJjcLu//SWnnr2Yh76vSbXaxoiMve2s4pydRJkgTj6XSvzzo0C9eeDIop9En/KDc=
X-Gm-Gg: ASbGncuUfi3ur02TxzZMtOF53+PbWlwezmc9ON0T70FgJmzPv1hU4S9buji5a34Nwzg
	4klipGeQsuVW3KEG3/pdOlOpIcJanJeo3VdxxUDAavPLQaYQv/GX9wlHoLVts8BLFQiomqFpr96
	Jh06yW9h/TCzcxqnrtmEkPa40qASD5lq9zFjWfOlROc57KCVdTVMl69+7rAlQbfr3b0IjEACAAS
	ni8mwVyzN+B6jglsAlVaWGo8HBy/4ntT7kHPanwx++nTbxaRphFJ8yqDllRMWmjLRHBjgGuohlr
	ij0PUd7whglmBVnH8DBK+1AVo4iRUOqXjUJfYweS1xUaJC5L97O9K5WLFoTBHDIihrJYzY0DUQF
	mSxT3eKVXJLwdepOhGzELmo0ZqjXmltZ4DWmQ7g01ETVfdXLxTigvqmk+DPEoFe51V1k/7r1Dii
	zCzcBedrhiXtfeo3E/ZMGzTl9h
X-Google-Smtp-Source: AGHT+IFsDKNEtkXrZmlfGUi2j1vQSdSipUOfLhL0JLZJNHYvMtbjeJOpgr7FZEJQgWQeKMI8HGLY1g==
X-Received: by 2002:a05:6602:168c:b0:949:3ac:512 with SMTP id ca18e2360f4ac-94903ac07b4mr1227116339f.8.1763508469719;
        Tue, 18 Nov 2025 15:27:49 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2d15ee4sm808126139f.12.2025.11.18.15.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 15:27:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: chengkaitao <pilgrimtao@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chengkaitao <chengkaitao@kylinos.cn>
In-Reply-To: <20251118012644.61754-1-pilgrimtao@gmail.com>
References: <20251118012644.61754-1-pilgrimtao@gmail.com>
Subject: Re: [PATCH] block: remove the declaration of elevator_init_mq
 function
Message-Id: <176350846860.360001.7321424818334963533.b4-ty@kernel.dk>
Date: Tue, 18 Nov 2025 16:27:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 18 Nov 2025 09:26:44 +0800, chengkaitao wrote:
> In commit 1e44bedbc921 ("block: unifying elevator change"), the
> elevator_init_mq function was deleted, but its declaration in elevator.h
> was overlooked. This patch fixes it.
> 
> 

Applied, thanks!

[1/1] block: remove the declaration of elevator_init_mq function
      commit: 8e1d91c2582d2b60d62616649546bb132fff566b

Best regards,
-- 
Jens Axboe



