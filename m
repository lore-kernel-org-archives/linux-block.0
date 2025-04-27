Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D31FBEB9
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745721953; cv=none; b=eQeuC3R75XRrkA69tsCZp8aqqPhKB1Pviq61RhV1S3q6y4qKS1Rn31foUfxSOYxh8oe0sXi2XDaPbsuGqFBOZtjXr3TQ+/NIqawxp+uoXRkxGxtGWcsn5S0wzjq+0P17gZ0RvmdawEfX0pC04L4W8B2Ka1CSJGj7amk9LGFVXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745721953; c=relaxed/simple;
	bh=9HyWmovfxbdO9WlvHm/CrZCGdDuQYBCiz0YIKAxiQIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BT9p98iSci8IrccvQL8s4C8a4fQ8m921ARP9Qsk4VAPoQoum52XdbOkCn+OshtH4R6K37wy9EDUFt8limvf7YxtaJa7nEIOEhpkC09miHbJrcE7q93btQG2hbkaqYMsE2e1Qec9L4xPpHYyfbOkUi8opRTNq7IKXKJcE0NH2+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bv3qL5dl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bv3qL5dl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745721950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lOD5wJKRJSGzLBcfg1idl+BdURTBGXU653f/FvKAjA=;
	b=Bv3qL5dlqFp4Ayz0xoBMi2VRHFPpgNKP7J/3Him+lF24KycqSfU8R7zOg/WoK0+Fbzqn41
	wL9oBWObdSHfQ9ehYnBlSzWY5ywxVPd607FiA2KgskXs2L9b3ebm8ozkYul4rYJJzDhI0S
	uEI9HBcc+BZ3obtxVaynX9B6rEuM2dQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-7DgefQYnPMquKpfqmAzhqQ-1; Sat, 26 Apr 2025 22:45:49 -0400
X-MC-Unique: 7DgefQYnPMquKpfqmAzhqQ-1
X-Mimecast-MFC-AGG-ID: 7DgefQYnPMquKpfqmAzhqQ_1745721947
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30be985454aso18982691fa.2
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 19:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745721946; x=1746326746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lOD5wJKRJSGzLBcfg1idl+BdURTBGXU653f/FvKAjA=;
        b=O4HlzX1O8JeMgilKPe2f48cxEHU+UyWPqB3LyGWoWZsAR7SmmUM4L6DQnAp11FNqvS
         lwBxwbBSkk5sUAcLzEdup++z2bJ0C0VzTHIGdk7pf7vtrVvE4rMRJNd/aQ97rxN/6Lvu
         gAUhQh48WSvVKT2/xPHvdZaJradz8Dq2Eymx2/0d0jIPBSUtCr/HQnEPFZl86uNIWeYQ
         i84JniqhrEcgB2FzjNMkGSjMsYSAPKsYLQ7y3Ok4+2Exr2Ul60kSp7RicUu9Qvp7uR5F
         L0cX3z2j770fXQuOIC6igll55TNVyVPYFa1TvAgOrF1bB/ASMXk6u21YhElZGMf0QWCz
         0P2A==
X-Forwarded-Encrypted: i=1; AJvYcCVyxSn/9vuV5LJRRv7w+m0Zt6YG0Hh3vg1rIa7oQRg7PXDj7WwnkmBQmxoZZPHkAYiOyxawlRTrbqczhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJ/yYKUiOLDThoWpjGZtlbzXGtruNCikGp8uO5CaRMLWegPBA
	i56lcLW5H6H6QAC0aKzdw8guQBxfu+ZCDtOdeVCeggaHqo/BZaVJoUE6PAU276DUm8YG/ezNUQP
	b/kXg9IMJc+5pvO2dyt8Myjr7nh+6y8aZXrUXZtecBmZYS1QsxaB3BdtEHGAwwPk2vWLJo550wS
	l5kDCLImDCs5mZyIQmzgpKgwv9q/oJrG2RjbGJ4vUVIC956Q==
X-Gm-Gg: ASbGncv/BQUicKSaGQW1qET+QvR7pWs18nr9X7u9MK6M/pI6g2R/kdqMV0GdQVfaJX8
	cJXQ/p2BWcluD0P0blRiYN24jALRho2mbOzwvjZZTytVBazdPmpVAunlgZyaVz9slHz/g0g==
X-Received: by 2002:a2e:bc13:0:b0:30c:1441:9e84 with SMTP id 38308e7fff4ca-3190614e2efmr19465741fa.13.1745721946229;
        Sat, 26 Apr 2025 19:45:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS0Yc4bGIbl2/v9OhZ9z0uTs3mIqptakH90A1Qqw9fP/ktQZ1u60ZhGAtb0KMTfZsMAlADrGR3uW4Ef7E40xE=
X-Received: by 2002:a2e:bc13:0:b0:30c:1441:9e84 with SMTP id
 38308e7fff4ca-3190614e2efmr19465581fa.13.1745721945851; Sat, 26 Apr 2025
 19:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418010941.667138-1-yukuai1@huaweicloud.com>
 <20250418010941.667138-5-yukuai1@huaweicloud.com> <CALTww29aehPQcbcy0j+V69r+RVgzNPwNhpAQ-7wWMdD-VPfNgQ@mail.gmail.com>
 <f14eac30-ab65-85b2-3e65-de6d50ea15e2@huaweicloud.com>
In-Reply-To: <f14eac30-ab65-85b2-3e65-de6d50ea15e2@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Sun, 27 Apr 2025 10:45:34 +0800
X-Gm-Features: ATxdqUFJRCKVD9aqKTI3GFPq-KDsm4Enqte1rPq47L--gyfTK3VWtePr_uH3814
Message-ID: <CALTww29b1MN8Q-ayFLxnRA=+=J-jrR90nrDrrY7xs1C_2k8KXQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] md: fix is_mddev_idle()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	song@kernel.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	nadav.amit@gmail.com, ubizjak@gmail.com, cl@linux.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, johnny.chenyi@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 9:37=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2025/04/22 14:35, Xiao Ni =E5=86=99=E9=81=93:
> >> +       unsigned long                   last_events;    /* IO event ti=
mestamp */
> > Can we use another name? Because mddev has events counter. This name
> > can easily be confused with that counter.
>
> Sorry for the late reply.
>
> Sure, how about, normal_IO_events?

It looks much better, thanks for this. I guess it's a typo error about
uppercase IO, right? We usually use lowercase.

Best Regards
Xiao
>
> Thanks,
> Kuai
>

