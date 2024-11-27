Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810013BAE4
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689808; cv=none; b=Cyh0tH16tIeIO2rMNBf/VOt/kLIM8h+hWsqLoTgZXe46EXA22s2jGR2+7IZ/gqtlnQyG91HIPtYb6QRxlTSbHQwXtxOqsqilDb/As4a0H/0mCEH5Yp4MUZ4ogELsfu29NU+U6rY1V44sKU0KyZq2qdpCWF70ECyu35AWUkA0nvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689808; c=relaxed/simple;
	bh=7u6BP9sf3OvJG4N5PTze4sc669mMfDdDHuaI2OpG8CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWaVZywl844Rz10r53Y7nbOSAV4FkqhsqHzOihWjv9vAi0UhnloQ35Komn9GCMm9ygFs3fz+YD9fABaEge/ohBY5VHa1hUat9ZdRAxeu6thm545jSqVUtTCV1rXXiE4fp62uUQO10mN0SZUjB9eRCxcRiELlammZ40SX0u7PV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8IDDWE7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8IDDWE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B32C4CECC;
	Wed, 27 Nov 2024 06:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732689807;
	bh=7u6BP9sf3OvJG4N5PTze4sc669mMfDdDHuaI2OpG8CI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N8IDDWE7SBOvj300+yrctCgnImF5Vc+bkpU0AAkExozV0YzCamTMOhvMkJ27uB07+
	 8aHnKYPe4iMlmI/49mnQ+Jb+I7EHzeZMDTWXO3F/IJNBiMKJ83airPR9UVpbePC+Nf
	 VJCqv4kU5g+f74yIIYSK6KOac4/yPkZpjbzRJqkXV+kNlBSkqIJG4c4eIdTS3v8RU4
	 HrEtFHOTT2ThMpM+PM/C8IL83elOTXPkARREcP/Z965ktqIHy/22RIgbiOnYebRvuL
	 loq1201sGA+vScu3R1z9hSd+MwxvnOW3+jpoab4gSrADiRtrD7PCdJFub3EE2fqQIY
	 HepKE0d04I/hQ==
Message-ID: <9d224032-254f-4b4a-a667-d1538cdbf0dc@kernel.org>
Date: Wed, 27 Nov 2024 15:43:11 +0900
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
References: <20241125211048.1694246-1-bvanassche@acm.org>
 <18022e10-6c05-4f7a-af8a-9a82fdb3bbc5@kernel.org>
 <ef0b613a-d692-4b04-b106-0a244bf4bfc1@acm.org>
 <12c5ee53-dcc6-4c78-b027-8c861e147540@kernel.org>
 <Z0a5Mjqhrvw6DxyM@infradead.org> <Z0a6ehUQ0tqPPsfn@infradead.org>
 <73fb6bae-a265-43c3-a362-3cece4b42bbe@kernel.org>
 <Z0a9SGalQ5Sypfpf@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0a9SGalQ5Sypfpf@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 3:33 PM, Christoph Hellwig wrote:
> On Wed, Nov 27, 2024 at 03:32:04PM +0900, Damien Le Moal wrote:
>> Might be good enough. But will also need to clear the REQ_NOWAIT flag for the
>> BIO if it is issued from the zone write plug BIO work. Because that one should
>> not have to deal with all this.
> 
> Yes, by that time there is no point in the nowait.
> 
> Another simpler option would be to always use the zone write plug BIO
> work to issue NOWAIT bios.

I thought about that one. The problem with it is the significant performance
penalty that the context switch to the zone write plug BIO work causes. But
that is for qd=1 writes only... If that is acceptable, that solution is
actually the easiest. The overhead is not an issue for HDDs and for ZNS SSDs,
zone append to the rescue ! So maybe for now, it is best to just do that.


-- 
Damien Le Moal
Western Digital Research
