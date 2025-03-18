Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB311EF365
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285425; cv=none; b=ozv9gFs9tpypbmXNcJgGt0aWAma80sq1NOWbL0QfifvMxaqVO2kQiP4Vs9kb2njB42nZdeHS8Aypw2rkRF5qF7m/YFFRGIufQ5458udRCFbbep+I0jadY+QLa7Ac0S+J2CJd6MJg4rQf1L4u/D15OIBmRHADfx2lv1ZuocfcCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285425; c=relaxed/simple;
	bh=6fRqmHHeqgOGf36TDhqGQ8fGGqn66hJpSEfaUv1FSYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjttFsgyy3dG1RUFFDlRATFTB4d0QVNlsMi9MI7koGXkcObeLw339II7F9WZ2R0YNFnQaTgA69IFG5UuxRNZTieThQvHS5LxoN0/MhIaXFUZbvIYFWjXQktWBbMQNuAQ7iL0X4jnm41p0ygV9KvC8zUHjgMus7GK9KkPoUpYVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGyYvD1P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGyYvD1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742285422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNED/LKIFp+L21kimYG44CVtj1edL5R8VzQcJcnl6QY=;
	b=YGyYvD1PRNpD8ESVzLefoEoH5TGw4tTiOtSmGSqfylArrVEijd7hcwMckVLjDUR+X2YqFj
	KnZHplwzKt5AX1HAyK9B00p7DoidZ7MSLlW/24sCNrfeCMvbfQILqPgxz0C9qGdGznU31T
	HTGjUx0aaljghOw8WLc7EtH2M+6lGWs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-eY56JBbaPRCU9hpGfcVByQ-1; Tue,
 18 Mar 2025 04:10:20 -0400
X-MC-Unique: eY56JBbaPRCU9hpGfcVByQ-1
X-Mimecast-MFC-AGG-ID: eY56JBbaPRCU9hpGfcVByQ_1742285419
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C863180034D;
	Tue, 18 Mar 2025 08:10:19 +0000 (UTC)
Received: from fedora (unknown [10.72.120.33])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5D371955BE4;
	Tue, 18 Mar 2025 08:10:14 +0000 (UTC)
Date: Tue, 18 Mar 2025 16:10:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] block: Make request_queue lockdep splats show up
 earlier
Message-ID: <Z9kqYBnvrxBckn-u@fedora>
References: <20250317171156.2954-1-thomas.hellstrom@linux.intel.com>
 <Z9jJ401CKYYXys0o@fedora>
 <fa077596a112c9cae51905cff0987755db2a7934.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa077596a112c9cae51905cff0987755db2a7934.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Mar 18, 2025 at 08:56:18AM +0100, Thomas Hellström wrote:
> On Tue, 2025-03-18 at 09:18 +0800, Ming Lei wrote:
> > On Mon, Mar 17, 2025 at 06:11:55PM +0100, Thomas Hellström wrote:

...

> 
> One caveat though. If this is merged, people will probably start seeing
> the lockdep splat as a regression and bisects will point to this commit
> demanding the potential deadlock(s) to be fixed.

Don't worry, just keep linux-block@ updated with the report.

> 
> Is there a line of sight to fix the real deadlock?

The linux-block community has solved many such warnings recently, and your
patch could expose more, and we will try to address new coming reports as
before.


Thanks,
Ming

