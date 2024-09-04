Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8561DA115
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454986; cv=none; b=snflP+Jzf9H5FaHy8xeq6E+V1a8RFdXNFxjg7es37Omkx//TC193zgq9Bl8jfKGambZ+MrGMSfqyu/5OqbrzvpHwQjtdFQAtC6yy7TLJrOHTNSC54zJLc6lumQJeLL3sDB867nep9rZ/sjt5DaZqixYvEN8YTbNu6LL1DH/QIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454986; c=relaxed/simple;
	bh=uMbn66TtshGa3YU31X3Gw5391g9ZvSIZhpzDYDCHC9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFF1IP7omanVVh0dxSE95WI/1UtqOv3HRipMh+Ke2Xe8MPl6KG2MvQjQ8/DOwwiszR0NA4ep58uLfOqQ3sZTq3rDblPK98aqqXbOg4HawoxkCplUUNOAkUdJHjQAD61EsJagXR5OX2469S3Yn22nL0NVqMAyrYcZS6HaQNHheQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBQxpoAZ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBQxpoAZ"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70f63afb792so2897241a34.1
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725454984; x=1726059784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMbn66TtshGa3YU31X3Gw5391g9ZvSIZhpzDYDCHC9c=;
        b=hBQxpoAZVoC23yIUj8faA0mXN1yPWfmtuUhCH3WW/njpoo4IRvC0t/BRXoCJsNV1Tv
         cJm29PFexXgvkaaR11tMUHcZsHtmDIcZoe7yhRg2m/e8NXJFdQH1aITe9nalHt272Uw1
         Mdy9fdzRnerRhAw98/WZuvJVXXREgB4ZnOWeWJJC3FUiRRVsu5oJKyvHwhSvZ1O8Hsc1
         v9Zq49Ws5Xl5hsJkTcsUNAQXeCqijVC2mKi9oVhjE2GQycou14jc4dnGURIs/EhcfEtx
         OxeI2O3AguQQB4HBT80nv+ObLMb7NkaFrvNB15ySfJxVJRhn0GvhPeRcAARlAo8bvtf5
         2h/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725454984; x=1726059784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMbn66TtshGa3YU31X3Gw5391g9ZvSIZhpzDYDCHC9c=;
        b=qu751V4djAD45mUwOVFRYH2OX8euwoPkLKojirwrhkrigizCpiXM5EjyqClXPl0Gov
         cuL6e2TGhw6aei2r6ShgVUeECJDu4LmvJrozeLPjnD95scyfHDqvXJWbAGUqGnaXbacB
         kFjjyrT/5Yadix9h9Fx2+IYQC1c9m39Bbpg1ZTAU7q2e6Hi/ZsErCVQPKWmEBOgw+6sg
         BrFaPoHx2QKQ6peKiE1y2YR2d2K8IsxtID+Fb/0SFrtCzjmG7B/JXAIdP+EPP9TKp47z
         BiQ8eqT4L2DuOtsU3RXjYV5GWAk23cX8pSruEkwiFnoMoM3k90NkF9huEVkPl59bOVIs
         SdqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSt+X9EsEzJv9SbSCgeF3uNgn/oQrJKJ5+wdZTzCg/WaqHmI99XR3WfyBpV1wsHbgWPxBTXKnY3QZQSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZppX2ESbu8SBMEgO7OqG5Hzi1Wuf2SsZPf3FAPJYm1vePXmpg
	EzJIbrWq3UL+obEWxwRnhfeINSSHhz/VLd57UsabcwSYuCeTg+L/eqmkGym67wijEHfy01G7gOc
	dVsR4WgIMgN5krLkFRQDQjq5qng==
X-Google-Smtp-Source: AGHT+IEdulZw6u98/TxISvhCEB+PWEUOXDMgrcbat3567ZXIVe3pY1VGDwAU8mWSXTM+ZMpWQFg57+LANpm3aH7l26s=
X-Received: by 2002:a05:6358:7e0e:b0:1b5:f74e:ae3a with SMTP id
 e5c5f4694b2df-1b7e37f1111mr1915202055d.15.1725454983839; Wed, 04 Sep 2024
 06:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e41b3b8e-16c2-70cb-97cb-881234bb200d@redhat.com>
In-Reply-To: <e41b3b8e-16c2-70cb-97cb-881234bb200d@redhat.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 4 Sep 2024 18:32:26 +0530
Message-ID: <CACzX3Av88j1mAq7-VRcbO+azSTN+P=c-0-h5Jy=L7GyaHVrt_Q@mail.gmail.com>
Subject: Re: [PATCH] bio-integrity: don't restrict the size of integrity metadata
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jinyoung Choi <j-young.choi@samsung.com>, 
	Christoph Hellwig <hch@lst.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 1:18=E2=80=AFAM Mikulas Patocka <mpatocka@redhat.com=
> wrote:
>
> Hi Jens
>
> I added dm-integrity inline mode in the 6.11 merge window. I've found out
> that it doesn't work with large bios - the reason is that the function
> bio_integrity_add_page refuses to add more metadata than
> queue_max_hw_sectors(q). This restriction is no longer needed, because
> big bios are split automatically. I'd like to ask you if you could send
> this commit to Linus before 6.11 comes out, so that the bug is fixed
> before the final release.

Tested-by: Anuj Gupta <anuj20.g@samsung.com>
