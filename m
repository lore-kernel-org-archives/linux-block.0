Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF337E2EE
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448595; cv=none; b=gQROhM8zIR9yRB8jf2LbOQeltmw7c850Wmace9cpBqh9fKWfbE9yBILOBu8syQtAbN9feWEjHa4FMUbG6K/9VxDC/Ak5Sbdzz0GDotkP1s1WOqsRDO0mMJ2QOjt72dAtodFglfr04iuMJj9bbWGGKyNGiIz1a+Bj0tRzyROvywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448595; c=relaxed/simple;
	bh=H+fC0Aj9lNIMry2g5OLsOVFCk0lkgCpK0rBGdHzX5BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4UNm7fXgSC/jkvyBQVZidQIFy+KRbINmr0rgeXV11Xi+t94hIeWEDW+zoCmfJr+lsvoKc8RZEnQWhwNmoeQNThwrH/dTDdXllib6JjwSG6UX0iAtdW8mRgkDBSRvIkZSDwidGr4oKapKk8OohKNxkQnBrT6WJjHxYejz287GTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=jGegmwhm; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="jGegmwhm"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B9UACK1499856
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 07:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=cKC6
	BNsxYTLmcXQYJdExb4GSON6ipxZyZfpmgIKUU2M=; b=jGegmwhmSmO99x95/UlC
	tB4qPrvgiat4PWc0bh/dTh+Cy51BZB8A8ODqRXDTgijDRrrin8ILnh8ZhYWuQ8xJ
	fGq1zXa2eGVmoWlNMUMHfkjiZ68Ny3UJPcHkNHnFOUXC1ZaqhiHpJ50LQ6rhV53J
	NX7GePWHgDd2LPB51ayPpBtFGpr3bsQUZxmwLMcS8jz5baNtUAphAIok7q/Ve/mG
	RK7gKBKk7u0pNfiFJ4Nt94u3hgZtH3Sng2tXDhDvxNw0eJnp1BVXU4lIQsYhjvsO
	LUe+Xgb7LGfrLeu/lBzY/PHL/7OdsxMUvVXD0OSc/bhOvJLbGr2flpXYd1nmqsHz
	LQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fymks3kvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 07:43:05 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e63df032bso90691985a.0
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 04:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786448585; x=1787053385;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cKC6BNsxYTLmcXQYJdExb4GSON6ipxZyZfpmgIKUU2M=;
        b=FYUssiw+JRopx3X4//bbRL9CjQu5Y6n7FyFwadDgZ3Ev8qJhOZjRFa4QW3uxe70VMF
         A4h0Jzdo512Ghav8HRUsnP9Y1IEcVJu+YPP/LAP6160+quYSFe3eKB6y8H3S5ro03A2U
         eUgXap86j1y/QizWSGFZ5nWy334SZvvGDmAEUM6oWcUqBxZCllKp752jFkcX/SuimS1/
         MHiQaFMNSKGAPH7LhZTYSJ8bu1dg7+Dzr3KWQX29kyib3wTtG8Jv0P3afkH3Yslci/Yi
         J1I8SZ/J+MIgngfKtDxjYD0BOYVpTv127GydbEtBbd+PF/v6zIcnY+i43JIOe+BLmNHW
         bbvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrUF3A8txtPJe+7qyrs31FgKUr0JV5Sp/n6/jMb71G4+Y/6KvpLzUyEpIOaHCgmPn1yMdIimOjLyUGRyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycFryq/HWcYwDvGdJqDfMTFs6as7KnCHfV4KLPxlu4YLj5HZB9
	FUtnBkbxHgkZQ2BP0Q/xV3UIZZiASpoeGup1zXUnrnnE50TvinTSMXSyPVrH5ERzH/tdNjPa78U
	Jaqln3LRTbpHw5Two7UBPFimmVC/MQ6kGEpkUw7cLUa+Ub2uRqWYHmvkH1O/l
X-Gm-Gg: AR+sD11cxGj1o+qMimZAw6VSXBafhNkEWa8NqrgKESu9cWIO3rV5HCax0kzjVC9UiZj
	fP+L4k1CLGvrF/oG02E+sQeqbDCCJBRZdFW9KhWv/Aq6EuHkcUd5N3MTvSEQkee6g+qmHxeWZtU
	GNLKwGyF/WEIVAMTjStEfKMwj7+bzTjh56MOdQ5lzlKRl2+u6xPctQe+nToa3xgjfFRPDidKh3P
	mNwZrezRQSufDJhQRcmMF30f3OA5etGXjdO4+ozC+MnGK3o23hgZTSLHZjdkbWJReUAFCXLWhkL
	uPE3Ij+d6nIu9mRYKN8xTe9TuAg9vf0WMJZae3+hTJmwBpfWw/QlgciERoc17GaXuAq6lOKVP0/
	Xo/1s44Jhei8xvg==
X-Received: by 2002:a05:622a:1483:b0:51c:b91a:33f9 with SMTP id d75a77b69052e-52d595fd432mr15006131cf.13.1786448585502;
        Tue, 11 Aug 2026 04:43:05 -0700 (PDT)
X-Received: by 2002:a05:622a:1483:b0:51c:b91a:33f9 with SMTP id d75a77b69052e-52d595fd432mr15005621cf.13.1786448584908;
        Tue, 11 Aug 2026 04:43:04 -0700 (PDT)
Received: from [10.60.12.19] ([199.203.153.132])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5ac691sm4028393f8f.3.2026.08.11.04.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 04:43:04 -0700 (PDT)
Message-ID: <aff781b9-f782-46db-a34c-882b2562cf01@columbia.edu>
Date: Tue, 11 Aug 2026 14:43:01 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfs: avoid double deferrals for RWF_DONTCACHE writes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260810-xfs-dontcache-double-defer-v1-1-aea7484b3e49@columbia.edu>
 <20260810183341.GZ3556460@frogsfrogsfrogs>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260810183341.GZ3556460@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5NyBTYWx0ZWRfXwcFEuJM7pQ5W
 LjJQbTg4gB47XhxJaAbq26b4bPygVhJQBiC9aSFXI4EXu4VUBbVoWNGi7wJR3KqreuolNuubHzu
 R03/eQ96rH+hdh/sSvXQL03YYw6xRsBHBqiON+qk6xROXT3L816R
X-Authority-Analysis: v=2.4 cv=ApDeGu9P c=1 sm=1 tr=0 ts=6a7b0aca cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Nuhq1gQggzmwqSkCDcb0/g==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=VwQbUJbxAAAA:8 a=8C2fSIT-9AAHum8_5UgA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 6xAHsmT9icnA9BUkW_fLb45qCMgUjlNM
X-Proofpoint-GUID: 6xAHsmT9icnA9BUkW_fLb45qCMgUjlNM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5NyBTYWx0ZWRfX59Bl0/js52w8
 dDAPv0/yEpvl7dbeLZyyW8tLTLSsMQ3uTa7RPO5tnuMKVTgXdmZ1u9cJ4y47eALA4camWLrdyvn
 3AG7CT02DTeEu/MZk1FOdBwmH9Lq8XTh1gC239s4LjoXNhRlxtoheC6RAYQzctRPmfzTgPAPq2N
 D7381Wxzk+ctBMjmoqxVli8huxCBQzFhWClIv/hIVtnTEnoPWtF3A59h9h16CcAIUidqSqnCEer
 HRuC79vNElJswIL+K992WOk+fdH8fVPfvo2C0s7ULwVrv6KUnFHoAE4P8NXUVnBVLPJhvDOfi3N
 rvwvipYQ+eWEZ1vwMbCKWx00F3vtEYnQ/uGcrl8P7Ph6oduvMMHIJH7TglLci+chgNA0IfqtinE
 h+fuo7UPkUGu2ZKx2PtHCh/qgf0BXEUKNJ32S/k0O9Z3XcQnSzSWkwvVluCZHhtb3Wk4FzyX6+K
 Q5/BxYtGxBQLxMSsbbw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11871
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 suspectscore=0 adultscore=0 impostorscore=10
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=10
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110097

On 8/10/26 2:33 PM, Darrick J. Wong wrote:
> On Mon, Aug 10, 2026 at 12:39:19PM -0400, Tal Zussman wrote:
>> XFS already defers some writes to a workqueue when transactions are
>> needed to process the I/O completion. Disable the block layer bio task
>> completion in this case to avoid a major performance drop.
>> 
>> Fixes: efbde6f9f449 ("iomap: use BIO_COMPLETE_IN_TASK for dropbehind writeback")
> 
> What commit is this?
> 

It's the following commit in the block tree's for-7.3/block branch:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/commit/?h=for-7.3/block&id=efbde6f9f449da3306f5b5d32f08829954ffb44d

> (If we're fixing something that's not in Linus' tree then I think the
> fixes tags aren't required)
> 
