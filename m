Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504B3546E6
	for <linux-block@vger.kernel.org>; Wed, 17 Jun 2026 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676624; cv=none; b=tt8Yj0Yx8QfendOZCI4WknlRSVXMfkGdGdmA0Wl9cvsHHZNagKvCzhYLZaL0xpT/+1O1bZ/PrPYs3R2nhfy3p4w/hK0epzKgCXMcxS1D+PXXbc0V3axCCyiS5pW0ARxbzM3B/Lmh5Z1cTKJ6cj8ZX+DeeqvaadfB/Y8Au7vdG54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676624; c=relaxed/simple;
	bh=J1GaUtDu0lV/aN08T7cW6eB+bMo+zoBDOYe/2JHOaAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iul5k2KVbfVtXHfpCejkV5k6qT7SqfIkicVUROAVG0MK/pjJ65t6Ax09vbID90ucCIj/514ih5JmzGXh7PSl0e5a/3lmuQpnWIS1McQGZf4KkZgg9+bGjsotfAoxMqF87PSsWLIvdZsEf+PuIQGjSi8q/mP5aZAfIZiEm4DsZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D7y5i/qt; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D7y5i/qt"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8424b6792efso2277083b3a.3
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 23:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781676621; x=1782281421; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00zCxIJF6+oPAz4r/V9ZifNMpH6SjkiBAAesMrF/bTI=;
        b=D7y5i/qtOJsTxWHh9RXt+2JIsQm0kcvGBjhqY1+C5fOECxgVXMIojQCC/U+wAwBP7d
         7Y+EQlN/b3KfJ0X2y7KOPMo8m7XJyAleepJpfrcJLHMVoX2VpTshZ6PqhlM0EiK9oPOZ
         4cUlssh8ZOrIcxZb8Q2+Sh8wRTJneUJHAOs5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781676621; x=1782281421;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00zCxIJF6+oPAz4r/V9ZifNMpH6SjkiBAAesMrF/bTI=;
        b=gvbsU8uVPlmbAxjo616L8Pa3GONMNzpPzWw7Ugnot+3yWDChbHUzWnDvypROmVGEMn
         ThqgTqUfwdDRkpL740a9sDWarcc9k5E9KZEZeoSXmH/mccmOsdKh7eGA/U/1uFhEurv/
         IRIBerBsgPBODs0daGRD44bUmB3xNW4eH2oYXqW2R1VKvk06mKgtXLcCztziPcz/NRlp
         CMsMrkb1DkQpr3xqwqH6JxWkS9seZDFme+/ZtqTNAFkRNPVTWAcbohdHh+TO/g6Q4gBz
         /CFmp0pL1dHUK5SazWj0WVTfJEJeucilmywcDhob4XiYb8l3RiQlwlJySJHc2UObbK00
         uqXg==
X-Forwarded-Encrypted: i=1; AFNElJ9UwXXJvJ2X5mIfE+YNdKdxcXYU10i0RpG0dDoT7TFIxbuLdHuzRBezBJ5ANUQ5m6k9dudolmeXcGXI0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNkPHoeU+SRDzP8yS3uYpttMlmGv2Mq1c8NdFWRahzTWDt/7J
	JGV4dKtAL1SIshimmHV/tRBaLw57T3OAVcyuWvZ5mKnAiur2xRH23zDLBK4hYlr8Pw==
X-Gm-Gg: Acq92OHTUySSK2v0kLQgd9J7/+zibB0JSr0nl6Xf7dssszxFA+ylHZEtN9EtxmnjEvq
	IHXpbKMQHI3k0dUufvC1J+DSDUViP+RZYikbSBKWMcMXbWCIbEjDLwhER+OxfsmCcKsnR6HCUIZ
	vH87/eIEZQH5ezXYoALeQsxTr2xO1iCtgFvVyXet6ylkOcF6LQf9D6nHuqBjjiDTsWljdei5/m4
	PLbJqpkPfTHJK04rtaIfGuavEmusQFiafWO56+B9h3QXOJcS80ufVE9fdPGzgEGtwcGI1WgAKRD
	OAzzeN4UxGguqlRrQdHKL4CtK48Wsv6b1w0ciUc2emRTyALNY9CJtndwyC4xKxW1+E24jDM9GyI
	w7KV1W/E9kjdvyuq3QUxcnq0hFz9tlB5i+Gou5oJ0eu7I/N7kdNSncCcPouubE2NKtFUdE+dHTK
	BGt6sRQbeYb8YAj2SlcMjRitWkt1S3LZBeiX5lkM6ZgUAQ6iHI+sff
X-Received: by 2002:a05:6a00:2906:b0:835:6388:655d with SMTP id d2e1a72fcca58-8452445abfamr2457086b3a.14.1781676621348;
        Tue, 16 Jun 2026 23:10:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:20ef:efdb:f2c9:836f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b020b53sm14338791b3a.47.2026.06.16.23.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:10:20 -0700 (PDT)
Date: Wed, 17 Jun 2026 15:10:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jianyue Wu <wujianyue000@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Youngjun Park <youngjun.park@lge.com>, 
	Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
	Brian Geffon <bgeffon@google.com>
Subject: Re: [PATCH 0/3] mm/zram: route block swap I/O through swap_ops
Message-ID: <ajI52zahhZIY0kir@google.com>
References: <20260614-zram-swap-ops-block-register-v1-0-6c1a6639c222@gmail.com>
 <20260616123646.GB21024@lst.de>
 <CAJxJ_jhK+zkpjhs3YsQ9RoasKYh+E0NweQci0sPAEY1ne5LmBA@mail.gmail.com>
 <ajIYFtADxQDq8q1P@google.com>
 <CAJxJ_jiM_-a52EOm896FXkdH+wRxjSHJx+MW6b-ewNLVkp4uSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJxJ_jiM_-a52EOm896FXkdH+wRxjSHJx+MW6b-ewNLVkp4uSw@mail.gmail.com>

Hi,

On (26/06/17 13:44), Jianyue Wu wrote:
> Hello Sergey,
> 
> On Wed, Jun 17, 2026 at 11:46 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> > Can we elaborate on zram being a "legacy interface"?
> My previous wording was ambiguous. Actually I didn't mean it is a
> legacy interface.

Oh, your wording wasn't ambiguous.  I simply forgot to direct my
previous email to Christoph.
