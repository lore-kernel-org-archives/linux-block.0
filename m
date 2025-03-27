Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49331F5608
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 11:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076656; cv=none; b=fVGKL44eMZca5xKU/hCjL8rOSQv+ygGMy8DzOQZApuQ7WuIGMqcudM9ctRjg78OGLNe1n1e50ZrVeZV9z1p1MWeoziAcBdOXY6PJ9qkEafggpv4dEDBxc95rvDa4e7jwPNZs44D1obsl3vYNp/Z1G8JH0QXFnk4PEUBcsNwXLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076656; c=relaxed/simple;
	bh=AL7gJ87a2UA6E+40BaZ+E4mdcf+6HZXsmDjrJ7tBF8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/K9kDa3mKkNEIY7iO6D5wBywIFdnlDzvV3c+0Oa4UE75uJ5VDScctioaQnO09b5OZT4drF6ZJFdy75vjIX5aqEthlWR9e1G+8XCEl9/xJmyatmrBiN4YTxf9cahktWG0PC6fOm7F/pYF6wpMTf+TTuaoJBTz3GaPw1aflYLqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KdUG0aH3; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KdUG0aH3"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso13907366d6.2
        for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1743076652; x=1743681452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpSvo5VpDe+5C3l3q6WN5wiD27fFfcYVq0S4jyx0P6k=;
        b=KdUG0aH36qKf4ZKce21gUhCKT3ZUf2WNoOC0rZa2gRbutluZ0jCSFAmnnC+61A2sd0
         Njdrt1Nj2fXg43CLfCF44LW9ef95MhDEJWEEmBMehuOBXiRYdTiM30rWbtrMY/aWEGLd
         rYjBgTZlgpvZjm8HkNrGAcL/EbG9VgKscRinhah3bTwjaG8M50uvOVXNokIPSnt+2lkx
         mhlCuyeeTnoP/Xsk0vjebjmQA7seF6lSHIkFYpP3gnAknC14p/N9vvbD+gURC8OIj2bA
         LqbmNtn1g9Wn3vq/xXgwbUBfBwXSqyhktBciKekra4S/rYXgxaWVSGCpYbJtPZPWTipD
         /eJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743076652; x=1743681452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpSvo5VpDe+5C3l3q6WN5wiD27fFfcYVq0S4jyx0P6k=;
        b=gUD8reYKJn845yWfNoHV26FD5JGNiaq9XXoE1hmFszBrA7CxsH0Gi+VCIWITKftEov
         08v/q514dIDy/QlVREgRgQpEvDAXrKS00A4ZOsF5HMOQ9wWloSMdoRHz5X2MSmlMdxJN
         RvWZ0HhnaUHT3RPS/tKr5HXl4pr+2lDZ9FrzZKjluMn/Nrf1jgf64AJS/g4ztbjye+q3
         4D6rNgpvSih1ee1cvl7DZpaPm3I2Q6ETJYaukVnAqlz+XGiI/+1F6OTcqVD8swOGqnjD
         mmAuThbDsIFDvZLCEYP/56Vz29+KRj8aENBtgi+lWdEz3V4q9jgHO9pwdgF6djXChNuy
         7xmg==
X-Forwarded-Encrypted: i=1; AJvYcCWvl9u/I6XhD24b9CAoFJwkDaszwNrsNjjsz3YrJ40AP9xXOZH1Is3oSII6ZLugVij566vRz0hgcekBFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGk4f+GW/x5IFe/oQZ9AOs9AuGdZdUCFIgR/eTyMjpDc3y2oO
	xek0zQm8gSAgNOJ0uL64qCGdJZaVbdktVSxLTMfj88T5lE4J+jyjsz2UmUePj3w=
X-Gm-Gg: ASbGncuY9i1I22dnvQUOG2d40tZ07+Lu2ERveLxqmt+1mTlfUV2/r7QSQPc0mbNbkx8
	lXqTRJ7/sK8Jx+zYFA0dF4Gln6koss+7YgUC2ULHtnt/Vh3QPnhj42ABRKL2FyX0/PpWXJquMGs
	M8W/bn/9Qis/Ix73hF4Ly2KkuUcUDkPao9trr3G1jLJbGUcbcyzWYUm38mXczJIcWYstkFydLnU
	cfDGXuH2FkOA0HA/8djSputsOhM2szM6ByWyObZaxN8T3eN2HwmyLvuVM/tQnWasE5C/JdoxkUH
	MgIzP8VOtasLEKm4URVP1sHXC4x/KrQH2vqjLe0=
X-Google-Smtp-Source: AGHT+IHXYc+blwEc+1Jk6K0qq58ubOvP6uoSjfLzJ99a9D1oWzuzwHQ5UPYlNMHK61Rbx4L/GoX0BA==
X-Received: by 2002:a05:6214:19e1:b0:6e8:90eb:e591 with SMTP id 6a1803df08f44-6ed238b72cdmr40938446d6.24.1743076652436;
        Thu, 27 Mar 2025 04:57:32 -0700 (PDT)
Received: from [172.20.6.96] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3f0003c6sm79108206d6.120.2025.03.27.04.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 04:57:31 -0700 (PDT)
Message-ID: <2853aff5-9056-4950-a796-d3e19a0f0c5d@kernel.dk>
Date: Thu, 27 Mar 2025 05:57:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtip32xx: Remove unnecessary PCI function calls
To: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Philipp Stanner
 <pstanner@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Yang Yingliang <yangyingliang@huawei.com>, Zijun Hu
 <quic_zijuhu@quicinc.com>, Hannes Reinecke <hare@suse.de>,
 Al Viro <viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>,
 Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250327110707.20025-2-phasta@kernel.org>
 <20250327110707.20025-3-phasta@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250327110707.20025-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/25 5:07 AM, Philipp Stanner wrote:
> pcim_iounmap_regions() is deprecated. Moreover, it is not necessary to
> call it in the driver's remove() function or if probe() fails, since it
> does cleanup automatically on driver detach.
> 
> Remove all calls to pcim_iounmap_regions().

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

