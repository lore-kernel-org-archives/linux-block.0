Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4713AD39
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728364442; cv=none; b=olNizpDj0gG7WDVvDU/Y99bsDXs9ORBCZfS1/OZuB07LFxWvkWCpEEEedmtaXlMqTR5AhIC5/jvXASQxmcMpTPGyrCwowS2+VSlmrBkLrTjbnE01e4NNim3mpf0L7tmJNcL27uLfFfnWIsnYcbsYCSxjailbK44KLmaag6mDWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728364442; c=relaxed/simple;
	bh=a/zbZIuAvVl1hGpkkll37Yd1W+bPI193D2jr1ptUQZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiQGp1irSa/nAt7A2Vc2Q2uXGWwqFnxu2cmEE6Ih2CxOpTue1HPo16BPot0yxShGbxlhOeDDZywtkMKPnb++hdsSc7KJCVVVPP57MOdxx/QfmBrwG79Ywzjm/pf3L6Slxp+NelPvB535pmsmehAsAXZ2W0IbEDPTFh/fxjbUH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drN/PKGO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drN/PKGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A8AC4CEC7;
	Tue,  8 Oct 2024 05:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728364442;
	bh=a/zbZIuAvVl1hGpkkll37Yd1W+bPI193D2jr1ptUQZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=drN/PKGO6+FgFNeKmlfBc2zYrikNNw5Ogk0qmIl+DZ3JC4Db+zN9V7+XY2ued5jJt
	 JteMKAVSXI2S0Wo8zMBB9wuNQ2mYJejvxxWASWX145LIXdhE6ooqeKWKIetLFzT3XT
	 bUzq7yfhMRKOSrQBYuGO+ISm+NPevk6Xwkqbs1cSvfIkBvsK2zbeMlovm0CYKLIvfW
	 lGmzTIGopZIkuLduJFWYaemJYa0gjNSVfMLW00CSWoTVhzkAfKaS5pilpTGzDP9k1i
	 kVQKJlXelGb6Anv3Wso/5sJKxT9YxzalplyMxQBs89klpcjLjDOOxEcvtI3AJ5R5cL
	 362eVmZYP4HtQ==
Message-ID: <0d22b10d-8e84-44fb-9bbc-f66ac1de1cc5@kernel.org>
Date: Tue, 8 Oct 2024 14:13:59 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Fix elv_iosched_local_module handling of "none"
 scheduler
To: Christoph Hellwig <hch@lst.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Richard W . M . Jones" <rjones@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
 Jiri Jaburek <jjaburek@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240917133231.134806-1-dlemoal@kernel.org>
 <87ed4snq2h.fsf@kernel.org> <ee7bcfc3-ce25-4cdd-95c0-c96585128424@kernel.org>
 <20241008042005.GA20982@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241008042005.GA20982@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 13:20, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 07:48:10AM +0900, Damien Le Moal wrote:
>> Yes, ->load_module() should return 0 on success and negative error code on
>> error. Otherwise, a positive error may be interpreted by user space as a success
>> write to the sysfs attribute. Adding a comment for that will be good too.
>>
>> Care to send a patch ?
> 
> It should not return anything at all as alreaday said last round.
> Jens just asked for that to be sent layer, so I guess I'll do it now.

Ah, yes, that is even better.

-- 
Damien Le Moal
Western Digital Research
