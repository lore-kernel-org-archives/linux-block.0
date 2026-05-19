Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32C27816C
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779171891; cv=none; b=bGuWLxTSsXWsy5tPZhGHXAO3C0Fth91bDAwrUeOE5WObNcHbADeeRE0fN8GnKHfRyM41BGoSv4lCBpCS8mfKVHrTiwcl8qZYqW6AAQ5Y46eNL0WofC4hRhmkAmqIWZXjqqiVfpae8zVZN+nMV8dXj1iGYbFktVTtO5qOz+fIWaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779171891; c=relaxed/simple;
	bh=USZhdeU6uSMNhhEmh0P72YsQ5RfRVnY3l60kkealAKc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DlYUB1oM12zSGzoc55O6SFrHoz5TIozTFB/WqU5KgRvvPxhSezIBkRFxMr0/5HZfKjC4H4+ROR79/sidg1VjsOaOx7IIrp8cj6gPCYn/40kSbOCc9LQngorPS7kD1ctvftAlR6fyHaRB/pwicl5BcZ3Y4BAsdBBDNnMU5ZB7sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ11DAC8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ11DAC8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49021532ebdso773505e9.2
        for <linux-block@vger.kernel.org>; Mon, 18 May 2026 23:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779171888; x=1779776688; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HM+7ddMcZEIpwWbgVG5FkOfHpCVKpzbRD2Pq4qNLBM=;
        b=EJ11DAC8BrC3UWQmM10uHtFx5ZXFFC6fn1Ua0zn4vW7qetIrHk9MYNdoX4zI3WeKTz
         8/q2x9FljErPdBoSGUYWcFZFBUuuh4NfKmKNuqnvd1zrvO9B9vfyd3LWfdmyD37PScOQ
         0R1QepSulQ6Xwrrf+6gRVfda3qEKqumvaQ3+CNTOKQ6OOSB5Fg7uY0OOqRAE6Y1FTn9f
         E1MhQhmEqzOOF2jOgHy+avIJ2h/c00bRk/lOS+VC7fhWwW5IuW2mKvcXc4bXed9xxcCH
         2A3O1CNdGXdmtSRupLDaPprxQirvOZvwUAOJ/DyYbjxWdIHujJTu5BVvbHrP52LogTMQ
         sVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779171888; x=1779776688;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HM+7ddMcZEIpwWbgVG5FkOfHpCVKpzbRD2Pq4qNLBM=;
        b=sTkhEHYRaBTc6SbQP30f5BZSgiF9VUeCx2locRFiEyll/Sr9rht+0BPAEaVAtJcOU4
         Gyf0hBRp/FpwSls55mG27/zOH0nnxwvfNcG6QeLPzfzbobAEupweSu9A+BfJ6CVXQNxp
         yLPp+NI3TuZ4f/4MyvnI4yMMyd/mgzHGzSUEzfdynGbQAmDjbLLUaxfBGZpPYioFYSAy
         L4XJGKlLmXHKPXeuVf7mgB2hdwuVlgpIfAEUajXVIHSlGyyrYoH75sP0P7MlJapkdqJU
         Mxv4FfR+WNUJ1h7cJEByVfC9XJKktQFH/Lm6jzoJvaoDPm6+5TlG5q178yEON5QseShH
         DpmA==
X-Forwarded-Encrypted: i=1; AFNElJ+yv+sqpsxfKlsIFH8Dl8NWHKMU3ljcxDIP8g/yjPGi4dH5f9cdx8ZMRAy06YCMKeFTkep8b5gsxbWPow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9SJRSXHsOcBGP7VgDkSxRwgKABukwbx37i54+Zx8OgycZ3ubT
	ToOSCvwh/6hjOiJofdQihcXWgPZ8UwNjb/ln04uZy6FI0Pntd01Lx2B1
X-Gm-Gg: Acq92OGlTWHZF1cdYbYq0i/hKPWw/HWuuDIJh3zDGYdaoxbfAJ0rU4ptgBEMdxcle/V
	2MM8FVY13UGYeJHofkM/wHOAqTFpFxJKW3vZmZoNMKjAymirJedlFWD703aEtyYuvYMsZLeu/Rg
	g60DOCH9KRg8jI7U1vEYPtbNKzP7t6jJR96myRH6S/s7awZccn/LzilmiX7zCRRxUa/ydImSrOH
	ZdJti2V+EYpqKEY/YrMH+g/HY5UtziNfEw9rUkSPPSvb+rklsppY+g4cCJ1AB0KRFD3suUF8NTO
	mAAQkh12cNXG3R241+VK6/uvRV2XTLIAw+zZ3LvY2bKJxU/X+oAGrQ0OcvBUVn5R82xnzMe1yjn
	km023tyvFQTrOpTZUkp0VlPIxO/CFhpvt9SutNDI/hRs8qWOdQAvoRWnf+MXlTmpjVHnytp1e8R
	4NMw1T7MrBci0VcjA84fk3HtDGhWLYyo1deQ==
X-Received: by 2002:a05:600c:34ce:b0:48a:592c:e63d with SMTP id 5b1f17b1804b1-48fe60d7832mr305905985e9.14.1779171888174;
        Mon, 18 May 2026 23:24:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7e442sm96150365e9.33.2026.05.18.23.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:24:47 -0700 (PDT)
Date: Tue, 19 May 2026 09:24:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: [bug report] drbd: replace genl_magic with explicit netlink
 serialization
Message-ID: <agwCLACUZdi_GnKZ@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Christoph Böhmwalder,

Commit 8098eeb693c4 ("drbd: replace genl_magic with explicit netlink
serialization") from May 6, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/block/drbd/drbd_nl_gen.c:1859 drbd_cfg_reply_to_skb()
	warn: unsigned 's->info_text_len' is never less than zero.

drivers/block/drbd/drbd_nl_gen.c
    1852 int drbd_cfg_reply_to_skb(struct sk_buff *skb, struct drbd_cfg_reply *s)
    1853 {
    1854         struct nlattr *tla = nla_nest_start(skb, DRBD_NLA_CFG_REPLY);
    1855 
    1856         if (!tla)
    1857                 goto nla_put_failure;
    1858 
--> 1859         if (nla_put(skb, DRBD_A_DRBD_CFG_REPLY_INFO_TEXT, min_t(int, 0,
    1860                         s->info_text_len + (s->info_text_len < 0)), s->info_text))
                                                     ^^^^^^^^^^^^^^^^^^^^
This is a u32 so it can't be negative.

    1861                 goto nla_put_failure;
    1862 
    1863         nla_nest_end(skb, tla);
    1864         return 0;
    1865 
    1866 nla_put_failure:
    1867         if (tla)
    1868                 nla_nest_cancel(skb, tla);
    1869         return -EMSGSIZE;
    1870 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
