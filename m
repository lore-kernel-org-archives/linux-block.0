Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5C1C2A3
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720247055; cv=none; b=u16BM3N8+rIC0wQlBZm+EoglWa2ew/pjmRa/AQ3cIA2k5MB8vqv1w0wSr/a0WEzsaNwJUzep+5qsk2aCC4TItX4nm1EorNldrf1biusgv6y5ijwZks+8WhugwuhfgaIUF3bzo9met6OGqKH0dEE22Obbcv/IL+oOgTFRrGRd4eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720247055; c=relaxed/simple;
	bh=JKse070+sS5qDKWVbIFCfU3xee3WglP9rsaYjbsPCGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoL3aWih5COYCTo8Gd0MrGtWUY0M5KXKmqw+0oC9L56iNYgVjUoV6G/HotmARuSpLd3vx+8iuxwRZEtokwI+VR5KwTt/UsFDOEsvtGLHIspBuAgIlafG5hk5E18VRQYADjSDcpGfNgD0oEyTrFSaoJf/wuNV9uVRgizXDNbxmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P0JOG1KS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P0JOG1KS"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-760df01858cso154652a12.2
        for <linux-block@vger.kernel.org>; Fri, 05 Jul 2024 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720247053; x=1720851853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yNowAKT2Yx4bsVVhZtPKWhVqvIPgWNNxysVwRFzN78A=;
        b=P0JOG1KSpgqCrAzIjNFXbTUzx0MN+4xBv0/tGOj/WpbfE+7enGyuKYKBGDjGIs07j9
         flFh1BvPJKT3rD68tYT3xN7eni7IFfXRWaue1Ms3C6bQjFPhto0zcg2LY9b1loeupzS/
         m9y9Dj8YufA8g9zz1tyiLIZHAV0tfrskS1f6Qh8nYgZEA1QDEfpxJQSQCq9nKjYMFG/q
         hTitjxoKMiGDcTpBOb+bgThrxEmx6WX13mNmi0vrywm9EUuu3DwMsbjObZpCYicVq8wn
         IVs4OnuiGmvI2lxgbOwHQbIkFS16P0Q2uHSWHicOg1j2TFcsR/LweqzCN6MOSBRMw045
         IhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720247053; x=1720851853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNowAKT2Yx4bsVVhZtPKWhVqvIPgWNNxysVwRFzN78A=;
        b=gn7i7KaLFIrK7jwAZIDsgAxBen4w4f+h7ofRpdjCmRbLdznrcKIDHGpPE55ngRSrR+
         tSUrCJ6SaeBLZA6fuyTpVtQy9JbV0MhmepZC1qh5cq/xcU2czgCl/zRguGzqq4FuWmgy
         OqdqVzlUyUzaoWr2ihDUXsSL+P9M7Md6XRthQNc8ty6RNq3UeXpix9PrVxbvKL6A9GzV
         N1xJdjRKHqn230feKVLbr20VtI+VkYgDbnIFJAs1itRpwhh7IqUIHUsCQ/tuxPs3Ph1Q
         VK/7uZG5w2Qyo/lovUf9yL9vRoatn7Dyz4wWlZcVIpwZeHV6VgTN2b75Lnk7nqqtkoin
         fdTw==
X-Forwarded-Encrypted: i=1; AJvYcCXVXWcFYMBlpm/wLua3K5ACYERd71ssanEKBbyewoeJnehjHqAosHt0xtxKy+BVQIxVg06qgNFzhtCORY4C/1twvMUqCh6M8DcMXHw=
X-Gm-Message-State: AOJu0YwNpI4KTr/kLTKMMyfw6t5AwZHFYJtpVGHl4xfWiZcvJXYGKaXc
	tRwYU5CrO/YhDW/QUlJh0Ze2EJmhjw5S9L7BHzIdx7T7di9zTZFADS1jM9gBhIXIJtHOpjHmnE0
	4jctSPr8U
X-Google-Smtp-Source: AGHT+IHkATLu1IOVXZo0JSeysD65rehYU+N2CceBVCaz6QV3RMSnuU+l7AFk6tgRwEv2nx+DTk2O3A==
X-Received: by 2002:a17:902:e747:b0:1f7:1bb7:39db with SMTP id d9443c01a7336-1fb3402a38dmr74437755ad.5.1720247052790;
        Fri, 05 Jul 2024 23:24:12 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c8::1011? ([2620:10d:c090:400::5:7b2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8b3fsm149983025ad.5.2024.07.05.23.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 23:24:12 -0700 (PDT)
Message-ID: <bfd407d2-64bf-4e3b-961d-adb51269170a@kernel.dk>
Date: Sat, 6 Jul 2024 00:24:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: pass a phys_addr_t to get_max_segment_size
To: Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org
References: <20240705123232.2165187-1-hch@lst.de>
 <20240705123232.2165187-3-hch@lst.de>
 <c2333a14-04bc-49be-8cc6-a03dcdb2eec3@kernel.dk>
 <20240706062228.GA13842@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240706062228.GA13842@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/24 12:22 AM, Christoph Hellwig wrote:
> On Sat, Jul 06, 2024 at 12:21:06AM -0600, Jens Axboe wrote:
>>>  /**
>>> - * get_max_segment_size() - maximum number of bytes to add as a single segment
>>> + * get_max_segment_size() - maximum number of bytes to add to a single segment
>>
>> v1 had this change too, not sure why? The previous description seems
>> better than the changed one.
> 
> Because it is used to also append data from another bio_vec to a
> pre-existing SG segment, not just to create new ones.

Sure, but then let's make it something that makes more sense at least.
Maximum size to consider as a single segment, or something like that.

-- 
Jens Axboe


