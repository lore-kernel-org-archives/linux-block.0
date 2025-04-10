Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012C1EB5E0
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299624; cv=none; b=nTEzx0MCte4UYlssNjc0yLESWlqCLk9tAqXFo8Lmou9FJNmHw/Bw0m/ycGfKMYCXu9HhV4BYmn/gZUoiSvn8lgoRIw8OMI7nrSft+ja6FejtltMs8YE2L4qJx1iyhQiC3OxolOiGchX4woRMwkaKebMjIChHTNvl6Gun9/nVw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299624; c=relaxed/simple;
	bh=eBwEv1Hw9Kij4df56u1rywJS2psBZ3wwOfTx1fpEZR8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pVR3hghHzM+uhzispcBfcxdPm5FV2bijtERopDUeeqUsc3Ge12ZarOlNdw6l9O4j1HCGNgjs/k4zLWGvjpk3dTKZ7b5Jy6v3vFiKi02bdWR01TEKqlU0MxFJGLi1OJs52L9Em1U+gYSfdJpBKKEr8+B9v9nNnCW3uh2Dlxyzt2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0bCT7o1U; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0bCT7o1U"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85de3e8d0adso24374539f.1
        for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 08:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744299621; x=1744904421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YtFSJRLfiz+ZS7/iNWwK6CnodJhvI/BHKt9iZYwqij4=;
        b=0bCT7o1Un8TDiugr8aw+tLdd9E7YVuGkNpSpc0BpQFDgB0/4kdBGwwHkURypGVXGIt
         tp6tz1ajoxfjACP27elATonQYqYch931O5hOQ522QOIXvG5PypPkuzQ3DgY4EiufYMiE
         qsUN2VeEPfN54vmteCVeoqSqYb6kqf9OHSJpk35sjtuVBMt2wkMBqyv/eTPfN4hj44pL
         ok7804ciTxHvLvi9G5OWDuXdCTnMwvw9I2bfaw0q02PpM0e2G5++EKOxIFqzB57mISb+
         wNENxq+/YvSaQJURqtkU0ClgjTHpc5yvL9jM1XI1XIW0WsbkXr7eu0+1WQDzNJHTg33R
         /wfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744299621; x=1744904421;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtFSJRLfiz+ZS7/iNWwK6CnodJhvI/BHKt9iZYwqij4=;
        b=gu94S4GoGJ1xbeDl/gYB+mqNX/Nd4cVOQgj5uy2AYIdMZtOW+GJe/L5i5TJZv7/RwY
         C1jQSy6mn6mmDPEkR0Ort6TKac+NCUYXKhMr+raRAs+8p/Q2WDicWzDtd9Xx6/AMR9xn
         B1SyPbprinT1qOkH8KK9/BWOOIHsWtTnGPSUUiex/Viu33gEnZjdBiA+jX0TTNuli5WC
         aLHiqzayavtTigPSK7oJzCDX5xA3UvADTUsEjEtkjL0R9iYSyYfGk5xTZ9hCVlsjMeMh
         SSKGaF6bau80V2kcK6qb3mDkwJi92IecmmDjzUQ4FKa4AQzo0MfPCFpL3bp//GXrwMPo
         El0g==
X-Gm-Message-State: AOJu0YzDJIZLDtjlCJoPyBP57Xm7DEMrr0oPEeiDSJlLyXahYIQmJARR
	Jgma65FQ8sA6P7IafquUdgK6AUtIJACxjb7ePEF/ZtRtAn0CPrbX4yxMxd1Vo6w=
X-Gm-Gg: ASbGncu/Et4iJ7NF9P3qxPSh2CMujdccRyK3yzZoqG38GsSEVg1FYe4c5e0DG2pu30n
	ztddA1RDPE8W4vgykMXQZbk6NUnzHoDXPizQB86HFX9H4MzhexHUjvd5fLMTte0+sd+6rocQCrA
	vgxTOlQZ2eip3RZ+wW0cVGjID0KgjbZMGsu9rFrfSTevCF+oobxEepuk9SE0dddoAUMUQHfD7Qi
	LvPrzFgHJDIeZy1ZPFm5Y+vKZnKAg7bUFqCwSSVxlFrhk5KfSxhSyFPk/rFqwMPaE7ME2PeU2Vp
	deVlTaKzRBtqd9yF2DJSU4r/IUpmuvpojQVD
X-Google-Smtp-Source: AGHT+IF2bNT932I4gwJmrF6Z41TjY0uWt9mh3RWMkEHxOBFXNmolae6NlhSUy9V2Sp+pGJZrzAfQNw==
X-Received: by 2002:a05:6e02:1445:b0:3d4:3d63:e070 with SMTP id e9e14a558f8ab-3d7e47747f8mr33547955ab.16.1744299621349;
        Thu, 10 Apr 2025 08:40:21 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e026d1sm790693173.94.2025.04.10.08.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 08:40:20 -0700 (PDT)
Message-ID: <bbe9bcc0-a4b0-4f47-a6c4-c5cc50b5e463@kernel.dk>
Date: Thu, 10 Apr 2025 09:40:20 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.15
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <Z_fdSjFqscMuzxYq@infradead.org>
 <e613a857-fba8-4e46-8879-d791d37095b0@kernel.dk>
Content-Language: en-US
In-Reply-To: <e613a857-fba8-4e46-8879-d791d37095b0@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 9:29 AM, Jens Axboe wrote:
> On 4/10/25 9:01 AM, Christoph Hellwig wrote:
>> The following changes since commit 72070e57b0a518ec8e562a2b68fdfc796ef5c040:
>>
>>   selftests: ublk: fix test_stripe_04 (2025-04-03 20:13:38 -0600)
>>
>> are available in the Git repository at:
>>
>>   git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-10
>>
>> for you to fetch changes up to 70289ae5cac4d3a39575405aaf63330486cea030:
>>
>>   nvmet-fc: put ref when assoc->del_work is already scheduled (2025-04-09 13:03:56 +0200)
>>
>> ----------------------------------------------------------------
>> nvme updates for Linux 6.15
>>
>>  - nvmet fc/fcloop refcounting fixes (Daniel Wagner)
>>  - fix missed namespace/ANA scans (Hannes Reinecke)
>>  - fix a use after free in the new TCP netns support (Kuniyuki Iwashima)
>>  - fix a NULL instead of false review in multipath (Uday Shankar)
> 
> Pulled, thanks - since this is late, it'll make the pull next week for
> -rc3.

As it turns out, it's only Thursday today, for some reason I was
thinking it was Friday - which is also why I sent out the pulls this
morning. Wishful thinking...

Anyway, I'll shove this one off tomorrow as well as per the regular
schedule.

-- 
Jens Axboe
