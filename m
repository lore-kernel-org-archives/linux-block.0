Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0432FA30
	for <linux-block@vger.kernel.org>; Mon, 19 Jan 2026 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845860; cv=none; b=E0XtzhKqkvm38GVwPne0/iAceP12kMPL+3QIeRI97Or7yRJGaDOurGqeptWd2atqqtNiHoxzPuhlT2qHnmb0KQutoGFj0gIHtd4EqF9rX3cR80XAkQukmWjNjQPVWvUTMaLX6jvWPktnib+52ilOZc5Janww4xFSuntm8dcOd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845860; c=relaxed/simple;
	bh=YZ/etbGKsvDJxBmVxSvaiidiFCzoS7a7uBNHPljZECU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p9p9kcN/xXzQlcV9/Jn1WK/GRurr3SsCLq0x8qcUY1FsULJN7hn0X5VNiybgodrdLEhB/YHGvnwnnIwaCB6NHnU6juPDNBLiSzPA02yIPhssU9c32Qr6BWgLMNTuAe8W+kQPq34FEPBMIxYsW35lMAPt4WAqe9YxxKzLfPtAPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OnLiU09w; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OnLiU09w"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7cfd5d34817so3025295a34.1
        for <linux-block@vger.kernel.org>; Mon, 19 Jan 2026 10:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768845858; x=1769450658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmjU0ak1lsaum7nFKQEIrOwHth+XfV015kG/Ob4QYXY=;
        b=OnLiU09wld5WQRpjSlS219gNjtnCOrZSCvhGfWFB7+9ATHG4Q2Fz54O6KPKKInIgdQ
         AafHd6hc5nzZDQIwH665h4TGy5E65JYIxi+Lf7KdqH9M6ikrNJeL+pIPHOm+SfBVuai8
         hLdh8/0uYUF7K+plcWGqWcEgoCIPM6MxAELy6o3hHvYhgjL8yrv/nBXeFDoxe98xNP8i
         PN8uDvxSdI8kLdGMvFToGIxmshh8SiStjZxFNIJcJmFiVEHNrB8AFldiIugoFbU68cQM
         MBmOVqADeK9sB2yV+SllU59mYs2JxCY3MBqfXmsBBN99r72GVBBbP9x9WFE+A49Gfpcr
         G0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768845858; x=1769450658;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vmjU0ak1lsaum7nFKQEIrOwHth+XfV015kG/Ob4QYXY=;
        b=G3wrpMVa2VvjOYBLZFSgZFkTJo0Z0k8vVbxxbuyXBjNZEhZZz9eyqfD2gz/LIcfpMQ
         k2I88y73DFhuvy1nPvd7IiugVWU20s4z/5xu1cQwCOU5iyWAF0brZIwHgEsCWsdd0hY+
         PVpcHxva5/WSTpEbNTbC1jxqBqfnFMR2PusL2gjbQgOzytHVxqLkKTbttx2N/Ewh6hHS
         yzOg7M5m02HCm3MqjsR5CSCy9xn3gS/9/CuEFemGgBo9ZxUfvtOtmJLtcNFSet3femVe
         LH1TuUnL4tmlmpbopb65y8G5Vhr57qyUyQZhmOJgcPtsC/1CR5HkLmaIIn0TVMgRvkx8
         p/dA==
X-Gm-Message-State: AOJu0Yy8AJ4WmbZBGtsk6yvzaoOeDza3Y5RfzuUpCAR6ezl2PxXaatr3
	E/t8TQtxKqNswwHwErMKthxujZGUEK5az5RA5fwcC8+FUZ1tqvTBcVOMrWoTQf+Hwd8aDCL8S5t
	o20ls
X-Gm-Gg: AY/fxX6Z/gpJZ7hZ8cRESpGJFinJE9UGIUc4R+K4SZBqreiLQQitpWzcYq4HyoQdDDu
	42V0HvP3lfmh6FDxV/3GEliXoWMBWzLYFkLZycUWeEMJQhFWLLgO+Q80jAPyMHhYyhAhacV/vaB
	LwflRDJF94cQDQfqI6pOkhWmwUzkKuc1imdaU55MG7lYkFEE1lUHiPxpcs8uj/HQK/q552un4rj
	f9yhZU9+nNJ6ACDIQ+jmENo9SSoMCU6CDmh/fCh1kI3bOHncuiKsh1vVurzcVYedipLCIhDu5m5
	3QXKK15a4iXnOyAb/wuWBnW86Jgcq+etqYp/un0ANZnQODUSX5HZkkqTZKL6kvfvpkf3Bl/xkCx
	Ab6SHj5Btc8ZdlVjVkogMDdCj58nP4i02Kh/y6s9sLK6KJKtlja3dABRH0zQ8loFaIMplcvpjHQ
	CfWZROBAHFH3gJ6TeP4+5h6jSjecRq97QaxYayvGNKCDGl+YAEKSyttc1QiaALXtSy
X-Received: by 2002:a05:6830:25c6:b0:7c7:5d72:566c with SMTP id 46e09a7af769-7cfe0137951mr5338260a34.24.1768845857758;
        Mon, 19 Jan 2026 10:04:17 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2b57e2sm7059274a34.27.2026.01.19.10.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 10:04:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260114192803.4171847-1-bvanassche@acm.org>
References: <20260114192803.4171847-1-bvanassche@acm.org>
Subject: Re: (subset) [PATCH 0/2] Fix an error path in
 disk_update_zone_resources()
Message-Id: <176884585683.1591133.6692823875201359295.b4-ty@kernel.dk>
Date: Mon, 19 Jan 2026 11:04:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 14 Jan 2026 11:28:00 -0800, Bart Van Assche wrote:
> This patch series includes a fix for an error path in
> disk_update_zone_resources() and also the patch with which this bug was
> discovered. Compile-tested only.
> 
> Please consider this patch series for inclusion in the upstream kernel.
> 
> Thanks,
> 
> [...]

Applied, thanks!

[2/2] block: Fix an error path in disk_update_zone_resources()
      commit: 07a1bc5c14c9ef6401b21c1873c6c087075ff292

Best regards,
-- 
Jens Axboe



