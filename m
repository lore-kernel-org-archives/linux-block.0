Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E905199920
	for <linux-block@vger.kernel.org>; Thu,  5 Dec 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418036; cv=none; b=dSi5McJDwSu6L5Ezq/4JsptN0aAwy9znLrYmIvDJhhJ2B9jRydD/Z8deujZFbL2bWbv4wympBloWxtcuuR3EophIy+8mpIEO7TNiesriRZCi1VQLtmPL+y2yl3563PiKSoV0iFRE5JRq5PUo29qONeKi1dOWkulCDlk8i7jfAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418036; c=relaxed/simple;
	bh=tnQzLup3SN9IK8olecRg46PLyiLOeIsRMZVNRC5rX+I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XD6T3F/3IBFqpqhOVCZraCIXbQDLD5WlKMuB3MjhbYEW6veIBF6Iw9R1lZcVjMeEkCHsdjDNptscKFEjB4KVBLzXgjVaKGJ4ums7Ab7zTUgmJz8YY++e+lU+xTzjBUy8Tes6niCzR9rFLlMVpVf62CEUPDljhiHJcTl+oVShVpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FPHp4NuU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FPHp4NuU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21145812538so9488765ad.0
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2024 09:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733418033; x=1734022833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sYsHYyKEwYdU+pGD1sUEa2kFoGvEayvExztEGexqjk=;
        b=FPHp4NuUCrEDkY/j0N00zuS8D0QAz54Wch200sfxfNXu7nhicSKh54EYXgiY/o4UMw
         2GCEdzYYSbP2amapA0gthHznygnyfdH1orWB/sYIHifxyRM0X/BQTeDhLrVbkHnK2Mo5
         QC4PU2Llm+OQADbm/fAEFHHzaKPOxytHaZ95ZmIcPaFi3Q+PGdSFwIW/m1xrKfLBtf3G
         MVxq932LW1g9pUNpJ23aLN7mVJMRj+kj93/BJ1xYJYkKZdO3klMWodS93CXbFOrZxM6u
         tLpkaSL2MPaG8Jznf/3XLl/9k6MmZvbRZb6qx9/uEGNKbapctVl13/nU5zlGHyghkCkk
         YS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418033; x=1734022833;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sYsHYyKEwYdU+pGD1sUEa2kFoGvEayvExztEGexqjk=;
        b=aaVvfuSvVkzp/iA0YN1Me1GO2JRj0cVSXRBV5qX714JPvupjvcLHAfejO1Sizvvzz/
         PrNL/RgHO0WGZqD0G7l3OyMVVsbB7YOLvzGXdyCUv2/u6nv4FIoa4O6HtEN2rbOIFCsx
         vygfYcvHWQ9AVFJjoIC3ro6b3aGJGyE+KGFh3r5ioqk7j5prlnhoHcegEJ5lVsaczpKx
         wJlnzyoOH3eAswqxZWmAbLse+ovUhl5bMGRmvPnuf5mNn0OIj6TSi35uGsWST29ZfKxr
         T/QyBlwVJZ97BKwO9BezQSHOB4pnx4xLl6Rxk7TV2cpIqVtlPO69o3VHPdk17obWZ2c9
         ENTQ==
X-Gm-Message-State: AOJu0YzOSXnNc0E50R7iWiJVPQFDtLZwcjJBofN/8ZWMv3GViJXeN3qz
	HS1fY8w/MPuN2OlLAuqKeGvKlCWaFyFs6T0SnKe6IiiBrOnrTjsSlxzUB+cB83Y=
X-Gm-Gg: ASbGncvwJnYP9gn5QNfeMh0C6u+ZP/J8sPKO6TYMKzZWNZoIKJUZiSow0eiiQhpliwJ
	WChgYJ/mbP+/YfD79zAAne5WPyNsOOV+Z5SWQ3RMCIuWldplxtwW8LMi/y6pJoi2bbHWyLv3a8z
	xhsA65XQ8Rr7U47g1z9X6EMWn+sSFpDFZuc9X9OH1J3E9DVpzOBdyUIQjtpVGqpmojx3oPIYmlZ
	GrTwjGU78IvpfjuDSP29U3y10c8+w==
X-Google-Smtp-Source: AGHT+IH+6ZU/vU10S4DTHnV14trdeiv/HMOUP+N78dCEwlIoNUxevvyiqbsiem/5dlHa8xT96d7tGw==
X-Received: by 2002:a17:902:cec3:b0:215:3fb9:5201 with SMTP id d9443c01a7336-215bd16f90amr119499135ad.44.1733418032765;
        Thu, 05 Dec 2024 09:00:32 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:dea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f27141sm14727875ad.232.2024.12.05.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:00:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Yi Sun <yi.sun@unisoc.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 virtualization@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20241112125821.1475793-1-ming.lei@redhat.com>
References: <20241112125821.1475793-1-ming.lei@redhat.com>
Subject: Re: [PATCH] virtio-blk: don't keep queue frozen during system
 suspend
Message-Id: <173341803146.638625.9371515835290273948.b4-ty@kernel.dk>
Date: Thu, 05 Dec 2024 10:00:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Tue, 12 Nov 2024 20:58:21 +0800, Ming Lei wrote:
> Commit 4ce6e2db00de ("virtio-blk: Ensure no requests in virtqueues before
> deleting vqs.") replaces queue quiesce with queue freeze in virtio-blk's
> PM callbacks. And the motivation is to drain inflight IOs before suspending.
> 
> block layer's queue freeze looks very handy, but it is also easy to cause
> deadlock, such as, any attempt to call into bio_queue_enter() may run into
> deadlock if the queue is frozen in current context. There are all kinds
> of ->suspend() called in suspend context, so keeping queue frozen in the
> whole suspend context isn't one good idea. And Marek reported lockdep
> warning[1] caused by virtio-blk's freeze queue in virtblk_freeze().
> 
> [...]

Applied, thanks!

[1/1] virtio-blk: don't keep queue frozen during system suspend
      commit: 7678abee0867e6b7fb89aa40f6e9f575f755fb37

Best regards,
-- 
Jens Axboe



