Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479530BBB6
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788691; cv=pass; b=jyjerYsqcgSVMCicQyzKDA1JV5lxoFx3V5X3oDKYDNC2dqn5QiqaE6ivsNdg1y1k9VJOuD9zbZ7qruI/BlaQTHmq4vDLj3vQHckp5zB+rSoSCWhecqL3oRZ8X1e1wEhz6VXCbo1Ski86LNr+0UxOlZtIipQNgTQZlUoFDMtXhiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788691; c=relaxed/simple;
	bh=+AopWml64svojtyKo/jp9MW8zIFpZ2TZYuBX6ssB2oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbMGsuU5ksUEObcyzvMNYh/P+hNcS2EZTpyoYGMfJKosEvBguCpzZ0sCMbE6NrMRiCHCDVnRWgc5PQoktLBVmJpx8DP+LpKtODHLyBFlNdy1WLMdCTplBOQTnNy+FOHegW3U2waEY1trVa+NkIw9fCEFnchYYSxNs5GllrTMKTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JH+C2vFY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHc45QCX; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JH+C2vFY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHc45QCX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769788689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AopWml64svojtyKo/jp9MW8zIFpZ2TZYuBX6ssB2oA=;
	b=JH+C2vFYID7UgxSaPx+xdpzlc/WB9wtp34BuhCyuWxRuwH5i03GiH/V9SQ0Co1zzqwOgPX
	jBxCLf3dACOUNrzcEAkNz+u9Bk6lgmHfK1426MKQDNgMzoHGhcx+Ay7kSEcHRheyiSF4lZ
	1mmsaz67gTB+yB1QH9Htje/STqD8B9o=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-TyYsQiJLNL-Aag5orIYbQA-1; Fri, 30 Jan 2026 10:58:07 -0500
X-MC-Unique: TyYsQiJLNL-Aag5orIYbQA-1
X-Mimecast-MFC-AGG-ID: TyYsQiJLNL-Aag5orIYbQA_1769788687
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9483c49a63fso5893442241.1
        for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 07:58:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769788687; cv=none;
        d=google.com; s=arc-20240605;
        b=UCuq+4gbsNhqUbPgUePS/V5lS57l5C4GAGPuc/JXxfSvr8+wqKIetIMt0Nh6sS76nt
         +POKVjcanxTGIfbb6JrF2htcBoENgmWUv4f509b29GLct18fznspYuwNqyzIYT67kfsv
         q9ZSjiejHKCx3ywD5/BBIKX1PjoFTBFPAasLwNOO2O6yV/ik27ye+kGXYC6q5Xo7rThk
         mbKVzQbiV7xWQCs68xTb54/ZBLDtrGW0cSqmRmakQs4vqVgWVZ4A/SynAKQE8oetus4Y
         6Hvmco46+zH0T7JPxsxVOnZFD2dfSSTWLt4nc5PloX4Q/PsoMPschvYRep52wjbx1Lu5
         LSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+AopWml64svojtyKo/jp9MW8zIFpZ2TZYuBX6ssB2oA=;
        fh=+4NG83Aj4tfiPTasn5VeS28Wyq4VmVAdoiASv2lGawA=;
        b=UOfcFvTJPLIL8BC1702q8bOJI81HSd9fv3SRW5HRjxI7RYVFd6waZDLasomm2oAzTi
         C5iITJMnQhoMwYo0X3s4nWO1AwA1iMVMBvx0pOO6ee9e8daV7NnwsI56lv1593exCXPz
         6jdEVk7S9jm1FmjcQSV4Uvu/Ni1iLTUxwajTyUPBJipi0rxplqhvbpf6sKjAprteHsQZ
         DcwR2uHh7XTbYI8wHT6IRHHzyVQlb1bCLMT5igZWqdC496bPClVgkhA9id5V7+7LjlBg
         TUqEHzMNRAGLBNXDrZvFoot8yG/MQ7l+OunEU7Yc+Z8GoWGp/B4wNp0Upmbm0c6KBT/Y
         6wsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769788687; x=1770393487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AopWml64svojtyKo/jp9MW8zIFpZ2TZYuBX6ssB2oA=;
        b=QHc45QCXrNwFsNGIAzSbxQwkJCtLsDDUDXanNq8zCQOB4VZnXIKmDHiT6TgoX6eYDQ
         J3+5Rvtdz6HB0DpZyzAWXDekUb1oDtzJ6F6izATAfjXeTmxi+uLFHNPRlbk1L4gO6Xmp
         eGPfAESMuagHUj9iv4uDFbLweqJ9X3mVXVYlu29FxjkEuMz29Q0XLD7vhFawXq2J7WsF
         AEjtG/hMmNK0kZ8M3ejUC+iPzzaDX7LG7P1G3J9oaeYE2I/xl+PLFTvOiq5Ght5q/Rqp
         fdRt+S0gqVzNAMdsQGT99R0pYBTt9R9gNh8L7g+JQ5oKCep7DvfOo3sL0h2jBIKTVHI2
         Oiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788687; x=1770393487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+AopWml64svojtyKo/jp9MW8zIFpZ2TZYuBX6ssB2oA=;
        b=dGAEGDNI9xtBUUanAww62SAJ61hVkp+BY0TxqxZ0VkHjCpr1XD+RNxvcPvZXnoqo88
         Qqo3+PCYRB3zQohjhocF2Zy7O61bq5hqyG0xg1hmxKxvPVviTFWII6txP5NuUbzm8Iqx
         U9fGAYFVqhHP3kF/9Q4A/wVrpLOJYsVz3JpJkOTEWukwoCtrZ5Jd6J9v41rlUtiHj5K7
         8wh4J21nMfuNtju+KgI+ldGHaK9MIUplsAbJyUALSu6xw27uVKOHkzYNwp15Qf/T0een
         NmWBdXh/9NLWMsp89nMt8vgwJ2lpdB47OVzG9FHfr9M93apUa6zgR4XI2gIgaa28vVoB
         kceg==
X-Forwarded-Encrypted: i=1; AJvYcCVmhdsLMWFW82z3EpQwQ1evzn1a/rnTbjFgRVIFCiVZXAfGg46HUxLSEtOz6fa0ptCq6nMygZddaQGmoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdK2vjWJmP7fu8sip8Zf3bq0+NO4MxMs3RcecJV3U6j/SXHRa
	IPgqAtkWAOkzyxFEjwAbvjMYfikc9kBHTqmv+eBJwVjZY43KQaOX5RKKCzf+GijaMgX+EguKS0T
	121Wrx2dPxe1dFYMO5UPC8QZ2mp+mTRtWER2oNhqeyZuJudcPp/MIhJhFXaEr8Pox+WFewD6yyG
	kFNM6rd0bpbQ/B14UeGgHb/8FFHq6dWC+u7PM9oNg=
X-Gm-Gg: AZuq6aJeCrKLG6MTXCTUxWzDh5GHIUpDYIPXLMC9HiloBHn2f81/x8buEouq75NejcY
	Ln/JYdmBIOAosNxF2ZG7TzeyMfXGEOiUPShQZMggFgUVIcEsD8vXS1TRflxEQSV7XfhYJAXHj+d
	OKFOwt8XCTVpWOo5h/e76tYCOc48rOXTNeNc1UV+b46mZXedp8/y4nRDpZOzCbzFmW0UQ=
X-Received: by 2002:a05:6102:4191:b0:5f7:2655:f2c1 with SMTP id ada2fe7eead31-5f8e24bc761mr988242137.13.1769788685867;
        Fri, 30 Jan 2026 07:58:05 -0800 (PST)
X-Received: by 2002:a05:6102:4191:b0:5f7:2655:f2c1 with SMTP id
 ada2fe7eead31-5f8e24bc761mr988217137.13.1769788684058; Fri, 30 Jan 2026
 07:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130152531.1274646-1-csander@purestorage.com>
In-Reply-To: <20260130152531.1274646-1-csander@purestorage.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 30 Jan 2026 23:57:53 +0800
X-Gm-Features: AZwV_QjPH-0QVFtgVNQnURnso8pZ5Rnr_ofUye2g5Y309v4Hp34vuYAvs3R9swU
Message-ID: <CAFj5m9LZF2jk5Wq2FTPRv+tmOtG0dUJ0fv8N0aKYD9M7fWYXFA@mail.gmail.com>
Subject: Re: [PATCH] ublk: remove "can't touch 'ublk_io' any more" comments
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 11:25=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> The struct ublk_io is in fact accessed in __ublk_complete_rq() after the
> comment. But it's not racy to access the ublk_io between clearing its
> UBLK_IO_FLAG_OWNED_BY_SRV flag and completing the request, as no other
> thread can use the ublk_io in the meantime.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,

