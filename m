Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FC24B28
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750642928; cv=none; b=KnD2zzzQdwR0YDolux2XFWtSChqpjEFVyM1wSXT1o/7NCV4m+KMTs1cd6gs6/5YbpPPQjb/5RqagV63I6PXKg8KlJvZ565i9AXSmi2FB3183iMLj5LysQv/qYMe0tlfe/LIzEjukmT8Zc249SdzZdykUjf82gYjInflxrmLeh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750642928; c=relaxed/simple;
	bh=tZ6ACI6+qkNKJDG4TzvggulCC/YlI2a5QfoP3IGsyo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uftjxXpWEIWB0wge573SZ7//ybXideNV5dviGNClSrsWlD4taF51hLPLjk3au9+1A2VwU+sgkAK2LvOZI7DEfuRX8Dthh0RvlZyEONmJkywC0/VpBB684wUv8Zu/GWiBB8RpUbZP0GT/WyiKjA8Or/GUhc68hKxWIIs5yvnK/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ug9vd6kI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ug9vd6kI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750642925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RppXmlqXYtwn2IaAFW7C4LW7Gma4dq2BWE+LoO6fA+c=;
	b=Ug9vd6kI0YUCBw+2NhQehi41z/QGftXuZbVeY3EraB5Y4/flFjD70gM+G2iJtxM2euvEFT
	nR8rUvMb3Xbc8PPyHJw+lerOBRATWCah0tu1yndKd8rQ6mIZn6LsWjv/stOCEilWQ+UIpj
	rqaJydgCvVXb1OQUhdxY1s0pmzL0zDw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-dTIQymJAPtKYuuZPn-qi2Q-1; Sun,
 22 Jun 2025 21:42:02 -0400
X-MC-Unique: dTIQymJAPtKYuuZPn-qi2Q-1
X-Mimecast-MFC-AGG-ID: dTIQymJAPtKYuuZPn-qi2Q_1750642921
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 611DF19560BA;
	Mon, 23 Jun 2025 01:42:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2A9619560AF;
	Mon, 23 Jun 2025 01:41:58 +0000 (UTC)
Date: Mon, 23 Jun 2025 09:41:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: update UBLK_F_SUPPORT_ZERO_COPY comment in UAPI
 header
Message-ID: <aFiw4eaajxKEOVa7@fedora>
References: <20250621171015.354932-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621171015.354932-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Jun 21, 2025 at 11:10:14AM -0600, Caleb Sander Mateos wrote:
> UBLK_F_SUPPORT_ZERO_COPY has a very old comment describing the initial
> idea for how zero-copy would be implemented. The actual implementation
> added in commit 1f6540e2aabb ("ublk: zc register/unregister bvec") uses
> io_uring registered buffers rather than shared memory mapping.
> Remove the inaccurate remarks about mapping ublk request memory into the
> ublk server's address space and requiring 4K block size. Replace them
> with a description of the current zero-copy mechanism.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming

