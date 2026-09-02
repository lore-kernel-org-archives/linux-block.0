Received: from mta0.migadu.com (out-88.mta0.migadu.com [91.218.175.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA054A9D6C
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378540; cv=none; b=h0BQuxnJCYWNPMOyhomZseG0wTKCdrfLdRMF92zqgMeLU9GeP1AnaRWu9kdSXXVXfdJfUoHSUUTWbp/QQLvnfYHhA7aPIuuQi9LABgw8MPqKXYWPRhx8AR4auYv2zkE/NveUyrmqvhZIHO/Ec4ivRa4/zN1K1FqynIoGgoddv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378540; c=relaxed/simple;
	bh=q6Ch4vtqSG74hj505wHaVPu00x50jG6mrrZuNCQcrB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nL9WRiHCokBGxPyOzqPCt/pe0wa+DwkTbiiFM0/4cdv1e8WRavR82vicll9vSDE+uLQrXFB4IxhXx+f70zKCK8QLeKPMYaZYR83iP0KfrSX1++nY40kvck4sApBeGwkNt3FkGE723tSAOshDK+IVdlu1F5BvbwS24bA5ipjUW6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qlXBXnLq; arc=none smtp.client-ip=91.218.175.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qlXBXnLq"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=q6Ch4vtqSG74hj505wHaVPu00x50jG6mrrZuNCQcrB8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788378523; v=1; x=1788983323;
 b=qlXBXnLq1pd4WGrrjUG3JmiVDDT+4sNQVo2e8Veq+L24zir0DNZJicryScgWDBWMPKJppLuF
 vbhZB69gbqGFcKM8my4jybMAPXyMssZldybF0NqhXzZnY6bNXz0Zllz73xGeWJD4ECxg2NlWkwv
 lK6ulhxiJG4kzHUl8AExPBKM=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9af95a88ea923d85;
	Wed, 02 Sep 2026 19:48:43 +0000
X-Mizu-Trace-ID: 9af95a88ea923d85
X-Migadu-Flow: FLOW_OUT
Message-ID: <e5798ee0-99c3-4a5e-bcf0-355aa0d2dd9a@linux.dev>
Date: Wed, 2 Sep 2026 21:48:39 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 for-next 1/3] block: reject unknown status tags in error
 injection rules
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260830012002.80275-1-haris.iqbal@linux.dev>
 <20260830012002.80275-2-haris.iqbal@linux.dev>
 <20260902135800.GA22743@lst.de>
Content-Language: en-US
From: Haris Iqbal <haris.iqbal@linux.dev>
In-Reply-To: <20260902135800.GA22743@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/26 15:58, Christoph Hellwig wrote:
> On Sun, Aug 30, 2026 at 03:20:00AM +0200, Md Haris Iqbal wrote:
>> tag_to_blk_status() returns BLK_STS_OK both for the "OK" tag and for a
>> tag it does not recognise, so a caller cannot tell the two apart.
>> match_status() leaves *status at BLK_STS_OK for an unknown tag and relies
>> on error_inject_add() rejecting BLK_STS_OK.
> 
> There is no *status yet.

Ah yes. I'll correct it.

> 
>> That holds only while a rule without a status is meaningless.  The delay
> 
> This reads a lot like AI slop.  Can you please self-write a short and
> descriptive commit message?

My bad. I'll correct it.

> 
>> -	 * Return BLK_STS_OK for mismatches as this function is intended to
>> -	 * parse error status values.
>> -	 */
>> -	return BLK_STS_OK;
>> +	return -EINVAL;
> 
> No need for an int return here, this can easily be done with a bool.

True. I'll change it.

I'll wait for your comments for the other patches before sending a v3.

