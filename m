Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65135DA71
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773902843; cv=pass; b=AAsFZdQcjo3KML4rAu8sdRHFr56jSLMGZZKVUaHPxkYrp+vM7qvRn8jvaXlcbB4qp0hdYMv206ktxHTTUQSmY3AhTbUBDDJS50PIosoSAui1Vplndw3Sl05xWZmosz8WzFnWnt0356Hh+0hYabJhU5NWo6DtsgvfZSb5G5OgUUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773902843; c=relaxed/simple;
	bh=W2ZT4t/4zDKu6R8ipRrohH/gIdRVuml9/xPTE1KVg/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb6aNhHk9BGk8d4Y1nq2ynnrLiX8ud72Q9DqIKMGXmMMEjgnyPs/6Cf9S1cJhCSIR07e/eR5kBNkxycEN39EF+eINSVAGpFgmpRFkC3/2jdk2bXN61YGUqQc1fptaiw4B3FAetU8e7LVy/mnEdsw97nXrdwcJRObgc3VheeP5gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D55eKlcd; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D55eKlcd"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a12c1cd400so4460e87.0
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 23:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773902839; cv=none;
        d=google.com; s=arc-20240605;
        b=cw1rhsELb/FhjcHr0zSJUEiwg471kpmCV1AUnuSP/nw9OnAu+G/3HJF84DwIg40/4N
         rUFG2geyYAXlk4nwIZbS0fU11Mi5j1IarLUAPt6uOhTEe0PNxyu7P9KJNr3IB9YJId5w
         hchC0tW6GU6JggvLs0JqEIxM6NPFFiHtSg2MK85onacJASt/nUtltSYJgCBEunxA5yme
         NSHDNJZJGiV4tiAfKbUC80IRMskQYVwRc+azyErLEYxI2DyhjaiRRgX5P0qsTSHR0gzZ
         e4jyHtaRvpCD+l7LTG+OekAVfTZQob0JTLNQSLAM217ZL/tIKyYngGN1dtfIHks8kWYp
         keKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lAttBectZTjw795r1OEozVo4lU/N2EpOMcEeA6wKQPA=;
        fh=ZMFnykEvAb/2R5F/qyuLW6QHJbfAqQOPugRStKZcj/E=;
        b=BRhV3TwRa95AAnw+f1QsiZ2P5pQQhjpebGA9V3yHVoC6KjFkzePDH2bFr5dAec9sIr
         20Psm6XjZqYKqdHUGFWs+X08P9DhElbhpF+2GFjTVSDmKaoaxhDNQe7ZRnzrnisBGVDH
         1WIJ0zAIxoajuLwbU/BCYam5b9qKKO6KX2TuTpqOSe2Xn7v7LPvO1ma5/qCGKub6s9MA
         JfvkN9LQhWSrvs3mkh7KQxozQq6AkKr7hYwCCvIwuBLi9TvaIAHDqInLqfGWQUy7bfcU
         hwqBV1D/lKosFwc39lNXHgQ9B9B0Y4v6vzI34G33VcbjUZu8NtAMCVZKOSnUcS2+zEeA
         +DFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773902839; x=1774507639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAttBectZTjw795r1OEozVo4lU/N2EpOMcEeA6wKQPA=;
        b=D55eKlcdd/JlKPQuYlvaxbq+cFuKKma/XZO8krKPzFBu/k87eHTiZcjcjTryy6UN3M
         Vfghk2xei290l/b+cU1TQJOn8e0Ux9QyLWG4ZFg2KGmhQJ3FayqxoUV1q5OVeAYewd2v
         9vacQdalVCWhT6dVaer0ajN/7JS7TpmMcK2NosLzcUlUWQxVgOZFdyqGdPa1OP2LvWwq
         Gxzys1gmAvG9hrXCm/0MQaNG9fk9E8Wf39Iz7GxyK+fvK5b1eBe8xVOjTPbipF0C0KZK
         G1ys7N6y8FJX0ixKlYExtyw3PGo4Jq7xQjeDqoISF4HR7w+BtBc8CUevdM+RQcAwIhsc
         GXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773902839; x=1774507639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lAttBectZTjw795r1OEozVo4lU/N2EpOMcEeA6wKQPA=;
        b=bUwbLEd4m5CW9QbEU9C8R42Hk2u09L8PGWoqg1zS3ls0+07YkIcfQtFVd69clrnM9j
         M8/pJV1GOZc0eEMsozdcZ4INzZ749xwOBOkdgZ7bQrgNWCCmxboJga0N8HUQr1565YAj
         VAtOPmTw7Zgp7Z1OAD6dpjp91SeE4Jj1i+aIY5CnVCyz3YxMEeUPJfs2EpEGAMEVHxWS
         LtEc1u3ZbIJzpb5k3Sjs83nu3B67N25tnXAwE2winLHkpJbQPmCFNuJNEqroIzMGBth8
         V0P1L8eqm2HCgZ/nZG1fKJYj0WmGpL5XkY3kLbdRKOibmo2YNEPl8/97tjFIYEmWyd38
         AtKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwCL8WveQ/NqoABtFVcDgkAsNvMwly44imRZXfYwV/zpCfLfiZUdakidTxj8mhoW1aC147ZUWxsiz1dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEczzZMy09jgYUJPDMC466LsQ8bZc6jN/3e6y4uAXaUGQEyNU+
	jaWwOPHnw97hDmB14Y5wipJo9IY++ZsICZxrtdMDWhFi8AG1DiLSrpV74C5NWXfiBRRWj1RpowO
	E/UVClttRpC7hzPDmcfSp2oAAFKES7VxJSxSWEfE=
X-Gm-Gg: ATEYQzzwYQdsWcZwrDnIax/j2/kMBWb9iLAblxjB+r6zSHgkf/I2pc5IXUm021Koxm7
	ze7rwJ9Ujny7cWfJYMuKqUKgrKAnzAEjpw9SbVabXgWZ1Gv0rDbe+/YmEluqHER6jrT54cOrClU
	GokE47+Z5cu33rt+d0bafkD245wOF/SIuP2a3LdVJ9Z8LWz9qJwwrqMlj9y25GyUT0w9ilbzCYI
	mxPVBzTKtYdIoUGqf4zFbCwc4q2K+AYl7OYVfsLHPA48xA4S3Et+alDYMlO/ZqvJQzB4jMXmVsb
	6kBQHPRY6ekG1kfyAyBHYv4q5JnV21PvWxad
X-Received: by 2002:a05:6512:20f:b0:5a2:78cd:9dc8 with SMTP id
 2adb3069b0e04-5a27e5e721dmr89654e87.10.1773902838640; Wed, 18 Mar 2026
 23:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319034912.1894770-1-senozhatsky@chromium.org> <abt1dsjsT9826Ewy@google.com>
In-Reply-To: <abt1dsjsT9826Ewy@google.com>
From: Richard Chang <richardycc@google.com>
Date: Thu, 19 Mar 2026 14:47:07 +0800
X-Gm-Features: AaiRm52xZVJx1NkWEeoXPAJia0WXKTWJiqb9srzkPoIL8aJm3hm6Kd3ZjNlT7F0
Message-ID: <CALC_0q_2meJ7T8gvij5oR=idy9hn5rMC_RQhCbePJFVBOOd0Tw@mail.gmail.com>
Subject: Re: [PATCH] zram: do not slot_free() written-back slots
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think we also need clear_slot_flag(zram, index, ZRAM_PP_SLOT)

On Thu, Mar 19, 2026 at 12:06=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> As a side note:
>
> On (26/03/19 12:44), Sergey Senozhatsky wrote:
> > -     slot_free(zram, index);
> [..]
> > -             if (huge)
> > -                     set_slot_flag(zram, index, ZRAM_HUGE);
>
> Original code had a bug.  slot_free() would decrement ->huge_pages,
> then writeback completion would restore the HUGE flag, so when slot
> would get freed for real slot_free() would decrement ->huge_pages
> again, leading to underflow.
