Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D43783AD
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779490075; cv=none; b=auUUrRREft1pDBk4UIEBJZKq+dT2O8KFdLfPc9EgPZOAKp3m3Eo1g/AwKTaqVA1NsNXMOepymZpshYH7C0J9x1n40VbhqrAOSEk9fITZz33q1ppxoy/DmZgO55IPvUfxUSMcKvUutPnBItVW5bqP1b+KEoM6743ziifxMnFrvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779490075; c=relaxed/simple;
	bh=uoKzIXGyLSdhgTaP6+mkc6gT7TgNsg+NqAIq/YBaHoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQGRLpdB8fu8DG9LVoLXE4+0rnzTiHasl4BIUcHVM60AVGp6J8AXTCKWJ5eLjRRp1IATs+YzNNBiUsQpvaoFNl4EV8Tq5880bwo28LM7fBBQvy2o7/ENcvrbgNSHAPtfw7pX8ja7g6UziTPBzwWwhObAKbz8PKCaQf58u9XEZko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=vFpYLWSb; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="vFpYLWSb"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MMSJAI1858220
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 18:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TT8g
	lPTJWpZIUOrxyHUumKTmUNTeW5g1ZoNuE+A9ihg=; b=vFpYLWSbBpFKJ85ciFEi
	u2SR/IdqoXjnN6kLyLFAjIYNXlFduNAnKzlEOJyqebGO0BXFOXjsCKKQJvRpDhUH
	aUpuTGjW4y5shIkVkdDenX3gvbQPh7KZhgEc7Hc9vmM/v9gxlvZ3XsuWfoK58UbO
	vrXMR30AVDvhb9znjiDddAxgzDhPpb0AbCsj0BEwoahpaDGgnCWx3G+WBTDbFEXh
	YAtoaNiOY/hYZBSdZmzrj4AAJ4rTdfh2MY+l1WWXcYKdOY+FTwg32JJcgVrKzrxm
	fz3jOddrfZIJJZdVvcWgGxEk0/qjEKpkEhlr2iPrthjaCzM9KuhM1MTjfH79+HsB
	/Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4eatb52mvx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 18:47:46 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-514ae0e3ad6so197895961cf.0
        for <linux-block@vger.kernel.org>; Fri, 22 May 2026 15:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779490066; x=1780094866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT8glPTJWpZIUOrxyHUumKTmUNTeW5g1ZoNuE+A9ihg=;
        b=Od+9BHRTt05atbR2Mcv3zaAJTPIMotW6uw8hYyWNTpn//fFc8sV5jehUQ1pl0vcYfs
         JCWnNvOONFRr8lzhv3J/fO5hxVTzYb6xdniHoK4a55aC99XqCJztMHJ5wMfnXPblsznu
         J3aJIOgGM/IRO6g/XFMvk+8SGCd6w1gsnBz6szl/IO+XITYZ5WVve8FQwJHbWZ7+garT
         VosAFYfm2zsCKz+Jdxg58+nA2w7rw8TEt45Gajj5kMJx2rwpidvL1riU9Fgs9xtVtjsr
         cAU6IrMFC0tE6Djrp4/9lrxgnjQspckmZgCni38Z+VAV/WbVMjCrW+JOOJMg/me7J/zT
         1Fig==
X-Forwarded-Encrypted: i=1; AFNElJ82IVFlaK9Or6wqrxghF/asBzhUNp/ybDNcvWM5s4QPUyroc7hA28uNP8p4Q5lrpg8YAYDLUcNvB8+lCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0CepkG1hI5hNgukrNLi6NV8S6GkBN41l+iE/y7zxzM8ymRbQ
	1g158qkdpUceW2hJRPs2eq9b1YAe6AmOdMzpsBQSJ/hrmYEgz4oI15SSefDuK4knXYNZfBLb6Jh
	4geBoveILc4AkS5/wZgkOIxUlEMPONPXD1o33tBawYnsI6bdqesrEwcLVrWP2
X-Gm-Gg: Acq92OGJlZUJMlEgT99hRs+bY+IqBqLea/tw3u3ZhUzqXt4mRy8L3BRn+ipQp2Xc2NN
	tcWE49Bqla5m0fntLmUvJnK5g4dtzaujTJc3y9QbkPIqYC7ad0WMrQTmE0lQd9iaQHZpSgF5Sug
	jB1N0I8gyi3j9nafEc69KzSe9JSc7OrsB5bPM1vKMFngdPQrPUwzGgvVibx8OQGiv/lXjQaE2y7
	RVUNsKfeWFoJhnoP+v3pDko1edSLov4n6RG/DAvaLmZur0I6VTauswCSDkIYzEnVThPpGEt9IGY
	KkjboacFil+bj9V5MYlrYSRAiVDFnwdeWPUaoCOmMdd3K78Hcj0WaBQhALdMyisfC9FIR7XxvW/
	AiY9d0QJaObarVyaTRa13EPHhvOTJMukFcpANw/9ejMZqPvhNuqp+Jy3SXTp2Xm/LN3N7fbt/m1
	o9INpXfZTo+A==
X-Received: by 2002:a05:622a:647:b0:50d:987c:8174 with SMTP id d75a77b69052e-516c54ce3famr103506931cf.4.1779490065821;
        Fri, 22 May 2026 15:47:45 -0700 (PDT)
X-Received: by 2002:a05:622a:647:b0:50d:987c:8174 with SMTP id d75a77b69052e-516c54ce3famr103506511cf.4.1779490065251;
        Fri, 22 May 2026 15:47:45 -0700 (PDT)
Received: from [10.207.65.224] (nat-128-59-177-214.net.columbia.edu. [128.59.177.214])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b00143sm26022671cf.3.2026.05.22.15.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 15:47:44 -0700 (PDT)
Message-ID: <ea1fa305-3ba2-4cfd-b7cb-86875032a300@columbia.edu>
Date: Fri, 22 May 2026 18:47:43 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] block: add task-context bio completion
 infrastructure
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
        linux-mm@kvack.org, Gao Xiang <xiang@kernel.org>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
 <20260514-blk-dontcache-v6-1-782e2fa7477b@columbia.edu>
 <agq2KRd8RkP1TAf5@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <agq2KRd8RkP1TAf5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=StygLvO0 c=1 sm=1 tr=0 ts=6a10dd12 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=n4JpGxNP30DHW88kdRRHAg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=76MgQrUCaxHmrnKOjHwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIyNyBTYWx0ZWRfX+6je7cnx6QM5
 qBBpge17kLrkdJguINAujkbcsTaREEKa5+BuVx7acy3Uo0E1O8L5tdnWF5MCvX1ER/ehOY3dpjE
 eQE0+XhkCAqeHGUXXvbe4pczST4ysBEh4MlR8Uy/ttSV8I9sJ9uKoNJ+bj7Ra/QbPCUpoUvTzd8
 0K4nX+fSPn1EKRDITvetmfFhIQ2QiptOmipUFAbnxB1A/LSamjAihIYxDiSQ/mUyuAsxB7JleZE
 ZUkKL0X6ah2caIzBLShLhs0E6iTccagmHMjta1Y/nF3n2MirnPSGejtpmda7A7qyFha3LjZUkoi
 ZHMPV9BFAJ6MA9JaokLKUK5aQzByIPE4hujYA9haNWHTK0anzw3UGHGdnQRyjkjRveaU/YT0Lp3
 2pjdMHu00NADNlgDYlKEpoGacCTMuPTeXk2CqQjcO+dngtkU2Ddh7xIspYV60cWYjSr/gZKbY1s
 Lw6UlVCjGUbNXKziPZw==
X-Proofpoint-GUID: c6_RlTOTIcCpiubyw5nJ_Ha1HsrAwl6D
X-Proofpoint-ORIG-GUID: c6_RlTOTIcCpiubyw5nJ_Ha1HsrAwl6D
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11794
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 adultscore=0 impostorscore=10 lowpriorityscore=10
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220227

On 5/18/26 2:48 AM, Christoph Hellwig wrote:
> On Thu, May 14, 2026 at 05:51:14PM -0400, Tal Zussman wrote:
>> Some bio completion handlers need to run from preemptible task context,
>> but bio_endio() may be called from IRQ context (e.g., buffer_head
>> writeback). Callers need a way to ensure their callback eventually runs
>> from a sleepable context. Add infrastructure for that, in two forms:
>> 
>>   1. BIO_COMPLETE_IN_TASK, a bio flag the submitter sets when it knows
>>      in advance that its callback needs task context (e.g., dropbehind
>>      writeback). bio_endio() sees the flag and offloads completion to a
>>      worker automatically.
>> 
>>   2. bio_complete_in_task(), a helper that completion callbacks can
>>      invoke from within bi_end_io() when the deferral decision is
>>      dynamic (e.g., fserror reporting).
> 
> Note that method 2 is unused as of this series.  I do plan to add users
> ASAP, and at one or two could even land through the block layer in this
> merge window.
> 
>> Both share a per-CPU batch list drained by a delayed work item on a
>> WQ_PERCPU workqueue. Producers push the bio onto the local CPU's batch
>> and schedule the work item, which then dispatches each bio's bi_end_io()
>> from task context. The delayed work item uses a 1-jiffie delay to allow
>> batches of completions to accumulate before processing.
> 
> But this 1-jiffie delay also means we unconditionally increase
> completion latency, which feels like a bad idea.  Do you have any
> measurements that show where it does benefit?  Note that queing work
> already often has very measurable latency on it's own.  This also
> directly contradics the erofs experience that even went to a RT
> thread to reduce the latency.

I added this per Dave's feedback on v4, where he noted that XFS inodegc
uses a delayed work item to avoid context switch storms. There's only a
delay for the first bio in a batch to complete, as we only delay when the
list is empty. I'll run some experiments and measure context switches,
completion latency, etc. to see if this is necessary.

>> Both methods are gated on bio_in_atomic(), which returns true in any
>> context where a sleeping bi_end_io() is unsafe, including
>> non-preemptible task context. This logic is copied from commit
>> c99fab6e80b7 ("erofs: fix atomic context detection when
>> !CONFIG_DEBUG_LOCK_ALLOC").
> 
> Let's not copy it, but have a prep patch that moves the erofs logic
> into the block layer under the new bio_in_atomic name.

Will do.

>> +		while ((bio = bio_list_pop(&list)))
>> +			bio->bi_end_io(bio);
>> +
>> +		if (need_resched()) {
>> +			bool is_empty;
>> +
>> +			local_lock_irq(&bio_complete_batch.lock);
>> +			is_empty = bio_list_empty(&batch->list);
>> +			local_unlock_irq(&bio_complete_batch.lock);
>> +			if (!is_empty)
>> +				mod_delayed_work_on(batch->cpu,
>> +						    bio_complete_wq,
>> +						    &batch->work, 0);
>> +			break;
>> +		}
>> +	}
> 
> Ån all mainstream architetures we now default to lazy preempt, which
> should remove the need for need_resched() calls.  Do you have evidence
> that we actually need this handling on recent kernels?

No evidence - I added this per feedback on v3, but agreed that it can be
simplified.

> Otherwise this looks good to me.
> 

Thanks - AI review found a couple more small things, which I'll respond to
in a separate message.

