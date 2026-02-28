Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0D1D90DF
	for <linux-block@vger.kernel.org>; Sat, 28 Feb 2026 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772273187; cv=none; b=HneDlr3K9HGNXDdlzXXltvuMjN7lN73kdx5a0cyOVb4NXGmRI8klbM8ifEGBMHY3ln85qqtOuCZiD4zA87BFhETjDfD7ng1eBN+7cdQ5vpBWIumoRKKnrQYxqwRdEwhfGA8n8XP//RlZ/eoQGwGS+hOQZpYw/BKFH0qBMkIPxWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772273187; c=relaxed/simple;
	bh=Q06mW3BsnPh1cDStXMGZdQKkmi9wllubW088nTsOKIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdRwLyN63ErfquawV8EBXtQzzJflt3FrUrmImKOmMyyxzAZKkCeQ5/N0eQ38CA++IueIoy+FVdkXKWd/yoMr+pbpY8XiXcp+FQrCGnzhNAxcCfndEOIOS5aWRpauWj3Jbc2xpttjrCyYtLFGZD6+bf5nwmbbe230CPRyN/ib3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3NWPGzv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3NWPGzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772273185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CaHbT50o10hgosGr9mFnkzplPDeeZD18MXIOxV0r5o=;
	b=R3NWPGzvSNXO+5N69bdbgXYKyxBxZx5F90L8X8ZzctpSBHI3C4WVWnCatv2Eu0Gz/fLetZ
	kqdPug2hNgeVDd5tSi5Z5QiC3bW6cfND/BYo/oOWHfsmQJvqBynvbASxHXyaN2hAJn6eqC
	lzgbK+kryng+qtcBa/bRmAIuR3HNUR4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-7tG7tWz8OjyCj70XGQ81YQ-1; Sat,
 28 Feb 2026 05:06:21 -0500
X-MC-Unique: 7tG7tWz8OjyCj70XGQ81YQ-1
X-Mimecast-MFC-AGG-ID: 7tG7tWz8OjyCj70XGQ81YQ_1772273180
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10B8918003FC;
	Sat, 28 Feb 2026 10:06:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.144])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 469351956053;
	Sat, 28 Feb 2026 10:06:16 +0000 (UTC)
Date: Sat, 28 Feb 2026 18:06:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/4] selftests: ublk: rework partitions tests for new
 flags
Message-ID: <aaK-E9ovqnKPl_4b@fedora>
References: <20260227145756.3877069-1-alex@zazolabs.com>
 <20260227145756.3877069-3-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227145756.3877069-3-alex@zazolabs.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Feb 27, 2026 at 02:57:54PM +0000, Alexander Atanasov wrote:
> To support new flag - UBLK_F_NO_PARTITIONS
> add kublk argument:
> -m, --no_partitions - disable partitions on trusted devices
> Add short argument for  UBLK_F_NO_AUTO_PART_SCAN
> -p, --no_auto_part_scan - disable initial partition scan
> 
> Update test cases to use the new arguments
> 
> Fix long lines while at it.
> 
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>  tools/testing/selftests/ublk/kublk.c             | 16 +++++++++++-----
>  .../testing/selftests/ublk/test_integrity_01.sh  |  8 +++++---
>  tools/testing/selftests/ublk/test_part_01.sh     |  6 +++---
>  tools/testing/selftests/ublk/test_part_02.sh     |  6 ++++--
>  4 files changed, 23 insertions(+), 13 deletions(-)
> 
> v1->v2:
>   - switch from opt-in to opt-out flags
> 
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index e8279c4acc40..c0dacdc12ebe 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -1615,6 +1615,7 @@ static int cmd_dev_get_features(void)
>  		FEAT_NAME(UBLK_F_INTEGRITY),
>  		FEAT_NAME(UBLK_F_SAFE_STOP_DEV),
>  		FEAT_NAME(UBLK_F_BATCH_IO),
> +		FEAT_NAME(UBLK_F_NO_PARTITIONS),
>  		FEAT_NAME(UBLK_F_NO_AUTO_PART_SCAN),
>  	};
>  	struct ublk_dev *dev;
> @@ -1713,7 +1714,7 @@ static void __cmd_create_help(char *exe, bool recovery)
>  	printf("\t[--nthreads threads] [--per_io_tasks]\n");
>  	printf("\t[--integrity_capable] [--integrity_reftag] [--metadata_size SIZE] "
>  		 "[--pi_offset OFFSET] [--csum_type ip|t10dif|nvme] [--tag_size SIZE]\n");
> -	printf("\t[--batch|-b] [--no_auto_part_scan]\n");
> +	printf("\t[--batch|-b] [-m,--no_partitions] [-p,--no_auto_part_scan]\n");
>  	printf("\t[target options] [backfile1] [backfile2] ...\n");
>  	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
>  	printf("\tdefault: nthreads=nr_queues");
> @@ -1783,11 +1784,12 @@ int main(int argc, char *argv[])
>  		{ "integrity_reftag",	0,	NULL,  0 },
>  		{ "metadata_size",	1,	NULL,  0 },
>  		{ "pi_offset",		1,	NULL,  0 },
> +		{ "no_partitions",	0,	NULL, 'm' },
> +		{ "no_auto_part_scan",	0,	NULL, 'p' },

IMO, both two short options('m' and 'p') are not readable, I'd suggest to
not add short option if better name can't be figured out.

Otherwise, this patch looks fine.


thanks,
Ming

