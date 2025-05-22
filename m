Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7326345BE3
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 02:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747881645; cv=none; b=kGy4gddrkfkApOTQlnWDklN3oYzx5uYgOcrkfIkqvKXK12fGeJKdPWVugvCRIzKtbNWt49mU+qwK9bqGRLQyoIS0QWJ3hLKJ8MvxN/K8j2ZFQ9knschzZCglAWQ9YoX+1mIUZakXQBMi1UFtTyb6DuG8PrLKlKz2KZ6+fc7uBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747881645; c=relaxed/simple;
	bh=ZKOHIHDDi6AxMyc2CzMPxN5RVYD91Kp2m/Cz7iSWj78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucGR4XEWpqdHZngjfpdzLUtnaPNXB5TTi3PAkzI5cBUn2Axk0Z/tMJqdew/VidvPBGejRYNh4/iZdVvntiAHRzVhDIFnMhJQTnazRGC1O7+k98exai00MPiBxZIVh+5TLJHsI4EOpXd9mVhHOChR8U1txpbTnJ6cPxZ21bQ6sOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AeJgdVf+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeJgdVf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747881642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HmCantyUlLY67TPpShcPTsMGfNVblvBqn7EzBXLF2qE=;
	b=AeJgdVf+ow2PeX33MZ58bSbjN7bdE0e8yhlSbYNqZNd8eaIP7m7Tm+e9hLWF64owDvTHtT
	Sl8uBiLnFxVx+qByR0SxLEslvkFz6SvbFgaIOBhZJ5bdc1vRU3Svm5m7XI9HdXjni4Wh5i
	ecQcsDSSDSyL9DKopukLNLQgTFFzedU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-jLSzU6ccPvyT8xWboeghdQ-1; Wed,
 21 May 2025 22:40:38 -0400
X-MC-Unique: jLSzU6ccPvyT8xWboeghdQ-1
X-Mimecast-MFC-AGG-ID: jLSzU6ccPvyT8xWboeghdQ_1747881637
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B60B1956088;
	Thu, 22 May 2025 02:40:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A81019560A7;
	Thu, 22 May 2025 02:40:33 +0000 (UTC)
Date: Thu, 22 May 2025 10:40:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: remove io argument from
 ublk_auto_buf_reg_fallback()
Message-ID: <aC6OnAWeFwte_hUa@fedora>
References: <20250521160720.1893326-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521160720.1893326-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, May 21, 2025 at 10:07:19AM -0600, Caleb Sander Mateos wrote:
> The argument has been unused since the function was added, so remove it.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks, 
Ming

