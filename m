Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF4AD4B
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732771168; cv=none; b=lRHC63lidKbZ011BJKW9hTb7CkovobrHdhKTQLyRG1da+xn/QKHXHVZpvKKuz1G+FKpgHwi1+NwA6GUr2zto4oSVbDIo+yXVWe5G/BKfgBk+5axPNd5aptlHP5wqZjlNJBalVZb+I3xBLIdI1y4kaID6ah8LGGvPsZzJg23jWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732771168; c=relaxed/simple;
	bh=Tb9PU+zz1Bls0FFbXzRYyfOqTj3gegxEu5kBujDRsT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzFcsseAgJuJ7SDxDGQ3uTaklB8MZiSLLMl1/+QMmlPR5ouCxyG1GGLk0VNRuau1SoeMudBLBOYxNKlbXQzlvNUHpu9gtArSyadPamMU5N28NXNxyevby4w5dXHifb4rYq6CdcwVvuf7SMDPVjzhdOumTTTY/nU1WbxJXXll8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0WFjKSO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0WFjKSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE336C4CECE;
	Thu, 28 Nov 2024 05:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732771165;
	bh=Tb9PU+zz1Bls0FFbXzRYyfOqTj3gegxEu5kBujDRsT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T0WFjKSOEwTmyX7CB44wt87lvHBYuZVB9alMAnoV2ZJXWALo6yWEcLvrHshNG+11R
	 GSMbOkA3Ce+VS5gy8yifMkPDhcGjHYXGQ31FKqOSwJIy06+wYmoGsVQ+7j8A+sPgtU
	 5FZW9tHZBz9rwnAVTAJr17KdnINeNLXVeWZyblDNGH58tsOR4KGy9Fpz2socDHselM
	 l7sQF6OioJ43hvqDrKCz235ZMugaPPhCgc2JvtlgVyDNLSlyKGDUACPQxjOmYG1V1D
	 F69TYxH+tZ1cOuuoXMU5QixQUQnUieDsFJ2csjlJrmduhvqsJHD2WmXrdh1qZLyUap
	 uJ3iRL8p1SmMw==
Message-ID: <684a3b59-776a-466a-8323-d92c0502e7a3@kernel.org>
Date: Thu, 28 Nov 2024 14:19:23 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
 <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
 <Z0fhc8i-IbxY6pQr@infradead.org>
 <16e543dd-c4e6-4f79-b401-8030d7ba1514@kernel.org>
 <Z0f0B6Xf-jdc_fx-@infradead.org>
 <43c0f15e-7f3b-4ed9-bde9-dca2cff57afa@kernel.org>
 <Z0f47wft_sVto7pM@infradead.org>
 <a9ad27f7-b799-4322-ba05-944abfc0fa88@kernel.org>
 <Z0f8uAFz5C60fung@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0f8uAFz5C60fung@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 14:16, Christoph Hellwig wrote:
> On Thu, Nov 28, 2024 at 02:07:58PM +0900, Damien Le Moal wrote:
>> A bad sector that gets remapped when overwritten is probably the most common,
>> and maybe the only one. I need to check again, but I think that for this case,
>> the scsi stack retries the reminder of a torn write so we probably do not even
>> see it in practice, unless the sector/zone is really dead and cannot be
>> recovered. But in that case, no matter what we do, that zone would not be
>> writable anymore.
> 
> Yes, all retryable errors should be handled by the drivers.  NVMe makes
> this very clear with the DNR bit, while SCSI deals with this on a more
> ad-hoc basis by looking at the sense codes.  So by the time a write error
> bubbles up to the file systems I do not expect the device to ever
> recover from it.  Maybe with some kind of dynamic depop in the future
> where we drop just that zone, but otherwise we're very much done.
> 
>> Still trying to see if I can have some sort of synchronization between incoming
>> writes and zone wp update to avoid relying on the user doing a report zones.
>> That would ensure that emulated zone append always work like the real command.
> 
> I think we're much better off leaving that to the submitter, because
> it better have a really good reason to resubmit a write to the zone.
> We'll just need to properly document the assumptions.

Sounds good. What do you think of adding the opportunistic "update zone wp"
whenever we execute a user report zones ? It is very easy to do and should not
slow down significantly report zones itself because we usually have very zone
write plugs and the hash search is fast.


-- 
Damien Le Moal
Western Digital Research
