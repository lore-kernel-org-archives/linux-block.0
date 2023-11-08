Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772A8F53
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 04:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sN9Z7hL2"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2C210EC
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 20:40:45 -0800 (PST)
Message-ID: <b43c5a9b-7ac4-46d9-989e-f64a49366ef4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699418443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t30KbwaE7h3kWx6mo7ZJFQVtoWDbP/VUr5Sr5JAB/E8=;
	b=sN9Z7hL21x1KmhapFkhJxaeY6ARjhg3LPWEFoEvd70Sb0o/Z4jvctZ52ZCUsZAe52id20H
	Df43S7Brxdy53K2C7kWOv7uMFd8iHKAubKuVb/zuFl1nEYekbLCTGwXzsPuIOfbhU7SCEz
	W1Ul4lkNF+PuQPo9MJQwtOrEwSoQsWE=
Date: Wed, 8 Nov 2023 07:40:39 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] zram: extra zram_get_element call in
 zram_read_from_zspool()
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, zhouxianrong <zhouxianrong@huawei.com>
References: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
 <20231108024924.GG11577@google.com>
 <b87ff5e2-156f-4bf8-9001-9cfbb79871ae@linux.dev>
 <20231108033244.GH11577@google.com>
In-Reply-To: <20231108033244.GH11577@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/8/23 06:32, Sergey Senozhatsky wrote:
> On (23/11/08 06:16), Vasily Averin wrote:
>> On 11/8/23 05:49, Sergey Senozhatsky wrote:
>>> On (23/11/06 22:55), Vasily Averin wrote:
>>>>
>>>> 'element' and 'handle' are union in struct zram_table_entry.
>>>>
>>>> Fixes: 8e19d540d107 ("zram: extend zero pages to same element pages")
>>>
>>> Sorry, what exactly does it fix?
>>
>> It removes unneeded call of zram_get_element() and unneeded variable 'value'.
> 
> Yes, what the patch does is pretty clear. It doesn't *fix* anything per se.

Ok, I'm sorry for miscommunication.
I'm agree, it is just minor cleanup.
"Fixes:" tag just here was pointed to the patch added this problem.
Perhaps it was better to specify something like "Introduced-by:" tag instead.

>> zram_get_element() == zram_get_handle(), they both access the same field of the same struct zram_table_entry,
>> no need to read it 2nd time. 
>> 'value' variable is not required, 'handle' can be used instead.
>>
>> I hope this explain why element/handle union should be removed: it confuses reviewers.
> 
> I do not agree with "union should be removed" part.
> 
> In this particular case - using handle as the page pattern (element)
> is in fact quite confusing. The visual separation of `handle` and `element`
> is helpful.

It's at your discretion, you know better.

Thank you,
	Vasily Averin


