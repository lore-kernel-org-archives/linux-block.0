Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE83B2BA
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 03:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762140143; cv=none; b=cSpQTBx+HuRxlKD+jl4ULWBOaUykHk4TrbQaIl69BhFn0Kn3gLfuGGJM174NB4UzrYEetAvb3Jtdqp/VyIArPNP2MqhuVJKP4987kUpNg6IbN6MM/OvKPFSTrEAtDYAzPrwreaWDP423TDwPX0fcHak6t5QwGKJkMsBh8/w80Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762140143; c=relaxed/simple;
	bh=WaUyA0ZCx5CaFzACW1+Hc2d871lIYKAbt0PvQK4jaJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnV2d1APx1tzrBirbJ6oERXhLtI4lEtljjxot253Ot+c7pW026A8XUmaF61WW0pqnvrM3kA2N6e+u+yrUG7hb1HRpHewrn6yC5Omco9cuZn0JK5Z4ZYCnpGXZ/hmUXfAEsbgH0Y+DYs+jNQlqYrG8Jbnl8VHFo9bZpTzE47WOio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S26JyWKl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S26JyWKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762140140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+z3KkJi/+5spIeLFpWnBxRo1xp9OXbFEOLZGezOpB0=;
	b=S26JyWKljgriVlehx6tq0ucLCvCjxla9kWDnPRBJh6jeNMvUuGjRDHAypqggpUyc9xdM/9
	G9ygKWTkrQo47E13+yvUTqXfJ3GkmFD/1JZBaUS398AnId016VmIWneE3p2/5TUyI/i5q2
	oZ7BpMESnCWs2/HQbGtwJPWzTrCEP6c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-_GUoIr9UOxG6Ffr0MPRrGQ-1; Sun,
 02 Nov 2025 22:22:19 -0500
X-MC-Unique: _GUoIr9UOxG6Ffr0MPRrGQ-1
X-Mimecast-MFC-AGG-ID: _GUoIr9UOxG6Ffr0MPRrGQ_1762140138
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5E7F1800D81;
	Mon,  3 Nov 2025 03:22:17 +0000 (UTC)
Received: from fedora (unknown [10.72.120.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 349A71800576;
	Mon,  3 Nov 2025 03:22:11 +0000 (UTC)
Date: Mon, 3 Nov 2025 11:22:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	yi.zhang@redhat.com, czhong@redhat.com, gjoyce@ibm.com
Subject: Re: [PATCHv3 1/4] block: unify elevator tags and type xarrays into
 struct elv_change_ctx
Message-ID: <aQgf3ktdpmd1Q-NF@fedora>
References: <20251029103622.205607-1-nilay@linux.ibm.com>
 <20251029103622.205607-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251029103622.205607-2-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Oct 29, 2025 at 04:06:14PM +0530, Nilay Shroff wrote:
> Currently, the nr_hw_queues update path manages two disjoint xarrays —
> one for elevator tags and another for elevator type — both used during
> elevator switching. Maintaining these two parallel structures for the
> same purpose adds unnecessary complexity and potential for mismatched
> state.
> 
> This patch unifies both xarrays into a single structure, struct
> elv_change_ctx, which holds all per-queue elevator change context. A
> single xarray, named elv_tbl, now maps each queue (q->id) in a tagset
> to its corresponding elv_change_ctx entry, encapsulating the elevator
> tags, type and name references.
> 
> This unification simplifies the code, improves maintainability, and
> clarifies ownership of per-queue elevator state.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

