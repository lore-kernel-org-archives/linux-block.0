Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFEA2C6A3
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372177; cv=none; b=Xi5///TlhBonpkVto3NUX4NK/C5uFSxuhgp5KZY+xWIRt2aLiuZDFC56A9B2BEyLPMjpku3pHdu2QZK6fdo7BVj0TC6rzkTqtS7Qh6CH1tUJ6vCVzgr5Pf/MMUlQurKxOSUz4rhgiRdAfUPCjnN7qT0nFfMHKuTKXnMpQU5iJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372177; c=relaxed/simple;
	bh=KbVX5/WJLt/Z0+uhwnKhCH5C1tCBFTeakpeppFQXWBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOE4aSr5ibJe61dghr8dTS8kjDl/jwWO7Ig1LBf3WtmHosi9ncosbscMUVcLIlR442Se0ZuyJOpJV6nW6ye1OBIexJbKr95bummLEJ+Xjhoj/85LM2XzxkkmWZwS5DkAx07cqAlMm/8XsvWyla4fMmQRjw5sTCDA1M0RMD88MRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aEX9Rwe/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEX9Rwe/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725372175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1T7shADQQm1E7ZhQRMDcUIIeoOERk2k982scWhmF05E=;
	b=aEX9Rwe/Wo/5sR4tawJcmvkvr0aktBDy0u9KBjvmfpnJ90LtW1UrsQ5lZTY+0doAdLVnia
	Gc1rhwG0SQqUyPL9COpj9bf0zA+Esr+IX/HLZlWWuFRJhfEVqVSC4hNtnYT4v+MdagX/6w
	qNcutHRrhX8077noELHyEc0t7BZ7o2k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-a_HdLno8NnS3iy1JBhqcLg-1; Tue, 03 Sep 2024 10:02:53 -0400
X-MC-Unique: a_HdLno8NnS3iy1JBhqcLg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3756212a589so876517f8f.2
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 07:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372167; x=1725976967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1T7shADQQm1E7ZhQRMDcUIIeoOERk2k982scWhmF05E=;
        b=R7tk0QLByZGt9fAuB35tiXh3xnB1qzr2hKcXt9Nh3uDrLNbcE/XqaOQp2ZTr9Xu60u
         dToSsMGPugxRbtMdUFX7vWVcajX2/0qUmwVE/o7d6bSXpQn7s4hAWVnvw7Ggx94GT69T
         2gnZEmK/vbuSQt7YIbMbZhpfniPYIW3A6/40AhPFDmA+kzAhTozw2pZyc888ojrxVY5Z
         CDyZxap87EC6VkLK+2NUKfvOdRv57aRLGnbT+jk+Kf34nkyBpSh3xDi4mgd5whuBdL63
         Q6oUt8P9+suMQoX90cQKsw4WhWorIjreuRIn94ag+Mp88pNpBVvRKgkl76BE18MfKLQE
         k9yA==
X-Gm-Message-State: AOJu0Yy4537XMVGEF7p3iFBbFPL2+9vCkQMxrCrWsm/3JZxzz6yYyaN/
	wCpohPZ4d0bhNTQx8K+cuXRovw9tGHWK8PnwroxRYlAuekjpvsm54kZJ1pqdBo98YFzLwVJFKLN
	UZWojlDugc/iNkiYfokQdzpcOFYBzdARCZJqbVGBQuc7o49VkebWH0riRs//S
X-Received: by 2002:a5d:5c87:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-374c8eb9b69mr5013787f8f.24.1725372166725;
        Tue, 03 Sep 2024 07:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG+gCA4emCQ8lN+v2r+4PD0Xf7gtP5260Hobybyq26ysa18Yk2eN574I3dEkpcvY9bhrHY7Q==
X-Received: by 2002:a5d:5c87:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-374c8eb9b69mr5013434f8f.24.1725372163170;
        Tue, 03 Sep 2024 07:02:43 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm14372770f8f.50.2024.09.03.07.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 07:02:42 -0700 (PDT)
Message-ID: <c5658b79-f0bc-4b34-b113-825f40a57677@redhat.com>
Date: Tue, 3 Sep 2024 16:02:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] ethernet: cavium: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.g.garry@oracle.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240902062342.10446-2-pstanner@redhat.com>
 <20240902062342.10446-7-pstanner@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240902062342.10446-7-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 08:23, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Furthermore, the driver contains an unneeded call to
> pcim_iounmap_regions() in its probe() function's error unwind path.
> 
> Replace the deprecated PCI functions with pcim_iomap_region().
> 
> Remove the unnecessary call to pcim_iounmap_regions().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>

