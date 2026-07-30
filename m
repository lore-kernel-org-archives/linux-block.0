Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03C36607D
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443955; cv=none; b=YsiYFLgEGO6eq9kDeqm1TX0CA30JNBXx6Cr+VDtI7lT2IlKOM4rMrHi9Ds48vLaxyLU4I25CfeCCd5PlvYy+lm+9FYGab9MOo487eIVJanHHAarEZYatoG5u3SmOlw0eqCiXxQXVtd2+AY+EBkg02Z91p1exg4ynJ8dAUNNWS6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443955; c=relaxed/simple;
	bh=G/vRUOm8L2XZ3XeP9CnNcbxvMqQWrQcmwiBXs9OOzgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpmDybsot7d57wmNf6gZnNGY7Tcv4lV5btynDDtXRoxEy3xxj5zTioqVjiltFPXN5d81CF91lVGC1KwMkyWUPQl7BQN7pjSkE6iRPHvSR2wYvRB/rZUcwti4VofLFMz8lbaRDbqJbiPXz4K7HxUYJRFyJRCY9ua50dZxxTze52M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=WQ7HnPHx; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="WQ7HnPHx"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UKXwgM3893252
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=T8e8
	k+5EzrTp13lWK2mQytn9hp17i2RRCkab9M9He5A=; b=WQ7HnPHxqZL+jR81XllF
	JTKnzPju6U39UyyWhhTcphUfZ+xAg2wqUa791ebQ1v5NhvW0IuF//dLqtiOJvHMi
	fmyKW7M+TGXkdSy8yhCZpU5HL/IpFm8hExjB6Zd8ZTnCZBp0FfiM/4VmQMN3Nyjj
	wy9qKWJdLe5TFEiS34dauGmL0aNhbdETHjmjDl6ehafIPC0BA5I6nCfjcLjVALJk
	9EAViui9QVuK3SVhaPP15FKa4Vxbk1NUe/8NEuykcAZ7ZyTVvPKKcmrPB5R0nGP7
	1xqHFPEmX+ojBlGjFW+JqGfOPxg4M0VGW9uE0F4ziDhKljsql7UvZhC9GapkEQy5
	vw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4frbc0h958-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 16:39:06 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0f0a0760so3927941cf.2
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 13:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785443945; x=1786048745;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8e8k+5EzrTp13lWK2mQytn9hp17i2RRCkab9M9He5A=;
        b=qPR0ZXyrp7c5eFSp0MOTXz5Lyg2OPzhu2kRhm/u5862eDJ2E0YOtKjbuuKxLJM7wU+
         /wYlAtKX+ENamdIQxL/8h2GKcWAbLDphBzWmo9LRs6EzUf48T0WrWCCVuAEOtP12QO0u
         yFJ7NFyjer2ZI6njTMW5yEIc0HkWnO3RQLV1Am14f+OxbNI5pCetJQ9ALN5a3aYQ6MvT
         pOSX1DMR9mIdZP6FlIURj4otVlo5dhtPYfuBpAyTP8OE3lpsuO5JDMnmgBhWhsXq+ER4
         bPsqL1lsJqdkLRF8GcNbOmYMtMpVMoE4XTlovRjjh5Dhe1NTE4ylw7T2nKcs8Bd6CMTW
         losg==
X-Forwarded-Encrypted: i=1; AHgh+RrEr3/+aU13eG7jnYBDjrfTojr2yAIu0LJSscrhLE3lyV/kEHbcBHDvOxZ5s+Qu07pOTC7tcbqePfdj5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+X5TogR4ng33ivo9aj+DXC9ZMFBMmjfZcAGke5RGwclohaoQP
	ZAD/QMAXIr0tnGbaUe49wexV+Wux1ZQa39TEJdwJOI4m503mmkcCTgKl9jeS83qRrtGoiCYw6uQ
	0YTqvRxFI7bR8PB/fynU2buOkVgZtWJabtV5oCeSCqp90p+K+UwSWDWfmkMcf
X-Gm-Gg: AR+sD13ca/bubyW8gcDYA70zGl6hnWYxPJbyCbR8TDZ+GuTnvSPBwY0lV9XnCI/UsQU
	uuusw/OnODIW2awf8cYTYzyq19mPsv8JjUPB+H4RZqy0CuT5EOz2w7Bm0+TWpmXIhRPfw1G2MBX
	eAGkJtwONmUlCYU1GQ8b3Yt4568Xe/wcbG0/dkICWnLDZndfQmc88kpyFJfMX05BwEUiFQyfUcC
	UAwX2G/Y8P9HTklxrFcRushOdITG62+9d1gqKT7gVTm0hIw4SMESVOywLkuums70rMsu2SvSkzs
	4pk5saYxcMSYAu87fdAdG6VVedL/AmC3GMlrtmSw5nYFUYTXq/qn5fKbF6/heK97fC09NapjmnL
	ZA/ySxvK4iI2D3c4=
X-Received: by 2002:a05:622a:3d0:b0:51c:7b11:41a9 with SMTP id d75a77b69052e-52b38757e60mr44335541cf.86.1785443945531;
        Thu, 30 Jul 2026 13:39:05 -0700 (PDT)
X-Received: by 2002:a05:622a:3d0:b0:51c:7b11:41a9 with SMTP id d75a77b69052e-52b38757e60mr44335011cf.86.1785443945082;
        Thu, 30 Jul 2026 13:39:05 -0700 (PDT)
Received: from [10.206.71.35] ([129.236.231.134])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529e2d8251asm48127221cf.19.2026.07.30.13.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 13:39:04 -0700 (PDT)
Message-ID: <15506dc8-e5b8-4fa8-a85f-912a92edb83f@columbia.edu>
Date: Thu, 30 Jul 2026 16:39:03 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] iomap: use BIO_COMPLETE_IN_TASK for dropbehind
 writeback
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Christoph Hellwig <hch@lst.de>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
 <20260730-blk-dontcache-v7-3-3e8e6850068d@columbia.edu>
 <amsHrVCJnuXzeGG1@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <amsHrVCJnuXzeGG1@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE0OSBTYWx0ZWRfX+wQYqR7ePR+h
 lLw9kRJ9EavCa6ZKk9q6pn4sY75wnd+UBcXfFQOiZrQ5r9RyLNbBx1QNmPZ4eddyi9Rqw1Mtk9O
 x4kFGdtz9S8FPZktaDr78H889KtiDzw2ilkYibQJP1EYcR+89JM/vGS5Uzz1jMMmu9PmyXDAP0e
 j989Tnu2Veke72fgn2aEnAQtLDT8Sl/IsZuVkzMtQEnlFsbFxcElwgvZa9ub3TDTQvFXYhXPDMU
 eueD/Sfld4brSINmYnNo2kNyZ5PT7MDZlSYIG8E+evUnscL+ko5rBJ0sLmfyAycQSNaNZZVSbsY
 5ta91ml8iTp4/c6NZ2ZqMMgojQ4VfFQ7s++TIxBuhei7I5fuzh2HdfKiRuBUzBYN5ClXbX5Y/2z
 aiehQhfLI1KlgOodIn+4BllO0Cmr8dDoaCRDVmACqybNQ9EK/Z8dji4PqXKCaUQsevNN9sppIoN
 SkfVlMGmIgAukd2C+iw==
X-Proofpoint-ORIG-GUID: WpDB5uZzPfAwdVQwuAiE2aeTLsmZS2S9
X-Authority-Analysis: v=2.4 cv=Ga4nWwXL c=1 sm=1 tr=0 ts=6a6bb66a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Mx06nvryMUGB95QVe9e23A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=qsXxR-sLYAu0WPx4Yu8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE0OSBTYWx0ZWRfX66KQyydqTCXd
 dGb3gghtkOR9yZ9Kpsu9dPMdVu2C9ViBE44ccZ9Bief6JI7xoXhUcRx1gkzR8+XRVvh0o5DdMKQ
 Pn77QBAMdFVi8ii3hoWSI8JuB7PGVnN3S87SJf6cJp1schW53ONE
X-Proofpoint-GUID: WpDB5uZzPfAwdVQwuAiE2aeTLsmZS2S9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11860
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=10 bulkscore=10 lowpriorityscore=10 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300149

On 7/30/26 4:13 AM, Christoph Hellwig wrote:
> On Thu, Jul 30, 2026 at 02:57:53AM -0400, Tal Zussman wrote:
>> Set BIO_COMPLETE_IN_TASK on iomap writeback bios when a dropbehind folio
>> is added. This ensures that bi_end_io runs in task context, where
>> folio_end_dropbehind() can safely invalidate folios.
>> 
>> With the bio layer now handling task-context deferral generically,
>> IOMAP_IOEND_DONTCACHE is no longer needed, as XFS no longer needs to
>> route DONTCACHE ioends through its completion workqueue. Remove the flag
>> and its NOMERGE entry.
>> 
>> Without the NOMERGE, regular I/Os that get merged with a dropbehind
>> folio will also have their completion deferred to task context.
>> 
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> 
> This seems to be missing the bug fix you identified for the double
> deferral?

Sorry, I misunderstood and assumed you'd take care of it in a follow-up.
I'll adjust it as below and send v8.

> I although thought a bit how that could be done cleaner, see below:
> 
>>  		ioend_flags |= IOMAP_IOEND_SHARED;
>> -	if (folio_test_dropbehind(folio))
>> -		ioend_flags |= IOMAP_IOEND_DONTCACHE;
> 
> I'd keep this flag.
> 
>>  	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
>>  		ioend_flags |= IOMAP_IOEND_BOUNDARY;
>>  
>> @@ -256,6 +254,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
>>  	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
>>  		goto new_ioend;
>>  
>> +	if (folio_test_dropbehind(folio))
>> +		bio_set_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
> 
> And move setting the flag to iomap_ioend_writeback_submit, and only
> for the case where no io_bio.bi_end_io is already assigned.
> 

To confirm, this would only work because XFS provides its own task context
and is the only consumer of iomap that sets its own io_bio.bi_end_io.
If another filesystem set it and didn't provide task context, this would
break, right? I can add a comment about this requirement, but I want to
confirm the intent, as it feels a little fragile as-is.

