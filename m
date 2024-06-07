Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BAA199E83
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774978; cv=none; b=VcbUsUgyxhUj7gVMlnFIGNfOWaqCRSrQg6LADa4SqD5yBACvQ5InTmys7bWo8A17axeCS5AyMY/OX+TBq8YC9FuxfhyoP9Yd0nRtJmXdVppsQUO9MbIVda3i0M5bOCF/rYDabaE5jiiO6uu66dAa3T6dscicGOmc273OflcAzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774978; c=relaxed/simple;
	bh=VLKCBiqDO1b7IDOT96XGtlch+dI1HdxS4qV5hpgYjzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjuyrnvdR0V9/deSQGfOiAHdSKEPx73uxqsx1aC+qb+k5t9HuVEdwUFITlv+pNirXo9a9uMtOetaC4JO10tzf0wyFJ2JjJtdNX8mQ1hbngntrV+To4eb8wpNDVNZrFblqtQDz9Ac1EM2xcnzNYi/7C1lO8kxx8HGcO0XGDqEX2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-795502843ccso11884085a.1
        for <linux-block@vger.kernel.org>; Fri, 07 Jun 2024 08:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717774976; x=1718379776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RasJ+NShJomVG3pgYjIfDAmcUiePNRF7Ig+7YHU5+mw=;
        b=lkngcyO5A9V5S1pOMTF6dpeOceCClCNDKiO6BsWXqHvNj++V9+r7P+FLyurLBrTrhD
         3wlH5fxxGsv6Z+A7oaRihZMcN/nuzcn71xG/+5DQxPgBae4kLbcRNHI7ptdrxvixbxGp
         6bKrp3hEN1uviwWubxyNqvZi5JopKkbimfnbv1d229LArasLwzVFuQsUSZoYgVLnlW5o
         jkBHCnBAtWQj+kc89PZ7OiHSG0tpA9wpneGfqAIJEeE6uR/fxdbHWlrCgktFW0liOwDD
         PRC8hsGe6XEHcB7CJPKBoba5UV1W4mDK9/F46p+WyTCnnqzfSCreGKkp+H8JiBZqvBqI
         rwFg==
X-Forwarded-Encrypted: i=1; AJvYcCUQzgu0t/PjZrIVkVCTCIddC8w/cV5ja2Zq2PbVPUKWV4SzwTUYpabTjhyeQkS2D+hb64B446AxVJT81L9mW/lc/gCsULARAqJ22O0=
X-Gm-Message-State: AOJu0Yz7ifAEWku+8rZxJPk1EEYmYuIynAR7hZaw5yMJyGY4X6vFeeKH
	3ptYzNjfDPFDfgd6bY3FXk2RVCsBtTBpv2PVLr3wp5vha9RjUitX24PJrFPggPg=
X-Google-Smtp-Source: AGHT+IG83ZaoB4BbDgVdJbtiLnyWwBlppIWmQo0F3w7UfScT22lWYphwl0x6Lo1gXNyzaZaeoZjrHA==
X-Received: by 2002:a05:620a:99d:b0:795:3927:a801 with SMTP id af79cd13be357-7953c31ef03mr261564985a.31.1717774976345;
        Fri, 07 Jun 2024 08:42:56 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44042fe10aasm6814211cf.15.2024.06.07.08.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 08:42:55 -0700 (PDT)
Date: Fri, 7 Jun 2024 11:42:54 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: move integrity settings to queue_limits v2
Message-ID: <ZmMqfj3T9Ft680j6@kernel.org>
References: <20240607055912.3586772-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607055912.3586772-1-hch@lst.de>

On Fri, Jun 07, 2024 at 07:58:54AM +0200, Christoph Hellwig wrote:
> Hi Jens, hi Martin,
> 
> this series converts the blk-integrity settings to sit in the queue
> limits and be updated through the atomic queue limits API.
> 
> I've mostly tested this with nvme, scsi is only covered by simple
> scsi_debug based tests.
> 
> For MD I found an pre-existing error handling bug when combining PI
> capable devices with not PI capable devices.  The fix was posted here
> (and is included in the git branch below):
> 
>    https://lore.kernel.org/linux-raid/20240604172607.3185916-1-hch@lst.de/
> 
> For dm-integrity my testing showed that even the baseline fails to create
> the luks-based dm-crypto with dm-integrity backing for the authentication
> data.  As the failure is non-fatal I've not addressed it here.

Setup is complicated. Did you test in terms of cryptsetup's testsuite?
Or something else?

Would really like to see these changes verified to work, with no
cryptsetup regressions, before they go in.
 
> Note that the support for native metadata in dm-crypt by Mikulas will
> need a rebase on top of this, but as it already requires another
> block layer patch and the changes in this series will simplify it a bit
> I hope that is ok.

Should be fine, Mikulas can you verify this series to pass
cryptsetup's testsuite before you rebase?

Thanks,
Mike
