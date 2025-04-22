Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AE3265606
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288297; cv=none; b=ZA7ayJ8avgMhkx4FyHUCR0l5yR8n2gGRW7AuNFaT6bjj5fOm008prRxAq/f/v//t2MSCqLOhPPWDGqExkYtTi77UPDUqpXUcTLqg3gYj0dfd5PAsVU0mLL/4ALCHitwOmE5DKfJuXjNds8uM4g+BtdZnYdGoIge5jbpVTVLOFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288297; c=relaxed/simple;
	bh=zS84EJRGNrKADPfwFvwocethFfhlrJkXOo1x0ivuFUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAkDDxIy8PYVdBwOa9kiYZD4Sz2pQo5O53Z4xtRSEKGwfkem4aQN1ZGTl3lrGy+Q5WeN3fhCE516hrITbyNBzeAemerc6AAsqFAk+d6RtY7DeBQVxuDpSYMOcwikHwCLehKUyrFny4M584iNznSv1upgB3rBRswtf55bJSw/XXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnDU5pxG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnDU5pxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745288294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz86lwydqt7W3jRCxo4XE1dASLEkdIRMGCMkG2qnxnk=;
	b=UnDU5pxGTO2bmRqxDzT3fa6BqgLIsq3qDjYyqCv7kmHH1j3st3hRnfu/2qqhwZUkaOZyWq
	wxJmzow4U6Xgf9lf2qDuriuMtff0/vExK3hm3By8us6flyaC33CH8nIo87igG+UB4fc20k
	maWfC1tFjwqQJcsbT+AvZuuIuz1RDsA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-KVo2JgokMLuFbxVWZ4rEkg-1; Mon,
 21 Apr 2025 22:18:10 -0400
X-MC-Unique: KVo2JgokMLuFbxVWZ4rEkg-1
X-Mimecast-MFC-AGG-ID: KVo2JgokMLuFbxVWZ4rEkg_1745288289
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 880B01956094;
	Tue, 22 Apr 2025 02:18:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.137])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B58701955F1B;
	Tue, 22 Apr 2025 02:18:04 +0000 (UTC)
Date: Tue, 22 Apr 2025 10:17:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ublk: factor out error handling in
 __ublk_ch_uring_cmd
Message-ID: <aAb8V8ApTc8qA0CD@fedora>
References: <20250421-ublk_constify-v1-0-3371f9e9f73c@purestorage.com>
 <20250421-ublk_constify-v1-4-3371f9e9f73c@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421-ublk_constify-v1-4-3371f9e9f73c@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Apr 21, 2025 at 05:46:43PM -0600, Uday Shankar wrote:
> There is a tiny bit of error handling code in __ublk_ch_uring_cmd which
> is repeated thrice. Factor it out of the switch statement.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

