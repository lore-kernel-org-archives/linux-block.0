Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0051E3B961B
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538938; cv=none; b=PGdq6kL8VUzUcjpw3q6kqVzT9vU18nhFF1e/UHhealTBAE1dHgR5fhzqvvxWj3KflwyoKMi5lpTYMhXJMT/lHUJcRwPZBf3D1DZHw2hOW6ItH8QXD/gPF9Xgp6VetrT4iCABLsn9sMHk85J/Zxfa+eoFvqh2qRO2pUzSqWndTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538938; c=relaxed/simple;
	bh=5lo/HS3IacYKNgvWsTfqyEJUxioyzHwZN+YWFUDujdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1lsPIk08H2uY0LHOVr3LI530hmsMjBAV8i6SztaGjmjWCfX/8/hJln6PI0OeMpKZLMIYGlXbpTOSrekHduF3nffFT+k7DG88+e5o8zauXip6MNP6qggeRXasTE5SPQegxyWShNDJFKCWEbRWtsau0jRtFPNQwy+zyjVKxMMufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=B6TEOJfh; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=a46MI/7N; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="B6TEOJfh";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="a46MI/7N"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684GA91G2542750
	for <linux-block@vger.kernel.org>; Fri, 4 Sep 2026 12:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=/hUM
	T2eb6rgGkooNP01TzV3yzxEXfMXCcoh1N+XrBE0=; b=B6TEOJfh3hcEIJGu4YGr
	grTZ2PvSm80poZtWLmKl3xMIsOrPOkUxXKvqJKoVQylq0sDvT5kGfFs+6A156n1q
	1ZF5gq1AewdPPKoY4YxNqwikNWuMNtffsQYAbIJDKqFOsiwnBwydHZhnbSzfFWo3
	EG9XwLpEgiebky2NGPl8INKv+aXctSqK8bOFt6AeL4fo9tqRErlZWMMwZcl7ekMj
	GH15XFdvcQSy+5Hy6PyE+UWbBu1TWkTuK/ubfaa/1mYNu6PB5NJRagYe1XHdTBMM
	gDgj2IachFf7NjCItRw/3mISNCh3JgTnyKMznG2OixMueW4tNNx4RjbdgCB00M77
	Cg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gg0acs4cc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 12:22:15 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936aa34873bso164603285a.3
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788538935; x=1789143735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/hUMT2eb6rgGkooNP01TzV3yzxEXfMXCcoh1N+XrBE0=;
        b=a46MI/7NnRMAcsexQENNBzkQV7qBjnQqX2ZLUZfnYSB/Hw2P6zGpei+evanrshzkX9
         /VPUUzy7+UvohcHqsQpudP/Z0i7IV8ppLzNzWlSlHDM9m1Cp1xsvFsb6DiDUuQQ0E/ME
         D3GfJg2Hy1ZHbGgpE7V/Tcl8VY6s+REEbJADmqsOT91JpoPndSVYfsGDEUKG+EVCJqOe
         Lz8WFdPBP8yFu0TlQmzt9Q0t9EdzuVcj98S73OzdrVR/Zjcqn5dvXSVDmqLv+F2eMS8R
         FvdPGaH6N4AMPbvs5N1Syfd+WHvuZTqoQOoZJkxsvtjUCTR1fUEwnsdf+xq0OlK6YqNT
         yEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538935; x=1789143735;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/hUMT2eb6rgGkooNP01TzV3yzxEXfMXCcoh1N+XrBE0=;
        b=DmeSSV65v1S8vPPUR6awWUKhQHvzxhLRq726l/s3g3wcXRYOrDtqAfQdQzBM5roz4r
         ccv1U1GjaSz0ZEQgnaI5Yym9uvCVDCuqF/8I7nSOwhUXTTQyKjHQ8bYiGN3ed9YBkIX9
         Fu9hYGedi5eAx7YkOqy2Rwq3SBV3Dev84BhxtATpcxz4yur6LXSc2YUorqR7SPP5WZI3
         ErhDonMNagI1NNHp4kUCvKGMYmm84bOqMjFc1vvJfW3e2e9veO/UaO0+3NK8g+6Cl4Wa
         axb9sB18ihfUT9d9SHeF3x3UCjGe4ssQUk+BhJbpz7SkqDd/EzICLQd4mco6KBoa+x8L
         jWRQ==
X-Gm-Message-State: AFuF++lVfIA6nIydr9gD3Cqe0oLQuTsn3n1UVlMwGHj/W6H56fCbPvvH
	gDg3ctoNmQXe33r66qkTE2dsaMgB1dqBBA0wP7wUBjepia5JvpBXBpUSyUamuM4zRNRWx67Qw1O
	ffyzOVZKpEmKORkn50NdrNCnpemunTTorTGU93ZZ0GLMCiTUrbE6Mn+JH8Srp
X-Gm-Gg: AYBFou29LE+ipgGPJ70oIIvJCeKDd36XEAKtnq044kbLKRa1qQLH6cAMDScQi5Mo3ES
	DUPVZTy9wcugvH940+DcatYclHGGi+lYbmPFlHtN0D1URaaKQkNbsVp2d3JagnUXFjHi6bTduq+
	gMygf0zNLqrv1z9dAcZf+rTHyRRkNnhtzCrN0epf2oz1/K39l8fouiwJH2bcyC2Lp8Mk0DwQWBV
	aH3j+i/8lMj8t6QDwMv8HjJ0qK/aAWAF8tQt9xV3xszeYedill7hsGv/bO/lqBbuvI7iElsm6Qm
	KCw0npJgr/EP1fWVxUYpFqu7q0GPyyPlH/E152lF6xNzctKq3ClZa41a6yQ5cDjblf6z+6r5bYM
	K81A0yQ4rPucbfYiY/VW4/QzMHFfKVLhXj2MJBiKlE3vPKsPJtYgu
X-Received: by 2002:a05:620a:484c:b0:939:df7:6ce3 with SMTP id af79cd13be357-93980407102mr549717885a.26.1788538935066;
        Fri, 04 Sep 2026 09:22:15 -0700 (PDT)
X-Received: by 2002:a05:620a:484c:b0:939:df7:6ce3 with SMTP id af79cd13be357-93980407102mr549713885a.26.1788538934415;
        Fri, 04 Sep 2026 09:22:14 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-177-158.net.columbia.edu. [128.59.177.158])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397faf927bsm244025185a.8.2026.09.04.09.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 09:22:13 -0700 (PDT)
Message-ID: <befe2e23-4edb-473a-8ade-bb5c485f7186@columbia.edu>
Date: Fri, 4 Sep 2026 12:22:13 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] block: take i_rwsem for the direct I/O write
 fallback
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner
 <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
 <20260828-blkdev-fixes-v2-2-32f3f40cebed@columbia.edu>
 <e2082e5a-32d9-4a96-abd3-fd6ba7aa97d2@suse.de>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <e2082e5a-32d9-4a96-abd3-fd6ba7aa97d2@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C9LZDwP+ c=1 sm=1 tr=0 ts=6a9af037 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=tLges04aSNaZGVAfhBIy2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=VwQbUJbxAAAA:8 a=TpyNOygFdVc2XgeM1c4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 5bP4bpKxA7ZbYyRBQdsqM2GgIuvH8Kah
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0OCBTYWx0ZWRfXwrqtdZkeQDug
 CHpVAVO92OChe9ZmV87EXBPR7vQcWJ1ThdyfEw7lEBShkJL6m2QcWpkjKA7K4JlraiJ/GqRH/ZU
 fVttbXtCn6fpiSKUuBmPjq4rmJYIMjZPHJ+V+ldGqw1ZQlw9ltQm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0OCBTYWx0ZWRfX+vM8YObT64vt
 DDV1aozCbCFti/5L4lrPOFThW24nFOlVd515gNc7laSC21i48shLt9O/8rPqYrn2jXcenM2VdB5
 atG7QQltiWQeIC3DfJBvzKur25g9UpR4UttzgRp/LQ8PjJ8nrH3HKWytf1tuZLWic5osGFSWViw
 GIcM74YF4xeSZuCMxdT2vHxb4IbTqEMBmrCSOCTBKXjocEqZSYpui2PTNu3zhjtS9sjyTHVFZvN
 9leEnQVWZ8nmhmWUqKb0P4r88Br9Js9AC487JdDBBzktk+rSXA8PD32WK9S3N/P/IDt9q6sWDvl
 cF6LJTEI5MnGN8Ye8ORSrpsMbufmy84kbdHBf25g5DyB2MIOiC5RwTWhnbpMG+y89c6Ep2cXsJ+
 dNHsWkyhWWKrpGoaf3fcKxAwzM4juCbux6gk6Js9ziZZSQ3QSEHgaDl/kpKBijOUSKmqSM6V4zE
 TX7ZCU59RazK6brtLTw==
X-Proofpoint-ORIG-GUID: 5bP4bpKxA7ZbYyRBQdsqM2GgIuvH8Kah
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11895
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=10 clxscore=1015 lowpriorityscore=10 spamscore=0 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040148

On 9/2/26 3:47 PM, Hannes Reinecke wrote:
> You gotta love LLMs; no-one would have written up a testcase with
> four different threads...

It definitely wrote it much faster than I would have... :)

> Anyway. There is a reproducer, so we should be fixing it.
> 
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> 

Thanks for the reviews!

> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> 

