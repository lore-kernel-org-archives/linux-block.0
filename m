Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4E39FF9
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WFuvjd7x"
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A0AE5
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:28:44 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso93116021fa.3
        for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700065722; x=1700670522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jsVx/Q3YhVxHOvs8227jfNskpZuE2YqOrJ9wOZRuNEs=;
        b=WFuvjd7xuhCBhnJzRLvJiaDaDpenV7NQDapH0uL43DQC9r3vDlwdEULAfiYiGV3uRV
         4zYkTYj3R8rBHrJaBvuyP0WGvF3QOoMbfE89C8tp5MMqYjg5AVqD/Um3XbHDugLfRdui
         a2Lb9RNab2KQFGzcx5M6XKshzqUTNvYEVQwAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065722; x=1700670522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsVx/Q3YhVxHOvs8227jfNskpZuE2YqOrJ9wOZRuNEs=;
        b=jFxHnw+vJlvt6ArV7i0gQPpk7QjIwMKOGAW4/DCUwq+hmkcwSDGDasyAaROmtvkzER
         jY2UciA2PNbQPTU76ESqTOq7Zv92Td7ZfKrutMBopSL/xDU0vdFXMkejVFJKu7U5GoCc
         Fo+/1cdgE1QiQvD5oMaOT0H5Rt88k3pjyzBtIqi3nYC2mMj+y5H+ityVWu4Hzg0Smk5T
         407UYM9P5b4Mkh7c2mBRx1RSr7piPXZzKPrWoPECLM3pzL455G5xCrqj3wiFphMHdkq3
         trtRHD1uaJXi0FlyV+8RBwlUudGwGKskLJVcCKq031ndXmBDK0KhRUj3yj08OW8z8rNV
         GUhw==
X-Gm-Message-State: AOJu0Yx8z43vpnbwkmJTJy9gB2vEKQb5ul9l5fzowBBUw+Z7Uikn3kDQ
	eYz2F2RssYQ7KBgVX7Pz9fqi0eCg7otBVpywLv7BIfNH
X-Google-Smtp-Source: AGHT+IEWMM7I0C078oUtazM40L6Mbk0b8OXjFiISUMp6Y/Mk6zi0ZR71t9k7Q6+SWb0/tGSyvNVIFw==
X-Received: by 2002:a2e:8545:0:b0:2c8:3613:d071 with SMTP id u5-20020a2e8545000000b002c83613d071mr4207403ljj.36.1700065722466;
        Wed, 15 Nov 2023 08:28:42 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id y17-20020a2eb011000000b002b9e9a8532dsm1708842ljk.138.2023.11.15.08.28.40
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:28:40 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-507bd644a96so9967871e87.3
        for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:28:40 -0800 (PST)
X-Received: by 2002:a05:6512:12cf:b0:503:3781:ac32 with SMTP id
 p15-20020a05651212cf00b005033781ac32mr12684125lfg.41.1700065720301; Wed, 15
 Nov 2023 08:28:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-9-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-9-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Nov 2023 11:28:22 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjytv+Gy-Ra0rhLCAW_120BvnzLC63tfkkZVXzGgD3_+w@mail.gmail.com>
Message-ID: <CAHk-=wjytv+Gy-Ra0rhLCAW_120BvnzLC63tfkkZVXzGgD3_+w@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] iov_iter: Add benchmarking kunit tests
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
> Add kunit tests to benchmark 256MiB copies to a KVEC iterator, a BVEC
> iterator, an XARRAY iterator and to a loop that allocates 256-page BVECs
> and fills them in (similar to a maximal bio struct being set up).

I see *zero* advantage of doing this in the kernel as opposed to doing
this benchmarking in user space.

If you cannot see the performance difference due to some user space
interface costs, then the performance difference doesn't matter.

Yes, some of the cases may be harder to trigger than others.
iov_iter_xarray() isn't as common an op as ubuf/iovec/etc, but that
either means that it doesn't matter enough, or that maybe some more
filesystems could be taught to use it for splice or whatever.

Particularly for something like different versions of memcpy(), this
whole benchmarking would want

 (a) profiles

 (b) be run on many different machines

 (c) be run repeatedly to get some idea of variance

and all of those only get *harder* to do with Kunit tests. In user
space? Just run the damn binary (ok, to get profiles you then have to
make sure you have the proper permission setup to get the kernel
profiles too, but a

   echo 1 > /proc/sys/kernel/perf_event_paranoid

as root will do that for you without you having to then do the actual
profiling run as root)

                Linus
