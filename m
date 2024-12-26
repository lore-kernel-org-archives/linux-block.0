Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64279CD
	for <linux-block@vger.kernel.org>; Thu, 26 Dec 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735198260; cv=none; b=iWcCv2rgHbVXEsN97iDdAo/c+9s57CtfyI9AgDz0XK14tDzmeqwyminJ76a/dlAYafHz16r00oAqIBnO6/F7X9L+NPClZA+0qgjIhZZl+axFPkGOJsssWLCC5wX741k0FF2by9B+G69fwxCE+R8a4jr/YMeMhbXJfOVoBdpObQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735198260; c=relaxed/simple;
	bh=tZXB2VCv5CBCCinsKrKK/xrXCZvuuR0J813RXWP4gK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQ/qTLCLYmsLXn70Otap1qLVmFaMPJQ/aXOS1wIrHov4V5ryuS20hEcDhSlhK4sOKEMZp35wk7YgxPWhAXCYn+Jn/kULfpAO8cx7WPlfFe0r6tQD8KcMg2C7qk0nm/GOG//y9hNr14nTL7qKnxbfLHIquUAIUj76qsenIDny7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKTmJIcA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKTmJIcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735198257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g389kIsNuRjUAkUcV2IHdv6m9cJD2NDRJ2brIc5P96s=;
	b=aKTmJIcAHbRO7abE/5YBCElPJkVfDPjT4ykmtqxW0nHlA+RYZzqZ3S5gQmX9gDdTtLwkZS
	DPLuSKFECBeRhLsMaOxQERfe0vQvebsQM+30c6GEJLUCak2F0rN2XcYUcyDg9IPXLmpEt6
	mGroBM3cD5SAzxCukpo4BDkNp6SNav4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-pZIxHcGeOcKkJ3N-cqPqVg-1; Thu, 26 Dec 2024 02:30:55 -0500
X-MC-Unique: pZIxHcGeOcKkJ3N-cqPqVg-1
X-Mimecast-MFC-AGG-ID: pZIxHcGeOcKkJ3N-cqPqVg
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-301b911c038so30583411fa.2
        for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 23:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735198254; x=1735803054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g389kIsNuRjUAkUcV2IHdv6m9cJD2NDRJ2brIc5P96s=;
        b=Q3Oyg1no4c4aaxej4pIL0ZvflKu/BUZFvqU9l9NGfS1SOBoRnJQNd2XnMWO43Ae6pP
         xu5Iqcyep+eSCsheGMQWxWQoTTaVhvdWytYzdy20M8Iad0GomJubst/I5yRVqlyxgpOr
         O9WkviyoBx8Kbvuofku14NoakwYPbTNA2px99KkiO9TUfXHurp6KER+MSIkYRYKeXWGd
         mM2XALkcJHM4J4HwIPQ5IYPEl3VNo+Cu47ePFY+2hPYD+lXgmgZZc7Op6bjVjsOvPTdl
         Y3w91xGpUqTHLwU9jgvTRP6ew2qC8QbL3A5n545UlSTmd1uLq6AoWeTsWVDxL08tCPFP
         Egog==
X-Gm-Message-State: AOJu0YzFmEFjq0HvjzHehID3dO45wjq1zfoS9F6p/WcWk+jnc4FNCzGP
	cmVM1dSc4v8wbLH7Tc90S/a+iFbbaR+2rb9nT+sN3kuCBw/LAlFA5G5a9S/haOwbUUbyorklXiu
	YIz1QFhedalYvBDcXr47j1t7AiJR54xrz3SgluI5Q8ry0Mag/wirgJxQ39oORB6GBX++GS2WdcN
	779Hr0YOmA6bDefyAieuoBnqQK2iagY32uoOU=
X-Gm-Gg: ASbGncu8ieGBAQAEDDbvUjn/jjNvTvKCMRzPU3BNLMBW02Y0axygnKX3/RnjCyKO8RJ
	jRSY74hT15H9n/dO4zKdgw2jV1K1ijVsERoI+D/k=
X-Received: by 2002:a05:651c:608:b0:300:ef4b:d820 with SMTP id 38308e7fff4ca-304685e7805mr53159381fa.38.1735198253627;
        Wed, 25 Dec 2024 23:30:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrAS8/z7SB+xT48/8vr2YHO/Ezq3S03yzFQNWjoRaJg3IKEhaDCBXIkl6yeSzy68m62Og/MBggC0toxEaq4OQ=
X-Received: by 2002:a05:651c:608:b0:300:ef4b:d820 with SMTP id
 38308e7fff4ca-304685e7805mr53159321fa.38.1735198253256; Wed, 25 Dec 2024
 23:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218134326.2164105-1-nilay@linux.ibm.com> <20241218134326.2164105-2-nilay@linux.ibm.com>
In-Reply-To: <20241218134326.2164105-2-nilay@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 26 Dec 2024 15:30:41 +0800
Message-ID: <CAHj4cs9+mE_8zNEBigPF=HM8uYsWiyKOi-5R3D6qJ00y8m30Lw@mail.gmail.com>
Subject: Re: [PATCHv2 blktests 1/2] throtl/002: calculate block-size based on
 device max-sectors setting
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, yukuai3@huawei.com, 
	shinichiro.kawasaki@wdc.com, bvanassche@acm.org, gjoyce@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Yi Zhang <yi.zhang@redhat.com>

Confirmed the patch fixed the throtl/002 failure on
ppc64le/aarch64+64k on 6.13-rc4.

On Wed, Dec 18, 2024 at 9:49=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> The commit 60fa2e3ff3ab ("update max_sectors setting") added max-sectors
> while setting up throttle device. So now we should also calculate block-
> size which matches the wiops. Typically, size of each IO which is submitt=
ed
> to the block device depends on the max-sectors setting of the block devic=
e.
> For example setting max-sectors to 128 results into 64kb of max. IO size
> which should be used for sending read/write command to the device. So tak=
e
> into account the max-sectors-kb and wiops settings and calculate the
> appropriate block-size which is then used to issue IO to the block device=
.
> This change would result in always submitting 256 I/O read/write commands
> to block device.
>
> Without this change on a system with 64k PAGE SIZE, using block-size of 1=
M
> would result in 16 I/O being submitted to the device and this operation m=
ay
> finish in a fraction of a section and result in test failure. However the
> intent of this test case is that we want to test submitting 256 I/O after
> setting wiops limit to 256.
>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  tests/throtl/002 | 14 ++++++++++----
>  tests/throtl/rc  |  4 ++++
>  2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/tests/throtl/002 b/tests/throtl/002
> index 185e66b..02b0969 100755
> --- a/tests/throtl/002
> +++ b/tests/throtl/002
> @@ -14,6 +14,9 @@ test() {
>         echo "Running ${TEST_NAME}"
>
>         local page_size max_secs
> +       local io_size_kb block_size
> +       local iops=3D256
> +
>         page_size=3D$(getconf PAGE_SIZE)
>         max_secs=3D$((page_size / 512))
>
> @@ -21,12 +24,15 @@ test() {
>                 return 1;
>         fi
>
> -       _throtl_set_limits wiops=3D256
> -       _throtl_test_io write 1M 1
> +       io_size_kb=3D$(($(_throtl_get_max_io_size) * 1024))
> +       block_size=3D$((iops * io_size_kb))
> +
> +       _throtl_set_limits wiops=3D"${iops}"
> +       _throtl_test_io write "${block_size}" 1
>         _throtl_remove_limits
>
> -       _throtl_set_limits riops=3D256
> -       _throtl_test_io read 1M 1
> +       _throtl_set_limits riops=3D"${iops}"
> +       _throtl_test_io read "${block_size}" 1
>         _throtl_remove_limits
>
>         _clean_up_throtl
> diff --git a/tests/throtl/rc b/tests/throtl/rc
> index 9c264bd..330e6b9 100644
> --- a/tests/throtl/rc
> +++ b/tests/throtl/rc
> @@ -71,6 +71,10 @@ _throtl_remove_limits() {
>                 "$CGROUP2_DIR/$THROTL_DIR/io.max"
>  }
>
> +_throtl_get_max_io_size() {
> +       cat "/sys/block/$THROTL_DEV/queue/max_sectors_kb"
> +}
> +
>  _throtl_issue_io() {
>         local start_time
>         local end_time
> --
> 2.45.2
>


--
Best Regards,
  Yi Zhang

