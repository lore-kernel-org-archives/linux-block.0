Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C00C31771B
	for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925836; cv=pass; b=c/m1TZqq3hzz9JsaFo5WRf3BLW2D8S5Q5+FUfRFHWkRo7usfldLYFA2IRkZPVDxmeEd03A7Om1vwzoo8A2Rnlf/N7i0ASGZQN4HqjM+quBq06oyNTcep9CzoqXwIq8dFEy5Dd7UjS6RoGJnA+fup9tgvagG5wQHbPGI2VbgL4/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925836; c=relaxed/simple;
	bh=tCNVx6q0fwH6pjyWn+uRG02ZeHI/TyFmS/lDJY46FWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EtkbsKhSbgpLX3jUnrkDFai1r34G5ZtSsDYVc7Qe/3cTmWXXIBBsW961KXlgp/SSLBetlc9idCmpoZ3I+SzCV5KJzQxbOwMUBkEzOEHud92PYXOXafrhtV94UYDEueGklpIjrjjdTcpYhHBGzbGVmL1Lfqk7+0BcA9IlvDz8Di8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfv7DPgK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6YqEqBB; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfv7DPgK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6YqEqBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768925834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjmz6BJQ3UN8YVqtcYDSDmAuA9+2oF0GvLcz/cx2Xig=;
	b=bfv7DPgK9h/TeQVSyJckVIsQjj6Cf3VZ07IXWvNx6uSflUckfV6zqIld3bH9yDiJ6PGUDx
	CzYLAXiQibC52QH+Koaf8gMcwhO8Ih5JtPvPjXvH9XsBEM6u4Y/pNxSD2EpfWm1KVxEpl0
	NqDttVB9D+2nypb2IuyIp1WcF7kMNyA=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-HOCsT8m7O8qaxJpYDy1arw-1; Tue, 20 Jan 2026 11:17:12 -0500
X-MC-Unique: HOCsT8m7O8qaxJpYDy1arw-1
X-Mimecast-MFC-AGG-ID: HOCsT8m7O8qaxJpYDy1arw_1768925832
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64941169ecaso498765d50.1
        for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 08:17:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768925832; cv=none;
        d=google.com; s=arc-20240605;
        b=JpLXORM5dxKDYtY8oN37gDrRzFeCuO91A1Ju3b9CPM9cFaonJmSdxqSbYfkXbMnIFd
         i2V4uYnfqT7ylZXoSDcF+IPT1ITKubT9wAt6DuNuHvlMkxsg+kYoakgudpRuOXNevKP6
         kI1ebT+DQZioxnBNr7cK7Hetu9nDm75TMrFVCYYNmCGVm8VXSGvw3KPKzKXvzt9/yKLG
         aYumcilqxNrXaCfH/Z1db5Ev5yKVx3catrObz2un2gyenujqx2+leip7pyyeA0ipmI1b
         4f2uDaVHu9d+JkdTW1ymMe5WEVSWKlBLhquCoEwqyhZztbkxORe1Y2LcRODTmOG0sOUZ
         qgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xjmz6BJQ3UN8YVqtcYDSDmAuA9+2oF0GvLcz/cx2Xig=;
        fh=4CedISFanfkPvOoq3t00iWStznc8OpF0cpIA0cPsBZw=;
        b=F4hRDtw0OVNkOKKL/u1ARURsiX0xcEHwMgcAQwQw3e8pJANoCONkvHwViFP24hU7jy
         ge0M/wmNYtf48Af/BgeZG+xHyyicsMdvEjxA+6cUq3R3j26HN0kl4PgfJOyByXoAIkmX
         sUyQXA+dY8Hv4ZS5Mzfm2bYPqQkMfBm1NfNSkO/rZsyoEwmmgrxbV+2E99vG8CB7f4gd
         +N9D4NoRAD7+Jp8KkP8b4hn8m2PuSpiBC5NRvLqFuMnkja0b5ybu2rSwPMaAdT60+2D1
         L9UG7Gn3G2Y0iNVqxKfPtQ2Ab+MxjL6M36tKF+1lXaU1G1WhMEnlePoEybP6pKUwgEAd
         lOsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768925832; x=1769530632; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjmz6BJQ3UN8YVqtcYDSDmAuA9+2oF0GvLcz/cx2Xig=;
        b=X6YqEqBBUt+fWxoeDLipwWXIygdqmGQVPFtwwuFRyhS4HPzwBYmD5om30AvVVpaLEE
         Mln4UYDCOL/G+GSDGloS+9spxc292gZ/iwsLogHV4Iz1YHc6K/MGgdivgmcDQk4YWW4L
         5PGd48SExJlPA5ix5RqSrqfPknc40Lxhn+YTtmvfTtR6rgbP+sV6eTqZP/Idu5HuACzW
         BMBTtpbniPrQPdZYt3Nn0ohTJgSdm6dPPPX2gWY+BQp8owuN7/0BP+oMQEH52uzx6Las
         rl3FjGRKXklQIupwguFpo14LoslFs9agDrORhnTgj8b7XS27XH2hjT7s1jdaSBZvqlBH
         9kZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768925832; x=1769530632;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjmz6BJQ3UN8YVqtcYDSDmAuA9+2oF0GvLcz/cx2Xig=;
        b=Uu4NQhsvQ/aNG1ipfiO8feTVz1y7K9JBVoSYuFzNR3g+ECqb6dl9Vu5FFFnX5yh8sQ
         ZzXP9Ylc2NJSiCWs57kCro0qZKqJZQXAXfgPou6HhoQQdkzjos9U8ykYs4JXgdxiorgz
         4hpgrVcy/gzjao/Ga7Op5HiUs+pMlrNKCHwRMWOzcvPHydgWXnzX6jl/W9a/37xnpmBk
         oJZRTtxelcN830gE8Ax7sFVQeK9krJa8mT0abedPNqBEWCQDgmNXVYwn/GKr2l6Qfexw
         AGwOG1xSVJ+jqw42uA4Znk4V/5zZMB+PnZ0a+tm4AkrWM5A81FyUMUxvbiMlZXP0dYZ7
         tDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVITksPRGxtSNYN4GzbPe17IjzgHqXxtqzzYMRMJE6dDx8Q0mohwekSgTxFqxwR3z5ECuTzFhI3PNHGVg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkh+rO/Co4X/Q4OLaPKr3cRnRUcYqnvMovEltCT5cf75+7esVV
	wAcijaaCXTTIFXVHQs34xRUAGQ+Mt/Y7bRuxsIkBXWXpKZoEDvOqms5nrUfp6sA1BSAd/zEH5wc
	zQeGZ4cqVsLY71vqNTUJhe0u1ntBahOqRsj6YklBnSbQv9ecvycVBX9GrG0wuWYiDOVrMr5bLsZ
	FdhgWcxJAfhI6kzU2CUgmlYUO3gZAX7Z7tLEVEHOHXtAGmy7Q=
X-Gm-Gg: AZuq6aIOJanxgJD/zdBLlTdFtWzzAwH3snMMjPDA9qvpBaa9xDqoilmZEEAr/sWFMVB
	pCQ6rP/uFf+umE+d6Tvjk1I8nxV9OGx46G97ox4WH1Sy5z6LYpATDRf2nt39rwjaComt25/zhgH
	7xhY8QxiLeJCAU1/+0Utk9iDhaBn/KtnVdiEtUZEl8/4FZly8AGVrXP9rnaWvYTcVLNqlILW/t6
	gzJwY7I9tCJSwVYinZfbq5U1nt1uOiPP/JYLvwRyA==
X-Received: by 2002:a05:690e:b42:b0:640:e5e1:190e with SMTP id 956f58d0204a3-6493c848e5cmr1600209d50.57.1768925831677;
        Tue, 20 Jan 2026 08:17:11 -0800 (PST)
X-Received: by 2002:a05:690e:b42:b0:640:e5e1:190e with SMTP id
 956f58d0204a3-6493c848e5cmr1600203d50.57.1768925831291; Tue, 20 Jan 2026
 08:17:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114210809.2195262-1-jpittman@redhat.com> <20260114210809.2195262-3-jpittman@redhat.com>
 <aWo2phhtvibIfQ1D@shinmob>
In-Reply-To: <aWo2phhtvibIfQ1D@shinmob>
From: John Pittman <jpittman@redhat.com>
Date: Tue, 20 Jan 2026 11:16:35 -0500
X-Gm-Features: AZwV_QiGVyojD-1izZ3-hpi4JThkBwcYDNbp7bhF29TRDbbwyZJV0en7PwH1OqY
Message-ID: <CA+RJvhxhrRMnSqwdOtme7om0=qzdAtkYNectDU7HC4f6w_7KOA@mail.gmail.com>
Subject: Re: [PATCH blktests 2/2] block/042: check sysfs values prior to running
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shinichiro!  Thanks so much for the review.  I'm correcting the
attr and the unneeded argument preparing the V2, but I'm confused
about the below request:

>> Nit: spaces are used for indent. I suggest to replace them with a space.

Using vim to show the tabs (using commands ":set list" then "set
listchars=3Dtab:>-,trail:~"), I see in block/042 that I am indeed using
tabs:

device_requires() {
        _require_test_dev_sysfs "queue/max_segments" "queue/dma_alignment" =
\
>------->-------"queue/virt_boundary_mask" "queue/logical_block_size" \
>------->-------"queue/max_sectors_kb"
}

And lower down in block/042, I see that in a past patch you used a
single tab then spaces:

>-------if ! src/dio-offsets "${TEST_DEV}" "$sys_max_segments" \
>-------     "$sys_max_sectors_kb" "$sys_dma_alignment" \
>-------     "$sys_virt_boundary_mask" "$sys_logical_block_size"; then
>------->-------echo "src/dio-offsets failed"
>-------fi

However, when I check other test files, it seems like people have been
using only tabs for indent rather than spaces.  For example in
block/010:

run_fio_job() {
>-------_fio_perf --size=3D8g --bs=3D4k --direct=3D1 --ioengine=3Dlibaio --=
iodepth=3D32 \
>------->---------group_reporting=3D1 --rw=3Drandread --norandommap --name=
=3Dnullb0 \
>------->---------filename=3D/dev/nullb0 --name=3Dnullb1 --filename=3D/dev/=
nullb1 \
>------->---------name=3Dnullb2 --filename=3D/dev/nullb2 --name=3Dnullb3 \
>------->---------filename=3D/dev/nullb3 --name=3Dnullb4 --filename=3D/dev/=
nullb4 \
SNIP....

So, I'm unsure what to do.  Do you want me to use one tab then spaces
as you did lower in block/042?  Or stick with only tabs as others seem
to have been doing?  Or only spaces?  Sorry for the confusion and
thanks for any help!

John


On Fri, Jan 16, 2026 at 8:03=E2=80=AFAM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Jan 14, 2026 / 16:08, John Pittman wrote:
> > In testing some older kernels recently, block/042 has failed due
> > to dma_alignment and virt_boundary_mask not being present.
> >
> >    Running block/042
> >    +cat: '.../queue/dma_alignment': No such file or directory
> >    +cat: '.../queue/virt_boundary_mask': No such file or directory
> >    +dio-offsets: test_dma_aligned: failed to write buf: Invalid argumen=
t
> >
> > To ensure we skip if this is the case, check all sysfs values prior
> > to run.
> >
> > Signed-off-by: John Pittman <jpittman@redhat.com>
>
> John, thank you for this series.
>
> > ---
> >  tests/block/042 | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/block/042 b/tests/block/042
> > index 28ac4a2..bbf13fd 100644
> > --- a/tests/block/042
> > +++ b/tests/block/042
> > @@ -11,7 +11,9 @@ DESCRIPTION=3D"Test unusual direct-io offsets"
> >  QUICK=3D1
> >
> >  device_requires() {
> > -        _require_test_dev_sysfs
> > +        _require_test_dev_sysfs "" "queue/max_segments" "queue/dma_ali=
gnment" \
>
> Do we need the first argument "" ?  It looks useless.
> Nit: spaces are used for indent. I suggest to replace them with a space.
>
> > +             "queue/virt_boundary_mask" "queue/logical_block_size" \
> > +             "queue/max_sectors_kb"
> >  }
> >
> >  test_device() {
> > --
> > 2.51.1
> >
>

