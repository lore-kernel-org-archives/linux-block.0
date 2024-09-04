Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9744C96
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455851; cv=none; b=EZA0czYnEkuI464C+7+8kNINIhxGJCVHjl5hvMSu2nf4qoR/frrqc6Hqr9mZMTVJ9SPnUwvzhSb9Tp51mIEfQY5WDHAfmx4eT5/DfAmbQBem4+e8y3AXtv+NbuxdBtjE0zpLXxjrmBvfAWDFzlC7fbfixqGcJ9oXOYAzVet4ypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455851; c=relaxed/simple;
	bh=trZOzOT9tt7c4PuX3QL+EAoKfXlfF47ZQPc+JLsIVUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EtxLdKDnITZvPjK3qNXGYhscsEGrhEdlemAPQkusBTFjAf+HVJntLA7xJuI7PoIAF1yANcfRhf3Agw6X0y7opATATLcP2K5ka2A9RefaJxOcNp3qp6qL4Uj+Yg7khCteFIgEeelkcSk/wWxXpocFe8GMt6uqzlbEt6aoRmXK6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Y4hYi0WI; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Y4hYi0WI"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82a151a65b8so254023139f.2
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725455847; x=1726060647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ewKur6LwkETexv132h/n4P4z/VCGZ2QOrBVcB5Y/Fo=;
        b=Y4hYi0WI9cIniEn0oi2HpAzhX91BT8sucDeySt/HXxWTJ0R88DV+r3nyh88RPpIX1G
         sszLa7jhrqxpoSGhQVdJRxqHyeouoI0AVjO2f/DyS+5I4wXumZwUP/hUyB8/rWtJ/+3w
         kdipNEKQ8M+UzPC1PUvPKhrhxx7z8z6VCFFHVq2b013qbHEEwf0fonaknXgcc40AvgcF
         CfxSA8wgxTk4EBa09j0rVSihKYBKvSPsoE9MwbhnIX/XFFbM/geUOiWaQoZx7UQOXLhb
         24oREP4WYsSa8981s59IheMYKyjIpD9oeijFnj53IX8Ua+C9VgjJUTJ/YG9kU6xrpHCp
         ecKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725455847; x=1726060647;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ewKur6LwkETexv132h/n4P4z/VCGZ2QOrBVcB5Y/Fo=;
        b=v+uyQtcMfEOyUuDgLbBeHHr3kDM4O47tLhfZgt+K7ZUIAKFGMvm/ER8sBRq7z59S/l
         v1w53vdR2W8dFlfBCMDod85ouUTgwN4f1kmxvczk8vEqrg1w9lWwe/gLuU+X0RhyVahm
         oYtHUc0RY2OPIfb5FwAeOsEb1lltc1mUttTtrzk/HwmfbjGZFLXUqSf98i4Us/+OXgwW
         xjR9SSXNXm67Akn0gAuJCMcClOo/pG23ydX3Kpq2RjYr7Q0NUUzZzvCXHUDLh8BWZIFi
         y6cJVW4EPyK6EOJuPCso2kiA1kmpSXP7B1yfKdS7BqETCx0XD5O28DDvMHyu2M1e2cyz
         Nv1Q==
X-Gm-Message-State: AOJu0YzRYsHUf2o+8m7PvblYyO1U2/6xyQG2aifWcCMn9wf551MX3VuZ
	qynkOqgdWu/6wCwxK2iIH6Eh1VIs7gDejuF4l0gj44zlJogAvgZs76MWie/34UU=
X-Google-Smtp-Source: AGHT+IF0Dl7HPxeJEGoh5s+eAQHKvtGYbk5ubB/rIQdk+UOmHcDZXRwMcBAnMsyzDhcmfew5G7VdJw==
X-Received: by 2002:a05:6602:13cc:b0:82a:49ed:cad5 with SMTP id ca18e2360f4ac-82a6488caa5mr582824539f.3.1725455847473;
        Wed, 04 Sep 2024 06:17:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2dcdf02sm3128987173.26.2024.09.04.06.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:17:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Li Nan <linan122@huawei.com>, Changhui Zhong <czhong@redhat.com>
In-Reply-To: <20240904031348.4139545-1-ming.lei@redhat.com>
References: <20240904031348.4139545-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 RESEND] ublk_drv: fix NULL pointer dereference in
 ublk_ctrl_start_recovery()
Message-Id: <172545584674.61712.772791891876009596.b4-ty@kernel.dk>
Date: Wed, 04 Sep 2024 07:17:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Wed, 04 Sep 2024 11:13:48 +0800, Ming Lei wrote:
> When two UBLK_CMD_START_USER_RECOVERY commands are submitted, the
> first one sets 'ubq->ubq_daemon' to NULL, and the second one triggers
> WARN in ublk_queue_reinit() and subsequently a NULL pointer dereference
> issue.
> 
> Fix it by adding the check in ublk_ctrl_start_recovery() and return
> immediately in case of zero 'ub->nr_queues_ready'.
> 
> [...]

Applied, thanks!

[1/1] ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()
      commit: e58f5142f88320a5b1449f96a146f2f24615c5c7

Best regards,
-- 
Jens Axboe



