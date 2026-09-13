Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B872BE7A7
	for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789330377; cv=none; b=QPKXi5COI76MMW0dPvmoQN9Uk3FkcOv8Ud8WoRIS6XicfvU5r6C4Xn/cPBpKICKrhhv8h+K0dadyAQ79SxzaBtpKxl6PWIbFFYGO1R871urizscXseVl21taL9KucFOiH1Br1SxyHmx48wjs7ahTADxE0KFF4iCyzvcLB9Z6wuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789330377; c=relaxed/simple;
	bh=k0GTGV5zZqW8e9OqkW6QVLzZ/2iogaea3tj5Guot4+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QD42cxnSr7y1BoES9+jbG88nwGNx/cc94/cBm9A1z+6vMaybUt3XiINfVXK6Qkpe1nLjJLJdtaGMFtNcz+Eu3dlkuYh5P5DNdYVKrYAQmRmdgNavlwTmGzSYPsfmPO60mf/UjQIjFvEfkxWVUAAOxh/6CWUeYXG3gmgWQUHFeos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=gQoy7Xrn; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=VuwJdDoe; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="gQoy7Xrn";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="VuwJdDoe"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DJ1UW9445928
	for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 16:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=bDqM
	F7VA0MJ0fYRBYzcGOJXnsLMvTFFlZbyP/iQRyvU=; b=gQoy7XrnrRKCEEGq9c7Z
	jd8jSDobtRDd/bEy8dimQWvHSaJMnvEiKRO1u+riGDJoaW0H+yBjyHfqcBzmT41u
	Yjhd+kLsKL04Ip9Ny6gN3zdz1+7yd+JDyRBGXvWJ7yQZACzLJ8xPPOrBnCvbjACZ
	hen0JjAtM6PbslsAHNBxnlPBjBlNVt6GAi6rqPBWf8MjPLMx24eDcRl4NYqPblH2
	yeGl0rpo/e/cY2XR4Cv9NFuhB0DmpvYPkPw+4XzvF/E5lD01jLd8as0viLJiIJ2G
	Vnlm8vCrl6cMqjqq/jSTo/ycUA0Oi82kL+4eagyF+ofbdAxHkdR5q4sQHTk2z32R
	Iw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gnwac9ebt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 16:12:53 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a0c7126e7so182852985a.2
        for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1789330372; x=1789935172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bDqMF7VA0MJ0fYRBYzcGOJXnsLMvTFFlZbyP/iQRyvU=;
        b=VuwJdDoeM8b/k1uDMRzOOpcg4oaCzLaCZSbn/3aDPtSIAFniFee+NnnsaWUgDmBWcX
         biNEWvRASr05JanoC0xWGcOXDZpkJEQgleEHSpVffx5tzWW8OD2QxGLJwRLd2s5tvszs
         F29xfcyF2o7+bRkXmgZOXoCvOLmcN8ScC/uTp9NLe+HiBYfs9WTxNxR/ai0gzBNLXkPt
         Lxos1cNBCvLpAHFpCkz2Qx/Syk8z4ZD0whwZZktIVr3A0myDPOtpGhi02VVDPT5Rz8Bk
         l5AVmobuZZTTUoBYWEBmjV+sOtaho43Qq1b0gZoj37/OzquRQga8PkBJxqIsduAWeil3
         OygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789330372; x=1789935172;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bDqMF7VA0MJ0fYRBYzcGOJXnsLMvTFFlZbyP/iQRyvU=;
        b=qWhbdGNWcOYqi2PMD7jDI1UUTSzzepqaoGb12g/m4zhAi6ZFLNvb+Mv46rlLDUvz8q
         /Jdot3FZhI3iLIPEZC5XO5I5t0y4HJGSt6MDAm1RkRZ5KWNckniavy2px9kZcaiCSmZS
         Fzto1Gkx7jj1b54vDmUiFnAb8gnSNSwzjF56T1VCPeb1AAae5Aqrdl8qhHtJ50ZhVFTq
         qKL3ymwT5uqWUH3CJpsK6rWIqyFBkfRTCsuaLWB3Hgzp0Ufgz/lVNOwiOQAp7XtCcUJO
         LsFSLn2YgdQoZPbvicX/KfyIhMZVXtwSxNkbMylPf8ICYoM/1PwEksWdSw9Ahxgt+9dI
         sT7w==
X-Gm-Message-State: AFuF++m/NZU9OnENqudcd+PIFjEJ4ZpbQEBxJ/MOEhQrJ0qRaW8o2USh
	LCKTWHbChCX60mZjaM2o+5OfnfVwRO25wjEi3WOLPibT/7Vo46DNDffx1qYYqSBApJhY0nCLpH1
	qKjhfw7nB/R3eCOiFejxCH5OzYZj08oXk3S3StpU5lcXDWArzp5CiUmZLRC45
X-Gm-Gg: AYBFou0cHhVCeKukatqJGH+ogxDaskUKuZTOHPzy2WN3djy4NY6Q2Kt6pxPJw3UqvKz
	yrWkSKxpYVH+dgX3ROXZojdkw84R/nikiHK+pfPZ8h2meNcW8ZLACY4PgoSPcPUj1RHAt8CinLz
	npW0sRy2d99mP+YBKKmLtXEbkc7a+l+qqOStK+KyLaf8Zy67nFCUANG7daEaeOflDm2LB+F+S4G
	But6ItlTwv6bjAUa/GFOVMnATwLd0E3P64c6K9A/lzN2Zi1wprfAnAPiogcKZXIPWT/oiThyI/d
	+0K8NZPPfnV9pzm6kpCY+i9vXVr8cGBbkJhd6bF5m4Z1bIvtRvayIL8ZV04g4O61VIyH6ZmxZVy
	bQ1TWG+gLbQyIKvnSfm/ffybWAwcnk6KESML6hvrDQBqbl5e7o8qs
X-Received: by 2002:a05:620a:40c2:b0:937:6832:1f04 with SMTP id af79cd13be357-939ea22aa00mr2003301385a.34.1789330367740;
        Sun, 13 Sep 2026 13:12:47 -0700 (PDT)
X-Received: by 2002:a05:620a:40c2:b0:937:6832:1f04 with SMTP id af79cd13be357-939ea22aa00mr2003296885a.34.1789330367325;
        Sun, 13 Sep 2026 13:12:47 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-179-215.net.columbia.edu. [128.59.179.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d89f9sm79149266d6.47.2026.09.13.13.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 13:12:46 -0700 (PDT)
Message-ID: <64febc67-75ae-43e7-8b12-6f9de894e66a@columbia.edu>
Date: Sun, 13 Sep 2026 16:12:46 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] block: remove dead metadata handling from the
 async direct I/O path
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner
 <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
 <20260909-blkdev-fixes-v3-7-1a5222c6e8ad@columbia.edu>
 <b6eb9cd8-9597-4023-a2d1-7bc0f07f68b2@suse.de>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <b6eb9cd8-9597-4023-a2d1-7bc0f07f68b2@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BqQIUoX5 c=1 sm=1 tr=0 ts=6aa703c5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=2jelXx5xVcRIF5zNctN5Qg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=wwJz1-KtMk0lVk0rRkEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: f8_2GWxKTSYWKxWAI9DjygyFHIv0B88o
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI4OCBTYWx0ZWRfX7+Uj0sXqDHZl
 IjNhX50CzA1d2FOhxFyzi3x+HXUEeD6Be0239g0DApcT2NFWH+fVkgBGEIe0+eJr5+0WAeH4Z1t
 pMxfRfNoB5HwitLgokdI/4DGw8QF0ir0eS+fC822PGgU+81DYRTx
X-Proofpoint-GUID: f8_2GWxKTSYWKxWAI9DjygyFHIv0B88o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI4OCBTYWx0ZWRfX6295KBYgx0c9
 5ZTKBtl34P+EPyG2bbomIoq3bFhoem8RTlL/A9ltn3iw0tjaKp8lkMIh2LHacJ9Rzop1ZNvntKj
 2WWriCmUONo1JWxvXASNqjttq/GESYgypmkmGO9YaNPIZTkfhkkdKTD2WBOv3xgkfPTYs95LAK2
 k0zbLGrb60rCKu4zdF7DHT/M25l/gi7juUURT8b6Ezd9R88FxZKXKO13DQmx3/PbjdDEkhqszkz
 pEAgp2IVh2j9BGl21hGV4oRmOQht9qcuUR3N9TnFyNGkA6NkSkMABY47SvykiBiOSEKRhw4Rl8z
 /5/KG49UBwXbQ3vd17ltRZmoIY3ELlBDjHDUkhyUyyQoPnGUWsfk7EQ9cqtqHCDia1DMJxPT9Ve
 WEyrf96HMFC1HIfHaiydXquutz1hYq3Mh1q9AiG4pTPLMc0txm0S0HCHdvjTYpP7oymKwalXf8i
 eQYcux65e3FsjgMNtOQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11904
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=10 impostorscore=10 clxscore=1015 priorityscore=1501
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130288

On 9/10/26 6:40 AM, Hannes Reinecke wrote:
> On 9/10/26 12:05 AM, Tal Zussman wrote:
>> Since commit 2729a60bbfb9 ("block: don't silently ignore metadata for
>> sync read/write"), blkdev_direct_IO() sends every IOCB_HAS_METADATA
>> request to __blkdev_direct_IO(). Remove the now unreachable metadata
>> mapping in __blkdev_direct_IO_async() and the unmap in its completion
>> handler.
>> 
>> No functional change.
>> 
>> Assisted-by: Claude:claude-fable-5
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>   block/fops.c | 10 ----------
>>   1 file changed, 10 deletions(-)
>> 
> Maybe a 'Fixes' tag, since you already referenced the commit?
> 

No need, I think, since it doesn't actually fix a bug.

> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> 

Thanks!

> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> 

