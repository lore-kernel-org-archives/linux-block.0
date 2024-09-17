Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DED17C9
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578689; cv=none; b=IZXpAjI7TRetf0bno3Bpat71dYnh2nI4K94UFaopveBsFNne9V6Z0tNszjGx4wuxOw0L8gGeEUco3AAqzKDH8soTTXYg5tIzQxOVVxs3w5DEa7a8QtTRvTfHzFJZx2j/fdmKByjyToBkCGRqnUs5u9JFQ2cHhu2YoCMqqZsGmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578689; c=relaxed/simple;
	bh=7Cp7utYigKwoFCBSLa3dDA2O90LlaOoD4FAYlp/IroY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCM0ugyLvME4lfj5l/0vSXeXLiAaSDfZ7s48FI7YTeEVE5IGSGVX7G48GkbPsWaBPQEQF+V5TQJOM+Lv61hsgDCCCVvseh1L28NWY0mNHJkSHyiSAD8hoZklhUk2wS/hCfVvumSPL90H0gN7c5QysTAgxPuqvkyXWTyqqwSDqEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MBk+2QSx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MBk+2QSx"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cb2191107so43660245e9.1
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726578685; x=1727183485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4RIngZbAv+VjxrRWE4z8Sb/a+AMLtMo8gpv6pJbTuxo=;
        b=MBk+2QSxX9VsJ91viZdVtSLdbU2FxqLdCv/ZL4+ppSNvfArA58JunomDSt1ICg0Bm6
         MK4SAHdbF7P0P1DW1Eughd6iK+zGinzhnESE5PoP8/21XOhgf2x0wvm8NwWiONc+jp7d
         0i4F7taU5v84paX1KJBNUVYzVoCZLTnu1t9S5sltRSmQE+poYdYv27oOC9EV9jgH7uTh
         meOSVFrh20NJWzyQ9mV/BehxgQW5Lbc+T6Td3OxItLb3FM24jxpYdm+pmKV3an01q6T1
         5Dn0T7lCxDvxwFpl/CMmJL8gWEkdDomNbbWoT/zj8wVPQmfnSQH3HaELBp3wz9YzNYgc
         uuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726578685; x=1727183485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RIngZbAv+VjxrRWE4z8Sb/a+AMLtMo8gpv6pJbTuxo=;
        b=aWBShA1kfmKrLBVqyPeHTReFTA4cvkYC+4wvvxvuOqmThoUjwHtXfuT+miBVb13vF6
         TeDYM0zN7ecI8dB23KrdwLFxK3bwRy0crHhMfultyM2mJzIPZj1BAswNQfAGosGOW92/
         HK0uhvokkahEcem8d+fBDuOkF1l5PfuDAfo9wG5aFcY1kgaEWoBWXPD3n1vWyKnSiQYB
         P6bgAnmS6tHAWjrHFbTddwao9jWtxbNn92f1dz7kIf6mBkTjBE85JPGU8AES3a3RRPW0
         zkfocQHyZaZhMgM7C9ajwXmAbzVuEfz7Rg2h/xmikaiYlW3xXOCdntXVXFdKWU8O4jFW
         8e3g==
X-Forwarded-Encrypted: i=1; AJvYcCUw65kdK+V1xN7fPLD1BsXpSLEqHK5QNYKu8aJGpbnJjDMWwGiofuYwhkUeMvyMrcRh94OHBB8yBxwikg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzss1G158Jx0DU3eJCc++qVpQbfhnHWhMKAk8ces7krZuoHGHaY
	4f3sW1CvEsi7HMqoaPiFCKHRE/LAWdSoePnj55rx+I7xLJcf8PPRbpfavlHYg28=
X-Google-Smtp-Source: AGHT+IGkKsTfz4nOlb/gNzCrP+1rp/jsLOGQSpanSjdS3RJG9jhSodVH3D5+gAfscPRnkeVO5KPeAg==
X-Received: by 2002:adf:a3c6:0:b0:374:c6a7:5bd2 with SMTP id ffacd0b85a97d-378c2cfc091mr13411843f8f.21.1726578684438;
        Tue, 17 Sep 2024 06:11:24 -0700 (PDT)
Received: from [10.130.5.220] ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7804483sm9435146f8f.92.2024.09.17.06.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 06:11:23 -0700 (PDT)
Message-ID: <274ec9f3-b8b2-4a0a-bb13-f3705ddc349f@kernel.dk>
Date: Tue, 17 Sep 2024 07:11:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix elv_iosched_local_module handling of "none"
 scheduler
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 "Richard W . M . Jones" <rjones@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
 Jiri Jaburek <jjaburek@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240917053258.128827-1-dlemoal@kernel.org>
 <20240917055331.GA2432@lst.de>
 <CAFj5m9JZe5g07YNVh6BL8ZixabRTrhx-AELxTxFNm9STM7gNzA@mail.gmail.com>
 <5ff26f49-dea6-4667-ae90-7b61908f67cf@kernel.org> <Zul97FvBsVuC1_h3@fedora>
 <20240917130518.GA32184@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240917130518.GA32184@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/24 7:05 AM, Christoph Hellwig wrote:
> On Tue, Sep 17, 2024 at 09:02:36PM +0800, Ming Lei wrote:
>>
>> Here 'no_freeze' means that automatic 'freeze queue' isn't needed, or
>> it can be named as 'no_auto_freeze'.
>>
>> Again, 'load_module' is one bad name from interface viewpoint, which is just
>> needed by 'scheduler' only.
> 
> If we want to reshuffle this we could have a ->store_unfrozen method
> that does all the work.  But as long as the elevator loading is the
> only thing that needs do to unfrozen work I'd just keep things as it
> and not rock the boat.

Whatever reshuffling people have in mind, that needs to happen AFTER
this bug is sorted out.

-- 
Jens Axboe

