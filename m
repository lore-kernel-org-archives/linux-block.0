Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10D433C8
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732749499; cv=none; b=NgMuCTgnlTFLwZmFnfws2h+9h/lEHwemcbJfn2NORTzc9wsb/nHLsT3undPwBrAJSVHiMR1aC1My97aEkl2CZ5tciv45xXuk4Y5pj18OwU53hC7MCCb8kvO2n0aBVnAtojnFdYfMfAtj4FuTGq+K4v28Hqc+ta2MWiGmgHEUbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732749499; c=relaxed/simple;
	bh=m55HCj8KJwRe+uSRYV6l0BgUUvUtFVUJBRnYMlf2A8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IR/0CedlphEKgJFSlid+3ZSq9yerVcW9Ow+mnUjNAOP1FAnRR1A1TDi+YBZF3DqOVoEzfM0DAidKQXxx85S7pczRcwvBnf1azxBslZJJJf9clzomkRcafng9jTsyJbVJBm7z+76N/AaHOKTJFrlbsTZTZnihINQXQ2clpxnxZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4esXZzd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4esXZzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7310DC4CECC;
	Wed, 27 Nov 2024 23:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732749498;
	bh=m55HCj8KJwRe+uSRYV6l0BgUUvUtFVUJBRnYMlf2A8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X4esXZzd9H5ALCfPRCogeI2loLQfEPf6LMw2bnuSNaggWaXyER4gpSkIJgcZGwTm/
	 hhlgmkPkfzWRBMDGn37bP2q1pfw2mfFuenxae8L07Rin7xFeON+eZ/oIIPiz6PRg0b
	 990TQYfjfXt1maVIKqifvSz1DraY2T7GpcfGNKvlhYucD7gDSlwmYkbG0TA2B/pUrR
	 ltz2YHidFq76nBug/anuq7FTIEjgph2EFYeY1Q1EZfCu5W5qTZo+Jy55NADC7P7NGz
	 I3CYa5AewPkzVnLdwRI/GKLEXGyMeDg7U7sbRep6fWehQ3UEwolTFJ8Pczx7VTRw99
	 hwcgnZHqWRIlg==
Message-ID: <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
Date: Thu, 28 Nov 2024 08:18:16 +0900
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
References: <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
 <Z0a9SGalQ5Sypfpf@infradead.org>
 <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
 <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
 <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
 <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
 <Z0dPn46YnLaYQcSP@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0dPn46YnLaYQcSP@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 01:58, Christoph Hellwig wrote:
> On Wed, Nov 27, 2024 at 08:31:43PM +0900, Damien Le Moal wrote:
>>> We should not issue a report zones to a frozen queue, as that would
>>> bypass the freezing protection.  I suspect the right thing is to
>>> simply defer the error recovery action until after the queue is
>>> unfrozen.
>>
>> But that is the issue: if we defer the report zones, we cannot make progress
>> with BIOs still plugged in the zone write plug BIO list. These hold a queue
>> usage reference that the queue freeze wait is waiting for. We have to somehow
>> allow that report zones to execute to make progress and empty the zone write
>> plugs of all plugged BIOs.
> 
> Or just fail all the bios.
> 
>> Note that if we were talking about regular writes only, we would not need to
>> care about error recovery as we would simply need to abort all these plugged
>> BIOs (as we know they will fail anyway). But for a correct zone append
>> emulation, we need to recover the zone write pointer to resume the
>> execution of the plugged BIOs. Otherwise, the user would see failed zone
>> append commands that are not suppose to fail unless the drive (or the
>> zone) is dead...
> 
> Maybe I'm thick, but what error could we recover from here?

The BIO that failed is not recovered. The user will see the failure. The error
recovery report zones is all about avoiding more failures of plugged zone append
BIOs behind that failed BIO. These can succeed with the error recovery.

So sure, we can fail all BIOs. The user will see more failures. If that is OK,
that's easy to do. But in the end, that is not a solution because we still need
to get an updated zone write pointer to be able to restart zone append
emulation. Otherwise, we are in the dark and will not know where to send the
regular writes emulating zone append. That means that we still need to issue a
zone report and that is racing with queue freeze and reception of a new BIO. We
cannot have new BIOs "wait" for the zone report as that would create a hang
situation again if a queue freeze is started between reception of the new BIO
and the zone report. Do we fail these new BIOs too ? That seems extreme.

-- 
Damien Le Moal
Western Digital Research
