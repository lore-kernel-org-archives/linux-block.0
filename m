Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7690B1E51FB
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243527; cv=none; b=KqqPopDTEHm+vosZZi/vjizQt7O7tLAQndLoLV6T3qqKl+NswPFH3q407abKTQJgBwg7sVUoyjfH65aktww3IATf0yzU4Y/W6745ROjkYDhBye7Z6R2rSTb8FJ+ieecZDTQEEJf8ok9+BBukIAkpbhb1U6ccZAKVRb0rci57+Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243527; c=relaxed/simple;
	bh=INL+jGniSEK6jlOzw1pZ4EBFHb9iVRN2n/+Wi3ZEWR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUeg+Bx4AI83cQLHubDgPYLrUuULvUOglIfxBAND/t7H784LKDVVyedZEv3Bf8Q0/q9TtS4nykN7uJskiugY5iThPkUmwKmFxuS2AzxC8Zp99HSiXokVv5avuT4j0mY6I8oaQXw29AdKk5YGfgZrql5ISITgL6SMJNV/5JtZLtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YydwEGiU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YydwEGiU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758243524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INL+jGniSEK6jlOzw1pZ4EBFHb9iVRN2n/+Wi3ZEWR0=;
	b=YydwEGiUvywtpBzVB6wr8L+HcuSsWztDyAiHssPdiWbqXcf4AQ3uwp7TgRyD3C4q7yEBzE
	jhLORiD2qv950AaAHggePOIoCY+HUN+j+CjAi4gWVi3E+1Lybs9f60S2GCA1QPBJKgO9O/
	4OV1AxWYShnpQpcgB/eQg2XlxtilHBM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-CQZsUuWDNkaHpqIH3s6iDg-1; Thu, 18 Sep 2025 20:58:41 -0400
X-MC-Unique: CQZsUuWDNkaHpqIH3s6iDg-1
X-Mimecast-MFC-AGG-ID: CQZsUuWDNkaHpqIH3s6iDg_1758243521
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78e831e5a42so36175086d6.2
        for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 17:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758243521; x=1758848321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INL+jGniSEK6jlOzw1pZ4EBFHb9iVRN2n/+Wi3ZEWR0=;
        b=GfX3hhLVYqYKTyMCf2HvX4/hv+2G5BQpDJz0RS5iQizO2L0YfOieMxbbf2nIW9Y19D
         G7LsRs5+nMub1x73kRw8XG9I1Esw/tzdle2892CmpFISPWy9fi7JY3J586+8Au9H0Qu+
         oIgg6cuB9Pj5zrpGca4CszH8HjSSf/0ljerfSZ1zjjt10w1C/GCLQD9RtSygKFY7io/E
         x7vLNt4TDq/jWP4k8Xv3Hs9Pnyk3V2hJoby6xpL19QBTEBrS0w8XAOS/CWeyho8E71ot
         38yEyqX0zm9aDw5Ht1nQWDqgDLTYdHnsi6q33gbdUTNWuRCBJXvd01PWypSRsSUUoIbE
         tQfg==
X-Forwarded-Encrypted: i=1; AJvYcCWGpW4vB1IUmIX+lwdbSCKnXZFdiJljcYJU8ImvVxUuCIxvqy/YcSarocGjcB/etOeCdHxIBS5jkfDoSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfCFimwWVnwaMOzFQnxkyEZpedFwBNvaL2YKMJBUI8gmsC6Hvv
	rqSuLaetzuil8ttmYaPZE0kEAOuIWLymUptmKby0PcLLHtfotFW49bFmDK5kaFgJ2USmUvxUtem
	+nifI9mHCUbsdcB1m9l1yjerjhmQPlBqlIUbxxT6ADqkS+CaUZYHhob5eiO/dPsoN9R1qsRpycD
	q1XC88OX1zxCSVqgJM48RyPQP9er9ap4NuMV8UqrE=
X-Gm-Gg: ASbGnctwxcPVoZ9/afr1n4y997AYx20jyb/TwPHxw6zRbkBK4BBg/nziIpkhszIoIiI
	NCpP3K7nejtNPRQCCVYlwQ5xtOMVo/F6HTbN9pzYm6ts/ERQo54d6AjxpEGL7kizOWWPhx6hWdp
	IB10ov9/weGMl6r3avhyNv4Q==
X-Received: by 2002:a05:6214:234e:b0:786:dc95:7b4a with SMTP id 6a1803df08f44-7991f60498fmr17130086d6.54.1758243520864;
        Thu, 18 Sep 2025 17:58:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCePSrkJyt8xOhV9XFxKyR5ORnkdYCLN1UQ0pORMOf3Vpbal9XfU/aSeiMZSMO/Y8ggPzzI0yEwXtZdhKDphA=
X-Received: by 2002:a05:6214:234e:b0:786:dc95:7b4a with SMTP id
 6a1803df08f44-7991f60498fmr17129876d6.54.1758243520392; Thu, 18 Sep 2025
 17:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-ublk_features-v2-0-77d2a3064c15@purestorage.com> <20250918-ublk_features-v2-3-77d2a3064c15@purestorage.com>
In-Reply-To: <20250918-ublk_features-v2-3-77d2a3064c15@purestorage.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Fri, 19 Sep 2025 08:58:28 +0800
X-Gm-Features: AS18NWBMx6gMYpA8xwEV8T0_f_E3cL4Rmg1pd231x9f1zxxG5V9QV0oQsLm1gZ4
Message-ID: <CAFj5m9+ZFkuq=n9R=d5N_ePzrtvx44TdR+YniCJVEWu_P+DGKw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selftests: ublk: add test to verify that feat_map
 is complete
To: Uday Shankar <ushankar@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, Shuah Khan <shuah@kernel.org>, 
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 3:34=E2=80=AFAM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> Add a test that verifies that the currently running kernel does not
> report support for any features that are unrecognized by kublk. This
> should catch cases where features are added without updating kublk's
> feat_map accordingly, which has happened multiple times in the past (see
> [1], [2]).
>
> Note that this new test may fail if the test suite is older than the
> kernel, and the newer kernel contains a newly introduced feature. I
> believe this is not a use case we currently care about - we only care
> about newer test suites passing on older kernels.
>
> [1] https://lore.kernel.org/linux-block/20250606214011.2576398-1-csander@=
purestorage.com/t/#u
> [2] https://lore.kernel.org/linux-block/2a370ab1-d85b-409d-b762-f9f3f6bdf=
705@nvidia.com/t/#m1c520a058448d594fd877f07804e69b28908533f
>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,

