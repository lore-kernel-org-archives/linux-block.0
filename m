Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8CF1E3DE0
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055959; cv=none; b=NJOvHRyjMs1v00IOGdOH/KRjP3xhxc6gK/3u8JDu0n8RJcEj82HgFOOECOdxN3XTo+3PkVoGb4SbKbbg7qWLi14zZVLWusByFQfJCSMKRDDhuUj4TEUmFxsN3vERd+VfjuWEBjeZSPDl4ZSg0PgleXGFwZPOsUhPYL4c65ya6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055959; c=relaxed/simple;
	bh=5yTL8XGh2t9xK5VWWbyOX4lCsqycK775iZuobIRGfb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekAd8+Yiam5W2P8BEb5Nhi1gyJgDt+6RU7jTZILQ1yB/CXzakIb0CzD8UD5vrshFIMaK3jLoIMWNTJivv06TWDytLdut7n2jwXClKK9wfwb9uHCYYAudKuUQGYuMq4YSpcZDuLHn+JWpfaVkNib3sCEoNbsYM8Rul0BnRho2wpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbXWsncX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbXWsncX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728055956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BsvYJhdgN7y4uvFjsLjEprL3BcHtuRcmRyB8X0RUZKI=;
	b=LbXWsncXt2anQkzDsZG/VVSN02Fwp42c1Eu1puLlCKkGx8rNYiA0IBQbfupIvDwDBftm/M
	jV35k6g4wbN34/IgpsZN7uEWiQq8sQYq2MGM30uEOTSpKlc6XCZOResuIBzF0omGfAXgbj
	0+LyC4UVlfNCQ3/eCqZPPzliUIZqAF0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-aP2CdMNJOZqswZv2kB1EOQ-1; Fri,
 04 Oct 2024 11:32:33 -0400
X-MC-Unique: aP2CdMNJOZqswZv2kB1EOQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A946F1955BD2;
	Fri,  4 Oct 2024 15:32:31 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A216419560A3;
	Fri,  4 Oct 2024 15:32:25 +0000 (UTC)
Date: Fri, 4 Oct 2024 23:32:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/5] ublk: refactor recovery configuration flag helpers
Message-ID: <ZwAKgnJmJ6yZ-c50@fedora>
References: <20241002220949.3087902-1-ushankar@purestorage.com>
 <20241002220949.3087902-3-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002220949.3087902-3-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Oct 02, 2024 at 04:09:46PM -0600, Uday Shankar wrote:
> ublk currently supports the following behaviors on ublk server exit:
> 
> A: outstanding I/Os get errors, subsequently issued I/Os get errors
> B: outstanding I/Os get errors, subsequently issued I/Os queue
> C: outstanding I/Os get reissued, subsequently issued I/Os queue
> 
> and the following behaviors for recovery of preexisting block devices by
> a future incarnation of the ublk server:
> 
> 1: ublk devices stopped on ublk server exit (no recovery possible)
> 2: ublk devices are recoverable using start/end_recovery commands
> 
> The userspace interface allows selection of combinations of these
> behaviors using flags specified at device creation time, namely:
> 
> default behavior: A + 1
> UBLK_F_USER_RECOVERY: B + 2
> UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2
> 
> We can't easily change the userspace interface to allow independent
> selection of one of {A, B, C} and one of {1, 2}, but we can refactor the
> internal helpers which test for the flags. Replace the existing helpers
> with the following set:
> 
> ublk_nosrv_should_reissue_outstanding: tests for behavior C
> ublk_nosrv_[dev_]should_queue_io: tests for behavior B
> ublk_nosrv_should_stop_dev: tests for behavior 1
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

