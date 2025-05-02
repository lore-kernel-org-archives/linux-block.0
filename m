Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE082D98
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194481; cv=none; b=m1WQfZe5lEVv0uB226eslDBmHk9JZq5OAfv8/8W5myIyH9+2o3YuLE/RldQmg6/r1MIlQo1ycroszYgtbNi9KX7oBfMLlpj+rxdB3ALLVzb73RstnPleaHlpapZ6khYJGHfKn9AJjZH3I2vzuydAXX6q6aGEhybt8Pqi6jD96ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194481; c=relaxed/simple;
	bh=EEm0f/LHT+4ICq39QMKbS6+sRgrd2txjlTVjHXli3x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHeBgrnstruye7Isn++qjVNrAgUevtnTxzx8Nm+9v79hJ0DGB2dIW7YEEXbF0mFfxIB1jGiNtP+xWjhbrlX++AiwqjnQnuInhIlsgoQCuuxKKHSJUqD8gKZO12dkUSVyWNu7l8j7EpJNQLSazYVOQqsaoL9Sso9gVHUuv+xXpL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXBuZfW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXBuZfW8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746194478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji0mnBYPcABgWZx5a72/4cDO6XIizPhXd7dYO509EpA=;
	b=QXBuZfW8b8Wn++AP5e7OTcDrL/qPDAvqWfosQYhx5DnlVNkWKa6COwLI2BMUh2uezaX+ap
	YX3/0UZf22o/860bnvvx3iawCR2PNe7DzpZmLFaN1vHrBjjLVqC38znnrY5GmKVxSZN7k1
	st/QdA+WgSNeQhpMZMgGhbZFGKvARe8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-dGEVSfiNNkurRzPGpindXg-1; Fri,
 02 May 2025 10:01:15 -0400
X-MC-Unique: dGEVSfiNNkurRzPGpindXg-1
X-Mimecast-MFC-AGG-ID: dGEVSfiNNkurRzPGpindXg_1746194474
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FD671956094;
	Fri,  2 May 2025 14:01:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 531A219560A3;
	Fri,  2 May 2025 14:01:09 +0000 (UTC)
Date: Fri, 2 May 2025 22:01:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] ublk: factor out ublk_start_io() helper
Message-ID: <aBTP--tCG17AqK9A@fedora>
References: <20250430225234.2676781-1-csander@purestorage.com>
 <20250430225234.2676781-7-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430225234.2676781-7-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Apr 30, 2025 at 04:52:31PM -0600, Caleb Sander Mateos wrote:
> In preparation for calling it from outside ublk_dispatch_req(), factor
> out the code responsible for setting up an incoming ublk I/O request.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

