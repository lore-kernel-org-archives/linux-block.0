Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGpR3ZM1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F99107
	for <linux-block@vger.kernel.org>; Sun, 19 Nov 2023 16:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700441519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pg23Djh+yfVbJar8GNNdsoCwV8dqaP5vWE9OQixE4gw=;
	b=UGpR3ZM1jypWsUYlznOO/Pw536mWNf4k41L+F3n3I9zgPFIQvbgYGESN/KWNkcWzYsYHeq
	redWIhopKStbSjzPsxEcE25E5Mqs5fsFdKtW4TwaDOYUKBdJQNBbt/yiScbQsPWrEGUQG5
	tz4jXiuGn5PCeNmjo/8nRwnrAUtxTAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-oCQtljgZNkOU6qZrb7SqaA-1; Sun, 19 Nov 2023 19:51:56 -0500
X-MC-Unique: oCQtljgZNkOU6qZrb7SqaA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93B2B101A529;
	Mon, 20 Nov 2023 00:51:56 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 054E3492BE0;
	Mon, 20 Nov 2023 00:51:53 +0000 (UTC)
Date: Mon, 20 Nov 2023 08:51:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-cgroup: bypass blkcg_deactivate_policy after
 destroying
Message-ID: <ZVqtpGLIvsnlWEpF@fedora>
References: <20231117023527.3188627-1-ming.lei@redhat.com>
 <20231117023527.3188627-4-ming.lei@redhat.com>
 <ZVoiaucRAsPkN6FQ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVoiaucRAsPkN6FQ@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Sun, Nov 19, 2023 at 04:57:46AM -1000, Tejun Heo wrote:
> Hello, Ming.
> 
> On Fri, Nov 17, 2023 at 10:35:24AM +0800, Ming Lei wrote:
> > blkcg_deactivate_policy() can be called after blkg_destroy_all()
> > returns, and it isn't necessary since blkg_destroy_all has covered
> > policy deactivation.
> 
> Does this actually affect anything? This would matter iff a policy is
> deactivated for the queue between blkg_destroy_all() and the rest of the
> queue destruction, right?

Yeah, it is true actually for throttle code.



thanks,
Ming

