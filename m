Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496FF2E7162
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760998; cv=none; b=AX6R5XZR6ycEi4XJL3reDZvIcRR3Yb3KOGRJ3qN04zoF4fxuKkQRe/VKW2CAez/bbTQ9TcyBUKNwa6pt9r+lJwRuAs5pjkheoc2uIEiv8sja3RY+eaRAUU9fAf1PARZxrSlopY3DIFV+laB/ysRBQqQ80oMNPkbSl4I35if5NCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760998; c=relaxed/simple;
	bh=s8VtBesH9+RR7p0ccKkYYAEqr9HIwdQsu04bxw86QfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBSt9JH5kxLJlFu3RvL6cqVfGz5VLtcSdiLsj0RMJgHbIwC8ypGKnpRFOnEwPdDBHXiGTbH/v5KPh/CBpCFNV5jPdmWVLDRjUwmMHDSllbF83OLRW4wJshGw8giHfwIrbc4j0MKORoe7LqpGUyISXwFHgNJxl7m/YW9DVVuEm6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=C9NNnw7O; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="C9NNnw7O"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639Iu49r733606
	for <linux-block@vger.kernel.org>; Thu, 9 Apr 2026 14:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TidF
	UCcjURxrvT0mTb47uTbc8cUi8gBa7hb58XJT0I4=; b=C9NNnw7OyyNZTpLLiAgn
	1NGy89rwkfGQ8sKW2xsoDs3psZY5O19VidoJhD6BzpRDMyGkFkwTD1iN5wFldI0Z
	7ScowFZ5piO/9JjmpEEBRSlyCxja1P6z9Qy4nAXRuYvh4jS/8CaFyBXH4UDz1vcV
	7Mnk+PrEoPbR8rZZa1xVayXOGGpi39gL3Zntbbd7wmhqBLqzhA7J4itQLNZcZAbZ
	u4loMcbeOLC2TsS69QUqj1tdG4Qa70Zomc4Rnp/kG03BRMGpYgzzi5nZddQOssOj
	zWdOwOHr0li87w5xr9EbzOtHvvqqhmw6SVfAYvLxmRU3ocoFoYt5y+iH6so2OZRL
	eg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dee5e27vq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 14:56:36 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8d5d03ae893so187671685a.3
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 11:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760996; x=1776365796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TidFUCcjURxrvT0mTb47uTbc8cUi8gBa7hb58XJT0I4=;
        b=NxxGaXfZmRl4y+SZsazCY/WZr43Y2L3IaE8ob5C+cDSbZfoAPA64bTnXh79zxM4S+e
         qnrVoO4HI+pKPXeLHPOj9QFgIapEttGsGe3V1ONuRdbR8cubmH24EMWMUrYQMklSgXuq
         WTA3CSU9/apAsnvGcXJ9uq0PR9JuK+HyNrk3o7A3akSem5PrltUAkO4X14+85e55Fd6k
         EKdSAcbUflXmRrVnEczzWJ7HgRRGJXbYak46SChXxP8nnVz9WZp2ye7IGb3b2yGxlev4
         qoNVFbk+F+TEABTStNf6W8x1iRuY7Tbkke2OVq+sunn7oPazHjmPbWdUF73dURU1jaAX
         Iftg==
X-Forwarded-Encrypted: i=1; AJvYcCVbccAXbw29WgF/TSd1sdhNhj0cOtsMqnamhWngr15Ktqpy31NAJIkB9A+N2/PMSUbKbO2MhJZoobck3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAkY4pb08BARl2OOCepPdAH/z/P+sdhqYh2uqAtVYLSbWCrGyx
	9EWUJcKiujfRPfR5Eq9KB/XlG1wYObVd6+ZH6xnQIiUgr+0cJfrMSBaMrwzsDvavaMGCls0w+sK
	fvHCBT5Xgzzz4WpW4e4Jec9lhFHOWWmyFp8dNu92bNZr2zpLbCz5/oN9pyAqz
X-Gm-Gg: AeBDieutZIjYIspCPq8ub3NH+iVydHANHt+XYoVe9Jk815oqPl1xEmaZ2RWy5+FzWj3
	PVZwsvCcMAtXsEBG+SsetFS46iamYWZ2KtDHigF5uXTkZ5HjjVj5R3QKLnjoWIEr288CuTZWLFR
	/A5GYFcNslLOD5i0nzZfz/8dhURJY583RPxlvvtCnXhcoqgqFwaV9oT7SqWj2hUUl8pbRKuWL+K
	zWctqEv0e29AeZ4vYi1Q55z8YtuM08NuDD/jZq+3lR/zJkWET+VaEEbAlLtp6QZoQt1adhFvxXr
	Eigq2xwaU/jG094ZcY1zZC6BWOV/fuAzzPgSWnkioqGkfOYjCzrFdMtHZVAU2ZchmG2rTUhW575
	OH4H/BMqKdgSRDN0N7xVH4rynz5i4mBXyb9tTsflH
X-Received: by 2002:a05:620a:1990:b0:8cd:972d:335 with SMTP id af79cd13be357-8ddcf2be7c4mr2489485a.43.1775760995682;
        Thu, 09 Apr 2026 11:56:35 -0700 (PDT)
X-Received: by 2002:a05:620a:1990:b0:8cd:972d:335 with SMTP id af79cd13be357-8ddcf2be7c4mr2485285a.43.1775760995230;
        Thu, 09 Apr 2026 11:56:35 -0700 (PDT)
Received: from [10.206.71.59] ([129.236.231.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849e35afsm4077376d6.3.2026.04.09.11.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:56:34 -0700 (PDT)
Message-ID: <874d1114-b742-4351-b25a-4521e1f8f6e0@columbia.edu>
Date: Thu, 9 Apr 2026 14:56:32 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 0/3] block: enable RWF_DONTCACHE for block devices
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20260408-blk-dontcache-v5-0-0f080c20a96f@columbia.edu>
 <addM6bkKKtoMvDIG@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <addM6bkKKtoMvDIG@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3MyBTYWx0ZWRfX7l4EJVbKTZwt
 UBSlx/Lqa/jVQcgpaoiQGk7wJ2MvnuOfzqRnMmwXyjvQTruwBY5iyioGxzBTJh/5AO2rR7LdWE5
 0vWjf9FBBw08k5U0UYzTItGyTjzr+RulE9FYPy/OkJH2r+nOHtltC92ibJu+QHU8+qz1SUS0+uD
 W7/GQYh82lc1hqjRF93OsCClWpMFpeGzecC3JhHSzHe5I5w+nJtMEP9AAG/wbJGKaBjZhaD+OEW
 lnJi34PEpAf40QZCGTUGoneCBiyE/fDQSc32GjnPetSmLuur0a74zA+apJuxytgyscvC9ekWC8Q
 T+5MgN0gETwP+IPZ4P6I+k1Ra5/Kl8vvvoDkp6UBgeflF1twYoBNhZcBNViIAEKAb/4QcdazN4b
 40fLOHuqxpmcj3jBD4FMLP9ue9adfTArxsndFPh5MC1MhJQpHIkGmirztmLIXlEqhBEM5opokrO
 4e0pRkefXNimkXo0VDA==
X-Proofpoint-ORIG-GUID: 1ADaBumJpkWMKXWjOOyuTgWaqcaA2IPH
X-Proofpoint-GUID: 1ADaBumJpkWMKXWjOOyuTgWaqcaA2IPH
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=69d7f664 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=RFpAoTwO7tzpE9r8PTiuXw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=cYlWaDRCFYRnH0kQEVgA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11754
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=10 clxscore=1015 impostorscore=10
 lowpriorityscore=10 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090173

On 4/9/26 2:53 AM, Christoph Hellwig wrote:
> What tree is this against?  I tried Jens' for-next and for-7.1/block
> trees, linux-next and current mainline and it does not apply to any
> of them.

Sorry about that -- I had previously based this on an earlier rc and forgot
to rebase. For the next iteration, is there a preferred tree to rebase
onto? I see you rebased this on linux-next.

