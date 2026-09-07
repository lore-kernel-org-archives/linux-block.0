Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21DD371072
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788822934; cv=none; b=dUvzMHoQL76RCsPlqCow+gK6KxWmr336fzh5vBFvqPeYt6DF6KMTZaq4w4+NOU2hRflF1CklbUoZQ4W6ku66Jplb2CVN/yTfXbgawlVnuZV9SOZ4Ekjf6asIp1rRKLnesTqLpNAJYIBX6HdgLDnxDWEtyElW3a2fHp+iFi9HaOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788822934; c=relaxed/simple;
	bh=54FYdvIVoIC0Sy6F8zRr3jxj3oRCQFRwcuYEnCT1ZuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niRZnP6KZ345BfX1e875a6xJhGJleVZ5/bstyzHmSzQUokAZXYlc8cphl4Hpy0J/iUMnYT1wHGfJds30NP1r9G+nDp+an+Yr1DYZFZP//qFM1Pvwq9p3EDhwwNLWe2SS3JwUotRRMoeZi8qkqAHoSOv9ETB1XI8wgVuTxXdXCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=sc2ISMqt; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ywbKUdM2; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="sc2ISMqt";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ywbKUdM2"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687MY38k3185473
	for <linux-block@vger.kernel.org>; Mon, 7 Sep 2026 19:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TpwD
	HH8ZM/W/wUFqtMovrUTp6DZrPbd2fdTAYntlazk=; b=sc2ISMqtFseQ/vmmdj0H
	idk+oXT+FVA5KtIjB2WOMMlR6xfb6MG91gRKcMAVXcRyGs86yIp83OvAuwF4kvrL
	S1pDpbyxsw4ly5Eqp/ZCDSWmZF7ULMDQPoneS2Ea1/DMLgzQD/DPK/hUI7Z/Ok1+
	uW2tCrrfUIuIsolmkHcYkm7lG1he0Sc/pQJbZ8ZqM/UP1EYJ2Mkwl/lwsPIxKlrf
	TzdF8diIqfZJq/5QthXDlOnkHGBp9BhLk6Kyopr0275m9VtVMBw944S6z8KVbnNV
	7xGVMNerOoc9E9yfDhHMMNSDvmPP7Ve6DXHnV/N/3+YQ5i+fFCkSn634VFGhVFLG
	XA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gj50j0fnf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 19:15:25 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90ce21f2cc9so99262896d6.2
        for <linux-block@vger.kernel.org>; Mon, 07 Sep 2026 16:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788822925; x=1789427725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TpwDHH8ZM/W/wUFqtMovrUTp6DZrPbd2fdTAYntlazk=;
        b=ywbKUdM2FZcJCUdOMg1HrHmN/Sj1GSNoT+tZhXOxqBjl4VE/xruX9gGXSLTHvVsXOt
         ZAbhGhFte83yFr74j/ro8soyHoUC3eAcNsaasH+17mK3Nirsq08Betm7nhn2zBAXShOi
         f4wZIUbHgglRk9IiIj+R+ZTfuRE6euwFnLvf14ogNlhrZDWIW6TSdDXnJkBlJ5TCL8Uy
         vI0L4u4KCpPjrKO7+HE0/SlSifVoXRVYT8XSVYUeHqTKwXSgrImp84Rsc5juNI5Jg4eF
         yQoscQehJ+JPEDEqUunuuVrY4EFegQSQe+jmHohTrsSOsy/zOL6bl4QLp4VnBaOMcozZ
         9ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788822925; x=1789427725;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TpwDHH8ZM/W/wUFqtMovrUTp6DZrPbd2fdTAYntlazk=;
        b=JxxIMVMBdAATa2qg4uGGdoOS9OG5PIdTC9ZguM3bu5ZRC05dvkJ7iJ0VIiq77tDXdF
         SWzXXU7CIeKzLvlq9USJzrw319ELx0YXAJax9h7l550NDm0PvUooks5yGryCyQGDB7KM
         qzpfPGaEqQ7JkIN8z57ucy08JeZwv86xZ/VjHMEOiKbe6PhwoX2UEuvL2PXA1RGYk4eR
         79R7if8NQttCgSznyXqB6mLltPPbQm4lYyjMtCxl5MNKJomLbc+UdqbTFapS9Z200wtw
         5xAtXZp1btEsScgQq76XPKtzLu+bKavFDZ/QjvbktBDcULI2Bn6AZn9ICPuzvY6LNVLR
         P8Rg==
X-Forwarded-Encrypted: i=1; AKwUvBz0pK6qS6LBtC7EMOWnPsmoExoAE6z5k62B5HcsDw1kYmX1j5+farlGNDSQ2oJTfqMESU9ykvEkytwACA==@vger.kernel.org
X-Gm-Message-State: AFuF++nFDvrIpPm/vS64cD35Ejl3yJWkPuyDZNfyx0zr8ZXGLOpHqk4q
	r79XKthjV6Dnj/nhgzj1nY1/XvkHEUW0k91heGZ0ZpePsZu4l9i6IIUJIUGAJNcIN6YXgRPR9zK
	zvfw1lImVKSKz9D3mcIa9nwPc/ijTjLmvH7C8RH0N8DsvVpcrPOxLLFehVNR1
X-Gm-Gg: AYBFou2+mcwZ2hFBUIU8DyMFAI1sKb4HSeZPqeRro3+m8DmWWw2PvkevkmItQpb4Iit
	TsnBMBtLMj5BKCexeA12hnIqjgPs1cZxFRxotw6JqP2AtMkELS3xXwuOP2UwqAJD0UdWujHej6K
	onHzJ67SLjWLHnrnkCyHuvLjIZD1edNnXNxPE7KqDOSdhS9jzYVl2e99x5FhKdxfuU+SDrTDoNR
	8PSGkmxKcWIDQsHgOPXLRs7it8g3Evl68jLfdtRvpaxbqzDHsKoZp9seDssvffpHcuNVFkGHPNX
	xvaEk3Yed2FKv7VpjdhgW5qQW2zEGAU5ZAfMf/dzTU55QaUJg/1qIhnqw6IiQjnWz2WoYi7p1UN
	pruK5cSB4H/cp/THs78VGFTMwVN3c2VUN2GZxmHHyLb3nQlI=
X-Received: by 2002:a05:622a:244f:b0:530:35bb:bafc with SMTP id d75a77b69052e-53054961542mr281314831cf.28.1788822924878;
        Mon, 07 Sep 2026 16:15:24 -0700 (PDT)
X-Received: by 2002:a05:622a:244f:b0:530:35bb:bafc with SMTP id d75a77b69052e-53054961542mr281314101cf.28.1788822924471;
        Mon, 07 Sep 2026 16:15:24 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-176-3.net.columbia.edu. [128.59.176.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541ba2d2sm100456331cf.22.2026.09.07.16.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 16:15:23 -0700 (PDT)
Message-ID: <ebd92c0c-23bb-4ffd-a55b-349210e61da6@columbia.edu>
Date: Mon, 7 Sep 2026 19:15:22 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] block: take i_rwsem for the direct I/O write
 fallback
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner
 <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
 <20260828-blkdev-fixes-v2-2-32f3f40cebed@columbia.edu>
 <20260907070851.GA934@lst.de>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260907070851.GA934@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDI1NiBTYWx0ZWRfX0LXUNv5x9HmF
 47gsW6bgvSjvJRwNVQ6tOE2PdspvfUyByFW5tkHlJaqvV0PC3qBLW3VLoOi0guEHTn6ccV7NKpi
 jzOlHdS4ZgrK490K9/Tg9pp0M19hm9uRYbTmLZEIY6Bpvgvba38DyNqPcBMXHUDM+piU6bxWjSB
 mSyiuvq9vRkMAlds2SMPLelnWQNgpDheRv2cCpvspXa6YM7C0gjNkSDzZI7Rd83eQI2JuKpQ/TZ
 /L+V5UYhLov/aPJLkOdIWgh6FcNN7lAIh7iC2QX1Y8z6khstILJQ894BVUNoHsFa+esPWLHy9DT
 W/JjTPPqbSayrU01iLWFLSJkwrACP/tciB3++MXIFT64nRsN9OJkJcsARhQ4sK5eS0f1TKFIEzy
 UMVKR57kyWnep5BWMFVbIDO1xLmy6PlqcE8In+YcFV9zaDT6qooIG6X0r6y6oYee8YeZH0p0A4G
 CrVsv8gztjAJSIctAMA==
X-Proofpoint-ORIG-GUID: On6ieozbzu3Wc8kICXwrh80kWNr8AT65
X-Proofpoint-GUID: On6ieozbzu3Wc8kICXwrh80kWNr8AT65
X-Authority-Analysis: v=2.4 cv=O7gJeh9W c=1 sm=1 tr=0 ts=6a9f458d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=92j1mJcILCjWExuphHMrQw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=NEAV23lmAAAA:8 a=14txEF8SjVWJ8V080YcA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDI1NiBTYWx0ZWRfXxGa2MpyW18g/
 eLekVTdx+wJB8jtq2jfqPmC40YcctwVHearG8wIt4ZWnhBG0sp2rUIZ7n70LMH9NTTO9TL3isH0
 1N/2kiZynpbjhirdfbEtMTLPvKOpFGXdtGf5rjKvKQeEjvu4ASU5
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11899
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=10
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=10
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070256

On 9/7/26 10:08 AM, Christoph Hellwig wrote:
> On Fri, Aug 28, 2026 at 09:49:51AM -0400, Tal Zussman wrote:
>> The reproducer used was written by an LLM, and is available at [1].
>> 
>> [1] https://gist.github.com/tzussman/69d06bc57d42a42989eb038b1b5aeb74
> 
> Can your submit this to blktests?
> 

Will do for both this and 3/7.

> The fix looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks!
