Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3633C1B6
	for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341522; cv=none; b=o/m1BmCKyJASc252WLO/Ymxha9f/KWrtROZQiuifg+NotmSuwAECfN1t/5bqM8HU7PDlKZEYY7eHqOI/d+Ph4tjM4utDvgBQ2O0mAC3oKKlITz4/0gRMkWE0g6MmzkXOULKqQyG6MGQJhIJlqP3WY/lP2Z7Eo5foTcBIH4dLhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341522; c=relaxed/simple;
	bh=QPFJR1vWXmId38S6Ojs7fTtlJqKNFpoaJ1oU9u/sTPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buI8fI7zOulgJ9NefTc04MMxyzwwhX5zHqeSwK7EgXwJVRuszQQ9FXu4IrXVcxH8Z/oprMaovpHc202uvcdqIGYDpZJYtQn4PKZrf7gfiqyuFqcxnBDnAQujn6Hze6Vk6fCk28Afm8tXDp7VS6Cy/QEG3fGav/Xy6tyYqIoeU/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=BQ/XtwgH; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=kKTjyUYR; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="BQ/XtwgH";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="kKTjyUYR"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DMZMO8416372
	for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 19:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=ObdQ
	sYoMgqM8w+pcvvksK13OgLV53W+GjlfoqKgXnfE=; b=BQ/XtwgHWxGaUPJsgd8F
	yG5ZfmhoUv1wcuSGz+ROMMXmxjQT+PZL7OmaaAN+I2LreCpXDbuwsKy3n6+6BaaD
	Cyz5Txu9dE4X+agjtcrEFURVlQQckCh35yOgj2uwUdb+KLGFvizWEdyXCYV9Fhxj
	wa6YRttSXKGznHn9fCyxkMjbNsiOoZrT/TDGr8B0wOTwPm5lc4TqEQ9QZfBn5XvS
	SpNB1YU3nXPx1mirH/Bn5tYODyfRFC1l1Tg9k0zOzavA3Cuz3Lht8fansFlXGlpO
	DRybnUfFwN5r13GDDk2ep3bENxz5IONM8CnhSGcUCOecy0B8opPmRWCXGG7JwreM
	AQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gp0qas4qn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 19:18:39 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53018848232so31441151cf.0
        for <linux-block@vger.kernel.org>; Sun, 13 Sep 2026 16:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1789341519; x=1789946319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ObdQsYoMgqM8w+pcvvksK13OgLV53W+GjlfoqKgXnfE=;
        b=kKTjyUYRY0lyKQdmmOhd0loYvhRhao0QfSbCanRzduUGh7knZ2XrrKILUE2exGbjiE
         ysJoQrPrFERQmiX3KQslYkm1pVjakLc0O7qNKRUDW6+kqLpUn9rooIX+1TNAlyj78M0p
         TYxpuVVAjnXhi08M/S02Xoi/YoTsDnyPOySe6idxvLjkWIB5lcQiJuNYZIKTvZ6phhLI
         ytOQjQQqmWESeTVIatAqale+pJbwpVNaQIxXKjhglRrpHNXT0d3r8+CWS7ojFREJYUbH
         Z1+Ny7mVqoqgF5Rri12K77iAKCqVytO0ldFOXHUC0KBArANLX00mDCKsux0ScGGK3PGK
         EKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789341519; x=1789946319;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ObdQsYoMgqM8w+pcvvksK13OgLV53W+GjlfoqKgXnfE=;
        b=KlZeVryeJ/ywT3lCHEmzImv1IKSJgSTqeevK58uv6L8yNoDAqxGzElZgV5n1iTru18
         xGlsSewQDAN/uipi98Zkk1zTRnk09Bs2HbXmpIdbk4lly6+ROaXBJPry3gbmX3T7C2l+
         KTM3CcqTaQW7nE5Hs78HvayF29iEVa9pZQjxEhraBF+6GPbLaJCZsf5dehGL3O146Yom
         xep59qLSVlyCNbQXcLr7/AqUe7pKRDUP6YfVngx0DuZP/Qv2m2a1ZiQQGLSLpADcjzaE
         zKCS5npQWKmIdI4UngkLNFlrZI2SF4xyIXpzssJ+vf5EiiunTdcI28SmbrXIe2r0pGir
         ndjA==
X-Forwarded-Encrypted: i=1; AKwUvBzUqZZInMcXErbREF8U6K/ptJQiHb0hwgLtjI8ZVIUp9z4cTmMldmlv/CzLucxNFP3Itq3uYnDnrMWanw==@vger.kernel.org
X-Gm-Message-State: AFuF++lkGjx2uLZdmBt60JWCwUo1vpPKcGvdBrYh/y7U58ska65Pd6cx
	IiYgzx/opW6I7kyDSrWfguYlX0UaFclzBtWXE12MgwsVujaDKJEV1Xb8Pt8U41Ap9wJRedpUDFc
	vBlNbf3iaYCMNxuatdnL819rVmH/pRHX97vHHgCEpqu85LN92ipr9F6pW3pte
X-Gm-Gg: AYBFou2Yepgzz0eW0LkCodKSXywZCmuUASpqWiDbHLugwOrdqXu3/pcv+DDF6b6eCM4
	opnfBNvj/mRTnHPhwEaEo9h2uTUSEWOa/7zEUSD42kmJ708YDkIoqNL/mPJAOY6WWw/D3TLLvHL
	eRHvUBempm/aRkOFWHg8ER+BqyUi2uq1xctNZKryts2ryLPYLxN/Ls661/vRTSN5Lzc1aH83F8q
	N3zfiLV85D+ML3Yd8u0RnLUERsWGNvNyMqc+Hja9a4xTUvaFjD9HCuUTQtDL3PY8m5xFBsjuZGh
	PYiCv2SbKEYwTreIvnRw4njjWkkCpM6swVSjCDrCAfFASCCeNqCCs2HX80o5EIrGo8IjdoZG99e
	iUSpN50o0RjTHFB9TXftEmQjwwco1Mzb6/1FfjGA4cLnx9BTVrOSGoaw25w==
X-Received: by 2002:a05:622a:15d6:b0:530:b2e1:8e38 with SMTP id d75a77b69052e-5310d063e03mr2361301cf.51.1789341518765;
        Sun, 13 Sep 2026 16:18:38 -0700 (PDT)
X-Received: by 2002:a05:622a:15d6:b0:530:b2e1:8e38 with SMTP id d75a77b69052e-5310d063e03mr2360851cf.51.1789341518241;
        Sun, 13 Sep 2026 16:18:38 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-179-215.net.columbia.edu. [128.59.179.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca46283csm82324741cf.5.2026.09.13.16.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2026 16:18:37 -0700 (PDT)
Message-ID: <03907742-fc59-4d31-b12d-760a67e163a6@columbia.edu>
Date: Sun, 13 Sep 2026 19:18:37 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] ext4: never fall back to buffered I/O for atomic
 direct writes
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Baokun Li <libaokun@linux.alibaba.com>,
        Ojaswin Mujoo
 <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Zhang Yi <yi.zhang@huawei.com>, Christoph Hellwig <hch@lst.de>,
        John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260909-ext4-atomic-no-fallback-v1-1-5a6b9539c002@columbia.edu>
 <vgxva24firqq6eqt2wyovm6uqh356nvrsb35exzxtnxftspy3w@gb7uiv4gwets>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <vgxva24firqq6eqt2wyovm6uqh356nvrsb35exzxtnxftspy3w@gb7uiv4gwets>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMzNCBTYWx0ZWRfX3ZVd4l7kWhDu
 3QBbDMBB/35rwDtJ1s2RKX5BqusluAAbNS29m5K1oWHkbMDTOnH6NabHt/nLYi+NTfdOPOY+EH+
 DoYADmbxWhzCd6hO9EL71dqMwhP5jNUtfMlkdg3d3p5AcegdNOhDENF6CI0xI4B7eZDQhzMtkn3
 Zo7Y2l+n8VVacxPrpadZsBB0C+HtfYlIzzUxKq016nKp4mjraTm+YaxB3WudZPUu6ADwTl+XVe8
 +4rZAgIr4X+e3Lpg1HYjq9wnGfHdHmMMv7FXXJLoFnNlC3N2tfhfE8+CylextiVKTgs3L7A6NJs
 YoSS2aRa15MuCVUG4uwqnuD7y/6RGNXBpBlKJc2qZ9e1naS/aSvvmm62kkd7Oox9kG8PjG+MsDX
 6zmvS5RsS0UtcgvODyQgtqOBVPX8PlCnb/IMdpdZsY5lIzdBVHDd31rF2V1vyyLcAZi2j/EQH8D
 cLU2eoToTBHOq35lzuw==
X-Proofpoint-GUID: AkTrmf6fh2ISduSda9uIXN8dv2TCVsrb
X-Authority-Analysis: v=2.4 cv=XvBvqlF9 c=1 sm=1 tr=0 ts=6aa72f4f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2jelXx5xVcRIF5zNctN5Qg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=c92rfblmAAAA:8 a=yFLjkkry6Ff6WXaXFHAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: AkTrmf6fh2ISduSda9uIXN8dv2TCVsrb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMzNCBTYWx0ZWRfX8QR9+9obBuw/
 E07ZkWiUMIQzUBpT68dy2HZsRiYgFWPIcED9Wg6M7bRvMekMeOycFESimUicUt9goIDF6UHqhXP
 4whzIbUcefYfcmHGr9aoqCJI5kP4O9EVVQuNjljpnnnyi7B2SCJM
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11904
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=10 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=10 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130334

On 9/10/26 6:58 AM, Jan Kara wrote:
> I agree your patch makes things better but I have a question: are short
> writes (even 0) allowed for atomic writes? I don't think so as far as my
> understanding of atomic writes goes (and based on what I could find in the
> code). But after your change we'd just return short write (including ret ==
> 0) now which doesn't look ideal and also doesn't match your "so any future
> bug yields an error rather than a torn write with a WARN()" description. So
> as a futureproofing I'd maybe suggest just:
> 
> 	if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC && ret >= 0 &&
> 			 iov_iter_count(from)))
> 		ret = -EIO; /* or maybe -ENOPROTOOPT??? */
> 
> before the fallback to buffered IO as a more robust solution.
> 

Short writes shouldn't be allowed, so this is definitely better in terms of
future-proofing. I'll do this with EIO but with the if (WARN_ON_ONCE())
inside the existing ret and iov_iter_count() check to avoid duplicating the
checks.

It looks like Sashiko also found a pre-existing issue where an atomic request
can be done non-atomically [1]. I'll see if I can reproduce it and add a fix
as a second patch in v2.

Thanks,
Tal

[1] https://sashiko.dev/#/patchset/20260909-ext4-atomic-no-fallback-v1-1-5a6b9539c002%40columbia.edu?part=1


