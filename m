Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA053D962
	for <linux-block@vger.kernel.org>; Sun, 24 Mar 2024 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711317454; cv=none; b=i31Xul2cQNoYNeJoyLsy3uRgpgwbGj7oydoWrqSOuycDf0t0ymzG3s4ZEnZuCJZvI846i8Vuj4Bcax1jhKv9WjWAg3cvbJjgVXnu1nFxv9oS4bnMugfxdZG/u8dj8K990z/5x1rycdF0tZRAGt0U6tZcyWmJhW+i5JooPeCbtQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711317454; c=relaxed/simple;
	bh=BOkYCK2qQtPHq4L14VfaTwZ/r9VLhpWaboZSzmJjo0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnUK64fW/z8eDp+eAduc/4B/fU/rRuC83RF+HKDOUF/u7ka13ZUpfw7XJklZE+BgmFYNMAbt2aMInQTQDLXP989wxD79bv35nIEjXq1K2eSm8s5b0fQlAShVPqpvogbZVtUnpLmf2ITQWePyC1/dMrpafGxewrjl9RozWk/KHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430b870163eso45000711cf.1
        for <linux-block@vger.kernel.org>; Sun, 24 Mar 2024 14:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711317452; x=1711922252;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aW1uYlxzmK0CTtcm9QtkmtxOoxLLB7jXV7c/ndwCr2g=;
        b=dBZDGfBIIc2TzovTpKw/1J5/hYW/OUWkk5wecGa9sUJwR1/HwxzDukzWLKxRvE4sOe
         uUQr+NoKuFhd3M/+TVc3IHdSY0S4EkhWlTvSo28vCiBe3sY7V2mhAOVN8o3O0ZkvaiYB
         pUhgXlaPzG29hH4e9mTD/asTuQCCbPQUjk6p+Sb1ZREE1szowGLm8BJFsL0V4Y8NgLkk
         hRzfVrR9X2bFNPeCYTpumeozjE/32BIVEaId6ieY2M7sfpW8h0wtzt9GhNKQRhZxoPPP
         JV1Nkf/ZWjtlNyQkUbsJ3OGjBhRFpejDNni43IubcxV1YEaoRI9JK8CsP07pkcVLgXj+
         7P+A==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9/7VfgFAIa51ot0rdUQsxWtQX0sbyBNsVt2903YY9XsKEAwkdqHXkdIKlHsRvcdZY/8P9SsYolN7nIdrEQxn6FMHc82f6pbc+zM=
X-Gm-Message-State: AOJu0YxCCB3kMWN3Na5yA63PxQcO9fzOMng0AvmSCgqp8eDxmCJ6LWWf
	DClb+CqoXLTtHfpmMQrVST4QcwBQkjWUDAK4esmAZ3R24q/tvtkbgV8h9gcRkQ==
X-Google-Smtp-Source: AGHT+IGGMBnbwmlHZ1ViBESOWV4M56q0VRQdJ2XXd4ey16lzyfQzewIYJf/bLSJRR3q4cCsSThMoSQ==
X-Received: by 2002:ad4:5aaf:0:b0:696:3e05:9c21 with SMTP id u15-20020ad45aaf000000b006963e059c21mr7295157qvg.18.1711317451878;
        Sun, 24 Mar 2024 14:57:31 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id h14-20020a0562140dae00b00691732938a8sm3410147qvh.73.2024.03.24.14.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:57:31 -0700 (PDT)
Date: Sun, 24 Mar 2024 17:57:30 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, hch@lst.de, bvanassche@acm.org, axboe@kernel.dk,
	mpatocka@redhat.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] block: remove blk_mq_in_flight() and
 blk_mq_in_flight_rw()
Message-ID: <ZgChym1BEpxUm_bL@redhat.com>
References: <20240323035959.1397382-1-yukuai1@huaweicloud.com>
 <20240323035959.1397382-3-yukuai1@huaweicloud.com>
 <Zf79w4Ip3fzSMCWh@redhat.com>
 <abb0af09-e9bb-4781-176b-b4b98726c211@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abb0af09-e9bb-4781-176b-b4b98726c211@huaweicloud.com>

On Sat, Mar 23 2024 at 10:11P -0400,
Yu Kuai <yukuai1@huaweicloud.com> wrote:

> Hi,
> 
> 在 2024/03/24 0:05, Mike Snitzer 写道:
> > On Fri, Mar 22 2024 at 11:59P -0400,
> > Yu Kuai <yukuai1@huaweicloud.com> wrote:
> > 
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > Now that blk-mq also use per_cpu counter to trace inflight as bio-based
> > > device, they can be replaced by part_in_flight() and part_in_flight_rw()
> > > directly.
> > 
> > Please reference the commit that enabled this, e.g.:
> > 
> > With commit XXXXX ("commit subject") blk-mq was updated to use per_cpu
> > counters to track inflight IO same as bio-based devices, so replace
> > blk_mq_in_flight* with part_in_flight() and part_in_flight_rw()
> > accordingly.
> 
> Patch 1 in this set do this, so there is no commit xxx yet.
> 
> Thanks,
> Kuai

Would've helped if I looked at 1/2, but please say:

With the previous commit blk-mq was updated to use per_cpu ...
