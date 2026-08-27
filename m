Received: from mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A395477E
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870440; cv=none; b=mH6a4cKZtz3DUUyaMayeaSymxuzZkayDbsKr0MxMT8wDZUtlKzkKE493NjQrc0qvQcRQGYjS9/rFCuLvbRiJVCMaizFMXqslN7Bz2mrLuVuMH2R7ixw9g08XUHFd3+WhQe2K6drZUEHmkB81vp8Jffu3lq7o1C4bbXv5+VTHF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870440; c=relaxed/simple;
	bh=N88uwlR+V7OFNo6nTFVNlis3NlJZmcYcr6lDMd++8gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ls4CUKIL+LakZV9LY8q4ri3XX+SAVgHEhbdshK6WzLP5dN+EE81OpwmvZ902vNNMTZPYPFPZVEg9ZpjglqQJJ6tgdOGM0WfMuxxjoQzDkB1/1OdIDWXhXDfIHXYQUjb861OfgWpDWIAzljYizpzDim7J1TwS25kcQfpwLRZfm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Iv8P3t2p; arc=none smtp.client-ip=95.215.58.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iv8P3t2p"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=N88uwlR+V7OFNo6nTFVNlis3NlJZmcYcr6lDMd++8gI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787870435; v=1; x=1788475235;
 b=Iv8P3t2ppKMs7c6fWb/2R+jiux5+gIJsWbcFArJGAu9RCfUC1vJJu80zYQInwuoVytCOH3X3
 N3WWRAXXqH261stepjKo+pFmvrhayspq31LOmPB3xb2IqO9sNWDdb9hpbyqsqZosE2gQUIjmmMN
 u7dKIrFJHYj6SjZYL4TMalf0=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f50caea4806efe81;
	Thu, 27 Aug 2026 22:40:35 +0000
X-Mizu-Trace-ID: f50caea4806efe81
X-Migadu-Flow: FLOW_OUT
Message-ID: <59ef2bb2-e24f-4d0f-95cc-3bca54dde48c@linux.dev>
Date: Fri, 28 Aug 2026 00:40:33 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC for-next 0/3] block: delay support for error injection
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>
References: <20260827000115.128093-1-haris.iqbal@linux.dev>
 <ao-z23T9yE6Z2BTZ@kbusch-mbp>
Content-Language: en-US
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <ao-z23T9yE6Z2BTZ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/27/26 05:49, Keith Busch wrote:
> On Thu, Aug 27, 2026 at 02:01:12AM +0200, Md Haris Iqbal wrote:
>> Two things are worth a look.  A delayed bio is resubmitted below the
>> injection hook, so the rules are not applied to it again and it can never
>> pick up a status from another rule.  And holding a bio back reorders it
>> against bios submitted later, which breaks sequential write ordering on
>> zoned devices.  Both are documented in patch 3.
> 
> Would it be possible to do the delay on the completion side instead?
> That should avoid those submission order problems.

Seems not. At bio_endio, bi_size is 0 hence the comparison rule cannot 
be calculated. What can be done is to capture the decision to delay or 
not at submit, and then execute it at completion, but something (the 
same kmalloc_obj?) needs to carry this all the way.

Besides, the bio would have been written to the device already, meaning 
if the rule said to delay and then fail, the upper layer will see the 
failure, but the data would have landed in the disk. Maybe not the worst 
idea, but still semantically incorrect since the documentation claims 
that nothing is seen by the device.

One way would be to omit delay injection for all bios meant for zoned 
block devices.
