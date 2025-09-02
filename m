Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144FE198A11
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756778920; cv=none; b=r7ujF05iITq1BHXO5IMp/iM2azvLkMEYQkhF/KUeFt3emQYDzKDzt+92VZEWBisjpSF8icEGrORAF7WiQ/tU2OSQ+HqbLmXXZuCZg7ybzDj4ys/iUL4M6ZwnLfWmaT5ACCrGoh/kV8QjksT6Qdtc1T4al19WWsUExEbBH7N0Vfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756778920; c=relaxed/simple;
	bh=ejL7FVtpbCP0UrziFGS9r8cFFr4hRAr6pj4iXIHIW0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0GwIcQw2rgp7fZrFRQ/OFYGEtTJ5VgnQmnGNgleZfl8RcK41fzAR8BZ2JBp6+VlTz7pLtMJhn8e35kJNQxxFDbRvGaKx/2vLKk1Rsy9R91Db+EflMpKzAznoTFIU4Tzzrr9K1mRbNJknhm9cIUjWB6KYNKZIwgyW4WJikg2DfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5JpacJG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5JpacJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756778918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uho2Jrk1tvw2+42+MtjQMqg1bG7hf+OQ5CaL9V3WvCg=;
	b=F5JpacJGJ1xxucN2mPgIq72YQfGAxVcWiIaWkPVIwWbW3v091Ci3rO26ammmOamvJqkczs
	j4m0NrXkW5mr6eQn8cG2TlI5FFd+RxqT7X0A/t3A5eZU6QbF32Y7AyLs9PArJ2rl2PRlnR
	1jZqnoEK7a9HGJjeiZ2HDskgcyxNNRo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-7--9wh9aNna7wJWvNf40_A-1; Mon,
 01 Sep 2025 22:08:36 -0400
X-MC-Unique: 7--9wh9aNna7wJWvNf40_A-1
X-Mimecast-MFC-AGG-ID: 7--9wh9aNna7wJWvNf40_A_1756778916
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66EE51800345;
	Tue,  2 Sep 2025 02:08:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD83330001A2;
	Tue,  2 Sep 2025 02:08:31 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:08:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: inline __ublk_ch_uring_cmd()
Message-ID: <aLZRmowkkbEQ1tlh@fedora>
References: <20250808153251.282107-1-csander@purestorage.com>
 <CADUfDZovEN1MouTGyWHC4ZuhuPPTZ6WCkrS=yqa18xuJifuvqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZovEN1MouTGyWHC4ZuhuPPTZ6WCkrS=yqa18xuJifuvqw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Sep 01, 2025 at 06:42:31PM -0700, Caleb Sander Mateos wrote:
> On Fri, Aug 8, 2025 at 8:32 AM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > ublk_ch_uring_cmd_local() is a thin wrapper around __ublk_ch_uring_cmd()
> > that copies the ublksrv_io_cmd from user-mapped memory to the stack
> > using READ_ONCE(). This ublksrv_io_cmd is passed by pointer to
> > __ublk_ch_uring_cmd() and __ublk_ch_uring_cmd() is a large function
> > unlikely to be inlined, so __ublk_ch_uring_cmd() will have to load the
> > ublksrv_io_cmd fields back from the stack. Inline __ublk_ch_uring_cmd()
> > into ublk_ch_uring_cmd_local() and load the ublksrv_io_cmd fields into
> > local variables with READ_ONCE(). This allows the compiler to delay
> > loading the fields until they are needed and choose whether to store
> > them in registers or on the stack.
> 
> Ming, thoughts on this patch? Do you see any value I'm missing in
> keeping ublk_ch_uring_cmd_local() and __ublk_ch_uring_cmd() as
> separate functions?

oops, looks I missed your patch, sorry!

Will take a look later.


Thanks, 
Ming

