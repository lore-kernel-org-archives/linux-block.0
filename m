Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7D4D8A3
	for <linux-block@vger.kernel.org>; Tue,  7 Jan 2025 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736212120; cv=none; b=TtfquGfmu1jFwrtib4HrPr9QCnMJWRKdeBuewp3fRzBpgaGWayFFXKzELoExz5GqO0DqCYzlw1v1SinFSgtXKENURrZNwC/rtCPSFSrdleXNGyfHudwPPmt/EHZ2UwMTRK4QXFzHhFCmjQi3K3k6RNMHJllbWCWPJq8kapZTeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736212120; c=relaxed/simple;
	bh=0O1deFSuqhegkQRnjArcqP152Ab7BEbaIhxVPX1n/0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGMnJf0jndYbV5ISJSSoIFbc6Xqv558I5kj98ZkCzuplLLEwyE6CMYaITpTICF82x9FmxEMUbfoyTwaJYiWo4aLz3/8gxNMZiYTPzCpHA9ifgUXo1rxIOxI1C0IIC6PlfTR24lkBVB9lPLCHXhvehv7PekLof26pm4BdWEzrARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjkeEk88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjkeEk88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF3EC4CEE1;
	Tue,  7 Jan 2025 01:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736212119;
	bh=0O1deFSuqhegkQRnjArcqP152Ab7BEbaIhxVPX1n/0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UjkeEk886TiG47Yh1TRqnSvzR47WrCvlYpGo58Vo0TkGFODWgIdXljVAap020WcGI
	 MxqmrBzxapuQVigij8q0F3TWN/+072y19B0fkXAxXlGsQRm3oqNCL0Yae3rTUwU5Ry
	 gJKYwCz+qkCwnMWRzUkYDqn9xMq5BwgtoytZ6DT8DTaTsK7bzJJejeeOH2bLPKOFGg
	 Kp2uzn7nolCzohTHTYbKFkjbnzags49BWOEYahwlc9aMX/ngi3r+GdwAuHWlQPTffm
	 MYHCCrin4MnWsCzMDZC+z5lq21klqPKXYaXjBA3ydkufk+wHzL4V0VTw+WcUH6Nhsk
	 po0ck0ItbQv5g==
Message-ID: <606367a7-9bb5-48e5-a7ef-466eefd833fb@kernel.org>
Date: Tue, 7 Jan 2025 10:08:38 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] New zoned loop block device driver
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20250106142439.216598-1-dlemoal@kernel.org>
 <2f7c9abe-a23f-4b2f-99aa-e6d220c74dd0@kernel.dk>
 <20250106152118.GB27324@lst.de>
 <98be988f-5f6a-489d-b0e1-2f783c5b8a32@kernel.dk>
 <20250106153252.GA27739@lst.de>
 <0f2eea00-e5e9-4cd1-8fe6-89ed0c2b262b@kernel.dk>
 <20250106154433.GA28074@lst.de>
 <5f57ff26-2c87-45fa-bb91-4f68492bac85@kernel.dk>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <5f57ff26-2c87-45fa-bb91-4f68492bac85@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 02:38, Jens Axboe wrote:
>> I think this is a valid and reasonable discussion.  But maybe we're
>> just not on the same page.  I don't know anything existing and usable,
>> maybe I've just not found it?
> 
> Not that I'm aware of, it was just a suggestion/thought that we could
> utilize an existing driver for this, rather than have a separate one.
> Yes the proposed one is pretty simple and not large, and maintaining it
> isn't a big deal, but it's still a new driver and hence why I was asking
> "why can't we just use ublk for this". That also keeps the code mostly
> in userspace which is nice, rather than needing kernel changes for new
> features, changes, etc.

I did consider ublk at some point but did not switch to it because a ublk
backend driver to do the same as zloop in userspace would need a lot more code
to be efficient. And even then, as Christoph already mentioned, we would still
have performance suffer from the context switches. But that performance point
was not the primary stopper though as this driver is not intended for production
use but rather to be the simplest possible setup that can be used in CI systems
to test zoned file systems (among other zone related things).

A kernel-based implementation is simpler and the configuration interface
literally needs only a single echo bash command to add or remove devices. This
allows minimal VM configurations with no dependencies on user tools/libraries to
run these zoned devices, which is what we wanted.

I completely agree about the user-space vs kernel tradeoff you mentioned. I did
consider it but the code simplicity and ease of use in practice won for us and I
chose to stick with the kernel driver approach.

Note that if you are OK with this, I need to send a V2 to correct the Kconfig
description which currently shows an invalid configuration command example.


-- 
Damien Le Moal
Western Digital Research
