Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330232145B
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625405; cv=none; b=h4hfLWPUm0+d9aH6qvyxfS6UAb1lUpJ/1ewZHjHdPoFu2WmuElfR8xRtrUr/uikZnjse320f+AcvmYKh/9E93gvl7Lk4wje4L5euoRKi/Hvmk2tEaVvmudl9m8e5dCp5qbMJ8fL5IBd+3SI/u7TrSZWz5zleXI8nt1grL/Kpy00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625405; c=relaxed/simple;
	bh=Swe6rY9gynxIoiAb72Hw4MkrpYa4S9mjWoRmp9FxCiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvuOX4imZ8gc1m07218Ez0KO2a2dwyH1ayAzUpS0KPyRfDpU8WXp35Sg2ERnQr1XEjptEcEHkCdCgG+uL+aedrJ7db/N1S3vEiw7AzC2N1tyFr8r29WeMbso/9+4QwwfM0Y/E9A8ariR8KlEhtCMHR0ehO8h5VCN44nrzAkqCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVjGcreY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVjGcreY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758625402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Swe6rY9gynxIoiAb72Hw4MkrpYa4S9mjWoRmp9FxCiw=;
	b=NVjGcreYgOGYPX4pC6UZqrZ08SzO3gFMM72ycJCI543uhdOce6AdiTS3+h3d8Nk6smHipN
	Y5+mFkvtgexC+mLDaaWI9jHoiSc0L4CFCJJCXAHfR1O5DwPL7EJrDuEBpm6WB1vKI88+6N
	2g0I4sJ8wZ8dQpvvMrQ003v9rM4HJyY=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-bwyxaoyeMBisKMkdYZa0Zg-1; Tue, 23 Sep 2025 07:03:21 -0400
X-MC-Unique: bwyxaoyeMBisKMkdYZa0Zg-1
X-Mimecast-MFC-AGG-ID: bwyxaoyeMBisKMkdYZa0Zg_1758625400
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-54a8d35ed64so4334807e0c.2
        for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 04:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625400; x=1759230200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swe6rY9gynxIoiAb72Hw4MkrpYa4S9mjWoRmp9FxCiw=;
        b=v9orUFh2g/ADq7o43MtYwgHLBoBTduPpk7C3FcMXz3SjcyqOipMcWGk3mQRojRVmCE
         fap+b8IHVNnrmTXo2xBzTDqpklPA8C9m0cVrkg4/yTcQdGTcFRXgjZNbLvzf5NUqXcfw
         I2PsTZ4CYcvJhTWTAJ7FxJdT1iS+9DKPku8xSc6EvBtnkbZ91Mhkptz2QA2ekCqYbv+d
         skuFsfUlBFwYzseHjMVW+O0tVS/SXVFkOJNiFdZnJrKz3+gc3WMWk72mU6devzg6ELo4
         aJZjsnY4oibJOEbHubQPqS53oB6eVGhcTBb/Zbi0htFsQmTxQfNbUrIteRyxAFPGI8+A
         4uyw==
X-Forwarded-Encrypted: i=1; AJvYcCXOcqNkNBOEqqRI6r/VPa0TiIxpiz1vwnCaXTb6TbyP+LvQGlvx9/H9sy7D3SwcrwEk7d8vSi6I105YXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzlDgndFDtAB4bNZVUedGGqsYv73dANE2wDBOAlipuppJvEbhp
	epPkhT2Yq0j6kzLD4FV4BG9aSjnZQONBVhJdccBuCVvN5a2KJG7oXLF6p4Eq2uS6OMBfxSzsJxi
	cezmmsk21eCGizcFkWa8EejFMuTGFTOKIbV686NOYojXKAlsfHnSU87poN+INjoD1umaFRjxtOA
	Igjqkbzwexv+gKxNmUpU8Ce4RdjeLKHSaOwpiiUPc=
X-Gm-Gg: ASbGncsK5tKuL9t8lCYRG3VoOSiKk7QbFi1MLYLReEfqsvxM4UKUGIsxPChR0Up4Dbv
	Fdvo9cQ6WxCq5aEzmvOhzf7SCEZSGr1Ma2YbqXXL3Q0G4MDX+vxlfFZkOi+cSVbeyVD48bJIYxs
	JrfvH4o0lpzcOvGW3yOW1OEQ==
X-Received: by 2002:a05:6122:251c:b0:54a:8ad7:59eb with SMTP id 71dfb90a1353d-54bcb1d349fmr691544e0c.9.1758625400401;
        Tue, 23 Sep 2025 04:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmWnjjnlbxkqsmt70oRkDaJTjcTb/VK4xGaXasfxB0vFXQD9TngLFTar/C7vX/7UorI+HUBvcEWxOQXxVzWKo=
X-Received: by 2002:a05:6122:251c:b0:54a:8ad7:59eb with SMTP id
 71dfb90a1353d-54bcb1d349fmr691530e0c.9.1758625400121; Tue, 23 Sep 2025
 04:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923075520.3746244-1-yukuai1@huaweicloud.com> <20250923075520.3746244-2-yukuai1@huaweicloud.com>
In-Reply-To: <20250923075520.3746244-2-yukuai1@huaweicloud.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 23 Sep 2025 19:03:09 +0800
X-Gm-Features: AS18NWAY6oD65lXZ0U5a_gALUERAdhfENkXD2FWMa3u6Mrw0iQdazbmftghMxvU
Message-ID: <CAFj5m9KSEvP_gqN5_51q_iaUrOS70xC5r-odJYLOami4EKDVUg@mail.gmail.com>
Subject: Re: [PATCH for-6.18/block 1/2] blk-cgroup: allocate policy data with
 GFP_NOIO in blkcg_activate_policy()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, johnny.chenyi@huawei.com, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 4:06=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Queue is freezed while activating policy, allocate memory with queue
> freezed has the risk of deadlock because memory reclaim can issue new
> IO.

blk_mq_freeze_queue() already covers it by calling memalloc_noio_save(),
so this patch looks not necessary.

Or do you have a lockdep warning?

Thanks,

