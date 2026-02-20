Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E365191F94
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771563287; cv=none; b=oKb6WZXGU8SrzvMnV/k3YKXfwcUPcp5PrnBBGv9LOx0tF3xpc9x/IWo9XotsTEy2a1THYbYLdko39owc3EL3bxakA+4YltOTheZ3hEo+fxHBJ/pw4424BbcKxkowHMgFtwkDShT8F91nuNHVuYcjZeJH3W7xzqdmOefzS+oU7d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771563287; c=relaxed/simple;
	bh=Z5W4nlADXX7CiIM/7BOHHueG33MpxkM7U0vU1BuY5ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBzxmldKTooA04pUUBF2nQoTZjsoPSVTT6SdhbJTb6DC+Vzv6leT8STTHZk9jsL/p3W3HB/JhPaj08/CUzxSFCUu72T86toU0AdF2KO8FCm/FWL6CYhbd929hq5vhospXG3tOLg0dPPRS5C8OjbYwFdPz2/AVmCdnKm9ug3XKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKO5qbaQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKO5qbaQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771563285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFpWtD1IYt1ZYpogHogZ0DS07sreNitcmVsaYCQT/KM=;
	b=cKO5qbaQ/gQosSu/wvocRtkukdgU3ynlTvQYF9bNzPiSy0FRUV09ZnGkNkISWautO7XxkO
	MmdtgEQ18KGMNWa3S/4W0ANsOInkgY+hhY+XalYojPScyNgAeTyc7MdOUqfkRTsdEJqNNA
	b9ZEM86L/ntRdYBc5RcKbUaH4LrKSHw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-5PoUINfeOh-SX6Z_Z94HFA-1; Thu,
 19 Feb 2026 23:54:43 -0500
X-MC-Unique: 5PoUINfeOh-SX6Z_Z94HFA-1
X-Mimecast-MFC-AGG-ID: 5PoUINfeOh-SX6Z_Z94HFA_1771563282
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 417271956088;
	Fri, 20 Feb 2026 04:54:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.38])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 142F03000C26;
	Fri, 20 Feb 2026 04:54:38 +0000 (UTC)
Date: Fri, 20 Feb 2026 12:54:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] ublk: persistent device links
Message-ID: <aZfpCf5Vv0OaW7jN@fedora>
References: <20260216122730.144092-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216122730.144092-1-hare@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Feb 16, 2026 at 01:27:30PM +0100, Hannes Reinecke wrote:
> Implement a 'uuid' parameter to export a device UUID in a sysfs
> attribute 'uuid'. This allows udev to create persistent device
> links for ublk devices:
> 
> KERNEL=="ublkb*", ATTRS{uuid}=="?*", SYMLINK+="disk/by-id/ublk-$attr{uuid}"

uuid is passed from ublk server, so the uniqueness has to be provided by
ublk server.

So far, the ublk device ID is guaranteed to be unique, can we export ublk
device id instead?

Or can you explain a bit if uuid is a must here for some special purpose?

Thanks, 
Ming

