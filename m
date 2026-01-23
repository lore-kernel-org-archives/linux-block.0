Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C030DD1A
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769175213; cv=none; b=qLg3zg3RPCroOwk00xMKDOI9QJhOicTb2FCRjIekNtuNpSJFwr47BstANfvmXzDuRwyHoCUuHVcYIVbk1HA+BtLeemK3zTaA64MSBkvKkLCDfMKv7IMw/4J6X6mg1t3aE/1SwfPFslUWker6Uy3hbaf4yQh4J6LKJQZzS4eq0OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769175213; c=relaxed/simple;
	bh=Fgy1tFmfF35ftBDNMgSCd40rnxMyiRynTGtXv1c/WXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSIo+djViOf0PbOUlt9ntT6kfyrsnx9VCNPyeYo2LjdxCO0GxWmsarGzPNYXYTioMiUGmyq6C7petN2tkKkVSbp9JdMAevWlFI3s+9EzzTWBwMW6X8xhTxq0OnFUl7Wz+TMDcJ3HpdmF0jfLPZWW5DWYYS3fLrmKK3PwoDyFkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1VftjVj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1VftjVj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769175211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lLhcYYedh3hfzldrcwUUr9xBpyL/rwKLSqNMQ5untPs=;
	b=H1VftjVjSMoBo7pKY9vp2ZMgK9U1EqNpfTHK8C1syDlTkgB1UMZrbMbHclhHA/8zsqeWYc
	2D0m9HTXnLRXZY+ewUs0G+O+SzpDW8Fhr0EeHzaFnLv5Avd8GoJWt/jbmElkeCi339EC1N
	ijR84SFuzsIY50SsIZHXvW8ULc/b+mQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-RLxqBvJhPreQLwumG7M_sg-1; Fri,
 23 Jan 2026 08:33:27 -0500
X-MC-Unique: RLxqBvJhPreQLwumG7M_sg-1
X-Mimecast-MFC-AGG-ID: RLxqBvJhPreQLwumG7M_sg_1769175206
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 650FC1944B1C;
	Fri, 23 Jan 2026 13:33:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 055881800665;
	Fri, 23 Jan 2026 13:33:19 +0000 (UTC)
Date: Fri, 23 Jan 2026 21:33:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: use tmpdir for scratch files and
 improve relative paths use
Message-ID: <aXN4mFuoXhtJDKyF@fedora>
References: <20260123112039.1370223-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123112039.1370223-1-alex@zazolabs.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Jan 23, 2026 at 11:20:36AM +0000, Alexander Atanasov wrote:
> Create a temp dir for temporary files and use it instead of
> placing them inside source tree.

Many temporary files are backing files of file storage target, so far
the code requires O_DIRECT, or the size could be a bit big.

In case of ramfs/tmpfs of temp dir, it may cause problem for tests.


Thanks, 
Ming

