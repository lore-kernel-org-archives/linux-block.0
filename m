Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5391A262D
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175272; cv=none; b=Wlo91XJvCMMF8Q2cOMMD8ddxZVbwtlGBTXCYWWpgPJJC/ExQuv2hkq3lY3XJYpvcUWkHEZ8H7fMEm6FFL4XTePE8dsDYpeAPHfixWUsSezQSi4BhKMflnvu4/xeZUBaRK7aUUik2cbXUrP6/VVA/aIf9s/bGg52tsOwyKjxyQWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175272; c=relaxed/simple;
	bh=JsHvmGPK+bHuqFe4Ry0MfdIqEwMqxmuHqxXkPVsMjLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmabZJcxB/D8pyBaghQ1fpzrsM3IEta6F7U88r0PC2CgRM7BUZ7DcAnAKRs3oWr+uPPN2Hoo725LpZ1VDCkm8lXuIV/WYxVxG1yeojQxQvFahQWdCZrWBUJrBSQ7e0AN15Kqhoq09HUBeouYNc589G29tpP78LUpkXu7JELuSgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBoGKH72; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBoGKH72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769175268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sSp5brF2HyLKy5sjypMcZzHNDkCfxdAsbfbCzez97lo=;
	b=ZBoGKH72cbdVukWF3U2+xJIDApfrLQpIneslyW0iRSaxvBet0sbSNsS+EbRtUUua5MDMJV
	WrgKdUbeCvMSM0wH+azxY1d1iffNSD1CI9a0sFJzLk81Q6x4+NQ9DZH7LDIUPjw5HhW5Ip
	6SevO5+zSk8p8ARJVmNvjVRPiOUjYUw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-Ni4Qu3s0OSyoiZ5fkPYSng-1; Fri,
 23 Jan 2026 08:34:25 -0500
X-MC-Unique: Ni4Qu3s0OSyoiZ5fkPYSng-1
X-Mimecast-MFC-AGG-ID: Ni4Qu3s0OSyoiZ5fkPYSng_1769175264
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0F501944DFF;
	Fri, 23 Jan 2026 13:34:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A12DA1800285;
	Fri, 23 Jan 2026 13:34:17 +0000 (UTC)
Date: Fri, 23 Jan 2026 21:34:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: add missing gitignore for metadata_size
 binary
Message-ID: <aXN4z5PcLSMoPJlU@fedora>
References: <20260123112913.1371323-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123112913.1371323-1-alex@zazolabs.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Jan 23, 2026 at 11:29:12AM +0000, Alexander Atanasov wrote:
> A new utility metadata_size was added in commit:
> 261b67f4e347 ("selftests: ublk: add utility to get block device metadata size")
> but it was not added to .gitignore. Fix that by adding it there.
> 
> Fixes: 261b67f4e347 ("selftests: ublk: add utility to get block device metadata size")
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>  tools/testing/selftests/ublk/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ublk/.gitignore b/tools/testing/selftests/ublk/.gitignore
> index 8b2871ea7751..95052c32fa09 100644
> --- a/tools/testing/selftests/ublk/.gitignore
> +++ b/tools/testing/selftests/ublk/.gitignore
> @@ -1,3 +1,4 @@
>  kublk
>  /tools
>  *-verify.state
> +metadata_size

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

