Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eYH3/BYv"
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA19126
	for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 09:47:17 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a0064353af8so2380766b.0
        for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 09:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700588835; x=1701193635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GWpUH6i/TWiULkSXxy7JKYlrCmr9Zd67SZ1skaJHNkw=;
        b=eYH3/BYvgxBxpe5ivQo2goPIrJ5wKDnTrGntaeaHqOJU2Sd0+Uwf3+AkWEef0Jrpcy
         4ncYfIRa7YFaHFRe8op3JhFZPLyilCT/I2SW+56Zbs2+bT+tXg0ThkSXC97vYd58Os/y
         W2TLY4Db0hCLBOi6GB1fNJk1hlRPnQqu/cGpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700588835; x=1701193635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWpUH6i/TWiULkSXxy7JKYlrCmr9Zd67SZ1skaJHNkw=;
        b=eJ+Orsh2vQ4FWayRwsY8k9n7hGzrW/ZY8J+X6fpN2hTgNV7/h45Lf88HWcF0fTo/vE
         N5FKYLOTNW8w2o7L11NpbpXjaSZtzIWiq88mJtCGMB7H4aLzp+q7oz30rzloMO9xbt1j
         tQos9u/tkyijJzEnPsmyKM29bSsgIelLdUC5OLHYcAfVFz9t5c76T02GPLCM7XNk2uf0
         3wqMXYDNyAAyyqEMsiXN9itFnZpTeq4r4ojPcKs2IT+dakZG/UoCimjxzGE7YWoKlndW
         Osx7micic6GibvzuMaAAC1OS8ptqiiKldONksmMJTO10+19phqaT4ryCYxLatVXAaVaQ
         FxMg==
X-Gm-Message-State: AOJu0YysrcKJr/iYK9t1xjCT/bKsESjK+bZvy98iAlzGOonAJwhBoXgi
	DPmUqD+gD1vMyeni/Ur1ksHgk2/6LY9JQfTStElmFg==
X-Google-Smtp-Source: AGHT+IG/rs3btFnyiP8NQTKRzF02aDyhaeRaqb+SKz0acXfYBlJnezhGUwOu8YhqBBHRTSr2mJBOOQ==
X-Received: by 2002:a17:906:33cb:b0:9b2:be5e:3674 with SMTP id w11-20020a17090633cb00b009b2be5e3674mr53284eja.36.1700588835592;
        Tue, 21 Nov 2023 09:47:15 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id lh25-20020a170906f8d900b009fd50aa6984sm3117052ejb.83.2023.11.21.09.47.14
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:47:14 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-547e7de7b6fso21030a12.0
        for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 09:47:14 -0800 (PST)
X-Received: by 2002:a50:ec8d:0:b0:545:27f5:3bd8 with SMTP id
 e13-20020a50ec8d000000b0054527f53bd8mr33687edr.20.1700588834427; Tue, 21 Nov
 2023 09:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231120221735.k6iyr5t5wdlgpxui@box.shutemov.name> <20231121122712.31339-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231121122712.31339-1-kirill.shutemov@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Nov 2023 09:46:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqu14v=RdTYZwF60gpBb0gYdN++u-e-jnqkjEm0m6UdA@mail.gmail.com>
Message-ID: <CAHk-=wiqu14v=RdTYZwF60gpBb0gYdN++u-e-jnqkjEm0m6UdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, treewide: Introduce NR_PAGE_ORDERS
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: akpm@linux-foundation.org, agk@redhat.com, bmarzins@redhat.com, 
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org, mpatocka@redhat.com, 
	mpe@ellerman.id.au, snitzer@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Nov 2023 at 04:27, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> NR_PAGE_ORDERS defines the number of page orders supported by the page
> allocator, ranging from 0 to MAX_ORDER, MAX_ORDER + 1 in total.
>
> NR_PAGE_ORDERS assists in defining arrays of page orders and allows for
> more natural iteration over them.

These two patches look much better to me, but I think you missed one area.

Most of the Kconfig changes by commit 23baf831a32c ("mm, treewide:
redefine MAX_ORDER sanely") should also be basically reverted to use
this new NR_PAGE_ORDERS.

IOW, I think the ARCH_FORCE_MAX_ORDER #defines etc should also be done
in "number of page orders". I suspect from a documentation standpoint
that also makes more sense in places, eg I think that right now your
patch says

                        amount of memory for normal system use. The maximum
-                       possible value is MAX_ORDER/2.  Setting this parameter
+                       possible value is MAX_PAGE_ORDER/2.  Setting this

and that's actually nonsensical, because it's NR_PAGE_ORDERS that was
at least historically the boundary (and historically the one that was
an even number that can be halved cleanly).

So that kernel parameter should be in terms of NR_PAGE_ORDERS.

But yes, I do think the naming now makes more sense, so other than
that reaction I think these changes are good.

                  Linus
