Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468B1804A
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750642863; cv=none; b=qKvFFe0ChTogePf8Do/YzKVpBBY7Dlk6dTPGeP+xgJ0EpPWBuY3xODwkHikXV6qjDqO+C3KyNbqqkYWeci9m86kN69FEg3t9Jx/M+3AuJBBpshshXt7DJk3nnHo3OK6qajTXh2DcnO0mA6MY3oiBSqWZFVoxGS718X1oVIeaRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750642863; c=relaxed/simple;
	bh=Gj9wDrFCWAjZW0W6vVA05OitNVnE8cZpbtV2RxxtMX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KymLe4BCXBD9evNX/jSTA6qxkU1MqH4N+tn3MvbqEuITjMhiV9+cwf8AOZMNBWMEP9+QmZ6eO6v5JTdWTung/fxzE1IgqOX4hnuAAFEmHu+9g9CuLJ6i+dMxCNFs00VfmofMyjQZZjLJKiM+/jJa5itGai07WAPLhvPnRzDLCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EB+fx7YP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EB+fx7YP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750642861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+NP2l/+jtU9JIQqfmS2fbWPnVhjg4muGRENQNpidM4=;
	b=EB+fx7YP3YEdfQ8mFdyXDgYHM4unFPp38RtAeXsYForerFvSzzvQOf5b7/AKpuPSAXvTMq
	/tqoY7N6W1UnRkIaN66EDAawvM+gIUBEL+ZMrEMc96j0CAOaiI3uJ2jy2WElcK+Fo0T0TQ
	i0hQM3Z0BNIFP1FwxpmvtmRQqBbutSo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-SHOjW2UYO-qHVO4g75QnYg-1; Sun,
 22 Jun 2025 21:40:57 -0400
X-MC-Unique: SHOjW2UYO-qHVO4g75QnYg-1
X-Mimecast-MFC-AGG-ID: SHOjW2UYO-qHVO4g75QnYg_1750642856
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54E791800287;
	Mon, 23 Jun 2025 01:40:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21DEC19560A3;
	Mon, 23 Jun 2025 01:40:52 +0000 (UTC)
Date: Mon, 23 Jun 2025 09:40:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: fix narrowing warnings in UAPI header
Message-ID: <aFiwn2v9VGWBdd8t@fedora>
References: <20250621162842.337452-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621162842.337452-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Jun 21, 2025 at 10:28:41AM -0600, Caleb Sander Mateos wrote:
> When a C++ file compiled with -Wc++11-narrowing includes the UAPI header
> linux/ublk_cmd.h, ublk_sqe_addr_to_auto_buf_reg()'s assignments of u64
> values to u8, u16, and u32 fields result in compiler warnings. Add
> explicit casts to the intended types to avoid these warnings. Drop the
> unnecessary bitmasks.
> 
> Reported-by: Uday Shankar <ushankar@purestorage.com>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: 99c1e4eb6a3f ("ublk: register buffer to local io_uring with provided buf index via UBLK_F_AUTO_BUF_REG")

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming

