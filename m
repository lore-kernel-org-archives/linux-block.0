Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694CA1FAB
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310838; cv=none; b=AEd1VIh9UeNMsf98Y/AxkGiOYme35ZosDUiS2sgJx6RwBCWvv67tJdoFRucIt+bV8/bOR2QOcnVi8kr+jdU3lU/JfcsrLAAULBw4DevbVlU99I6slTumhjf+F8jN0cQ+xIxgkqC7v+YdNTkFOmnxnEksSC+KLKX2yxc8nHz9rdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310838; c=relaxed/simple;
	bh=uZkYzVZRVMCYpz+mzsZ1ALFdiU6r7O1qSRdFWdrt5uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3CKG75KMktpGN87WJBt4XL/YNhzMD71qv0XpoA0EQTQZwtOw4GV61RO9O3/sdqbGmohNcY6mdAM1Y4rYSoNcTtEnDURDbDspU4y+Lq8CdvrP+wJoiQTjiGru91gpk7wOe5DGGqIpTy1NIPrb6qGh4oiyNc0ua1LfqEr9swvg5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so1948588a12.1
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2024 08:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709310837; x=1709915637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4tAl8o/EZq5bn0YeTj7EYMSrlJ3Bl+m9X12avWxbvE=;
        b=Kb0ht9uMJd+LXyry1MJuxsjZZeEL89luFth13aIEBgyuA4J4xx4/jf+DeatMJxocBt
         yNWNEV5rDW76SBrUlLaYB9YKpq26UT1FMASx4Auxh/tUDNeUVUPjPhJNBUSEGBDua5Id
         6IaHkZXi3KcA2htXg43x1/O1hgsPHQ8+U6QetqIz+wCdg7i7ztJ7f1Ge891Jbe+UDT5A
         q4c1QFLTCDSY/wtEvaoOtm/x4Tydt+1wcH5kNA/ufwBhxBecphBP/tVSzP3OCCK9Y/nc
         XIwxj1jMyVj73nHO3LuLP5uc32R0Dyh0uOyVztJ2HwTn/fnEnG0d92LsnVRMdIQC9a3Z
         hL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlb66imcP8ClwVuOcheuYiDozmVX/J1l8k4ChsJalEkg5p3pjkpYSvMymdkDZ6AP8X5jdmwHR8IxD37QToTIVvT8v686ypZih3Sg0=
X-Gm-Message-State: AOJu0YwzwsR/JuZC2h3fO/KPrcOF1mnjEXrVgAcbUOcmsP3r2zRw5VsF
	zgrRfFDfCzZNSyrI3EJIKkzKvI0HiqzCI5+5k8xhdegBrnT8l+ycIwv3nhYnkFU=
X-Google-Smtp-Source: AGHT+IHdceNVpyQZsGCQCn1QEhLzR/NvShnqMky+vyWW6kRZoXif944dAjyAXytLg96tKLlrUOz+Bg==
X-Received: by 2002:a17:90b:11c4:b0:299:61eb:c75e with SMTP id gv4-20020a17090b11c400b0029961ebc75emr2153875pjb.23.1709310836533;
        Fri, 01 Mar 2024 08:33:56 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id sn7-20020a17090b2e8700b00298ca131c75sm5582786pjb.24.2024.03.01.08.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 08:33:56 -0800 (PST)
Message-ID: <399ee6af-c1da-40ab-a679-065aa82f41ab@acm.org>
Date: Fri, 1 Mar 2024 08:33:54 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report]WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
 iomap_iter+0x32b observed with blktests zbd/010
Content-Language: en-US
To: eunhee83.rho@samsung.com, Yi Zhang <yi.zhang@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 linux-block <linux-block@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "chao@kernel.org" <chao@kernel.org>
References: <CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com>
 <esesb6dg5omj7e5sdnltnapuuzgmbdfmezcz6owsx2waqayc5q@36yhz4dmrxh6>
 <CAHj4cs874FivTdmw=VMJwTzzLFZWb4OKqvNGRN0R0O+Oiv4aYA@mail.gmail.com>
 <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 23:49, Yi Zhang wrote:
> Bisect shows it was introduced with the below commit:
> 
> commit dbf8e63f48af48f3f0a069fc971c9826312dbfc1
> Author: Eunhee Rho <eunhee83.rho@samsung.com>
> Date:   Mon Aug 1 13:40:02 2022 +0900
> 
>      f2fs: remove device type check for direct IO

(+Eunhee)

Thank you Yi for having bisected this issue. I know this takes
considerable effort.

Eunhee, please take a look at this bug report:
https://lore.kernel.org/all/CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com/

Thanks,

Bart.
