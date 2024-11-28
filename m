Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519213D891
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768669; cv=none; b=fOSKJv9lEsW7Y6FpHECQ4w4aLAhCL+ea2ErTeL1NSfIM7VIaGp2jA/W8+JjeTqw+/3135mptiaTRcPehtJAkS2UNTU1NCye2C5SEyOo8hFdiiOXQAVy9LrWiSdf4KhFno/Avbhr8bWymPuK3ij4Y1G+kACIUrXSDTG8P6PIHQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768669; c=relaxed/simple;
	bh=tf9sSKbB9pqCRhDsRdvSz4cswSxBOC29e41WzRObwI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdJiE9LeSszhiMamK7r1fTemej+a7WPqPxG8shc5A71Aj7qRztTIiJUm+WdKg/5trty+moXNlsaEl4oL6Cv3SkJsunrTFFQtopfZy8xn+mwL2PatIDpFdiM5/pCQ8XnNvE7/k09COdCw48MQc/e/UYybbhuk4F8kJ4aThcIGyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtO0qyzh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtO0qyzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00321C4CED2;
	Thu, 28 Nov 2024 04:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732768668;
	bh=tf9sSKbB9pqCRhDsRdvSz4cswSxBOC29e41WzRObwI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AtO0qyzhhda2mZe7GDK/baKg3yIxxMrUzy8i6wIfiVNQ5IYFXxFtxvWqV1lAR2B++
	 P080q3JJSElxyRkkqGE3H2UxyJPDL8MrLn+G4G5eL0VQw2dg6cTreliS0KnHvWyFV2
	 V3SRuUwEkfFeGEcazvmNwRxiIgYKylwBS35L+Kb/br448etszcJPrO10WuAIK8D7ZN
	 3gz1okRpp5HxZPPQUdObmX4wnni1rVw6R7sA4t4tZl1KC/svoHkZzH8pECx7U1h6zQ
	 FvHrsbhuN/DY7+LGsoZ9FPiK1CAn87TQCbnVeDtOj+AQAEZnY6p9fSmdqM8+FoT+kW
	 VmVEn54PiwOOw==
Message-ID: <16e543dd-c4e6-4f79-b401-8030d7ba1514@kernel.org>
Date: Thu, 28 Nov 2024 13:37:46 +0900
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
References: <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
 <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
 <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
 <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
 <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
 <Z0fhc8i-IbxY6pQr@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0fhc8i-IbxY6pQr@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 12:20, Christoph Hellwig wrote:
> On Thu, Nov 28, 2024 at 08:18:16AM +0900, Damien Le Moal wrote:
>> The BIO that failed is not recovered. The user will see the failure. The error
>> recovery report zones is all about avoiding more failures of plugged zone append
>> BIOs behind that failed BIO. These can succeed with the error recovery.
>>
>> So sure, we can fail all BIOs. The user will see more failures. If that is OK,
>> that's easy to do. But in the end, that is not a solution because we still need
> 
> What is the scenario where only one I/O will fail?  The time of dust on
> a sector failign writes to just sector are long gone these days.
> 
> So unless we can come up with a scenario where:
> 
>  - one I/O will fail, but others won't
>  - this matters to the writer
> 
> optimizing for being able to just fail a single I/O seems like a
> wasted effort.
> 
>> to get an updated zone write pointer to be able to restart zone append
>> emulation. Otherwise, we are in the dark and will not know where to send the
>> regular writes emulating zone append. That means that we still need to issue a
>> zone report and that is racing with queue freeze and reception of a new BIO. We
>> cannot have new BIOs "wait" for the zone report as that would create a hang
>> situation again if a queue freeze is started between reception of the new BIO
>> and the zone report. Do we fail these new BIOs too ? That seems extreme.
> 
> Just add a "need resync" flag and do the report zones before issuing the
> next write?

The problem here would be that "before issuing the next write" needs to be
really before we do a blk_queue_enter() for that write, so that would need to be
on entry to blk_mq_submit_bio() or before in the stack. Otherwise, we endup with
the write bio completing depending on the report zones, again, and the potential
hang is back.

But I have something now that completely remove report zones. Same idea as you
suggested: a BLK_ZONE_WPLUG_NEED_WP_UPDATE flag that is set on error and an
automatic update of the zone write plug to the start sector of a bio when we
start seeing writes again for that zone. The idea is that well-behaved users
will do a report zone after a failed write and restart writing at the correct
position.

And for good measures, I modified report zones to also automatically update the
wp of zones that have BLK_ZONE_WPLUG_NEED_WP_UPDATE. So the user doing a report
zones clears everything up.

Overall, that removes *a lot* of code and makes things a lot simpler. Starting
test runs with that now.

-- 
Damien Le Moal
Western Digital Research
