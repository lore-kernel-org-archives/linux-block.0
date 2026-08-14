Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F5B35F172
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703600; cv=pass; b=hNdLqZ08Iz9DaequhDQxvHViQI9WlADOlawf2GJg0aYwli/DNvI8Q7Z/8inX2i1jVNkue3BISVkx5L2FI3YBI0Q4pajWGJjOGYHol4gQbnJlhkoA1YZaiAd7S8W+GIGGUejb4tcnHLzQL/36UUIRv9XehdhYGU3gd1Qf6i0prZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703600; c=relaxed/simple;
	bh=MFn0rFMGzlhvFYkG6CLH+3UeqL+lH0hpQNeN5BvjKqA=;
	h=References:Mime-Version:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbbswyZucA5jpCFGM0V4ltLnrhRCxutDJjeVE7AUAGhYVuv1sQbNyqEOOYg887IQnOV4uLfM0GWR6GKxxn+R6PY9YmuBHjBa4clN6FBVFWpGkgIb0dA++LJ8n8OY3JWt8HGfzCTWvcVYJ66DjqPM8Wxp9Zq21oZpDw3gRGyPulw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Uclt42/e; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Uclt42/e"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso735565a91.1
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 03:33:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786703589; cv=none;
        d=google.com; s=arc-20260327;
        b=E1vel9/grcBZMBDbvK0KYw1KhkIFx+8htyaNNEs46oMl/KrddKr8s1Zzs2WpAuKoby
         w2klYiGb69Gq/pEakyXJwMMpZvMPyNYatMiPCsoiJFvGLmaXgxDAlENqSd0BtDn8ssUE
         aI4vWaOnbmjImuyp0sCELJA28m3JvHmZFdowWa80XzgY5jQRe62EWHd4LOdTRkPpAIEC
         Z4IsjxFjfBkz0EETBDNbtPR5b7s37SyJ4WEFTq5TMkKqhyG6EIDZ2t18JQymuTY+dGTZ
         lE5uVOi2IZikXInYPwaEonUTJBml/9w74PFkAl015ywqorc24EtXkqt2k+jLmHQsBSqA
         NL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:mime-version
         :references:dkim-signature;
        bh=MFn0rFMGzlhvFYkG6CLH+3UeqL+lH0hpQNeN5BvjKqA=;
        fh=P+UaON3ma5ue8E76NeG9bYFRJ6Oflujn22zSJzN8UDM=;
        b=e4Z/xeAG3jWlFOOwJ47+suh5OSDMENyGdgBVQDE8aZwYdFkFUYxGqhWxoAv+0pgLQY
         OdMT9ct0QUga7T0KfIXKobM3ca3DqEAO/jxnOoY7jxtBSKkyy93KKTK+Cu4LIiq7qgYh
         s1Z+24i8e3yH0hG+++QuCUB6SQNtCTV2tcvcIS6rctjlrPBPckUDXCLnQ3Q64wO7Vb1X
         7pYlEf/GBCMXKAa4R32kdhWOb4jg9TAKJig537WsIGXaBf48jDa5GVXEoJuweOlnfaNv
         cxggr8hqnJAPEsjeqZDEvVLSlF8Wl918do2TWlhcbG4x6Z9023vlV5SxrrI2zsA1C1sG
         66NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786703589; x=1787308389; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :mime-version:references:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFn0rFMGzlhvFYkG6CLH+3UeqL+lH0hpQNeN5BvjKqA=;
        b=Uclt42/edqlovy6668C+UKaLdgHeqDrYbl/aon4LR50VwU7to0PRGKYaK+aKRPdTGu
         9JOjv+QvsRJiN27/8/E438OndRu1DY/wH0iU56d6/BDmWyUK67tCd5V79Rx/UTdf7LQO
         nXwBs3ohxuUs2EOztKHuPkJGeGYMCS2ULfjbAvFiSJgzZs1qzu6GCVo6jDOyJ36/jdM+
         g94QHL3dVOtuCBWInXLDkPR9hwzEtzZMS+db4jJaLwB6m+1oo8qNQG4DXKyPotVEZ+EA
         c1dgNNylZEmYXiIXw2OHyYgzoJlCjL05WNNVYyRNp4+7+wrRCcjflOz8tl74Ilp5DVq7
         yQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786703589; x=1787308389;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :mime-version:references:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MFn0rFMGzlhvFYkG6CLH+3UeqL+lH0hpQNeN5BvjKqA=;
        b=nW763oqJ6HlT0i/DsC0thTP5Y/zaSutvpppu9e2zUYFXy7KCXBwAxziDSghBhyiY4i
         2Edw8u7nsVHLT9y/XeF8az6AMIYq5ehfZHWzGvh35NeRdgwxulZWqzQeSuloMBzOEt77
         97xClqiLxzf7uyatSda4EK0AxUAVImh5H8siThYhXlvuQvdjbi6oIwUEm5USkpV+qxEO
         N8i8SLJvCLITx3sxs2fxVPfYQxttd0uJ7iyCd1kEMwjARBjX/7J8m/9rtAOPzcjpvGep
         OiklbPPgjD3TV8Hgeu4oC5BXErF7NTq9LmlMsM07W4bsQwrGaKfh91+pTwipULT1zeuO
         U6RA==
X-Forwarded-Encrypted: i=1; AHgh+Rqr/vFZ8vi5cheZgDTA02K4utP6NzxeeXmANspYrbR5KFcOCNl+ViXJDn8meXoLRhhUyDBEttpAbaT18w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSy5KDQa2vCgKlz4IoQXAtMtNKCSkFl4XiYMzkBXxe8c/mNK7
	mpXQVQi8WexoBgbLfSuKdlCTpA6EvV7ewoM07BLFCCeGOwyJ87P8mLCs6VVo4nAedxi4y1uSZbd
	zaWiNNSZq/XzrGVckBgHAO4Gv0jGekl8LyxMg+liKvg==
X-Gm-Gg: AR+sD131WF69MEPLmtXcflTfgUAysqvMa+bpyVgjWiRQHPCFdTuQ8DCr0VnynfRsdzz
	CkLrBmi7trym8tSz81fem9zj6Sg73hD6SL5F04ZCn8qk30jFXeCyQOo9fLaxqZTVCon8bINOeYV
	fph11jdolMub78OPxfiPz0JywTXrln4MtG/2A3OlyiGfJPHzfLicUjYxdyRtGB2u9LTzpTgINw5
	se0GxB+Z1zsO51hlKiURO0VdAfScyqHLcRxIEOcj8zuDJMERg1p0Ye631pYUWrKGawBVz59MCpN
	Zdg+DzV+WREDFMxATy0+Zj2JIzcwe5LI65lWUFYBrQ0=
X-Received: by 2002:a17:90b:574d:b0:38e:5828:a446 with SMTP id
 98e67ed59e1d1-3933b1091eemr3879161a91.19.1786703588922; Fri, 14 Aug 2026
 03:33:08 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 14 Aug 2026 03:33:08 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 14 Aug 2026 03:33:08 -0700
X-Original-From: Zhichao Huang <huangzhichao.1@bytedance.com>
References: <87f85f83-5514-429b-8dec-8ca4da39a3d6@huawei.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <87f85f83-5514-429b-8dec-8ca4da39a3d6@huawei.com>
From: Zhichao Huang <huangzhichao.1@bytedance.com>
Date: Fri, 14 Aug 2026 03:33:08 -0700
X-Gm-Features: AUfX_mwZMGIZixes5i22ZthgFcrjQr6RZ32BzbmFxxxGx6N5OycDYPPcWOC_D9E
Message-ID: <CANUnaiapOwNTPJxjxn6B=zYfTrrH-+qmArhW+iabsqcfWEG0iw@mail.gmail.com>
Subject: Re: [RFC] nbd: is the add_socket queue freeze needed on the initial
 (pre-start) connect path?
To: yangerkun@huawei.com, yukuai@fygo.io
Cc: josef@toxicpanda.com, hch@lst.de, axboe@kernel.dk, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Erkun, Kuai,

Thank you both -- yes, [PATCH v8 0/8] is exactly what we need. It covers
the nbd_add_socket() and nbd_set_size() freezes I was asking about, and
also the blk_mq_update_nr_hw_queues() one in nbd_start_device() that I
hadn't gotten to. Good to see it's already reviewed.

Erkun, I especially like that patch 2 removes the freeze's root cause by
rejecting NBD_SET_SOCK on an active device, rather than relying on the
capacity==0 / bio_check_eod invariant I was reasoning about in my mail --
that's a cleaner and more robust basis for dropping the freeze.

I'll apply the series on our Firecracker + many-core setup and follow up
with our create-latency numbers and a Tested-by. Happy to help however
is useful to get it landed.

Thanks again,
Zhichao Huang <huangzhichao.1@bytedance.com>
