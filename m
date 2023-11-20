Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hM9if9Ga"
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1FCBA
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 09:37:07 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so4820087a12.0
        for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700501826; x=1701106626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj7GhPSDbYDdw4iQB/bb+X84NDAwKJX0VXMHzUWyOhk=;
        b=hM9if9GahI5S/apBLigF7sWmFebWR8Dw04d14EuCepD7LodVsjHvfMDVy3jsCv7Mqc
         2iSJTPKf5o55bPp5qP1DwYh1dEwF/EM8CnvPrS8hiGPDaOP4Q3Yv5SrDj4XS3w1aHzC7
         xf2MgeL5f18KZxBRg/UHHhFpO0U9fPvvJBYHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501826; x=1701106626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sj7GhPSDbYDdw4iQB/bb+X84NDAwKJX0VXMHzUWyOhk=;
        b=BYgsAyZgJd9ySEmtAbZuS44poUvRTEAZsXyrbAbr1/wP4ga8RfM65pWTdoTr00XqJd
         AYva9b+vx/T8uHgp7I0hMEsreEoaAjrtgq6YWoOZ3QO/PDsbz3XP89oq0UMh9j5wwT9F
         DgswOTP8LMIajtVIfdXrgtEzBxmSo0srqcwOnYlKv8K8Z6qjpAB1NY5Pvrrt07Tqy8Gs
         NTPULCpvrPP0ILM0qLsD6q3ow4ErRaltrYdZTyxpjN9QxZ/PGmnb9doYD/QGlMSFTOto
         tMA/3mzf31lNhTpICzELn/worVkJFivTdiBmK+cwnC/wvLgED8O4MZtuqXnU5IpzrePv
         6/XQ==
X-Gm-Message-State: AOJu0YzEBJNEAJ7FMgNo8PkzqzkOyW2Enxd2ypRsTSRQjg9/ETiAG4W+
	V25qinJmJqwxMWajtwfUNZNHzV44uJQyGcq6C+zg5g==
X-Google-Smtp-Source: AGHT+IGyyfhxYxTd5zhTgAEwDkw4P12KHDk0SIVICkRO8J5dRbSaackcJgoro2YMv4zCno+H50d0Lw==
X-Received: by 2002:a17:907:720a:b0:a00:afeb:5d15 with SMTP id dr10-20020a170907720a00b00a00afeb5d15mr1135776ejc.33.1700501825981;
        Mon, 20 Nov 2023 09:37:05 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709063b5200b009fc9fab9178sm1984634ejf.125.2023.11.20.09.37.05
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 09:37:05 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so6442091a12.1
        for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 09:37:05 -0800 (PST)
X-Received: by 2002:a05:6402:2056:b0:548:d4fb:9c1f with SMTP id
 bc22-20020a056402205600b00548d4fb9c1fmr51556edb.40.1700501824606; Mon, 20 Nov
 2023 09:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZVjgpLACW4/0NkBB@redhat.com> <CAHk-=wjV2S7xBcH2BGuDgfKcg3fjWwk5k74nq89SviMkH-YsJQ@mail.gmail.com>
 <CAHk-=wjCXvFme97sxix_zDfq4-oNRv7fNp+YzWEuUGH-gihA-g@mail.gmail.com>
 <20231119152136.ntnl3sfulo4tgbw3@box.shutemov.name> <20231120133145.y7ghl64bqfpeqtwd@box.shutemov.name>
In-Reply-To: <20231120133145.y7ghl64bqfpeqtwd@box.shutemov.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 20 Nov 2023 09:36:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgarn2DnvMsZVfm+vDHyUXk7qGMbZHw+mxYvnc8i+SvKw@mail.gmail.com>
Message-ID: <CAHk-=wgarn2DnvMsZVfm+vDHyUXk7qGMbZHw+mxYvnc8i+SvKw@mail.gmail.com>
Subject: Re: [git pull] device mapper fixes for 6.7-rc2
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Andrew Morton <akpm@linux-foundation.org>, dm-devel@lists.linux.dev, 
	linux-block@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Nov 2023 at 05:31, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> NR_ORDERS defines the number of page orders supported by the page
> allocator, ranging from 0 to MAX_ORDER, MAX_ORDER + 1 in total.
>
> NR_ORDERS assists in defining arrays of page orders and allows for more
> natural iteration over them.

Well, the thing is, I really think we need to rename or remove
"MAX_ORDER" entirely.

Because as-is, that #define now has completely different meaning than
it used to have for 24 years. Which is not only confusing to people
who might just remember the old semantics, it's a problem for
backporting (and for merging stuff, but that is a fairly temporary
pain and _maybe_ this one-time device mapper thing was the only time
it will ever happen)

               Linus
