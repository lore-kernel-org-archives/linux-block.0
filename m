Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE14C8E
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453690; cv=none; b=M4N1osJlMpdFO386ML8pIkHTOkoK60kQRKKG7w4LWdXUD/9uSXvSHJki4cGhjJHByxvQXX9K0so8lBYkUxhHWfQVc5okLcqkIBgZj7up5aVSmxX0QKcqc9CC8zc2u2B3FG4qlKsEJHs6urU3HwfAHjeGu39rwMzOMz84FYOepJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453690; c=relaxed/simple;
	bh=2m8sexQCiCeS0NPH/YWsjatLgVmRA+dMEEtNEKgEUTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juz2BepdZAoerG+M7PLNSMNi+9OBYpPRX5vC0FbvtUf/4GqmxzJmiT7uk/EkjMNKwjSBsDISYSjWLfVrc1UC5pwrP0Y0FUPwCWlmUfzQjenFCVuLLUMh+Xf5efjgv09n0FmmI/reR0e3l/RlmoGD2/jU1DyJWX80GUncu93cprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fuGD38ul; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuGD38ul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749453687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r0tw1I7Oa9u3KztbtQT6Lbx36chqKCoXRLWd+AUp2NA=;
	b=fuGD38ulvbP6ZkQ+UpzfJ2CphpBGsfX5plGrfKNvO9I6nupS5Wn701DmSSe4euf+8fe5pj
	fdk+MfYQWlo71o73SGN5qcCk1pAONB2chFYYeAqjs+THhFBlmmy4utqMbwloGhPoF7T8eV
	jncsVJ7wg6daSSxKOQSyi3EmN+LTZ4w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-NvXLcjZVMveS78s-cdTSWA-1; Mon,
 09 Jun 2025 03:21:25 -0400
X-MC-Unique: NvXLcjZVMveS78s-cdTSWA-1
X-Mimecast-MFC-AGG-ID: NvXLcjZVMveS78s-cdTSWA_1749453684
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A546180136B;
	Mon,  9 Jun 2025 07:21:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF6ED1956087;
	Mon,  9 Jun 2025 07:21:21 +0000 (UTC)
Date: Mon, 9 Jun 2025 15:21:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 5/8] ublk: move ublk_prep_cancel() to case
 UBLK_IO_COMMIT_AND_FETCH_REQ
Message-ID: <aEaLbLU9VzI2yp-0@fedora>
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-6-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606214011.2576398-6-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jun 06, 2025 at 03:40:08PM -0600, Caleb Sander Mateos wrote:
> UBLK_IO_COMMIT_AND_FETCH_REQ is the only one of __ublk_ch_uring_cmd()'s
> switch cases that doesn't return or goto. Move the logic following the
> switch into this case so it also returns. Drop the now unneeded default
> case.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

