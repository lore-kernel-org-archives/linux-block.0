Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3A2C850
	for <linux-block@vger.kernel.org>; Thu,  4 Jan 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjWK8FCD"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso680533b3a.2
        for <linux-block@vger.kernel.org>; Thu, 04 Jan 2024 14:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704405882; x=1705010682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIh3Z66IIGfEBP4Az5+AV2rLKwPcu328Lc09vd7c9xw=;
        b=EjWK8FCDIa8T+mk/75X7LCz5dzyFmNLRlh1dk2AzFCtCGW4+tKkL/0XhA0sMRByagu
         3Se9hyYM5WLEdHs7S6AMQYgyg4JXrGioVr5A/3tA5cZcw77KQP19N5VqCUjzlrdif2Hq
         AvNzQjiTWPkQ9MryNsf7rob9pdN2P0lsAc4rXUuVKTmtzLaERJQO9fzClhJlp44u78ov
         p2TwxndeXTq3II12O4r2lmF9EbL8qhoR77Ea3aQzqv6zLX/So+tMJNUnofxD/NNncBlJ
         V4EMFDdpUYUIk3zgYQfgWYfp0lCgAj5kCFWyepCO6ZMimgDuRew5b0xB3N/Db+eBtkU8
         yPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704405882; x=1705010682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIh3Z66IIGfEBP4Az5+AV2rLKwPcu328Lc09vd7c9xw=;
        b=KowMV8Plcfu4KJ7DiltIA6c5kYGVdsMD2vLJiiVatgwRpepVMTK1GwW1CnMoyqYmof
         +9MyBbBYwHiZwY8/OSXjeJGJEp6qzR3jtXE7wxbJt7EW3XyVj5cs1cjtW4Mzw/oVGiNw
         T4puvkRk4cE7D48RQrd+DcnY5nqyhcpbibnFViIZcQqaA8vpP6770AmKqYq2ReBU2bNd
         K+GzFTOVkkUTHt2TPIZNZ4poHtRFlpn6cxM80x1FfiJrcVzqTy82wZDqXiC68QK6iPuL
         r5qpxGcGVkGrRllArP1xFgJW/HfHmdJeFLdoZtIZxc5vihaOotd/pIp6iLChgd8OXpui
         tFpQ==
X-Gm-Message-State: AOJu0YyTygJjtC1e5mEbSs/l3RBwj6QK9MY1CNqIj9iFdw0+ucCQXYM3
	CTa2HvbSrUWnpmM9DxwjGkuHlyrsfcM=
X-Google-Smtp-Source: AGHT+IFzJr41XrgJOxPcE6Hg9hW7uRqo7wPS97MJGtR9RzF+Dk94BmWzwKhwIGlbfFo5tH7dprncTA==
X-Received: by 2002:a05:6a00:396:b0:6da:491f:152 with SMTP id y22-20020a056a00039600b006da491f0152mr900292pfs.1.1704405881673;
        Thu, 04 Jan 2024 14:04:41 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id p9-20020a056a000b4900b006d9b35b2602sm137392pfo.3.2024.01.04.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:04:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 4 Jan 2024 12:04:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH] blk-cgroup: fix rcu lockdep warning in blkg_lookup()
Message-ID: <ZZcrd1SdTj2CTqIq@mtj.duckdns.org>
References: <20231219012833.2129540-1-ming.lei@redhat.com>
 <CAFj5m9KQ=cvODNGP_vcqtRT=EzbncUqe_vHbqUPsvYEu6d_PZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFj5m9KQ=cvODNGP_vcqtRT=EzbncUqe_vHbqUPsvYEu6d_PZw@mail.gmail.com>

On Tue, Jan 02, 2024 at 03:38:10PM +0800, Ming Lei wrote:
> On Tue, Dec 19, 2023 at 9:28 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > blkg_lookup() is called with either queue_lock or rcu read lock, so
> > use rcu_dereference_check(lockdep_is_held(&q->queue_lock)) for
> > retrieving 'blkg', which way models the check exactly for covering
> > queue lock or rcu read lock.
> >
> > Fix lockdep warning of "block/blk-cgroup.h:254 suspicious rcu_dereference_check() usage!"
> > from blkg_lookup().
> >
> > Tested-by: Changhui Zhong <czhong@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
