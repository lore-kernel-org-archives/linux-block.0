Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB12C69C
	for <linux-block@vger.kernel.org>; Sat,  2 Mar 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709403127; cv=none; b=bRwymBaNqi8S2ZUDKevFW2CEsHR6aPCgPdEVgvM8AxLGLGSYWMriyFnLz0/xiIJ93p9DTywhCgLn4mcw8cO4YKR62pbDT8dbRaVcuxKBHRcn86BlEsIgh7vcIAD6k/iTsbZSF8sHYC0u/037CHfv8mCY55bdCHvXLVs2XUxchAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709403127; c=relaxed/simple;
	bh=UaTnZY8Awdcgt8ZW0ePFAWj+b5DkUlXvw9yVNGy7EKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRAvsAj+jafgjH7Y9kosl+ER7dStxyUAp8Oaj7vhMPYNXbHvR28L+LMkwVHWjX3qAdec66JQSrQKzSB9V7Xgl7najDsAVTodwD6xN+q3meXOWAbsXES+LcCwEIeCwyQ5LozZJQZQrvYdZSk43DgbapmIpdWHr0wuu1uZq9s97nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KK1s3AKS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KK1s3AKS"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28a6cef709so522499466b.1
        for <linux-block@vger.kernel.org>; Sat, 02 Mar 2024 10:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709403124; x=1710007924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mpxtfMFdGHdZ3KBLFHI8lmN/KThAgx7c0/ntlIOIqzY=;
        b=KK1s3AKS9QI5zO1IM+w3Ch6ZpCoQI7Ipd/X5JmGtv/iVdozGaSoSvQwDJf3cgS44IH
         VY/1+kgJiiMNw/Td/Xi8N7sm5B1mmBFNEOYr8Ck964UUWpIGf8l0K5yZeXps7qC2aguF
         yL4QldbtYQFPnquyuaP877/tuSCkdc5K+BZ9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709403124; x=1710007924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpxtfMFdGHdZ3KBLFHI8lmN/KThAgx7c0/ntlIOIqzY=;
        b=PSGoryiMIqPB1lS8sT10DVRq1qZdy9T6IOuLh//10YEbH368M+SiUNVv7k09VjPBSi
         DnKLXUxfdTYMTtlnyDG88j7laj9WcwwCSSzwzEfEEke5e92NJnAFDGicgbUwLeVpWsfh
         Pt5Z7BVJGAOdyo9a5srFsIHri3ECwo4wnk7d/DYwWrFSuu//g0ay5r2lzS8QyUjU/IqL
         Bd/Y/E5yRkMTM+Av6KAijJukbR0Vuq8+T7ynOWIHe+hMKxoOtlVncmUR5TZXJwhMrS+d
         t1jrpC3A6G06vkiUAvltAZ2lRJHRL66MMlc4gDsd1lRdzsnn6gWIbC1qp1ce4+1j0uBL
         TD8A==
X-Forwarded-Encrypted: i=1; AJvYcCVXHnE7KRMWROEXs5BILBG+Y9wh3EAP8sgu+toVipNglhMnqsxBFFbNY6PFx8fCLlmXvviZq8lqKGgWpKZJXhJf65Ti3W0HqioSfBk=
X-Gm-Message-State: AOJu0YxSj9I7bBWPJC/BGyOc19FaGjFwKCjBPaLY+CbX9Pi7vPKklsAy
	DiZNfeUYsaJ+myu57d4nvUByxK+zsUZSsy0F9FDErzXZ0I2dG2x9boUusOwP6c7k10tcbbrMvEF
	1hg74mA==
X-Google-Smtp-Source: AGHT+IGyolSZ0i+dpUkGiOLYk0+CNaGRlMePil8rEq/uynk7t6MIsVpOXv+0QYFvtbpA6Kc/zYYVjw==
X-Received: by 2002:a17:906:f190:b0:a44:2134:cba9 with SMTP id gs16-20020a170906f19000b00a442134cba9mr3296535ejb.69.1709403124138;
        Sat, 02 Mar 2024 10:12:04 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id mp20-20020a1709071b1400b00a431488d8efsm2928852ejc.160.2024.03.02.10.12.03
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 10:12:03 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28a6cef709so522497966b.1
        for <linux-block@vger.kernel.org>; Sat, 02 Mar 2024 10:12:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZDWXA4ZbAyMLSaaPRgqjIp5/8j3ysw4KeHgciV7hNOstcR925+tKbFVWCYlY2iaCEfqhFzGWuAmtXnZUyRn0knRFFGYvxDq6HAk4=
X-Received: by 2002:a17:906:f190:b0:a44:2134:cba9 with SMTP id
 gs16-20020a170906f19000b00a442134cba9mr3296518ejb.69.1709403123040; Sat, 02
 Mar 2024 10:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com>
 <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com> <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
In-Reply-To: <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 10:11:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvkP3P9+mAmkQTteRgeHOjxku4XEvZTSq6tAVPJSrOHg@mail.gmail.com>
Message-ID: <CAHk-=wjvkP3P9+mAmkQTteRgeHOjxku4XEvZTSq6tAVPJSrOHg@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Al Viro <viro@kernel.org>, David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 10:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In other words, it's the usual "Enterprise Hardware" situation. Looks
> fancy on paper, costs an arm and a leg, and the reality is just sad,
> sad, sad.

Don't get me wrong. I'm sure large companies are more than willing to
sell other large companies very expensive support contracts and have
engineers that they fly out to deal with the problems all these
enterprise solutions have.

The problem *will* get fixed somehow, it's just going to cost you. A lot.

Because THAT is what Enterprise Hardware is all about.

                  Linus
