Received: from mail64.out.titan.email (mail64.out.titan.email [44.205.83.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1FD20102C
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.205.83.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134906; cv=none; b=cog0RTfmjVmoo184uP2UQEHTDL0J72Ei48X+6jNlBJWbD6uefyySD2aVj1TUuQyFNCvls4riZaDiwZ47Ft2Ui+7CIt9dzVymx42MI4uSQQXwCZGnzchO934wFqVPBkpflHRi05Zfh5MuZosB7fLV2Znw2Aun6FW6IQAwzy9sRd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134906; c=relaxed/simple;
	bh=p+2rsaQ4FhCWyfKQl3y+ihQwoGzxuywBqGvV8Qy4oro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAwtB3qrburaSnLRO/2mPyeL6T0CKijckP+X0lk9cnMY8XBq19flF6eVER5YvICQ5I9n9DnimEp+RCgPK9pANBOolfJOhCnDNP7kVVtlFHPXvqwct0vO6T+AaQytGVoqVSFqin+IqeD2xwWry2PSrhEJrBVWWOxALFa5WyMcY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=JYWW2Grh; arc=none smtp.client-ip=44.205.83.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="JYWW2Grh"
Received: from smtp-out.flockmail.com (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 6898F140047;
	Fri, 21 Feb 2025 10:08:48 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=cqetpmvMD/jN/5sZxj0Bd7e9Bah0FkeGurb936MERnc=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=message-id:references:mime-version:from:cc:subject:to:date:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1740132528; v=1;
	b=JYWW2GrhxrD87R/6VDrIuznv0wXZf8RZQe9zr+sTIISV6NXdTYjOutiXUk70VsmWxiGBZ75f
	JSOQGAG1c9IBCwtHhIbTpRLV+kr/914VH6Adg+XcNwILI0S88RbLgTGjzj6Vr1U9rmkWekwKYoS
	DAb9B9d42RFRyglmgNlcYs2k=
Received: from studio.local (unknown [141.11.218.23])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 65BF0140108;
	Fri, 21 Feb 2025 10:08:38 +0000 (UTC)
Date: Fri, 21 Feb 2025 18:08:36 +0800
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: axboe@kernel.dk, song@kernel.org, colyli@kernel.org, 
	yukuai3@huawei.com, dan.j.williams@intel.com, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, ira.weiny@intel.com, dlemoal@kernel.org, yanjun.zhu@linux.dev, 
	kch@nvidia.com, hare@suse.de, zhengqixing@huawei.com, john.g.garry@oracle.com, 
	geliang@kernel.org, xni@redhat.com, colyli@suse.de, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH 03/12] badblocks: attempt to merge adjacent badblocks
 during ack_all_badblocks
Message-ID: <w527neyzlfzjxzhxge2pmip7qxzwrumn5bvztjtuonu3opoyf6@7umwkulb6eeb>
References: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
 <20250221081109.734170-4-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221081109.734170-4-zhengqixing@huaweicloud.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1740132528291528194.32605.5719148889041607543@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=bq22BFai c=1 sm=1 tr=0 ts=67b850b0
	a=USBFZE4A2Ag4MGBBroF6Xg==:117 a=USBFZE4A2Ag4MGBBroF6Xg==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8
	a=ZuRJGKQMYiGAcWkIlfYA:9 a=QEXdDO2ut3YA:10
X-Virus-Scanned: ClamAV using ClamSMTP

On Fri, Feb 21, 2025 at 04:11:00PM +0800, Zheng Qixing wrote:
> From: Li Nan <linan122@huawei.com>
> 
> If ack and unack badblocks are adjacent, they will not be merged and will
> remain as two separate badblocks. Even after the bad blocks are written
> to disk and both become ack, they will still remain as two independent
> bad blocks. This is not ideal as it wastes the limited space for
> badblocks. Therefore, during ack_all_badblocks(), attempt to merge
> badblocks if they are adjacent.
> 
> Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
> Signed-off-by: Li Nan <linan122@huawei.com>

Looks good to me.

Acked-by: Coly Li <colyli@kernel.org>

Thanks.

> ---
>  block/badblocks.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index f069c93e986d..ad8652fbe1c8 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -1491,6 +1491,11 @@ void ack_all_badblocks(struct badblocks *bb)
>  				p[i] = BB_MAKE(start, len, 1);
>  			}
>  		}
> +
> +		for (i = 0; i < bb->count ; i++)
> +			while (try_adjacent_combine(bb, i))
> +				;
> +
>  		bb->unacked_exist = 0;
>  	}
>  	write_sequnlock_irq(&bb->lock);
> -- 
> 2.39.2
> 

-- 
Coly Li
