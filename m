Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D9145B3F
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 11:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755169964; cv=none; b=Uh5TQkyHEwh4DTLFHqbo/Elvn8NF+LhN6x+48qepDlurQ0oZSJSRpwAzYxUS9oMyeGVdP0cthrQtGRqLcp5Vi2xFmx1b0PFzUpQc2Wc17kO1yEKLjw85VPGhIRvaqECRYiQZU7/9NUVgw/iYjB84XKAWtG1LvLJQZOgIrH0/kwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755169964; c=relaxed/simple;
	bh=rGcdJABnR2c2mbTMgN2cnZqRdKbk04upwGoMupWnl3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIM5tUGNsUVekzce7SlwUN2cmOllFN8a1YpBBJ0rX62vwEEoa7sQow7V1YcLeaOwq8pCv02WtNBe/nlVFNc0VFRDchUGWXzaiiAV1PN2apzNklSPsiT8xouYs/mF4lW0AS1UhLY97tyUNbfrut7agby8rJfFFaLGPjTL6FAHBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FP/k4ed1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FP/k4ed1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755169961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ghSH9MWUsBgaR7fZ01Mocl7GMd+TVyFKFUofQaF98s=;
	b=FP/k4ed1O1SF7XaAFf3HI5RS+VCloau/dfZF/zibSa7f8mXELq/9rMuTQEDfkTv76EUdYq
	CBXTWikj7ZWckqsrFkCBq4ncy/1cFyQBL42PV8isBE629v4mWrFGx5duu9t3OVRpUobPpZ
	SdJhLGdWg3o60Fo68TvrxLIHu0JX6to=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-ibUsHnXPPl-SOZs-LP4AgA-1; Thu,
 14 Aug 2025 07:12:38 -0400
X-MC-Unique: ibUsHnXPPl-SOZs-LP4AgA-1
X-Mimecast-MFC-AGG-ID: ibUsHnXPPl-SOZs-LP4AgA_1755169957
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD7341954203;
	Thu, 14 Aug 2025 11:12:36 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E37A1800280;
	Thu, 14 Aug 2025 11:12:28 +0000 (UTC)
Date: Thu, 14 Aug 2025 19:12:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, yukuai1@huaweicloud.com,
	hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv3 1/3] block: skip q->rq_qos check in rq_qos_done_bio()
Message-ID: <aJ3El12MWxkJEz2e@fedora>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814082612.500845-2-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Aug 14, 2025 at 01:54:57PM +0530, Nilay Shroff wrote:
> If a bio has BIO_QOS_THROTTLED or BIO_QOS_MERGED set,
> it implicitly guarantees that q->rq_qos is present.
> Avoid re-checking q->rq_qos in this case and call
> __rq_qos_done_bio() directly as a minor optimization.
> 
> Suggested-by : Yu Kuai <yukuai1@huaweicloud.com>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

