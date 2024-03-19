Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575D7B3E5
	for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816236; cv=none; b=CapH7WHoGBb6gqpKMMvmiFcmJsQ3tCLbZRX9UsO0gJLkudnipfBZfhlMZ2GULfNhmpKA3Zb4w1h6e5FJtUUZPrXW7wxJiXqPzDddcZH38twNUcCw4Xl8eJsSfuI9xrVLqbCiHs7Npe2avqPKICI7Y/BD0Wmvi9shj924y4wZrdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816236; c=relaxed/simple;
	bh=3mwPFdlLe6iihegFeLuWyoNCKNk4T2+zb2+2mtWwdWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eM66Bmm3GAPUJvqBDjUfeMCRphSp9xxC/t8KSItTlnnFOFvhtooIaV7ANmi5p1xvneMvoX13qIVzqndB+hk7MLLKM2+9A/Uv2D0JOq9Ex1kX8/BwGtuyDNa/8FCnemTriMJRnN1/tHbb6vh4ukMo0NB9UO/qCKa1Uz/D5aR/HOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iB8RiCaa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iB8RiCaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710816232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mwPFdlLe6iihegFeLuWyoNCKNk4T2+zb2+2mtWwdWs=;
	b=iB8RiCaa/TcNF2DVXoHBkmiMNvxfkMldtxOwWBuPEME2e9ZVWgzaHbKGZH4p8pBzXvkmcn
	sEM5V19OruvX8OObM6ATvRhDn+UV3grYENOSxchQ8qyMhOcr19mSsl7ZQCZE/Ja5wY/I+x
	LWTWGGJ5/HekJPUqskLXY+hDQJ1HQvQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-49a862ZBOAee3wRoIARJPA-1; Mon, 18 Mar 2024 22:43:51 -0400
X-MC-Unique: 49a862ZBOAee3wRoIARJPA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29df71a709eso3536510a91.1
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 19:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710816230; x=1711421030;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mwPFdlLe6iihegFeLuWyoNCKNk4T2+zb2+2mtWwdWs=;
        b=g3BZBLKtO+XzOkfZKwEhqTrQcMoOKUVFulcGjt4krHngXUPTWoUhff8f/3QNtmPqaG
         DFwW/UYmDynTRtWES5vD4Ic+gYvxiZHHdwZUu9NkOfa0D5w7OOoZbaTpK1rKOCzcfa1h
         VhYmEnQs+xvZcLM2NqT4+CCyvJmlUcUuvXHye81eLtYk+IkN7CSy+bm8sl1bvNNkKz38
         MK1sYgHukiPh0vDO7MUHYewTGFGYsqqHasmcwBwGXQBl25wHFLDJNfpbHsKXdSm8U+QC
         1zaJBOqrVMj7CNSq1ckRI4E2v8ai+E+JogAWZW2Lcz4zbkebtrey4s28VyJ4xh9E4o0Z
         Ejlg==
X-Gm-Message-State: AOJu0Yyws7TSMugymsnA7M+hWQxvEuN923NDJF3uUHbwdS4lDYlrcUCc
	7RrGXRRy62of/eeyxPT7leA8uLmQoL107obBTHsr3BhpJvTgE+3QU/0/0YRVbylxHzMZafE8qJu
	HQBpQUaR/8q0jF65MU9yoCPbBxv5M8BxdA8LUKPQu5naWn7LqroBnkLSX/Mukn6y48DJWw6gE3j
	TpLcymOrbrTFyaF1haOw4+jV4oEVY8Mdq85hefC8j/RbAns3am
X-Received: by 2002:a17:90a:4701:b0:29b:95a:baaa with SMTP id h1-20020a17090a470100b0029b095abaaamr1230681pjg.47.1710816229965;
        Mon, 18 Mar 2024 19:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqAWtqRe0ws9wu2Lgw7zGmZ+bKlIN9yHFF2gj5hwharTmg7ipt4ZZVpBnGMVFNAz3sRHsPJ2ExLWqHqNnVDjQ=
X-Received: by 2002:a17:90a:4701:b0:29b:95a:baaa with SMTP id
 h1-20020a17090a470100b0029b095abaaamr1230674pjg.47.1710816229590; Mon, 18 Mar
 2024 19:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+WxUcAzkDcii_2T-wQTUmCjvM=mKJqpWKV-vgG7CvH6yQ@mail.gmail.com>
In-Reply-To: <CAGVVp+WxUcAzkDcii_2T-wQTUmCjvM=mKJqpWKV-vgG7CvH6yQ@mail.gmail.com>
From: Changhui Zhong <czhong@redhat.com>
Date: Tue, 19 Mar 2024 10:43:38 +0800
Message-ID: <CAGVVp+Vjp6ZQecLUaNAcjtt8Xvg7z4P_rxDY9-BudYNXNtaveg@mail.gmail.com>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address: 0000000000000000
To: Linux Block Devices <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 5:38=E2=80=AFPM Changhui Zhong <czhong@redhat.com> =
wrote:
>
> Hello,
>
> found a kernel panic issue on blktests nbd/003, please help check
>
> repo:https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> branch: master
> commit HEAD:c442a42363b2ce5c3eb2b0ff1e052ee956f0a29f
>
> [ 2519.746767] run blktests nbd/003 at 2024-03-15 18:22:55

looks the same issue as
https://lore.kernel.org/linux-block/CAHj4cs--N4tDj6ZKACCGEHcBYG9NqEvM-Kiu6U=
Eq0WejypD9TQ@mail.gmail.com/T/#m50404b005619119f0ffe574db32a231d4e9577fb

