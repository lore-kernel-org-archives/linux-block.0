Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16313B58C
	for <linux-block@vger.kernel.org>; Fri, 26 Dec 2025 02:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766717483; cv=none; b=G5khU0Nmj/3eIxycoIwYAK2wk+lspoJsh+SVzUOeWGQfk0WSO1plpHxwUiu0LyROpzoBRAK1KV/YZv7zwe6sTwLqVHtML2hyRuX8Hc1gmVehiWxBmGoPuW//qmB2dYdIvv9canRxjvoQei8R+pIEpWPgd6jSELy2d8MMImKG29A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766717483; c=relaxed/simple;
	bh=xvhd+798rmdkTXqOI2P5JGZmsSV2OmN8I6fkUCNTzpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdW524ujGEI3Jn1UyEQCPr+LFNNANdonrzVPPQKC6NKiwy9QqCXwPEmOYJXHpI3gSIwhrgCE1MrdOBeMUbIAa89TBO9ubvbSGOS5/WNsWreERIHuR+g0KutydAlp5wYmGEw/cDXhq7Sq5FaLWHiorDMY8cw8+tSMH/NZHlDV6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1E4UW3k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1E4UW3k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766717479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=syVyzrdITVT4PIvkT7TnxDjknHuk9KwWcoQMn4NlCzQ=;
	b=Z1E4UW3kpwYRxjuCacqczCjXZMBRtoatiLzahqniWY1T6wIh4RJMbVptNqOoPUQ70yfDfr
	53a9/uoOhDttUZPJvWpXCv1v97h2MHK/O2lFVkC05U0ljrfuVDqvcoWag4QelAnA5uiMqL
	SITwtsOdHXU+dIUABz5bKlnuzja/xtA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-Zzsu1CzjN2C8a3rUIa3NJQ-1; Thu,
 25 Dec 2025 21:51:15 -0500
X-MC-Unique: Zzsu1CzjN2C8a3rUIa3NJQ-1
X-Mimecast-MFC-AGG-ID: Zzsu1CzjN2C8a3rUIa3NJQ_1766717473
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C6A71956046;
	Fri, 26 Dec 2025 02:51:13 +0000 (UTC)
Received: from fedora (unknown [10.72.116.63])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D38ED180049F;
	Fri, 26 Dec 2025 02:51:08 +0000 (UTC)
Date: Fri, 26 Dec 2025 10:51:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 13/20] ublk: optimize ublk_user_copy() on daemon task
Message-ID: <aU34F9Y-47IhFWRJ@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-14-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217053455.281509-14-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Dec 16, 2025 at 10:34:47PM -0700, Caleb Sander Mateos wrote:
> ublk user copy syscalls may be issued from any task, so they take a
> reference count on the struct ublk_io to check whether it is owned by
> the ublk server and prevent a concurrent UBLK_IO_COMMIT_AND_FETCH_REQ
> from completing the request. However, if the user copy syscall is issued
> on the io's daemon task, a concurrent UBLK_IO_COMMIT_AND_FETCH_REQ isn't
> possible, so the atomic reference count dance is unnecessary. Check for
> UBLK_IO_FLAG_OWNED_BY_SRV to ensure the request is dispatched to the
> sever and obtain the request from ublk_io's req field instead of looking
> it up on the tagset. Skip the reference count increment and decrement.
> Commit 8a8fe42d765b ("ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon
> task") made an analogous optimization for ublk zero copy buffer
> registration.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

