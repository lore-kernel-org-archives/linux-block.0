Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775D55448B2
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988708; cv=pass; b=SYXIao3uVULKscIUk3BDdO8ze5/jHDkScXhN/wnfwIQlhoiaPW8XEzKudRlOXDDU7Podg1AizfdO6njz5VrmqqUhtUtnHAZ5vkuL4A7htH47BuXx264iaWtg565qvbk6EfAQH+2xNesywe00zdRsVpZhZyai59I7QGIswCl0HwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988708; c=relaxed/simple;
	bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLiqn7fiCV028xCS36qWImGRmqKGHD8E8ul0XT/YwhFwK/eIjHIbQKoitTIwAAsxxgLGYPA7CR2cWlafLufoJBAP5vrpICWnVUcy1eunHeCFwMXkLKYNiU4b6Me7mJa7auAUZe5r//n3PN0eTYSWOPjuAVWvjrpELwwi2igbb4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cngxshHk; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cngxshHk"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so990857a12.0
        for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 07:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791988705; cv=none;
        d=google.com; s=arc-20260327;
        b=V4zF/7i7kWQpEfPkLaXFcNuHS5xsggGis7+63k2uZxDc8jf0Pudsl2vd4myXXqKz2F
         F2HcMkMzY6clykl+0hbxa4fncOA94pCRAOch2M98Qng2JEHDkdGQXO5duJNIApswz3UH
         X+dEjQQmOIZeoznbGkqXZ0ZlLRqpkQDb4fX7mr09/dw2TnTNVgQusFYPO519s8UzGNij
         JAnDkTXyuwnJA/JiEJ/KYg8ZHT+baGCZCF0PlNHCkBpQkV61XeMi183TIrO7bSKl4vEt
         WLzPC8jgcaStrRlu3lH9ajh9Ud13OHGOQdw46xRMBUTGA5l5OVDJc2rqJouHvLxOaDJC
         xxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
        fh=a9079r63vn2+PGQPdS9qYozaH2t5qzDykXEW5VxYRcg=;
        b=YCZG6mB0VoNcDt8keZnqvZLwCYnelNCBqEl9c5x4UFaLvaeMqiD69pYsFlyloxiXY7
         UmXk59shkEbprt22Vn7bkqWvUJHNLwL7jMhgE6WhKiCr0yKggl1ifBJvLdx19WJzMHoW
         dkzTeWkkx9RAWUoE7aBuXeKD6VAuAzt2wzXvmITaGoVORyHwuX4h7A8slUXl9mJBvaY6
         AKZ6i3OqIRZFHLz2pbOBI0qZq8RfeQApLuT4Mnvv38rxKu8TH3kdEvU/er0GaFsSHSvP
         mrrlipRznAJACIVPARAOuWlHjX5pOFyVYp/LfQ2NOYeHWW0jvdde/IH5qg390GwQuyl9
         V09g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791988705; x=1792593505; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
        b=cngxshHkw8vpezJT+yDObXyASEd/+1ZURQ3kSvVkslJTVzG3tDddeyu6Itpilt2JMA
         ec1WM/YYgS3Rq+vyX4T4IeWYoQ6OxvUiPFQKj/JmDAP4bVMSF7iOJ9EhmAZeTB6IBdyW
         hrr5fD+726lY+ajAr5CUAAonz79E10XEa2mHWfe7oiuU+5I4HQVr9qTl+RLPz1Diqx29
         GtSbTklK5jEE1PNTzOz4Evx6U/DUQ6OIJjmi6onPw4b4rseZ8zc4j/e6G/SDgBZfMjcD
         q01QWWumP4wG0aQUh+R5aOlmSu3VVONxsq4Rn1Mj6JpmuA+W5oTi/cpSHA+wcMS+164o
         h7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988705; x=1792593505;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
        b=cPdLXUL6QxVsjg8c7T8HffK9ILJftTU4zRUHqHZtMaaACAmg2mzFCybChRFeZ2CgWu
         CJ7duJRI0FCsNlKkU/5ambXW8ddXuN6j/Phwuo5cP79sCJjY+N7e0BSPgu5HLkAsEyJp
         qzJPmSmoRrw915xHcwMV7prL1HX7jnAsEcOV57LV+Z+BkGaPUT0tziCEU3ohpZ95w5zy
         mA5q2ecxlxb5PHcoo6IRguHq0rImTM50Dk7YmQUXkDNaAXQk9cl7n4N4OCfu6NFXOyMZ
         xgphzoUVyyUoZnYTiQmXk1DMSu+Gq3TOgtgIoReIBJn3/rlUVwdtfm7nFqYold8x+bQb
         yzkw==
X-Gm-Message-State: AFq9FYKTpGXtnVB2flePaUKjoInoykNkFUTci+Kg393GJXTrMxRcZqzZ
	SxMs8feAHr9GTVLtAexZaEvWblsXI1bNVONYpRfgEeMjq6iI0+5J8vsuhRCdXYFr8RwWuXS8ZLv
	ASKvMmbrQvoanJye4AR2fqbbXN5xfbw==
X-Gm-Gg: AYBFou2p6a6p5scLO7HVT7uNZ3LeHlc2n48ymj2hpUuNmRuuZ/7PdfgbPklr8LEte6S
	+9cO6W9pBfjZOr6onLllElXpa6sVK360iYa7j7QjIcdcg99UPArcztBcRd8zWGQONopaJ+pUlpK
	jpx1OSUuiB2z0wOdbIZF5SP6KixWXR4xf38lev1zSqx8EP0BKOXgCXOQWoaLigKZ5eMSqumJBvR
	rrarSL5htvwod7cAHgtL9YUHle4cz+sV7Cgs8biMUEwNG7H8ZyKcAW+wjpetvDmGoijSa0H3IlE
	L1FeAcxsi3ChmNsNQ8ZGwZ9NY7CTA22rMxF9yOPq70QgeiYBQHIPPAd5xskqx2F0aE7ALK5VLQI
	GTyEyCIqNn3x2RGGZRKWSbfIFwht+jl/Tn8362fI=
X-Received: by 2002:a05:6402:1912:b0:6ac:b9b5:8e8b with SMTP id
 4fb4d7f45d1cf-6b17c2a3670mr12616709a12.15.1791988704432; Wed, 14 Oct 2026
 07:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791975048.git.asml.silence@gmail.com>
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 14 Oct 2026 20:07:46 +0530
X-Gm-Features: AclHuK8DZ9QwF2AgJ3SDr4lT4xl3Cf9evBnlWqjNFK8bj0mT2h6JXCYZXSbhb_A
Message-ID: <CACzX3Ases=5auovox0XFNheDHY9iNmxv2BvB0dugC-W3mnjGLw@mail.gmail.com>
Subject: Re: [PATCH v11 00/13] Add dmabuf read/write via io_uring
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
	William Power <william.power@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> Tushar, William, Phil did a lot of testing and experimentation on various
> devices with previous versions of the patch set, and I've received lots
> of help from Anuj, Kanchan and Nitesh with investigations, testing, and
> patching. Earlier benchmarks by Anuj for IOMMU optimisations with udmabuf
> showed:
>
> STRICT: before = 570 KIOPS, after = 5.01 MIOPS
> LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
> PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

I've been involved in the development of this series, so I won't add a
Reviewed-by tag, but I tested it on NVMe with both an AMD GPU dma-buf
and udmabuf exporter, using the liburing tests and custom fio plumbing.

Feel free to add:
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
