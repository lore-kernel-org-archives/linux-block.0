Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9D1A255C
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477815; cv=none; b=gjfENaKFnFnUBB19+7y9nd+66ZNbzXtll/ZCtugcdNrBkB1LjcOe1phm3mTqTfnR5wUCxfUdiWqAhriJw3+mS9cR3lfd4BxFZaCPHDacWQnLcQJSoIUu1clRzh+26/Ventl7GO8zn8p3HOq83fLmv5QoHrHz45VGGlpdPJp9Nog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477815; c=relaxed/simple;
	bh=EJ0mjZpiTvo7aaYFVM9sQ4nYMP1oKk2RR4Iz/0DbNWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWJ83UrT+9R6s/3URgyDwYV9Ch897OhxjgXfov507fzW3C6wKfNsJOcaWtS7JBPqk9cl4/ZbQq4dVkrmlzHRBgnk7TrUoahV10ztO1AfjXrSIw+YBFgxaZhoA3mc3VQsjk36d94KIXFpDt2C8/dW+f9+w0NQ/o40Z4eKO+iUxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LPc5Nr19; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPc5Nr19"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b58f2e1f4so46013235ad.2
        for <linux-block@vger.kernel.org>; Wed, 09 Oct 2024 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728477813; x=1729082613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyzyg4yHFKtiomrdvdh9IAhRc4x4c/V6Ile49WRVMr0=;
        b=LPc5Nr19otrPbFFuz7gP3iLu/m2IjOHcnct2S/oBrd/C3avd4S0H1FizKJeNUawogp
         FftFji44j6bw3msDRSxjHQGZlg9cgCJvEyg1hINZ1stqqBd9E4/oHx8juWGM8yrEmigr
         1UPlubbs4In9rlA9m6mYoF0eUh3NLwGsAGMV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477813; x=1729082613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyzyg4yHFKtiomrdvdh9IAhRc4x4c/V6Ile49WRVMr0=;
        b=VUegOhmmWvBBGWSx/21IHYAucS6rM13AGG1h2SnDceGy2R5nda875hKc7Bykw173af
         8DXnhvU/c0gRAa2WU8FzP22iiS6k9zOvm/Uic+Rt8IhZIUvL3iUgTW9KNuRfL9cfo3cS
         /4cu1i/hKxB2FNC2i7EwF+qWJYwWD5I9yZJhG+3mha4hO1/J8MkmpKaJh5GM3lXsUxw2
         11Mwr89VN9BfzfHGNblJf6r5e7w+1jxFk4S3VAWSyxT5XmUGEbh11Ey3RKELmPLeQmsE
         LkN1hbQqLgE7rGrIgcoTnY43Z6iZufeWCz/QfGlh48GNClCKFMt55tfO0tWrZO2VjK4n
         m6DA==
X-Forwarded-Encrypted: i=1; AJvYcCUHTOU/YTPgylMsMpRJBjCCzezh0fxcKJj8DRejBN4063lQRJy3Lgx2LJaIR5rV6wcqsLopO2OhI6d5OA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDR5P1CbBh9sy6nNxTQV2448aV2dM1xwewXrwwTCvbzQUnj4h
	8Zrhz2GDHOZBxdskEKs2+VPpKaeerB52IjsqTgcHTCKl6aRLpvGTrmoro1CNNA==
X-Google-Smtp-Source: AGHT+IEUwPHJySPKzKJx8pK5OxTSSSycTnDz6yH48hb4lxKvVkk1+Q32y5eALYRDe4nnUCx2/v9nvQ==
X-Received: by 2002:a17:903:2307:b0:20c:6bff:fcae with SMTP id d9443c01a7336-20c6c00012cmr25875285ad.5.1728477813685;
        Wed, 09 Oct 2024 05:43:33 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:52d9:628d:d815:8496])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13930b92sm69721945ad.128.2024.10.09.05.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:43:33 -0700 (PDT)
Date: Wed, 9 Oct 2024 21:43:30 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, YangYang <yang.yang@vivo.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241009124330.GE565009@google.com>
References: <20241009113831.557606-1-hch@lst.de>
 <20241009113831.557606-2-hch@lst.de>
 <20241009123123.GD565009@google.com>
 <20241009124137.GA21408@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009124137.GA21408@lst.de>

On (24/10/09 14:41), Christoph Hellwig wrote:
> On Wed, Oct 09, 2024 at 09:31:23PM +0900, Sergey Senozhatsky wrote:
> > >  	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
> > > +		if (test_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags)) {
> > > +			clear_bit(QUEUE_FLAG_DYING, &q->queue_flags);
> > > +			clear_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags);
> > > +		}
> > 
> > Christoph, shouldn't QUEUE_FLAG_RESURRECT handling be outside of
> > GD_OWNS_QUEUE if-block? Because __blk_mark_disk_dead() sets
> > QUEUE_FLAG_DYING/QUEUE_FLAG_RESURRECT regardless of GD_OWNS_QUEUE.
> 
> For !GD_OWNS_QUEUE the queue is freed right below, so there isn't much
> of a point.

Oh, right.

> > // A silly nit: it seems the code uses blk_queue_flag_set() and
> > // blk_queue_flag_clear() helpers, but there is no queue_flag_test(),
> > // I don't know what if the preference here - stick to queue_flag
> > // helpers, or is it ok to mix them.
> 
> Yeah.  I looked into a test_and_set wrapper, but then saw how pointless
> the existing wrappers are.

Likewise.

> So for now this just open codes it, and once we're done with the fixes
> I plan to just send a patch to remove the wrappers entirely.

Ack.
