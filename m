Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2908A31B100
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538062; cv=none; b=GYxq+0ysnLJ0G0TfgPHmzqC5Xm1PWfon+7s5MqdrZxEdIMAm+Bv9JSW7aCLdmI8Z4e/bB3hG/ZsdS+vHXiVeNXx/uf+6odbo5mEpwC1gVfnN2tsk0sXVCAuglnH2HbRhmxm0H+r8UiEU6eh6bQmd7fWBUyMENRt/aNJLCJ0Fj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538062; c=relaxed/simple;
	bh=599F0iN8VoHAMcBk9hlUnhzqpKfM9wcRmEpKwX2fypw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTI5/I317IWVIJIbp9/iqqWDOr2d46tRyRbvDd9YQGMmuEqud3ZSKSo0HbRwUmut8p2vSZdJ4mHi5ETHmExeHwye8MJN/3W3RQ90lRSL2qqnObOfcVakM9/RVVBX2YGdRXesvyMFhv7BjdmLxmWokp+eTFTYEope4KDwy/oR82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S54uSWJI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S54uSWJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765538060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FeH2q0RH17mtsW9nUPh5TVnCObfHE1KFZdVHyBk5l4k=;
	b=S54uSWJIwGTDSoV2FYLSj88wBKvpoOgI7tgZFSh9+9enUBhtrUEMbpc89SgZHr/GN0oqUL
	9ZYp7AE1HQxas2qJKJO+IKxQsC379ipKn9QyJpYIACQ4cOR+wGWxGqLOJLrv2gyykyfZhQ
	60A+rhGuhnbo291kK6rPM3M8doh1+OU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-RbRQ-7iWMRqa-CUX7uIwng-1; Fri,
 12 Dec 2025 06:14:07 -0500
X-MC-Unique: RbRQ-7iWMRqa-CUX7uIwng-1
X-Mimecast-MFC-AGG-ID: RbRQ-7iWMRqa-CUX7uIwng_1765538046
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D50EF180035A;
	Fri, 12 Dec 2025 11:14:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EB6F19540DF;
	Fri, 12 Dec 2025 11:14:02 +0000 (UTC)
Date: Fri, 12 Dec 2025 19:13:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] selftests: ublk: forbid multiple data copy modes
Message-ID: <aTv49eVEicH9EHWg@fedora>
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-7-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212051658.1618543-7-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Dec 11, 2025 at 10:16:56PM -0700, Caleb Sander Mateos wrote:
> The kublk mock ublk server allows multiple data copy mode arguments to
> be passed on the command line (--zero_copy, --get_data, and --auto_zc).
> The ublk device will be created with all the requested feature flags,
> however kublk will only use one of the modes to interact with request
> data (arbitrarily preferring auto_zc over zero_copy over get_data). To
> clarify the intent of the test, don't allow multiple data copy modes to
> be specified. --zero_copy and --auto_zc are allowed together for
> --auto_zc_fallback, which uses both copy modes.
> Don't set UBLK_F_USER_COPY for zero_copy, as it's a separate feature.
> Fix the test cases in test_stress_05 passing --get_data along with
> --zero_copy or --auto_zc.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

