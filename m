Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DB928BA95
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765443849; cv=none; b=hn2EsPhMwtwjmNW8uzza/wZW44fK5R8SU+9G6VnRQu5ORbXcDM0lres0U0zZk/nmlDIOIO19l57P0ht6HnBJfLAr/Rdsft/2ZzTdd5lURZ6bVlHe3Lv5KAnKuvz+cNoL3KJ+qUJOaT48vuPmb2MXekScAzDwRcX5xVO9yFsaBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765443849; c=relaxed/simple;
	bh=rgWQzXkArdNKxZWWY7GD+rveWG6KntmnPHpJak7kPZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEy4FvQ6sl8nw/oeQ3/vg/M0kiMjD+N1ByQpx5iXqlPqbTec/0keLgMzyexQ4VS220UFhCHQCWP6YFvBYJ6KcfmCTYa/UvptnCqweaqve0M36Hc42AUoIF6uf+E3AfypYEbyo9eYpCmIAcPvH/NPxtFgGyjHL9mKdIwQP103cng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZjD5Czv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZjD5Czv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765443847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+P3Fg80P3FSGUIaveMBnlWzzxUXDJdv0MJd5t/DXbQ=;
	b=WZjD5CzvWxkY5u3i+53RK6wszZg1TZCo/P5iW5o7GCFbKrlufIv2ekl2YVoaXz4r9t00Xi
	BYKKZU717d5n0fStKWYBO1Fo1qBx6KyhQyJjRZLErSxwEAQgTTZpihjVRRLS2r7MHVwQjG
	0PNDUs6jJkJmy8SYaycgYEKiAwgktR0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-qMnsxxqsO2OOWIb6fJtHvA-1; Thu,
 11 Dec 2025 04:04:03 -0500
X-MC-Unique: qMnsxxqsO2OOWIb6fJtHvA-1
X-Mimecast-MFC-AGG-ID: qMnsxxqsO2OOWIb6fJtHvA_1765443842
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 748F41800654;
	Thu, 11 Dec 2025 09:04:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5501A1956056;
	Thu, 11 Dec 2025 09:03:57 +0000 (UTC)
Date: Thu, 11 Dec 2025 17:03:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] selftests: ublk: fix fio arguments in
 run_io_and_recover()
Message-ID: <aTqI-SzV2uS9YPQ5@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211051603.1154841-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Dec 10, 2025 at 10:15:58PM -0700, Caleb Sander Mateos wrote:
> run_io_and_recover() invokes fio with --size="${size}", but the variable
> size doesn't exist. Thus, the argument expands to --size=, which causes
> fio to exit immediately with an error without issuing any I/O. Pass the
> value for size as the first argument to the function.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

