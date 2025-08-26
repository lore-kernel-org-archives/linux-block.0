Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B5352FD9
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218501; cv=none; b=EQNb8/Gmtmry+tJrWpo/CzXXPOMDwJABwuBK63YesfiJwmYHKtZML1S61YftKqNngxH1kFR19/KmI4n7V/2kyzJU2O1FTi015aZnxSo7852DYOnoe9guAa0tFqZC3+z6QPM46Lgy4CKCv7SVapGyfQhyBsEbXt3rrp/fRLUxtB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218501; c=relaxed/simple;
	bh=P6021VZBD+BnnOsxeb0EkJ56RWqupt5QR9uLHm0ShHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHsONT69OfapWpzmukA7D0mkINcD5GOlBfR9QAp6fqCuvyZvNf0TSNuGmQKqMyArzb6vsH6aR5UuqM4ImiKSe3b2K8XqjVrrojpmyVFgysfNl1+ccvJ/Ezn0DKd56klqaf2kts3gH7iaJhFSI2UzPCzRANs2855zq/e7/7zoM/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pNdkIbh5; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pNdkIbh5"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ea8b3a64b8so36630135ab.2
        for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756218498; x=1756823298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Dn03cfTvDWj48cfCXQYJCtc325XbPN6PN8Ow6iRCMI=;
        b=pNdkIbh58B3t0eb7JBwq4biwMUoyIt9RH1brJUJ9CElCrWtZY3/SNw3bX6eEzvU89B
         /sH7kFJpc1gGaocxTyNUNqODkHITfKRNYV14M86dED0mdF4XEisMUVOMIscHIfjqiihB
         Lq5/RdWskOTxV0LfCgie4p4mOwW4lJx/NVghmk6eNnwLRvJ4pP3a6OCDpTV+rV9nj5nR
         EaCc4z+90CmTI93BY4DI4yDvIOz3+r0ullT1JGEeAx2mnt5W//acD3O1C9JAsIBh4eew
         uXz9ah475JEPyEw7A+bjXpr4z4fz86JIlAS32DrixgTDzGMtiKDNlHlbfIy0ZUYVmzvM
         ebeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218498; x=1756823298;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Dn03cfTvDWj48cfCXQYJCtc325XbPN6PN8Ow6iRCMI=;
        b=l0z9SnklZmwcWsWSDYZmduHzH08En2UHpOEuaSGTEqZ5u+ZFmXnpyP3kYSpoGOrUUy
         URHGcFA/Dz7LJU4e+BNSzPthhTDivHYKru8i61iCeSjtDiTx8CA/DOYjUqfCOb8y/I1z
         qCtjHPasv4BVP+ViE54wI8rtFJDfXWmyqeV/XGLCJyamTvqw90gZDRVW96/Bf1o+CiKy
         l36vMNBHCKrFQTiyHNQCLSDdqUHBzmJrVfdCEf38mIyMtsC2yNrOHAi/rJr478wvU442
         5gqDQ4xwDSNSdUMUR0mjWEK975cyoP/JYyHk2Oh+aRFFWVTcGSiOuY3yylMpXCkqZHJz
         rN8w==
X-Gm-Message-State: AOJu0YzC70jxW+BS1jAxq+DIHz/wLrKxu3WmEce4Muyz6jwoXlGAPMjx
	Y9BB/O4gkjA1zcChQZzF9yXQ3DFvMG1rs1j8gix1KnNz6DkLf1el132u/E0S6oOsp+X+Pb99LuN
	Udeav
X-Gm-Gg: ASbGncs0ujixs81wlyvgaoQs5MUYP7aYACBzQKUuVa9THk37R0himw3p/OVeTfuealn
	ivzA38mbdBwhN7SlR/p1vhKgGlzo9SBSdRLGYJvJ1dXPDdm13pQB4Jys6JL4544WIrLKsjgLZLR
	f3/7Zw/eYNrzDwedzo101H6cW2wIdjK3ImEGuEB6M1Y15ZF3Uz3TF7RSPq6us5ACXawH5kFfW86
	V9vOcxnmUpvlGK7Lwb6F884WaI9YDUycnG0vqUMHZ/FVsJXH+SHKxGKswVE6V8Fht2eVsdw8XCq
	R0Ba7TTLdoT4CsLTwtX0fnXm1F2PfXw8CyGq6TWooEMeIIAlTrNg+QTW7dktOw1ddOSLtLz1ewc
	B/AchtHCy9j6g+jRHeV2EBzWR1Gn3/Q==
X-Google-Smtp-Source: AGHT+IEPbdh9t/BIF3uZsCsJ9oeH05EfajzsDhtA8YxCN+HMh3fbtvav8Xd9kFF3PB5oNYvY2XmJxQ==
X-Received: by 2002:a05:6e02:2192:b0:3eb:9bfa:b6b1 with SMTP id e9e14a558f8ab-3eb9bfab7bemr65788325ab.3.1756218498267;
        Tue, 26 Aug 2025 07:28:18 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4ec1f9c4sm68760295ab.44.2025.08.26.07.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 07:28:17 -0700 (PDT)
Message-ID: <33b19b5b-0697-4f49-be20-cd8094404c04@kernel.dk>
Date: Tue, 26 Aug 2025 08:28:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-zoned: Fix a lockdep complaint about recursive
 locking
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>
References: <20250825182720.1697203-1-bvanassche@acm.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250825182720.1697203-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Missing Cc: stable@vger.kernel.org

I added that.

-- 
Jens Axboe
