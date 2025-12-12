Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E338313E07
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538271; cv=none; b=s6+JetdZJGIjEK7HLmmUnHOfCpc8smXhY0aQiDxpQqmM5FoZKr6vSQiqXYRRc5xPdqG8L9MKh2fBkFZkBWTvT1Ap0s12xyUa/qxh3ZP9icGr507YGsE27Eox+bwV8ws6HMZTSeRnxB5my1ItPUl3/pzJPWUr9cO45f2Mc6/F2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538271; c=relaxed/simple;
	bh=9vfZ5XCGP3ZhYtH+h7UKepd7I2NVyzlr40thkL6imuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9QmiiWWz8O7U95nr5vWF/Vck21yF2UAPF/oDK0sMUZrmWflw/pibzkuPhajiFhtSFkJkgAXyMJLpaa8sZqgffk4rxevIhdC1o7IDaEfqX3xJffjvzZ3boOYS1e6CL9zQkdd6+H/OyYFwto9zttRVUyjYTMVXjTeVIKsjEgZhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hx3AMIF2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hx3AMIF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765538269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZaHPS68+EA7nzmnx3Y5AjUxG/xQcmg9zYrO4XmI6Jk=;
	b=Hx3AMIF2OlZuopHrV9TqPseyyZrF+C0mkevlwila1oCY/Ev/88ggsPTiApr/symfmk+lQj
	5xLI/bBd43kcJUXep/DYwAz51W11vdn3VF3nYxz3tQzQjod/Kfg0jt0HvxaU5bxWDABb1g
	HlTpXQF58qif7zTLr+Q4aR1hpdVIkdE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-vXgnASk0OK2CIht-AbhYMA-1; Fri,
 12 Dec 2025 06:17:46 -0500
X-MC-Unique: vXgnASk0OK2CIht-AbhYMA-1
X-Mimecast-MFC-AGG-ID: vXgnASk0OK2CIht-AbhYMA_1765538265
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00358195608E;
	Fri, 12 Dec 2025 11:17:45 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B263194C65A;
	Fri, 12 Dec 2025 11:17:41 +0000 (UTC)
Date: Fri, 12 Dec 2025 19:17:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] selftests: ublk: add user copy test cases
Message-ID: <aTv50Ip1GzR-7dbc@fedora>
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-9-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212051658.1618543-9-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Dec 11, 2025 at 10:16:58PM -0700, Caleb Sander Mateos wrote:
> The ublk selftests cover every data copy mode except user copy. Add
> tests for user copy based on the existing test suite:
> - generic_14 ("basic recover function verification (user copy)") based
>   on generic_04 and generic_05
> - null_03 ("basic IO test with user copy") based on null_01 and null_02
> - loop_06 ("write and verify over user copy") based on loop_01 and
>   loop_03
> - loop_07 ("mkfs & mount & umount with user copy") based on loop_02 and
>   loop_04
> - stripe_05 ("write and verify test on user copy") based on stripe_03
> - stripe_06 ("mkfs & mount & umount on user copy") based on stripe_02
>   and stripe_04
> - stress_06 ("run IO and remove device (user copy)") based on stress_01
>   and stress_03
> - stress_07 ("run IO and kill ublk server (user copy)") based on
>   stress_02 and stress_04
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

