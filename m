Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF8612F6
	for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812056; cv=none; b=rOwVS/55SIKbARzMWsa0GUrUwAqYKTs9tAT49+UFJRgou6i8Ux97Z8/CM5GPCRRsH8Gvgy20iuc/mKYlV2ZFFQsXA2+cPI2OSVqFPvKj9te/owtzPa7biqCAyjhY6XIqnrKRulHoCFiemj07eTIRP8mRSViqtcVjwIGna7PzfoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812056; c=relaxed/simple;
	bh=8V9k8lXgPNAHSwbbO7zcFZqhQO3pjZt+ju7YG7abVnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Go8Ap5ETp851+baJc4vvxaERrLIj4M7tAV98tjMsEzxj+GGPwS2K1Di7+aleAth8dld6dTMat2Xr4icv7pvk+gdOgKgV6NckRPVKIpL3V5oQAT6Nq0+Trbw6Btu7SpvmScdWcP3iaG0zVHc0Iue2P0fJpBB3ok6cdB3G2TUlCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmmxM0OY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmmxM0OY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710812053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CiL47lsaFfqKLmgurxyE3/xGahJ90wedsyL49MP/HU0=;
	b=dmmxM0OY0xwdVUehTWA36FCfv4hJwO7ip/bYZidVtjP0AIZJey1ijcpeVv1V6MuM6Jqgzg
	Ry8AmEQRFxHJATYyXz31been1vKDmpg/hqQLQ18+mDd9IuP94yQ69gH1uEPck12OHqxlzq
	CfG0lz5cWQ2FLbDCg5RUOoILWfMyIoY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-_39Uz9zIM-a-5qKfTjq6xQ-1; Mon, 18 Mar 2024 21:34:08 -0400
X-MC-Unique: _39Uz9zIM-a-5qKfTjq6xQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04D03185A781;
	Tue, 19 Mar 2024 01:34:08 +0000 (UTC)
Received: from fedora (unknown [10.72.116.95])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DCF08492BC8;
	Tue, 19 Mar 2024 01:34:04 +0000 (UTC)
Date: Tue, 19 Mar 2024 09:33:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 02/13] io_uring/cmd: kill one issue_flags to tw
 conversion
Message-ID: <ZfjrhIRnSD0ksbeh@fedora>
References: <cover.1710799188.git.asml.silence@gmail.com>
 <c53fa3df749752bd058cf6f824a90704822d6bcc.1710799188.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c53fa3df749752bd058cf6f824a90704822d6bcc.1710799188.git.asml.silence@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Mon, Mar 18, 2024 at 10:00:24PM +0000, Pavel Begunkov wrote:
> io_uring cmd converts struct io_tw_state to issue_flags and later back
> to io_tw_state, it's awfully ill-fated, not to mention that intermediate
> issue_flags state is not correct.
> 
> Get rid of the last conversion, drag through tw everything that came
> with IO_URING_F_UNLOCKED, and replace io_req_complete_defer() with a
> direct call to io_req_complete_defer(), at least for the time being.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

