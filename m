Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A731642AA6
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 02:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055707; cv=none; b=ZD6E53YIh2oCnMtcUp3VjjOzqgn8neosdpQebIxJ/xt1J0Z2XNUdWDn/1ArRjsFKablnJzVRV6aGFmg4GNIZJEshvVWFltBC+sHeHj47PaHWO/mTL03IUPt3VEBQODwoxThJyzI7TsBko3oovpN3+TLyHF3XpLRtkVYwAk2r3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055707; c=relaxed/simple;
	bh=/N6DTjx4bMNjT4L9NEX3XpcO9guBS7cavMoy+l+3WMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coz8P803JT95UNcKQEb4YIycGrhn1+1DORGBfRE0jXCvj1+y4P7m3fsrnULke/yFa50TC7j3F9FpNqcd5RiEUK1RAVc21FmlXxyWAXkchRT+6Qg8XI36NrVZ9N5jbixemyF6iV/vZ95Nju85dVHXYOHOkpQzc32KJ5uxiSe9Xnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GH65IdLA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH65IdLA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741055704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hmNnBPQSG4/JQiTH7GFC97F6Fk4OVNc3GtFOK8TdAWQ=;
	b=GH65IdLAA9Ih2M2NAXQpdZPiSdOiK0yVyjTzzDD0p/akc57qMKoSb9aYE+xHHjlE5k3lbc
	Q2rZXC5edi5E7fzPLPKIAgmjooD14WvdA/p3rdOXxXd6JL1Mm5E/UnxGU+is1a1KU0Z8QV
	E+hOsoEDzXDQtZnzZPY2fBg64DoBACE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-3KTn4lt1NmSHoj4BLDs1ow-1; Mon,
 03 Mar 2025 21:35:02 -0500
X-MC-Unique: 3KTn4lt1NmSHoj4BLDs1ow-1
X-Mimecast-MFC-AGG-ID: 3KTn4lt1NmSHoj4BLDs1ow_1741055701
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 975F219560AF;
	Tue,  4 Mar 2025 02:35:01 +0000 (UTC)
Received: from fedora (unknown [10.72.120.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E8EF19560A3;
	Tue,  4 Mar 2025 02:34:57 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:34:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH] tests/throtl: add a new test 006
Message-ID: <Z8Zmy91_o7alwuKI@fedora>
References: <20250224095945.1994997-1-ming.lei@redhat.com>
 <ddvcm7qzw3wxx4wrz6partrr5riobvna75vgcly5cxah76cmmd@w3v3k5yj4daj>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddvcm7qzw3wxx4wrz6partrr5riobvna75vgcly5cxah76cmmd@w3v3k5yj4daj>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Mar 03, 2025 at 12:06:44PM +0000, Shinichiro Kawasaki wrote:
> Hi, Ming, thank you for the patch.
> 
> On Feb 24, 2025 / 17:59, Ming Lei wrote:
> > Add test for covering prioritized meta IO when throttling, regression
> > test for commit 29390bb5661d ("blk-throttle: support prioritized processing
> > of metadata").
> 
> I ran this test case with the kernel v6.14-rc3, and it passed. Then I reverted
> the commit 29390bb5661d form the kernel, and still the test case passed. I
> wonder how can I make the test case fail. The commit was in v6.12-rc1 tag, so
> do I need to try with v6.11 kernel to see it fails?
> 
> I have two nit comments in line. If you respin the patch, please consider to
> fold them in.

The test needs to setup cgroup v1, I guess.

Kuai, any idea for setting one test to cover the change of commit 29390bb5661d
("blk-throttle: support prioritized processing of metadata")?


Thanks,
Ming

