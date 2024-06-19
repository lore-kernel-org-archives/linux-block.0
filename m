Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0991812FB37
	for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794436; cv=none; b=lAjsr5c3/es7aIWw7f4aa+kEEoybaGA1Q8caZj4Tk9EoWbz1N3KvJVWIKQO4B/Ek4wDFba3gbE7IxNw/3DEh+kXH0sAd7lAF2tWrRFUKCluHswqoMdA7Wn8jEetb+sFwYkNUwUwnptiePvUkHCis8FuGcl3NqYd0aXtZWqINfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794436; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQzuikbLR+VLW2bsoeHlnw8MgHTCKgYdIhmA2/g0zkArub/vLaeZJw2jFrdvo0UuYU4DQ2AUmdd32WGW5RSEI0aDSnybjcX3r58KoLkah6/VgD+PfulOSz1w/Mmx2E84nXXO1jIp3xeG0Hq3Epjh+KMAGykYCfoxp0CPmu0ECEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c82bea25fso901943e87.2
        for <linux-block@vger.kernel.org>; Wed, 19 Jun 2024 03:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718794433; x=1719399233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=LDP58m0rb6LN/NtkBwL/Rrqs47Fu36465NPw239ULxbt2SFr02AhLL7Nr3ZE9KgUnx
         XAO6wqUpIKWahQkMC9fso1N3t7ZAL76qQWyJGb/19aL96Q7J7YJlQm1sAus1WmAX9LmJ
         g5FgtseBGNU8oRn6+gEtL399x4NHTZxkj7orlJLp9IrSrSP4aq90eR4SCOql9XbUASyy
         4d2qfQPWCLD3xQVioEO3Xbqn1curGMiLoUo93pZv5JoAAaBP67pHZeAoxCHmQANbsSi1
         SVF1Tz/ob8TKShTisiLxzKW9JBwVq+k8zKEgTx91zEEZCk8xYUnIE8jQMzFppmumrGOP
         KpUA==
X-Forwarded-Encrypted: i=1; AJvYcCVCJi5LtSrroE6Pj4WXyXXzTDNc0eHLpe0HHZSF5rKtsGgzwv7FvDmlaZWSYML86ncVLcFU+ptm1ABaoggE0RsFLukQ18pDHBdW7Rg=
X-Gm-Message-State: AOJu0YwgU3ULGZbOeGmb9D5lG3m3eF3z4a9gZzfV+52rK824bw3Gn6Ru
	UjIigtRNeqIEjqU9AHsbhyKqxGV3pF/oQZxet8+E1qu45nFbAgFP
X-Google-Smtp-Source: AGHT+IEetUrZ1T30ANSPYnS8A6L58+q9UHO8TWfOeEexUWnhNKarZDwYihTQn70QXrVZADkwHmtmeA==
X-Received: by 2002:a05:6512:3baa:b0:52c:a88c:1db8 with SMTP id 2adb3069b0e04-52ccaa59183mr1425786e87.2.1718794432956;
        Wed, 19 Jun 2024 03:53:52 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-364244948fesm189269f8f.61.2024.06.19.03.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 03:53:52 -0700 (PDT)
Message-ID: <4677b042-3d82-482e-935b-7ddbce2ef0d9@grimberg.me>
Date: Wed, 19 Jun 2024 13:53:51 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 blktests] nvme: add test for creating/deleting file-ns
To: Nilay Shroff <nilay@linux.ibm.com>, shinichiro.kawasaki@wdc.com,
 chaitanyak@nvidia.com, dwagner@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 venkat88@linux.vnet.ibm.com, sachinp@linux.vnet.ibm.com,
 linux-block@vger.kernel.org, gjoyce@linux.ibm.com
References: <20240619104705.2921801-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240619104705.2921801-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
