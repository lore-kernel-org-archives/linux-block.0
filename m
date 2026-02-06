Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747742877CB
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391904; cv=none; b=eRN9Hgjs5U2WakoGvQDy6lJrNl9L2PxTaT94gMllgtaj4V3wg6yrQDiXYAuJqAUSEIS6LENaE5ExIY6YdZHQV1I0ySKJ+UNNniTXhQ7wNR5zqkQ2i0OFNheW0p5EhRle93y13Lr2kDPM467P0ArBzV+z922Km6gPGz2UssuiZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391904; c=relaxed/simple;
	bh=FOZp+fKYICaywSOSz8HEGx0ClQJmII5sbhnSlZlsVrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/j9dyIQBHhKvgCWwbm2Ep+P5qpqekOqZYp89JItL/V0tabL4oDU+bYx76X2qscxUVNCJ8FkbYE/gsPqXu7Qe/T4McP9X4KVDUcX9OsOXalcH0ZqhM8L1St/70kv+RNhXDM9FkBJyVrMSIDAJKdxSkKpwuJQnRa+R1SvGwjpwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZQ/Je4a; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZQ/Je4a"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f454be5bso27386015e9.0
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 07:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770391903; x=1770996703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dtaKddwV2/PcA3n1ea+mcGd7uhw0cLfK+Ko2hhVKsUM=;
        b=VZQ/Je4aqSeah8CGvMEzBEpKIeoCyVrytXIA5k2WCQ4wzXGXvJzZOQEgeVcyw08Zmc
         8eDckuXUeNhi9YjbE+Gat4W4+ShHOu6VewHKTYZssULJtsbHIYiRNlEwpQ1KKViPGBAj
         7IGuNnzgqjjgzNE/RlHJ/yeRMDRqFVTc9cyRGD7qKiwewO+7bTpAe++Sra9YjR1FJSS4
         AfhF9QVSmViqGQV6jW832IPS/T+9MvQGG2dQbmb0Z3vGj943ZJ/QY9QsRLFvrTBocSDP
         BdN//3CWl1G3Uv3pifk3sFN/hc4ydykNR8IhDn4OIuoxi7hMPNS+Dc5PmI0fjgehTN0g
         ZmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770391903; x=1770996703;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtaKddwV2/PcA3n1ea+mcGd7uhw0cLfK+Ko2hhVKsUM=;
        b=D/bhfCJbN7dghmxb7s3qszQ7UIw5iUXwOcDUuI8ylxQQ2gaA6POOZu95hmwdwtVVHU
         f2cph9qUikDKVBBvubTkBdSdBAC4ObFHCFe6eTLwWRsPqdVQIYLvLzUdlOT3hTyWPH+N
         XZgnLsZw6RinM8Y5zv5HEi1BJpzelINIKNA7Pf+cIbbn8cm4bLaYONtAUKlHSakC7egs
         hZD5xGya2zxgG5VX+0D2DVFefS0r7ifvzAP12bJ+cGTygXbpTUB/Vr+2tlb6pRrQtDYO
         7WaaxRtdrQ8/yhAUo5XZBRX710fg2CPx1zbWzm+kvH42+ljuzmkLiJKXHL8wfWhdrKpP
         5eOg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ4EYWyfeiRsq0WeiPITpFBB7PQu+3VLhiPeqfJVrTWpgUR4BzwudCi1JwEVYSGHgM2WS4OBs6yhVd7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3PopUh1ze9Ma15Qs+BebZ4r8VwYle2BxEud5e+0SiRCf4Diuk
	/V5BF/XB0kgS6Y3sbkteA/qqvssS6bqxpG25bfGw4vAlhnEnM/Z+jLWQM7yusQ==
X-Gm-Gg: AZuq6aJawfMPuoCa0N9JeH6mUF0rlwR571zpY4gxWb0xvN5nkdzryNIdEqwA67ZXHwl
	V6c94PtloDR6e3/Y3A6T3gnHAiWazlqw2yQS/vRg5e/xXLJTl+BoWQyTwMc4fkDj8qZpy8jQkSO
	/zjTWvDbDHVByon1CvaFbEwfGvshiDjc9HDDT4aeZSOrwF4aIXI8WppSCAN+MX3yrHXcNNgb+cK
	CdhvZeJeFMLiJJ8w0H/OfYfMWQqYnHLpvnncDNPhYz9zyZoQAfSEiKaNWuZZBbLh5Jpheu4BODX
	3e8HdMo34grGtPGTYvXUVEh6EUDMsW6QNxFHichY1DONyuUyHdTAy9w1qzcAe8x5GGPQOpM7TVp
	Q/LC2tRhlAq+9zjBGHy7+ddPNTzGSF5jwSo12yG1CUZ9q4wiHaNVEDmgTFNhj/VNF9meDjnUcQS
	jwbWB6Pb6lAi44iYa3DOLfHQSUvbOvW+DTto7B
X-Received: by 2002:a05:600c:1f82:b0:47e:e981:78b4 with SMTP id 5b1f17b1804b1-483203d0b11mr47461565e9.12.1770391902702;
        Fri, 06 Feb 2026 07:31:42 -0800 (PST)
Received: from [192.168.2.14] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483207286bcsm55655415e9.12.2026.02.06.07.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:31:42 -0800 (PST)
Message-ID: <e1d39e41-b503-4207-91cf-2e94b159e4b5@gmail.com>
Date: Fri, 6 Feb 2026 16:31:41 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] sed-opal: add Admin1PIN parameter.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: jonathan.derrick@linux.dev, gjoyce@ibm.com, hare@suse.de
References: <20260205150935.238137-1-okozina@redhat.com>
 <20260206141804.278721-4-okozina@redhat.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20260206141804.278721-4-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/26 3:17 PM, Ondrej Kozina wrote:
> As desribed in ch. 3.1.1.1.1.3 of TCG Storage Opal SSC Feature Set:
> Single User Mode document.
> 
> To be used later in Reactivate method implementation.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/opal_proto.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-and-tested-by: Milan Broz <gmazyland@gmail.com>

Thanks,
Milan

