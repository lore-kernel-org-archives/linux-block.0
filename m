Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D431A568
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534898; cv=none; b=AV/tWUm7GkZAMYcb0KajD9VCkVLG/9ctST4zQ8OuGerYnE14Q0VfbXV57rLIl8kuttfswNwWnf+mZ2Ti61bmaBvBvXQoJiRX4b+VMvD9GkoEGIYPlyr1oYgcCWB+sCWxB0OyLyYdBix0PDx8uQop4DJopF7x9OeJfZ7nEb0Sly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534898; c=relaxed/simple;
	bh=awUymwBOhC47itu7ecucOMoWbNKHt3Ez/u/Movb3JeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI8lF5xjh8o7ZcXL2Cx5YLjrvxe3JoR3cjWKiIEfsouYla5Sar4Jnk8OG37mG5+JXXLhAVLKWiYijj2ywPBBO7j+hmJR8lGj9QwOzstp2A66blo450Xx7H/Q2UWAC8tU4P9Yxv05yG9aOYi6IwQk5y3bKES3fT7mli0dafynDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JY8ULKl7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JY8ULKl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765534896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q6Lor8Lpgp2EoSCBr8xGXTWBkjbzDfRr36NxSS3iwDg=;
	b=JY8ULKl70gfrtI29CHCYZ2CswKCJXTMb51Qgx4MKip75942wZyg8mNvIT8/ei42iG+/sBl
	uBFz2HhO5IPk1U996clV26tIvCEGrjrbfDGE/YOPGn81X3I/f3AGJ7V40BMmXSD4yMx6Hk
	uQqUpHN3/eTFWr/+JVzo1o7MrbpPIes=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-mVY7mouoPgezxasEN4OPWg-1; Fri,
 12 Dec 2025 05:21:28 -0500
X-MC-Unique: mVY7mouoPgezxasEN4OPWg-1
X-Mimecast-MFC-AGG-ID: mVY7mouoPgezxasEN4OPWg_1765534887
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94C47195608E;
	Fri, 12 Dec 2025 10:21:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1D51180044F;
	Fri, 12 Dec 2025 10:21:23 +0000 (UTC)
Date: Fri, 12 Dec 2025 18:21:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON
 tests in stress_04
Message-ID: <aTvsnv9aGxJZ486D@fedora>
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212051658.1618543-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Dec 11, 2025 at 10:16:54PM -0700, Caleb Sander Mateos wrote:
> stress_04 is described as "run IO and kill ublk server(zero copy)" but
> the --per_io_tasks tests cases don't use zero copy. Plus, one of the
> test cases is duplicated. Add --auto_zc to these test cases and
> --auto_zc_fallback to one of the duplicated ones. This matches the test
> cases in stress_03.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

