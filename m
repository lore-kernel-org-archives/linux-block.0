Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66131739
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VV5P1oSr"
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F9619B
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:04:56 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9e28724ac88so1028070466b.2
        for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700064295; x=1700669095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzZnZquzqfUk+KfrDds9CQaV555iZ1w7ZZ/4IXXyLOU=;
        b=VV5P1oSrCsmhHHL58M7VO9guP0f3dSxPO2nWl5IvS95q9nLoAG/dYl659ExKA/JQF6
         +I+sIP2zsMroB/EFnvomsYxtobvXVBbeTsZuymRkb+PARCdN0WWb/g/TZFBK5zKU+3GD
         GtIWZmyhL5iLXbapzs+V4tCQsT0QTDvf7lm2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064295; x=1700669095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzZnZquzqfUk+KfrDds9CQaV555iZ1w7ZZ/4IXXyLOU=;
        b=sjEqZXexeAazDh182G8S/+ys7Qymxavwr6P87mCGxV/bkqsAv13cZp1jIw7lWl9MbX
         kkuoWJXLgyLWTDHl0gvfh1g6S9gyh44dl/qCOCeWearKXErp1O1fOEXlFbM1PfM4OJaP
         vZpcVhRqVIouA28t+NEplyqWge3FCayjpAB0NwN3JnxZQyapnOGrZBJzB6J9P5zGDC02
         YHdOdUdCC9HSMnsnwI3MlmG5tbF+zXFe8gxrzaZoviwhapqhaoga6GqDLgDFUZWiOAW3
         IJFxoZRuhBnoveGpdezpCu5fI8idUgODlKqbWA/Ia5hxwPMHa0wQiBbrQrMxcF9j03hA
         9bvA==
X-Gm-Message-State: AOJu0Yy++5ykliJ3hOWogzto4amwpaP0kAihjsnS7y8Uka1FNV1LrngY
	htJiHFr2yRSH0wuo3c6x3xuL1uvWLl3AFFljuSXA1CAA
X-Google-Smtp-Source: AGHT+IEdC8vLgb6uuNjxwinvKBFretxiyz6j70lnfw0mhEqNiB4sqfHmgZ8I570CdjtAX6Whr0XBoA==
X-Received: by 2002:a17:906:1315:b0:9e9:88ec:7a53 with SMTP id w21-20020a170906131500b009e988ec7a53mr6840799ejb.16.1700064294877;
        Wed, 15 Nov 2023 08:04:54 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id m22-20020a170906235600b009e6279fc1d6sm7163631eja.40.2023.11.15.08.04.53
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:04:53 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso10761259a12.3
        for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 08:04:53 -0800 (PST)
X-Received: by 2002:a05:6402:34f:b0:540:7a88:ac7c with SMTP id
 r15-20020a056402034f00b005407a88ac7cmr10183276edw.21.1700064293347; Wed, 15
 Nov 2023 08:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-1-dhowells@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Nov 2023 11:04:36 -0500
X-Gmail-Original-Message-ID: <CAHk-=whTqzkep-RFMcr=S8A2bVx5u_Dgk+f2GXFK-e470jkKjA@mail.gmail.com>
Message-ID: <CAHk-=whTqzkep-RFMcr=S8A2bVx5u_Dgk+f2GXFK-e470jkKjA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] iov_iter: kunit: Cleanup, abstraction and more tests
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
>  (3) Add a function to set up a userspace VM, attach the VM to the kunit
>      testing thread, create an anonymous file, stuff some pages into the
>      file and map the file into the VM to act as a buffer that can be used
>      with UBUF/IOVEC iterators.
>
>      I map an anonymous file with pages attached rather than using MAP_ANON
>      so that I can check the pages obtained from iov_iter_extract_pages()
>      without worrying about them changing due to swap, migrate, etc..
>
>      [?] Is this the best way to do things?  Mirroring execve, it requires
>      a number of extra core symbols to be exported.  Should this be done in
>      the core code?

Do you really need to do this as a kunit test in the kernel itself?

Why not just make it a user-space test as part of tools/testing/selftests?

That's what it smells like to me. You're doing user-level tests, but
you're doing them in the wrong place, so you need to jump through all
these hoops that you really shouldn't.

                Linus
