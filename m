Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EEB1B4F1F
	for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789794974; cv=none; b=c0mEIxfHoJoFxDro0I1A7IDSrgz/DV4zVaawGP7wcg7zfZ2u0NHGTGFU+volGj0y6WB7LB1wjb1uO58PDlPPLiPLJLuQ5Gxwi3goG0smbDd9lMt3F5LlNR2SIBNNlL+1Ooq30kZWBnYS5ETxFutIGxHLiYRMFhZimVAZ8rMw2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789794974; c=relaxed/simple;
	bh=3F1dRiiOctBT+Y4P4x/exnUO4gCUsgrPUqAzlMHblfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFmLZi7qFF+4VHv/Z69bvlPwgADnRAldVKM+Uc+83QY16AsLh6h6Pgp/qRaAHyJGWg8wedVGYETKYRfHP/mC1m+iAoTD/wLKEtGA+3KBDT+HolxvEFXv7cddso7Y2hGgWVLUvC4PZaBFXnxhNNhxEsDicJ/6kT2q9sJ7vuptG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=RWpD7Jjh; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=tdyIqgqU; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="RWpD7Jjh";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="tdyIqgqU"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68J4iSMo145706
	for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 01:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7ckE
	x97Ao3pgMPGM+UVMLsGwNfRL//boHpDqglPVhzk=; b=RWpD7JjheOxPes4WzuRe
	AmT+kXTi8DNRrCjBnQXGHotfxOG8jDxbt/At8ZFKiJ/LEctm8d9nWGTJWPYdgCJg
	ZYEZCXGW7ySNZro1m0t2JtiOWfdeAlBG4bsO8VlCkb/EnHQNgUjAMhYJPsPNB8SL
	9Mj6LEZDhPvDMWp/otanQZj2Vq7CIwWdifZgxuC1++BtEXd4EmphozaJljpWHppq
	Q1JAghuT7vHvq6555fKgRrgZx+2Zp7rzOqDpvWvJzwgRTVgaHJVQiGT8FJM1+FSs
	IfQ4setrFUobuyGQZHtlW14GSHzajxs6wwEa6S+PzD9GBa9dFKNjSnNz0PVabO+x
	hQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gscxehqqt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sat, 19 Sep 2026 01:16:11 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939d6c515deso305672685a.3
        for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 22:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1789794970; x=1790399770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ckEx97Ao3pgMPGM+UVMLsGwNfRL//boHpDqglPVhzk=;
        b=tdyIqgqU2WuBFyzr8W7fjy+oPPBvV+3TcGUoweT4uFkigcUKFAIuDMAQQ27m2c+smV
         CdTH4cna6Hwq2zc+IhQAQYe53mwwK8fTCSLVT5DawaRoPnNi3EzrP5qkd5DS8/xmv7+T
         ZJlnIrg92vejQANaNJmjLHxjwyQAbsgyX5V3TcOF0OWNqOiD5zbuUZjqAzSqGtzwbaG/
         aD2ahFRE/prnDIIZ5lGWpWHFT/uCOk1yV5JvWidgOzEBx7FfprvtzeX10WZLjqCR/4kL
         z/VRDW60ErGhK903h95gniMwbXy/sdxj/F3+x/nyVpYs156I802KDmcdbRkztoRC2aT0
         XOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789794970; x=1790399770;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ckEx97Ao3pgMPGM+UVMLsGwNfRL//boHpDqglPVhzk=;
        b=ACwc2Bf50iJU3tpVeHsxHUmy/CtxTMY0G02Kfu9z7/Snl4Uis54HUNR7tIP8Y8AM3a
         5Na7y3ISkpIwy0S5+Vya+UUWVsPM1lmlnc3JTiwPyGaB7257rToF5C+D5VdRPte5lm5S
         Vjv1l5aTLFojIXvoRqL3irhGfz0ShNxnVK554lZahGaw2MRR5Vy0cdirqryKDGYmjJEL
         +Nf9Z37OZXlKt0pk9abneYId6DmRIvp/TPh/MSaaWySNbRRCZHi1Rbh3hOs1YVuOovtV
         f43YjLgqaV/7CJ3pSXGPutH/Nj4RMwPYhE7B8w10V53nRlCt8tg7+X9YRXDE2xBnd6jv
         bTug==
X-Gm-Message-State: AFuF++m/El1ynQm1zUnT4TZ9ZShVOORnwelPfwHJ06oSZdnaiqqskSfy
	2ZkKyZzn9tcbhBMe5b4mZc9z/SQlO9hx0gwo24b1P5Xinn6r6B/MCbJSYLw9mbiQDefY64MFLMi
	CApajBc2gztKH5lzPFTlSVpFVzXpodMhviZZ2PPfBd9J5WvVIoHjhtR5HodBU6Ns/r3VB
X-Gm-Gg: AYBFou3d1DIpLSFBqsmn2+OkcXl8AeT4Fdvfm/1TtdYZaqxAYUKpI51NQP+Z5HKGIit
	qxhpWx1KLBcMtEdUTkQPNaikfeJgvX1osF3I53wLx6M2oOI+emSpWJmAIYaGSMew9vc4t3NU/TY
	WOvOZgbtoEzWgz4DsRz9Cg5PcegneI4M4o3xhACQNv77ES5ZHLEVwWpVIPtQU4GMCbrFYT/ALRE
	bcpSadIL48itrjMINXeebhYAeszGlQS9xxd2dDnTib9oUST0JOug/8dfZ8D/Ta0jkeTNQQGcsnt
	dtUh2Ef8/183av3p4q8IQ5eV2bAt0AxWu/lNVOAB2eoA9ZYJycePwMU3h05tsEeQ79L1W6A/39q
	WLDpzu/0ztCniSwYsJ68ykgRjww9MHZYyr5abu+bXMUulOsCQ
X-Received: by 2002:a05:620a:648d:b0:93a:14c3:72c2 with SMTP id af79cd13be357-93bf559528fmr15354385a.29.1789794970298;
        Fri, 18 Sep 2026 22:16:10 -0700 (PDT)
X-Received: by 2002:a05:620a:648d:b0:93a:14c3:72c2 with SMTP id af79cd13be357-93bf559528fmr15352185a.29.1789794969791;
        Fri, 18 Sep 2026 22:16:09 -0700 (PDT)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93beda709a6sm113958185a.14.2026.09.18.22.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 22:16:09 -0700 (PDT)
Message-ID: <b8b0a7f6-59cc-4ad3-8b36-b8107fe0fa77@columbia.edu>
Date: Sat, 19 Sep 2026 01:16:08 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/3] blktests: tests for the direct I/O fallback,
 splice, and bio trimming fixes
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20260909-blkdev-fixes-tests-v1-0-1f8af8665d16@columbia.edu>
 <aqyll5sZ6qrYzo3W@shinmob>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <aqyll5sZ6qrYzo3W@shinmob>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE5MDA3MSBTYWx0ZWRfX2Txc+IHsBZzL
 xdLDvvCkRB+PQXnlDj80KJUgXpbftFGq5QUb7pEy6sxaqP9G19FisZoNeGFDsgEputooVdPAAxd
 meHzgnQ6zY9Xm+DKr6IGlW3l06nymYQpzt0Yi6zwRx7owngGH7H9Qi6qaPU8CMsxt+DcsPAqKXW
 vrAr9dVV2eYZ/06W7t7rbx9DLUY4erhtDzmx+HSzB5fALU8plPQYIjZr350APmD1X/7O+20TLWK
 n+Rufyvg73US6jiMeyLROxB7qfTopcbRXCTW4AgQUwFeeZstUTvp4MIcj7BiyY74UVnmfwJC7c4
 H7vXnEVGfrKXLtPRM0VS0kRz+1EHzJk+aLU3JSZHdeDI6zS2TLlS6QrakkVBkWvxxALeY/vp13R
 db/GgD3uGZBqtPu+5R6mi+Q6Ccci4Ps7eC3/U++ckh0gPtBH4dVszGmI0TFhcP+rekxzyOYAuxq
 hi9Jn9eTPbNDv1aW2vw==
X-Proofpoint-ORIG-GUID: 1iG7DSGwnI9_TP9Erxyofqfm_Fn7ijSc
X-Proofpoint-GUID: 1iG7DSGwnI9_TP9Erxyofqfm_Fn7ijSc
X-Authority-Analysis: v=2.4 cv=GqfXaU1C c=1 sm=1 tr=0 ts=6aae1a9b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=VwQbUJbxAAAA:8 a=nFOSXamSZsj4_remXFAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE5MDA3MSBTYWx0ZWRfX4ewSJeDKxqRv
 +0KvsfUUhpUjI0BSVGZ4zekLzd7NhKsnCkVeD5RPKSELU+o5n8hKrTrRIUpRsD3z2pk6Cmn11Xw
 wBPqSMD/GvKhPY/AzCD0Ku2qbmwg6RVjBFeKgYfZPXSAST2M6R2s
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11909
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=10 suspectscore=0 clxscore=1015 bulkscore=10
 adultscore=0 lowpriorityscore=10 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609190071

On 9/17/26 10:49 PM, Shin'ichiro Kawasaki wrote:
> 
> Thanks for the series. The patches all look good to me.
> 
> I ran the new tests cases with and without the kernel side v3 patches [2] and
> confirmed that the test cases trigger the expected failures and the kernel fix
> patches avoid the failrues. Good.
> 

Thanks!

> [2] https://lore.kernel.org/linux-block/20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu/
> 
> I will wait for the kernel side patches get settled to Linus master branch
> before I apply the blktests patches.
> 

Sounds good, I'll send out v4 early next week.
