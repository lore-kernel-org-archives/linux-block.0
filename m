Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7C233718
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846999; cv=none; b=SIzzAFGP6DUwx7s9JMypZ5Nwrfrg3Rj760iNG7QAU7b/lenJwy3HWBH1SQxkSdxiuJ2t2uATm4Wp0WkKIDEZO+eiWY12ic6UHmdLetW2wStwsZTXJvTPGnF5fZjlaqt+gF4ozHaq2kLuoyQWgvcS0OPKPACdLj+OBye+InQas/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846999; c=relaxed/simple;
	bh=RQTJ/wmmNXFK5RhZZx8y+KZ7wo3Wl0wvVK0ExHBLyn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBhexiAPPed25U22gPuqfvqsi37auGbwtRUUPOgFkZUBadgMowh1x8y0yGxkhJSl5SMmzIiIeSKkC+3VKZVF4N76pub8K2rCSqbPIksdynx9W8RKD6vh5uq2OBnDZe8I2f07lS6d3L7p2BOBOXuOJkdqu6FK0hLYGa+VpqVLnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXKQBX8O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXKQBX8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744846996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NIr5h8ynnUOf6vq6z2NuQ7XKIXMI6GtrEcxUXCyv8oY=;
	b=GXKQBX8OL0jY8GKDl5dc3X/s+L367Npn75PsbAd/mVcy7syYbOMAqKrVyf1t9upxJnXezz
	nJ4rF2oV5niCRDzSl8yjuJetAtCa50bn2rJ4/OZOhZxp636+AwFTovLO8yV3/e0GIgXCuV
	T0wkzMehUTlc9J4lQnwsyfw8vV4bPiU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-BMfqCnkhPrKFpn4W4D_scg-1; Wed,
 16 Apr 2025 19:43:13 -0400
X-MC-Unique: BMfqCnkhPrKFpn4W4D_scg-1
X-Mimecast-MFC-AGG-ID: BMfqCnkhPrKFpn4W4D_scg_1744846992
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0CAC41956094;
	Wed, 16 Apr 2025 23:43:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC1461800352;
	Wed, 16 Apr 2025 23:43:08 +0000 (UTC)
Date: Thu, 17 Apr 2025 07:43:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V2 00/13] selftests: ublk: test cleanup & add more tests
Message-ID: <aABAhzcvon8gmp0I@fedora>
References: <20250412023035.2649275-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412023035.2649275-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Apr 12, 2025 at 10:30:16AM +0800, Ming Lei wrote:
> Hello Jens,
> 
> This patchset cleans up ublk selftests and add more tests:
> 
> - two bug fixes(1, 2)
> 
> - cleanup (3, 4)
> 
> - allow to run tests in parallel(5), also big simplification on
> test script
> 
> - add two stress tests for zero copy(6)
> 
> - kublk misc change(7, 8, 9), helps for evaluating performance
> 
> - support target specific command line, so help to add new
> target(Uday is working on fault-inject target) (10)
> 
> - add two tests for covering recovery features(11)
> 
> - add one heavy io & remove test over recovery enabled device(12),
> which can catch io hang triggered by several recent patches.
> 
> - the last patch is for making sure ublk temp file is cleaned up
> if test is skipped
> 
> With this change, kernel built-in ublk selftests can :
> 
> - cover almost all tests done by ublksrv 'make test T=generic', which has
> been effective to capture driver issue early, so it will make ublk driver
> development more efficiently
> 
> - add more stress tests for covering ublk zc feature, which has found one
> kernel panic issue introduced recently, fix merged already
> 
> - help to add new tests, such as per-target command line, which
> will help to write fault-inject target
> 
> 
> Thanks,
> 
> V2:
> 	- use ARRAY_SIZE() (Johannes Thumshirn)
> 	- drop one driver bug fix
> 	- fix ublk temp file cleanup
> 	- improve document

Hello Jens,

Can you consider to merge this patchset to v6.15?

- ublk selftest is just added to 6.15

- it includes bug fixes and nice cleanup/simplification

- test code is always tested fully

Then we can speedup to make the test code mature/stable in this cycle,
and later it can backported to liburing/blktest project.



thanks,
Ming

