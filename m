Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792C429810
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786398798; cv=pass; b=XGX5q+OQL3rK/uWf6PDvy53LD4KqjjH/KOm0VW6Xqw79QI4MfOF8lNqU2uX+mGFxBGUALiwKOnHAfAGtAtOx1oM0qjQNU+WLvnwUO+316dcHANspi9J99N+xFBgolEktIh5OzWA3kLkpDuQ0YTRsupbK4gYRp5CPZQW9H3imwtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786398798; c=relaxed/simple;
	bh=12oIIc5O1capmjJJP/+oODc1pOTzirDH7HfjJz0s/rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3pQhCm/YUBnO2T5fTYE90ilT4P5tbYQ//1Ls0Dg5tQqMtlRl2eakui/0Lok6xJi5loX2LLv4Ls/iZUaCBYlH16gGgZd6Go+RqzOI8JMLEjW3C7WQm54RnfZuFFQ7CzpNnrkgwrb9d7nh09omqpCllg8IUU+uA0hIYjsiHipKaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsV7lQXf; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsV7lQXf"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so3861751a12.0
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 14:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786398791; cv=none;
        d=google.com; s=arc-20260327;
        b=CBWZHaZ8/8EY66NbOUycB7q0QV/6IpY1PD7uuCLy5+JdwJI2Xit9aBBVn3pn0Arbqo
         lof2BWZCk4F46B/tdXinvHrPKI5coGcvXhbQkjbHXrorlDqzNOz1mTdPQdH9P5lsccfS
         cpyNBN5ivYT+AhRHCcSNbrmO9Xh8KCnnZQ7i4NIEnzLAIdhY4+peM1HQpw4KylBtcCPp
         n6NXhb/txWo6eoG2JB7FGiI46M2f2UQ4UHU5w2Dcu5amFruZquBEMl38MxXvqu7YmR9O
         AOlrTzP5JcxjFsd9t3Byl6okcPLCc9d6idQqMzlIoWylfMPNjOJNTX4xP6NXkqVQnWnX
         rIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jd/Y3zn27Cd0GpBsyq1VGImYrXsirceQ0Ivgd9jLp3M=;
        fh=VmL9apLAR2Lo5r2Y3EUAhlqrszajZiuzQEUg+KA0OSM=;
        b=MblY2OjZ4OGqzEByMVpp23ilklIt57eKaWVzhAGBOHjF/PHfDQD9j5COm9jGRUd43b
         a0UCZKrDMhMORfVaWccDjXvNjM0jhMDKlWdpJrwcHD300BeoxBsl/ygEY0rrv0KSRxq8
         b/9fYnOA7SURg2Bo6N7GqaTjDKtgdxYDbvufNZZa4kOxmpaTQJoWnsc0WO2pYnG7rr+9
         nI/7brn/NqEDj4fZv/SDDSHUKtAg63JtXD3gC8ONjgkT/E0senKDFsP4CXKzuTcSMWXM
         lpJCHagt84jcyZaIfNzVB6Hu4OmD9g4x6un/RW2IRLV4u5nVG1RqDlXmZmFcqqx1tjqe
         cOow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786398791; x=1787003591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jd/Y3zn27Cd0GpBsyq1VGImYrXsirceQ0Ivgd9jLp3M=;
        b=LsV7lQXfxm81kEhZl4Qg+RLWxsw5Yx11xEF/fc6gHsPKHGhmaOoPSUkrhWxuVmGDvm
         wrqI58+LbC9iPTp7TLiNjRWqooespv9+nhmwex3NldxbAiUFYiAc/yr3U5sLrVkj4++W
         aV+ibqUTbtXWGYbMReZqmN1Vb+d5oT+Zj+X970qmCt9mv3SKFXLjHnygYH/u58g4F10e
         Ui4ML5nel1jLM8r81HCktjHLq8jKjyqTdvoV380g3hnmMMlNX9LwTLdpzJsiVbQny0UC
         g57OM09R9o3vZ3r9IF6cg177ak0lHa35gyQEiMsI5F/xb5XfhUCaiFcAGjuot6No1RzO
         +b0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786398791; x=1787003591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jd/Y3zn27Cd0GpBsyq1VGImYrXsirceQ0Ivgd9jLp3M=;
        b=Pp97cZfw+oJ5ToC3o5NX2oCLpm0RyFDdj0gkYTF+kHjclONfO79nHMp0kQDYJe6co5
         Ik6n82VoN7YtX2sNI/IURYfH+G9KVm1xgEQ/1tyxVl6+Jdlu1XoEpUaqVql1u+fr45ua
         ytenlgqr1T16BAKgOsG6Qj4UEBuHUSNzhlRb7pElOlMVSaySNEvWoGCJQwIg2x24wLy0
         IYeFLGAblxqyodV/t19BLVUdA9yP5mDcnS9hnCtxD8w/yG/9bcIpPQFXd8nyWLzJMvW3
         8cVr+67TKm/XPo62QH1yPw7wpRRwh3NmqupTZ+zw9kxbqBPMkzzkPnAJL0YBWQegGCiX
         Xzqw==
X-Forwarded-Encrypted: i=1; AHgh+RpT7MP8lfwU318agEpK5dliqT9etlF0lXJur4+kUf2wKRdsZHzIXN1cfAfKHSMRgK+IWq4KQaiH/3Za7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrtC7wvzPc79V80ilu6H4d1K7CI7gUTXGnjfMjz0RQgf7SCt0
	WnSvZfG4ZObGH/WDgLQ42W6yGDjDeLFv/6wOjr8J5orPHYAzBPVRq6gTmcxii7V5rJr1Bb+q5s9
	EuGtAymFbllTQZTJOpU9Ty/HzJkJUSC8=
X-Gm-Gg: AR+sD11mDcwWYhrU+W6FbVCV77oIsN6X3QQOoI3SCk+WLXropjFPj/u/0y5p7COXqsZ
	sY8f9HxF8U/du8KN8eIVRkGTLh1l2wsTxt+1uDINCeM+yjM7lLGk4ffagsbpI0SjL3p20Ff056Z
	5i4Puuz0WIhfS0iyXguYwEnfFVgUpUcEUpyHxKJ3Z120Y2Ocd1Ii1H5iIOVL+EzS3rRlgmDw2Z1
	C843UZ6pnwzNhdri/yTV5KedMHQPvDQlT1BE+EKF0Wb6fSTGewkmMq5Y6fZfHeq8g+vb1myhLko
	9xeD420uURdmYr61JNNYY5spOjFdfwiLvhJ2wopkuY5f
X-Received: by 2002:a05:6402:4597:b0:6a1:854:e75e with SMTP id
 4fb4d7f45d1cf-6a1f2488fb6mr11785301a12.15.1786398790858; Mon, 10 Aug 2026
 14:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-4-kbusch@meta.com>
 <CACd_6n2jNS9Msd_N-idPx3ijgN8NUxT1U1m2OrJu=e+GToB+ZA@mail.gmail.com> <anpBQXfo7eGNU2-v@kbusch-mbp>
In-Reply-To: <anpBQXfo7eGNU2-v@kbusch-mbp>
From: Chris S <coshi036@gmail.com>
Date: Mon, 10 Aug 2026 17:52:58 -0400
X-Gm-Features: AUfX_mz-TxhDpyhqedKezJsp7FjgXE-sPnTQOf8ufLKnlwR9JDNJrqPKqLRJsyI
Message-ID: <CACd_6n0dCda28CA+1WePuHjXEqu+wB_sFvWWPQmrmO3nfW7WiQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] block: validate bio bounds in the queue entered context
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de, 
	tom.leiming@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org, 
	Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got you. Please let me know if you need any help.

Best,
Chao

On Mon, Aug 10, 2026 at 5:23=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Aug 10, 2026 at 05:12:45PM -0400, Chris S wrote:
> > Keith, I checked this patch against the nvme_setup_rw() WARN I reported
> > (the second link in your cover letter).  __bio_split_to_limits() is
> > called from blk_mq_submit_bio() after bio_queue_enter(), on both the
> > cached-request path and the newly-allocated-request path, so the bounds
> > check is now serialized against the freeze window in
> > nvme_update_ns_info_block().  With the capacity forced to 0, the bio is
> > failed here and can no longer reach nvme_queue_rq(), which is exactly
> > the race I hit.  Thanks for picking it up, and sorry for the slow reply=
.
> >
> > I'll drop my own "nvme: don't WARN on I/O to a namespace revalidated to
> > unusable metadata" patch in favour of this.
>
> I'll need to revisit this approach as it is dependent on something in
> the stack calling the split to limits functions, as well as the upper
> layers error handling for a catching the end-of-device condition later
> than before.
