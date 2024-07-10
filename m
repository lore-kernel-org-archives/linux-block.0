Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628BF1DDC5
	for <linux-block@vger.kernel.org>; Wed, 10 Jul 2024 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619041; cv=none; b=pQp61nCdd17Sbof68R/II67COYb30IiYPS+lrkyoDZ8HmP0HF6Ai179HbKt4zGUeS0Wjagm9K0aaEybKNYV8dPXMsbBd8GjpHzFL1KKYlRupsNDUNtc7/OA0COS4o0bsARM2RCTmdNC+0wDjjVKvJ8LKlhlWHengEv/cFZY9brQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619041; c=relaxed/simple;
	bh=VzjKYiC3TRUVmEeY4cruQ/i9VL72Y+56Uze1Zz3LcRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNcR93ZaTLLBkW3KegDaPr/wCjdcGEqvZXJKZxlZMgeLt8PegRBq1rvC8h9YBydOyXz8LBHI7u7BFJChWOPXwQ27KYkUfB03Jl9wj0qdoNzzXFcnfQTL/CMBxUb5/PZVlicS+A66MXXr+DuS08ZSvIkpYjvErf1HFcB/IuxlqCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INtTRkgV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INtTRkgV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720619039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1UbC6sYG8EyHF93wDqXaOQ84FYoZKixSqTX2HRZz/I=;
	b=INtTRkgViOnr8Dstlr/Jaz+jEeK8KIk5ONpVCY/Ni+DLmWEgb1It18HylDA30Ncx6R+jc7
	ok4fn5fdykyJufrSbpxFI3N8Bda/gf7Bs/bC1HElREcvJucDxA7MvQcC39fn1tgT+1+ld7
	1QkdVkq8PPk1qNgh0Gw/SAtSYdVdAwk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-SKmLDCLMM5yM2Fx8X2U03Q-1; Wed, 10 Jul 2024 09:43:57 -0400
X-MC-Unique: SKmLDCLMM5yM2Fx8X2U03Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4272718b9b0so8165545e9.1
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2024 06:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619036; x=1721223836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1UbC6sYG8EyHF93wDqXaOQ84FYoZKixSqTX2HRZz/I=;
        b=F4U3gWL/nzzpzs1MYlRZV3jF524mikKaPkkvETWH+RhgE/oOU3qNMHiW6nBW4a76Aj
         +v5AGGcnDEnbWmK+wpo6I3Elx8XwnprqqFsTZAqtK/MEOiCCoqwHQ7O1bH4qSvg5a+BJ
         EzINY4KX4bq9ydI50qJSBHd4FywvoF9zMbs44FE8MyC4ldqQljSc15+u7vaxduye7K9O
         qw1mrDO1rm84cz8JtbN3XkvRO4MdjemHWCcbsRZgbUp/iREeMoxu5DZKxlT+XCfqKU1M
         Re0JrnkpsVHW13HeryhiMqo8thh6IOz0YrwEMW/C/nR8s2nXKaMgVJnV/EenIKkWrouR
         CYDg==
X-Gm-Message-State: AOJu0YyIjm/PjMNO/xEGwBgrCCrhMTjNX2qGZvd573AE1NRZ0fhdX9AJ
	PMwHGi/JNny2VrAqqzb28yMKisEsYXKsVsaj1RdZQAJ8MoGyJEutZrUt5iS8YIDzv6KacxCq8CK
	O8ExJZhUPYUFznZjYmGITFrLV0h+F1tOhFd1dvrjCzXFrio2RMlQ/MgQZdP7AxQMUFLBZTaGuNS
	Sppf/fPmStHjoVx2negG+KH9q+JzY0gJjodS4=
X-Received: by 2002:a05:600c:2284:b0:426:6416:aa73 with SMTP id 5b1f17b1804b1-426707d89d9mr34785325e9.12.1720619036771;
        Wed, 10 Jul 2024 06:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvC1hvx7V5bnT3xH71scnBh6oWIrG3mzuiuTXE7uXCAsFFgNd/Eb/h8kwSAwP0ae++izLV337A3NwkIwYO4LA=
X-Received: by 2002:a05:600c:2284:b0:426:6416:aa73 with SMTP id
 5b1f17b1804b1-426707d89d9mr34785105e9.12.1720619036136; Wed, 10 Jul 2024
 06:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709124441.139769-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240709124441.139769-1-shinichiro.kawasaki@wdc.com>
From: Bryan Gurney <bgurney@redhat.com>
Date: Wed, 10 Jul 2024 09:43:43 -0400
Message-ID: <CAHhmqcT6F_b8ZJMbm9jbL0Zg-vv6zq9oxfMttzf1K4GH-zz=NQ@mail.gmail.com>
Subject: Re: [PATCH blktests] dm/002: repeat dmsetup remove command on failure
 with EBUSY
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, snitzer@kernel.org, 
	Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:44=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> The test case dm/002 rarely fails with the message below:
>
> dm/002 =3D> nvme0n1 (dm-dust general functionality test)       [failed]
>     runtime  0.204s  ...  0.174s
>     --- tests/dm/002.out        2024-06-14 14:37:40.480794693 +0900
>     +++ /home/shin/Blktests/blktests/results/nvme0n1/dm/002.out.bad     2=
024-06-14 21:38:18.588976499 +0900
>     @@ -7,4 +7,6 @@
>      countbadblocks: 0 badblock(s) found
>      countbadblocks: 3 badblock(s) found
>      countbadblocks: 0 badblock(s) found
>     +device-mapper: remove ioctl on dust1  failed: Device or resource bus=
y
>     +Command failed.
>      Test complete
> modprobe: FATAL: Module dm_dust is in use.
>
> This failure happens at "dmsetup remove" command, when the previous
> operation on the dm device is still ongoing. In this case,
> dm_open_count() is non-zero, then IOCTL for device remove fails and
> EBUSY is returned.
>
> To avoid the failure, retry the "dmsetup remove" command when it fails
> with EBUSY. Introduce the helper function _dm_remove for this purpose.
>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

I think this looks good, and I tested it on my system:

Reviewed-by: Bryan Gurney <bgurney@redhat.com>


I want to cc dm-devel and the device-mapper maintainers, in case there
are any questions on this test.  (It's probably a good idea to cc
dm-devel for any "dm" blktests.)


Thanks,

Bryan

