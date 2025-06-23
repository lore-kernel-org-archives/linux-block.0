Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614EB218E9F
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672159; cv=none; b=Nw9C6tmcxkWcUxjMarrxlWr8HDI6G7ja2FqmtbIBaeU5WooQzO9dr6XsUNmFZCY91hM34xwbQL3WoUOHOaFAKDejT7QEhZKbwJs+Z09YaX0Na4Bwbv7Z6q4f5pRQJoTjbZuXN7HO/sbR+LmyNLrrpYsiOlAg4nwa2p28JoIZN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672159; c=relaxed/simple;
	bh=g65jt0VSj3nwiTw8FU7cd0BAVjpoRt8/tIX5/8xOaQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC1AK+ssT5FdYH977VPefqeKRgau1uLzD8n2HDeokVCM/14SZj7j3UBicM9QTwK8SivaUF3XKjXudp9n5OO+woM25+Fnsi/8/os6YXLeTO6n13a2Tt8Y4UwiNRo0LQSwiYyco1FqtqIedNXibsWDK8ISIB1BR7chwwaYMDrjlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBYbXhwi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBYbXhwi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750672156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQPIHXp0g+QvXAx6z5hZ1thxiI+yNBfpOMzFK/H9ugs=;
	b=YBYbXhwiER20dlyX+2qIOqjVe8ynZTsrI8bydzBYzZ8gGQOEvWJGNE/7ZBh3yqUPxr5tWT
	5RLW5JbpwTTEqIEEzrtoxMJoY1rcEsWGys9gTPBPVneUDuDfsBklWBaAFzvc7rPeizzt1B
	c3PT/sMXI1HHqdQpQ+QsME3SqpWS9iU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-flBr7n_aPUycaodvNzt0_g-1; Mon,
 23 Jun 2025 05:49:12 -0400
X-MC-Unique: flBr7n_aPUycaodvNzt0_g-1
X-Mimecast-MFC-AGG-ID: flBr7n_aPUycaodvNzt0_g_1750672151
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6330C1809C8B;
	Mon, 23 Jun 2025 09:49:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA22F19560AB;
	Mon, 23 Jun 2025 09:49:08 +0000 (UTC)
Date: Mon, 23 Jun 2025 17:49:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 13/14] ublk: remove ubq checks from
 ublk_{get,put}_req_ref()
Message-ID: <aFkjDyu6aiSZrUNN@fedora>
References: <20250620151008.3976463-1-csander@purestorage.com>
 <20250620151008.3976463-14-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620151008.3976463-14-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Fri, Jun 20, 2025 at 09:10:07AM -0600, Caleb Sander Mateos wrote:
> ublk_get_req_ref() and ublk_put_req_ref() currently call
> ublk_need_req_ref(ubq) to check whether the ublk device features require
> reference counting of its requests. However, all callers already know
> that reference counting is required:
> - __ublk_check_and_get_req() is only called from
>   ublk_check_and_get_req() if user copy is enabled, and from
>   ublk_register_io_buf() if zero copy is enabled
> - ublk_io_release() is only called for requests registered by
>   ublk_register_io_buf(), which requires zero copy
> - ublk_ch_read_iter() and ublk_ch_write_iter() only call
>   ublk_put_req_ref() if ublk_check_and_get_req() succeeded, which
>   requires user copy to be enabled
> 
> So drop the ublk_need_req_ref() check and the ubq argument in
> ublk_get_req_ref() and ublk_put_req_ref().
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

