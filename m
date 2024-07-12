Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2844168B1
	for <linux-block@vger.kernel.org>; Fri, 12 Jul 2024 03:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756451; cv=none; b=Nw4Yowo6zgidydRMJJjmpHCOtl6qMNTAbGYWCvOF8mRuGaDfqlxkFr/IV3zENFWMXLmpFzY+Vuf5HJmInCwD8qoSAbX4ZbaK4bvlF3/y3KaYwUWzEuHUHBBN//70Rx6nXwEflPacXv1VLqOIn8PUC1fQlcCmRKiVzO987B4gqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756451; c=relaxed/simple;
	bh=Oywlvc41O/fZ15OgbUg3HsIF1kxs6Qcld6yz5tZjlCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGNez7CcoNgaHbdD6qlRvdZe4h9sK8sgRKZR6m++10n6EXfiAc793RB2jKL/1lHfNPicmrr8wPuWijH2UMtZepe8KkLZUVuFACE55vPN+i7stmuJsRvvuONspETpBR+qKZyYFIQd7BM6wNPYkCfhp1G+0/P3iOTPVt7NlkJJQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pkm-inc.com; spf=pass smtp.mailfrom=pkm-inc.com; dkim=pass (2048-bit key) header.d=pkm-inc.com header.i=@pkm-inc.com header.b=CHrzjI83; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pkm-inc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pkm-inc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pkm-inc.com header.i=@pkm-inc.com header.b="CHrzjI83"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77b311a4daso8434666b.0
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 20:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pkm-inc.com; s=google; t=1720756448; x=1721361248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EiszlIMmh6W5WfqcNN/QT9VWluIrTdOMcpksL1/8loc=;
        b=CHrzjI83JsW2/AuE4JQqxuxi1GCeyVPHXgAQyusro7o0cNAmdK0zshAF1e3oEW5KEY
         vKrIQoRw9h8Sfc3Oc9X+HxwwmyYdLhs6F9SpCfnQwojVYAIRAA0MdDuqUimOk/9TmOXs
         ixz6T3hoPoNFkWo0P77nvfsqpoBsTvgSQSNO4oFvGn3x455G2WIMisX6/ZgPAz8Iuhdj
         dasK0LMvTmkABd4vTLmM+YHASrqpgwC08/jY08bpUgwmXB3Ri5TtDYTh9osUAMgTP8c9
         k8FSMoqfitN2vpj+OSF2GweczdizQcr0wDh4Teoo7kq6gBorBQzTldYcrtfywVJzYisP
         2ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720756448; x=1721361248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EiszlIMmh6W5WfqcNN/QT9VWluIrTdOMcpksL1/8loc=;
        b=Q5rFa6wwImjMBEsUGOOx3sSE9LgONuCHQbeVWPR2M8MPw7uiNAWqC0IUU2gGRSuVQy
         OG99OTNU6TT4NAlac6NLYmg51q5DiEL3GcfS8Eag+0GoGPNgHHI/ESsxg+Ls+1LyJNC9
         U7bCjo449Pc4eAbnwnDFxw6vt8kGm7dKESFTV51PZ6EqOHVE/+yGdgpS8d9nZx3nmFL6
         KXXX9Af+nBJbhiKYq87ggDp1FElqpXEzQhn+g5Hv94A7NmpfXQafuqNHN794+4tb48PL
         hy7bPnT4PegfYHmnuwIOMQoUgiQPMblUDFUmSWLoaBgM7rUxItqy/alEXcQX1FWFTBP5
         vmrA==
X-Forwarded-Encrypted: i=1; AJvYcCWvXNPPwHr7zM3b80kSswEXWOqcB7O9icO/OK1co3F8+uLwoyFiF3LQRx1IucT6Wc582iytJJ4qcASN1lLpgHwWt2aCpDAI0TEny/M=
X-Gm-Message-State: AOJu0YzLbgwzUiqNj9i12ereVec3dnYPPtfGc7ccbfI3KEiyyT+WPlWt
	VC3SrzJso7cSTQaGA3XReCYeRe1NHbVLgR0O8MPXTd4VKUVz+vM7aL3PEkDiU+7sHOVEcbqMoYH
	Ysik=
X-Google-Smtp-Source: AGHT+IGxkEIyhKXzPo0M6Zvyu+W8hbsXRGJ6rwe60tOLQEueZg+jdx48+DugAfVnS6bDG1ecm27afg==
X-Received: by 2002:a17:907:1c27:b0:a79:a1a7:1254 with SMTP id a640c23a62f3a-a79a1a712a7mr25729766b.10.1720756447885;
        Thu, 11 Jul 2024 20:54:07 -0700 (PDT)
Received: from ?IPV6:2001:470:1f1a:1c9::2? (tunnel923754-pt.tunnel.tserv1.bud1.ipv6.he.net. [2001:470:1f1a:1c9::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dfa4esm307811566b.61.2024.07.11.20.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 20:54:07 -0700 (PDT)
Message-ID: <7c300510-bab8-4389-adba-c3219a11578d@pkm-inc.com>
Date: Fri, 12 Jul 2024 05:54:05 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to debug intermittent increasing md/inflight but no disk
 activity?
To: Dave Chinner <david@fromorbit.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 it+linux-raid@molgen.mpg.de
References: <4a706b9c-5c47-4e51-87fc-9a1c012d89ba@molgen.mpg.de>
 <Zo8VXAy5jTavSIO8@dread.disaster.area>
Content-Language: en-GB
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <galileo@pkm-inc.com>
In-Reply-To: <Zo8VXAy5jTavSIO8@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/2024 01:12, Dave Chinner wrote:
> Probably not a lot you can do short of reconfiguring your RAID6
> storage devices to handle small IOs better. However, in general,
> RAID6 /always sucks/ for small IOs, and the only way to fix this
> problem is to use high performance SSDs to give you a massive excess
> of write bandwidth to burn on write amplification....
  
RAID5/6 has the same issues with NVME drives.
Major issue is the bitmap.

5 disk NVMe RAID5, 64K chunk

Test                   BW         IOPS
bitmap internal 64M    700KiB/s   174
bitmap internal 128M   702KiB/s   175
bitmap internal 512M   1142KiB/s  285
bitmap internal 1024M  40.4MiB/s  10.3k
bitmap internal 2G     66.5MiB/s  17.0k
bitmap external 64M    67.8MiB/s  17.3k
bitmap external 1024M  76.5MiB/s  19.6k
bitmap none            80.6MiB/s  20.6k
Single disk 1K         54.1MiB/s  55.4k
Single disk 4K         269MiB/s   68.8k

Tested with fio --filename=/dev/md/raid5 --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --runtime=60 --numjobs=1 --group_reporting --time_based --name=Raid5
