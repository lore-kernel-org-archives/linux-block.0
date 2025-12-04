Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9743D2BFC60
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878286; cv=none; b=HHSy8K0KlgKM5EXWE3WuoyeKXX9fyQqydxOjDbJmmVk+uXcKGmwDI5BvMsoBIDZ7PW/1+Eqbea4oMthZy/uyL97DWPeip2RnTIbH63RMIDxHwnyvo5AhrhZARmIpz1URb8pfwzc1lV0O6sNePF2Sj07oj3nuAjpyYzfPQ3hjAr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878286; c=relaxed/simple;
	bh=A6Ci7mAh2AbmOa9EDiuaP1L8vpxkl+Y7UtFtcBqG99M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+pVUwo2d+WB8yJ5w0UDzZTPUzrwTQ5P9pPZ8V3R2TGnfVVoi1Zuls52unjYTot+l30u16y8aNIeRrV1ho/XIctT/F1Tb+gXSl/uGACl60qxtLYSADNhNhRLJe460XH8qjAshDMZW5xz4OWnzpAJDEqOJRel047zkNFkftHHpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A6FzshQ3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A6FzshQ3"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7a02592efaso12275766b.1
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 11:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764878283; x=1765483083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K85hLvlaLvTs7QWXRfbHiJadW8G+Kx4QGeXhEF8abl0=;
        b=A6FzshQ3oBiIAG5NpYTfI7c9E1Abn8PkC90gunJV6uxGAYn6BwgXVnTEJGwha3c99h
         Rr/NIYUsZT8htXzZ3NBZlMg/oM5tFMzUOcfChVwZwU5vAojZ5pu13ge69eqaOQx9hhz4
         fDcj70QfcBRmJlKb5KYZIsarxx92BT0Lnv3/PWnRN532aHFk2bl5FVfSl4p/SRwPPVzt
         OGxkyeP97+3Yr/dpyR86lPOhyo0AxuwGIRUs0qZiPrcqZ6qq2b079mUKU5K6njS8X+g2
         kzp9eR5lOZBWBEM79RbrhoMEyAjX74dS9BS3FXncBbQvgjU0gSAUtNQRTK8lQVAxyn6I
         umTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878283; x=1765483083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K85hLvlaLvTs7QWXRfbHiJadW8G+Kx4QGeXhEF8abl0=;
        b=CtXyHJccnKXrLt4HgJq1wGBBjxOoiHkxLq8oKLgV+F6Y35yb3v0rDemEzeEyeCiAe7
         F25BHAyOXoTYRMMBjG32FEevcVImv0AGiR548NAjaZVlreYbx/XW4wR7n+EPAp8qnryN
         /OXrREHlHdhnPszY2zZwf+PJ7B6kQkfFC+qwXrOP1aH3b4Mc+ay5qmGH/2Jbnn6v5F0m
         1lIrtDgrkyV9qJv25pvBV/eGN2k35FuVOIZo6SDUyse/2uXtjEhHd3UiqHPLqdx/teKc
         XjlRFnl1XUg6F8IldYjT/+0luurAKuzH3h9MSGdwnZYk4XKNFpA9FN2DNHM1sFNvytRD
         EiuA==
X-Forwarded-Encrypted: i=1; AJvYcCULpMdj4R6hp9hMswd88MtPpKQrluN9T8MTwRF27fLUy9jAskVAqWZOCuz0YPT4c2LmfPHfZcyCpVcoXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz52Eb7jPlISoHOL2SaHGq/th9nKuosh0ugzL68dQk1EEN6iQPJ
	lRIHkripZ5zB+oO5xucOH5PKd8uhTEp99mQ/T3FLnGHXmzzwN62CSS+1W1536W32gVQ=
X-Gm-Gg: ASbGnctE1jmBDVbAG6WmImEEePhgopAdYM9Ur6qVcNlunhLXX1Z0TywsozQS1Ib1dYw
	Q87/TzbzxzDyih/NRZXw2ix4ZFnUg7S2Nl30gUbeypp79oOpgcDjnCsBpzz43p8e6oCNQBbZJoZ
	mciCyxzLWVUnwWx1L1Ee8PWKm52ova8rXkmRkX/ecbSENZN7lbOzruZlw8/B7jbg1tL6VFTDkf8
	ExyMNKgcpk8uoUjWzTFHX7xoEWk96rtOmWPqZ69SxHLsACfEz+c6c0RBXfCn06kkedFAeuVPIMk
	+mZyXyZ9JlsF+TlDeRWBRPi/Isu6B5vQiPw5aEwjP3elbHQQuPp+QUUQ0g9+8+l6ixrY3Dfodn2
	IYLwM3CTW6KmTzo1UV+uOtdKicTvTbkmFpFGmD7zStk5l4oJjzCGz1ITjn1YSWmt5+z7Myr+5Wn
	yD7ausXcU8TgFor/iZUDTEGy/RtWKRvSI=
X-Google-Smtp-Source: AGHT+IHUPzhRdk1tJWg+WYux5jYGrf/7CZPDqfa+5xnHk5ZwVdIiMDev2CwK7tTMHnl9R6P38XGmgw==
X-Received: by 2002:a17:907:3d8f:b0:b73:9a71:13bb with SMTP id a640c23a62f3a-b79ec67421bmr451758966b.32.1764878282667;
        Thu, 04 Dec 2025 11:58:02 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a640c23a62f3a-b79f4976027sm193456466b.39.2025.12.04.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 11:58:02 -0800 (PST)
Date: Thu, 4 Dec 2025 11:57:59 -0800
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
Message-ID: <20251204195759.GC337106-mkhalfella@purestorage.com>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>

On Thu 2025-12-04 09:31:55 -1000, Bart Van Assche wrote:
> On 12/4/25 9:15 AM, Mohamed Khalfella wrote:
> > The stacktraces are from old 6.6.9 kernel.
> 
> Please always include stack traces from a recent upstream kernel in
> patch descriptions.
> 

Good point. Will do that in next version of the patch.

> > However, the issue is still
> > applicable to recent kernels. This is an example from 6.13 kernel.
> 
> Thanks, these stack traces make it clear what is causing the deadlock.
> 
>  From nvme_timeout():
> 
> 	/*
> 	 * Reset immediately if the controller is failed
> 	 */
> 	if (nvme_should_reset(dev, csts)) {
> 		nvme_warn_reset(dev, csts);
> 		nvme_dev_disable(dev, false);
> 		nvme_reset_ctrl(&dev->ctrl);
> 		return BLK_EH_DONE;
> 	}
> 
> Is my understanding correct that the above code is involved in the
> reported deadlock? If so, has it been considered to run the code inside
> the if-statement asynchronously (queue_work()) instead of calling it
> synchronously? Would this be sufficient to fix the deadlock?
> 

Yes, the above code is involved in the deadlock. I do not see how
running this code in another thread will solve the problem. It will
still cause a deadlock between blk_mq_quiesce_tagset() and 
blk_mq_del_queue_tag_set(). The later is holding the mutex and while
waiting for the queue to be frozen. The former wants the mutex in order
to make progress and cancel inflight requests to let the queue to be
frozen. I do not see how this will make a difference.

> Thanks,
> 
> Bart.
