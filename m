Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB0465EB3
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876171; cv=none; b=XuuJ/KYdUlY8C2SwUOzhF+b23IEeMULE2dYrA9EbDM0al9yMR0l+E2L6q+/8SQh8d0Zvp0rFsJpN+Q0d0FCIK+oruv9JmbWDvb4fuuKHBXS/eCE0s6qf3vRse6apWqkQ8wWy8Wid8zKuPcq8jEefm2+45cGd1aghklyL/MIRm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876171; c=relaxed/simple;
	bh=rCID7ihfpqiqBJh5JGnaHJiTTRwiLi8w2ml7fCklyR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4yUgQzXtv9tgQa/mk7ERg5W0gjGjUPw2ux2wjsYOd2zvIklHkbWDsBNoWJCzJSssnrSqsz1n53K6p3PZgyNhwbcxeUU9VqDH1UPtsILJxu6nkRDO5NL6Jjj/BCt0M6/0PL+IDCcvVZv6kmbVZdSlCymOMK2g/idjVGkqy8BSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOu5bz6t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOu5bz6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767876168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxorc1hYnSYDj5qHulGUOtJiB+WHqxZGOCjvPA69Ukg=;
	b=EOu5bz6tTwbzZWO14AWN1LzSNKZKgj96WbkrXGOyo7cbNG/j0u469rv47wWUM6ypKQLNUK
	KVXW0WPHAh/T7yq8bL8jijP+/1ZGrtvUTVRhaK3VS8KsEjwA2l3cjahC7q8fAeZLGtAw1i
	L35NpkZOZcKPYD6O02bfgVa+XKXqRnw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-xzBPntqaM8ibymP7cKLTBw-1; Thu,
 08 Jan 2026 07:42:43 -0500
X-MC-Unique: xzBPntqaM8ibymP7cKLTBw-1
X-Mimecast-MFC-AGG-ID: xzBPntqaM8ibymP7cKLTBw_1767876161
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7FB518005AE;
	Thu,  8 Jan 2026 12:42:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC8A430002D1;
	Thu,  8 Jan 2026 12:42:35 +0000 (UTC)
Date: Thu, 8 Jan 2026 20:42:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 17/19] selftests: ublk: add integrity data support to
 loop target
Message-ID: <aV-mNgMwsYEMTLSW@fedora>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-18-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108091948.1099139-18-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jan 08, 2026 at 02:19:45AM -0700, Caleb Sander Mateos wrote:
> To perform and end-to-end test of integrity information through a ublk
> device, we need to actually store it somewhere and retrieve it. Add this
> support to kublk's loop target. It uses a second backing file for the
> integrity data corresponding to the data stored in the first file.
> The integrity file is initialized with byte 0xFF, which ensures the app
> and reference tags are set to the "escape" pattern to disable the
> bio-integrity-auto guard and reftag checks until the blocks are written.
> The integrity file is opened without O_DIRECT since it will be accessed
> at sub-block granularity. Each incoming read/write results in a pair of
> reads/writes, one to the data file, and one to the integrity file. If
> either backing I/O fails, the error is propagated to the ublk request.
> If both backing I/Os read/write some bytes, the ublk request is
> completed with the smaller of the number of blocks accessed by each I/O.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

