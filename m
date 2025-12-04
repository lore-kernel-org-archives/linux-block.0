Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39788198E91
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873771; cv=none; b=IPT8C27br0i+MFce3FzCwwg2XSxfuPAgaMRlfNsJGQtOkCuRzaQo6P6cs7DbhUMOdy5ZMxaUW2s+aL6r9/33GWuMO+pGs0CJgQoW2x6i6xT84chLdMaUPw9+scJlnysbtyk/p+bTtfV67voZw7TnQOfnffAPBcgof2kVM/Aivw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873771; c=relaxed/simple;
	bh=2ycByKH5tOclg3Uq0z6lwTolOr1qqSAGzgVLRI82ISw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWlNTDslgSok97wv9HjqgbORzHiibBAr3S7iEaPraabJVFx+nXK2A40DMG7QanU6O+mzRaAepToRosptjin0whD4mfyPErl30MAtg6Cs1uV+ZZS2/HGc9rUCUWZ5MWSY48nvw59B9eT/XPVVZeZuE4sWbWac24iiaaMxbpw1Z9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZD/1606N; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZD/1606N"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b735b89501fso143118066b.0
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 10:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764873767; x=1765478567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cf+kn5lOp/6h3Y1AiGLVlIFXGKeJySsFzdzukNmqPPI=;
        b=ZD/1606Nh1E78arEAbuES/4Gpk+f8VSdBJ5QfwwLU2LCqOodXP/dJa18K3mzJb1x6J
         Il8yXsXVI8CWQockYq144jhqXf/E0FCK/5Ny0km+7XD6bpf/87gIY5hYYmtAJ5/NOkRP
         cqMnbmhAA3E5oqxh0PoM4kuLb/C0q8RUfDbVCrbK8d6l0t9g34v8T1nz9sft12bY8jU9
         BNlt0Vu1E2ex6l+HGkIqOgGX7sa9ngkUJnBWiV3qxoADCVLHbibPjg14P8WhFzSdtQce
         Wg2faK+IKxnnspZEp+nsgMmYiSlSjxgTl+q/ETF2gTa9zXqzxJCHp/sRT9Xicv09w3nF
         vuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873767; x=1765478567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cf+kn5lOp/6h3Y1AiGLVlIFXGKeJySsFzdzukNmqPPI=;
        b=ihaMbSyef6vBtgP5/SgM9tm/f5lqevRlXuoMArEEMU35QGmcSCRhrr1TyE7/pcYsX/
         NAzwfNxEU11ZuZ4R41YPwLX0EfYfpnhFOWMLIGbDw3TCtbTmGQu7CUPbQOrqTxmX9s42
         w+bP6ryWpfid61eEtTXvmrd3SG3Cxox/PlIkAhQVlgl6DTfXEXQ5Y1qRIQHbA7nTq693
         tD9OEs9MbqFagKhDW/WMKiNcIe8U45uHLQAChut3d7klRZxqbEf6uyHbvL/JCljrK38l
         ljbUkKCX91TJ7bitOHtb8Hl6gPPjoxWfNrjHKYKdEYt0JM0rT03PGH1SAyZveD5HvYcR
         2KEw==
X-Forwarded-Encrypted: i=1; AJvYcCV8oEQfjgW8lXy2iGrfodPj0iAjfzRLwGOO04H0nz1ZkZ96NuGgOIrUUTuptfZUcmS1BgttnwnPfgEJzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7ZEGbsx3ymU76ASgmFVBGvx3IUI976v3YRoPcTf1hqbIVn8d
	ARbuyR+wxwLDSNK36ZblC9/0OuLai4FQdetumk4iEz/2g42pCChqoel6y8t4DgLSZVk=
X-Gm-Gg: ASbGnctwPAe28pi+7Te7fk4QIAZssxWpC7aX+C6jSLrLsrC2M4aEcLD0eNgLhLnbSm8
	aVmhmOJrKQJ2YJ1hp0b4KhGFB/iZS/nnwIBa/Aurrpsie4hHfNUEn/5iHa1JcIzV7Ez0D2FVLgB
	qM/CnTWbuDpOwsw1ThA86LMhBHuQ+DbbWwBsR+78WGQejcYNlsaP6UF0c2uktGyw+TsNeZyRHh/
	UDAD8i2sRNeO4aUKY5D8y6LpTZBiJgP3fHga3n8/KNL6S7RAwzItnU5az+bSIXQv/qUEsutshhg
	o8p/SL4zvwJ0jaBcx8vYQaNCv4GPyHZK5UhnLD8M7X+SbL4mZSJj6kN3zMlEM03dwcigCHviSt6
	w2UbdbCNDnepV4se/+C7X+j/FFOpOQAQLKjZnslxFX3dZmWy5bv9Hle0JhzfEWnbkFo9LoSdQTP
	GHe1EfLWqhUr9rl1q3c6COZ/+rgpzCamU=
X-Google-Smtp-Source: AGHT+IGiTSXfiAWCdvi1/VdObVRjj6OaYx7p5aqm+cw1Klk7prZUSljRTg9EQdF+dHv1zTm36XZmlA==
X-Received: by 2002:a17:907:7252:b0:b72:b433:1bb2 with SMTP id a640c23a62f3a-b79ec406510mr444593266b.7.1764873767283;
        Thu, 04 Dec 2025 10:42:47 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a640c23a62f3a-b79f4a558b3sm196108166b.69.2025.12.04.10.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:42:46 -0800 (PST)
Date: Thu, 4 Dec 2025 10:42:43 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <20251204184243.GZ337106-mkhalfella@purestorage.com>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>

On Thu 2025-12-04 08:22:23 -1000, Bart Van Assche wrote:
> On 12/4/25 8:11 AM, Mohamed Khalfella wrote:
> > @@ -4302,6 +4302,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
> >   		blk_mq_update_tag_set_shared(set, false);
> >   	}
> >   	mutex_unlock(&set->tag_list_lock);
> > +
> > +	synchronize_rcu();
> >   	INIT_LIST_HEAD(&q->tag_set_list);
> >   }
> Yikes. This change slows down all blk_mq_del_queue_tag_set() callers.

synchronize_rcu() is necessary before re-initializing q->tag_set_list
because of list_for_each_entry_rcu() in blk_mq_[un]quiesce_tagset().

Is blk_mq_del_queue_tag_set() performance sensitive such that it can not
take synchronize_rcu()? It is not in IO codepath, right?

> Please fix the reported deadlock by modifying the NVMe code instead of
> slowing down the block layer.

I can not think of an easy way to do that. Suggestions are welcomed.

> 
> Thanks,
> 
> Bart.
