Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BCA1BC2A
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 04:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745553884; cv=none; b=CCgMX1PKIpNcLAgc1lWEgpCneTGLef1Ep/eLCKjcXobPgNdh1DZwgS1Sn9o9FOYe+EBxhbmz1iZhPDts+z21OJl8we29UYqkifm8yhEfr1DmFSYcnuPMzARmI858r+7pCRk7iQQevKhV+YhsTHqXWo4wmDhViujgG0t/qlpsNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745553884; c=relaxed/simple;
	bh=Kwof+fO62y7e/RHa0On3RX/TwZu9uzYKZRQz19L5h0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YO5KCBFWynC0LtAeRXFXeDpS+akzF2Isw7uK1XKS6OvyoygvkNN22MtPhn0CySracaFYKLfj38j50JiGV7x01+JkgrTeg8hkP4TUaWZKuxMvNRzF3nkrHNIv/rz12WawHxzB1gw6YFneuwdL0bvOYDaqgTgKQr+dRfVvcHv0vN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqWiWq1z; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqWiWq1z"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c55d853b54so22757285a.0
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 21:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745553881; x=1746158681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mT5VjZuJoUlawhbHokQ45PcTHgcGF9j1l+eGww/vtv4=;
        b=TqWiWq1z9jXsNeLtwE073Akj1Wl3QT0/FVKL9+MkrnnRsqcaYlgg2HEP0dpYe02xga
         WOXxeCO54P1Dc7P2UEnxmLuSisO+QtQyp6KzYjlYhDueZxJeuryXCHI4hOXGoGq2nwxD
         yzsvO3OuMeaCM66PvBCZiI4taEVs6bsuRlkXrIXNdxPiZ4aODQfRwzTk9iQ/5CKGmS1n
         rOiHz0rWVack2f8KRxf+ddhsycaX6sFFhfKItpRef5aKGE3sX8spcnUelYVddqhGLDVA
         NlaqxALvf6VlUTHnMZvJBfmNTzCVQO861BVV2I9LZI9aDNHLDp1QFpZ4PPYwxrJzG4mm
         NHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745553881; x=1746158681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mT5VjZuJoUlawhbHokQ45PcTHgcGF9j1l+eGww/vtv4=;
        b=CjFR5pEJYByHvH9jQC/MrY6Ypwoh+oFmOkv+U4QAg+ev8BnoxXbVsDUZz9XKbVTwmx
         BNVH7BNAlBB6XhIcB/2ohfNRDbVWU5omWj3/6cBaLQj1Aa0mOBXUPUiefaFeXClwa2VV
         UZ0uyCz8yrUkrDrb/UwgG7SQni313AkjinRC70oMQRpXxdjCzkUXtE4Lamn1rQ2NnVK4
         Ky6FX/FFotNNDQif9wPfc0iArfPKwB8t+PyvkQ/Z3cM2DjiHwsutD2/8bSO1ty9ZptN5
         5Zy7Oz57uKzE1iVNMRHRxDy6mkivUIY3Gim8j+XldPFtAoclPc+A0Vt6Ce7MvILJHs3E
         h2hA==
X-Forwarded-Encrypted: i=1; AJvYcCUL36mZjXtFY9vYOB43CNolW3G4Tnrsrw7zZd3C+P3vq1e5alo/sL/+lWoWPbqsXisdpvoPnFqSJcpN+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzveqgV77nn53X3250TDrS/Ud0mEV3dA/u86vUkEPRmZ7eMij4t
	nlGAgRdWUu2VqhYOSSpE5RFet0Auna/kmP4ISF2Z5uR1Uz3d96Nppdgj302b
X-Gm-Gg: ASbGnctM8hioFPmrWLVzJw2j66RYCUkTdcdvvOAj+MtPpSy2k589KjduVWXeg7s00KS
	5TuCDIEtYw3Nmj48b3ZUSnjUjyuK24TMrCs82Oe4xRajDnisCKO+wfgERujLqOMo3BaM23f8cZe
	soyreRHCK53MLKm7J5KIVav9EftLemX1AlLRKcRBBPVCmwf38HTdLLS7nac5Ts6rsJPOvEq0X1S
	0e6jIWJbZ+vM55xIYb55ONYY0GPLh8yC6oaCAB6aQINLhmLucqhOjsCna+zBQqHfyFh0oZ+5XQW
	iQzs+twy39jcF5JzmgTmQvKdJspCsghhLuFNyItd75kFH6+drFWZC8skIty7MHslemys9beIsTG
	QPnumu5s2mLdupAwF
X-Google-Smtp-Source: AGHT+IGvsgdYcMJOawYzasIKw0eOoRQ4FqFhC8ackjUTEfEj1ILDqHFQItCppOQxLJuGi62ODhURjQ==
X-Received: by 2002:a05:622a:1a28:b0:471:f08e:d65d with SMTP id d75a77b69052e-4801c88b9b5mr4759931cf.6.1745553881515;
        Thu, 24 Apr 2025 21:04:41 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-176-137.washdc.fios.verizon.net. [108.48.176.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f5bcf0dsm20764211cf.35.2025.04.24.21.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 21:04:41 -0700 (PDT)
Message-ID: <790260c8-09b4-96b3-310f-f9c5a93ef7ff@gmail.com>
Date: Fri, 25 Apr 2025 00:04:39 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] zbd/005: Limit block size to zone length
Content-Language: en-US
To: "hch@infradead.org" <hch@infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250423164957.2293594-1-seanga2@gmail.com>
 <aAnxqAv41Quh66Q1@infradead.org>
 <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
 <d683d1fe-7817-f692-addc-93d2fdab39db@gmail.com>
 <aApFcW-fsdUP4Ztj@infradead.org>
 <e94e55a6-a93d-2c7b-2c3b-8829ab53848b@gmail.com>
 <aApJWu1KLw7607Vz@infradead.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <aApJWu1KLw7607Vz@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/25 10:23, hch@infradead.org wrote:
> On Thu, Apr 24, 2025 at 10:20:09AM -0400, Sean Anderson wrote:
>> Because the test is trivially wrong.
> 
> I stronly disagree with that.  We also don't support < 512 byte LBA
> sizes to give an example.

fio already supports it

you are just passing a wrong parameter

< 512 LBA is a different case because there is so much both in kernel
and in userspace that assumes 512-byte granularity. But there is no
such deeply-ingrained assumption for zones. You just have to set the
parameter correctly.

Plus, smaller zones are more efficient at reducing write amplification,
in the same way as smaller block sizes.

If you really think such zone sizes should not be supported, then go
add such a restriction to all the zone standards.

> Yes, it would be nice to have a sanity check for that and reject it
> early, but no one is going to rewrite tests to remove that "assumption".

This assumption is very weak. It can easily be removed.

--Sean
