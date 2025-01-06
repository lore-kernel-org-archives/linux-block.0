Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA51DDA3C
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174391; cv=none; b=jklmE1xvX5EQ5brui+YsL6B9zZzB7DuXNdAWQkHk66HU6BvQLzP/ZkctKmg2XXrzogw1Q7C874uiWaES0UwAHubjK2gFosPssBueCUNfb3Xv+zU57/cZ7i5dWIhl7Jvcs7j+4xOlFvIVbCKK0rSwQ96uVUrmSM+WUQGqbYTYDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174391; c=relaxed/simple;
	bh=pEcdNS6biiuDg5Lz2TFAPdrcZP4bEIgW5De5HoGw8aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ehgh3pRR2HD2FIsyL67HC3MBMdsYxP+mDGUa3V1oujAsoPTwQbzfKsp7/aiFOoHDKe6LE03lyv1yFPj+W/miFmB6iXbdYJdXjU2mkppQztkx0BECJIMpNq3VXF/mLJZODT/PIVDyrOMykvnZ4AwTa27+rcbSKsyj82F6L40rCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JLi2So6Y; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JLi2So6Y"
Message-ID: <6c63dd3a-378d-471f-8af0-725edc3785ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736174377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1QBb1SxSbkhq0fjJPP/D8igQzmWEtDwWTFQrDDQ04OM=;
	b=JLi2So6YMgc1dnvVKl8hkq5wxmbpmbt93tP9dW3JvqKloiWUhxBzIW4jWw3BIH4IdoUiuD
	9wXf2ugoGGIVDR78uxu6XWy1ZOr8e/zHj8vPORYlyin6Oy6bcJETw/dBqjDwmgeLJYnrPl
	dmUulL7tkr6kcGySvUEWJOd+D5/Ekcs=
Date: Mon, 6 Jan 2025 15:39:34 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Christoph Hellwig <hch@infradead.org>, Vishnu ks <ksvishnu56@gmail.com>
Cc: Song Liu <song@kernel.org>, lsf-pc@lists.linux-foundation.org,
 linux-block@vger.kernel.org, bpf@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <Z3uIOPxr4s09qS1X@infradead.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Z3uIOPxr4s09qS1X@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06.01.25 08:37, Christoph Hellwig wrote:
> On Sat, Jan 04, 2025 at 11:22:40PM +0530, Vishnu ks wrote:
>> 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors
> 
> You can't.  Drivers can and often do change the sector during submission
> processing.

If I get you correctly, you mean, the action that **drivers often change 
the sector during submission processing** will generate a lot of 
tracepoint events. Thus, this will make difference on the performance of 
the whole system.

If yes, can we only monitor fentry/fexit of some_important_key_function 
to reduce the eBPF events? Thus this will not generate too many events 
then make difference on the performance.

Zhu Yanjun

> 
>> 2. Captures sector numbers (not data) of changed blocks in real-time
>> 3. Periodically syncs the actual data from these sectors based on
>> configurable RPO
>> 4. Layers these incremental changes on top of base snapshots
> 
> And all of that is broken.  If you are interested in this kind of
> mechanism help upstreaming the blk-filter work, which has been
> explicitly designed to support that.
> 
> Before that you should really undestand how block devices and
> file systems work, as the rest of the mail suggested a very dangerous
> misunderstanding of the basic principles.

