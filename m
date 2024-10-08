Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4031DFE8
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728355780; cv=none; b=hMJaEGhSgjsyNe1433goWBRhSsHVjXDOSjzTyX4GR+dEHWasWEXYhDwF4Pc1XxndLICzYncob/47FtLkTYspJfRPSCkSBG52HOAjBGFYzzEKnAqDhRG2ZNN3tel0mm3inMeYz1oU2Uipks2negUvRV0+kdhxMITMd8MWlmqc2Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728355780; c=relaxed/simple;
	bh=gpY+cDuQR0lLdum6L6kVAbwjqPlfs79dMpkOAx0XZz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvIgIjBGMQ3PJHAkKVkaRdoaMlbVW0xcNAJTgU0RfIZNev7if2Pu2DTi5LZeWWSUWWc0MlXyLMh7JKDM6Rm+CmeVFR5xT+stmpGjqW1c5DmoTNJdoXMkVgkY4Jsnt61mkMXaF9o7pA+ZNqH4+WjYwk6w76jZM+idT1TRYiefax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cePW6jBn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cePW6jBn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728355776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=heKr/qtCoGXLP+2dMwftapVkcL7j0LVT6rdLkl8ZxPk=;
	b=cePW6jBnGNaURGLdw+amggfkmNIX+/dZXNBEiFjy3h5H4SOYGUeLTvNTNpb0nNsStgcwDH
	I4z0xFOuW2daVsRXomt4wYSqkeuNVqt3uR2K4hKPwzwVpitgwzpkqMMgYVsXssgY0UOzYY
	l4EheCCxSvjc2nhmHmBE1amQAqAj4BY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-Mv4JjQAxMdi5IR48t1Ficg-1; Mon,
 07 Oct 2024 22:49:33 -0400
X-MC-Unique: Mv4JjQAxMdi5IR48t1Ficg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 014AC1955EA9;
	Tue,  8 Oct 2024 02:49:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B452019560AD;
	Tue,  8 Oct 2024 02:49:24 +0000 (UTC)
Date: Tue, 8 Oct 2024 10:49:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 5/5] Documentation: ublk: document
 UBLK_F_USER_RECOVERY_FAIL_IO
Message-ID: <ZwSdrd1KcmEbFT-l@fedora>
References: <20241007182419.3263186-1-ushankar@purestorage.com>
 <20241007182419.3263186-6-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007182419.3263186-6-ushankar@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Oct 07, 2024 at 12:24:18PM -0600, Uday Shankar wrote:
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  Documentation/block/ublk.rst | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

