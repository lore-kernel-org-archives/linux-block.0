Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A2529BDA2
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444044; cv=none; b=Inr8H4SObt0woz8DpMqsNCPvokjmrvQSPxD5kHhE93Ij2S/rq4Or7M99boAXUBGCIOd/+Itouliy1jWYgGxYpDMTSP0B+zLZXBSwz9UifveV1BhQ6+0GBQ7zPPzzUcWZcyM40Cj/zQSx5zU5rneIyGu1WLohYprFnwQ//LMv4Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444044; c=relaxed/simple;
	bh=ttdjBkhC96i/wRHOwkiUCWxMcnZwcz60Y9yMhK/NI8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dN7kTJ65mG633pRIQ1c4GsRr/lziklTi1IeCCdPBFCQ8/Go1fjI3LA4hwXk+YsnAjqNYsl8NS0r6walxRJ3GrmF9AFdnxcVFAvZ5PjwGOHbWtsSGzVsjTIeO68RzPrMpRlY7njpO7GC++4Re4a1XxbIURIz7fWWxXoAJIR3PPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggDNOmyU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggDNOmyU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765444041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4d8Su7OCn9SSpikVB1AMndX+Pol0Nx0pC/e19C9VIs0=;
	b=ggDNOmyU6e5RqKSGk7a2zcrLzDE6GKP0IWuCqhqcQkLRbQxZZgv644J73wSsa9nXhiy7DN
	T+rvqInGMktnlsedjZPgRBI3KrmQGoq+cUoKcvsI5ylwypo2KifbjObzdcXKCR4fN4Bjar
	zkYiU0ivne2WHPobAM4BdMhytunMVI8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-N4WSIRJXMsKS52O_R2LxKA-1; Thu,
 11 Dec 2025 04:07:18 -0500
X-MC-Unique: N4WSIRJXMsKS52O_R2LxKA-1
X-Mimecast-MFC-AGG-ID: N4WSIRJXMsKS52O_R2LxKA_1765444037
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D745E195FCDF;
	Thu, 11 Dec 2025 09:07:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC39D1953984;
	Thu, 11 Dec 2025 09:07:13 +0000 (UTC)
Date: Thu, 11 Dec 2025 17:07:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] selftests: ublk: don't share backing files between
 ublk servers
Message-ID: <aTqJvMr9D2orECii@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-6-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211051603.1154841-6-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Dec 10, 2025 at 10:16:00PM -0700, Caleb Sander Mateos wrote:
> stress_04 is missing a wait between blocks of tests, meaning multiple
> ublk servers will be running in parallel using the same backing files.
> Add a wait after each section to ensure each backing file is in use by a
> single ublk server at a time.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

