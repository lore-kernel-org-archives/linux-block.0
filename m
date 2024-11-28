Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2FE360
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 04:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732769577; cv=none; b=k/IQDsPz2CNJzRsf+mqnyNUq8Bm2Cb2q9ZEsfyskIs8zTxLhbTdau7SCVk/P1qC+3zQlm2aTbMvF5+Y7fiaL3reKvRXwTqIuo8/lvOPjIYtpR/fOyM16qDU8pY1OQJeZEQDFQ+XzSYj9Pg6SKQ8ThnZ3Hs8C9C9ZGTt8o7K8Qkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732769577; c=relaxed/simple;
	bh=h6+hfh1daxiVMluDielZ8EGYjfjJl0zcXIugU45Np88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pm1/mItHDTgcayySkjW6gIM395XsGlV2UnfTbeY2onVgS1ZDT1QmJf/V9nxBu+44au1f+xBnXdFRMyEGjp/mWH4x5AGYZKZdxKLW11MjBd7pQ7FCnYKN7M8JJNfV65RAEd5MBbgvcKQ607fbUqFbtLoDnHG8IEk0sYKs+xGW6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd1Ru4Aa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd1Ru4Aa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63D7C4CECE;
	Thu, 28 Nov 2024 04:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732769577;
	bh=h6+hfh1daxiVMluDielZ8EGYjfjJl0zcXIugU45Np88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rd1Ru4AaLntaE1lXHi2wOIPLIyEnA/HOoeaTJoZLBsT0XGP2tRk4rVUp00a3Fa4MW
	 NqGqUJf0rIYPyKFikMA+wzeySoyryX7BAnsfjQ7Avb//QPKfmicWaSc+APs3FIq/6W
	 ghiLvQ580Y/FM3kZeT71FIC9xpUMJsJdTv+KbX81RgW8r74dFEf8ogeRFg8mOjii1J
	 MuUAjTx5Sylg03OOb4y7FJss46SrNOwDynU47CuZRkAVdXJnTzdx6cnZVRFTkinZfg
	 EpkC7iC8J3RfQhHqEoOkZRUhuhYstb7rRxGmakTJxVczepncwpCF4LQmmky+RxYSJ7
	 cR6/7Yt9V1aBA==
Message-ID: <43c0f15e-7f3b-4ed9-bde9-dca2cff57afa@kernel.org>
Date: Thu, 28 Nov 2024 13:52:55 +0900
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
References: <Z0bAHKD-j49ILtgv@infradead.org>
 <52570aad-c191-4717-b91d-a555d9dfda96@kernel.org>
 <Z0bIDopTmAaE_nxQ@infradead.org>
 <0e2dc18f-d84e-4dcf-a5c2-134d579c480c@kernel.org>
 <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
 <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
 <Z0fhc8i-IbxY6pQr@infradead.org>
 <16e543dd-c4e6-4f79-b401-8030d7ba1514@kernel.org>
 <Z0f0B6Xf-jdc_fx-@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0f0B6Xf-jdc_fx-@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 13:39, Christoph Hellwig wrote:
> On Thu, Nov 28, 2024 at 01:37:46PM +0900, Damien Le Moal wrote:
>> suggested: a BLK_ZONE_WPLUG_NEED_WP_UPDATE flag that is set on error and an
>> automatic update of the zone write plug to the start sector of a bio when we
>> start seeing writes again for that zone. The idea is that well-behaved users
>> will do a report zone after a failed write and restart writing at the correct
>> position.
>>
>> And for good measures, I modified report zones to also automatically update the
>> wp of zones that have BLK_ZONE_WPLUG_NEED_WP_UPDATE. So the user doing a report
>> zones clears everything up.
>>
>> Overall, that removes *a lot* of code and makes things a lot simpler. Starting
>> test runs with that now.
> 
> How does that work for zone append emulation?

Same: the user must do a report zones to update the zone wp.
Otherwise, it is hard to guarantee that we can get a valid wp offset value after
an error. I looked into trying to get a valid value even in the case of a
partial request failure, but that is easily douable.

I could keep the error work and trigger it to do a report zones to refresh zones
wp on entry to submit_bio() also instead on relying on the user doing a report
zones.

-- 
Damien Le Moal
Western Digital Research
