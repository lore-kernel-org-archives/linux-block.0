Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F756B8C
	for <linux-block@vger.kernel.org>; Sat, 21 Dec 2024 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734768647; cv=none; b=pCEcdp+JsbWDBnhezxbJGMTVuEsZ6gI3Toa4msezE/1e+x6PQ8coasK56CyxPpGQwvRxTz/2ELTBs8E7QtjUKlKGl39G9PaoI47AawZvnNLp7JRTKclPpnDIkl+jd1Wecn5o43iJfWPwt2jBj8IBM+vaK9HYppoGKVk+5zaTZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734768647; c=relaxed/simple;
	bh=wHhrwqBBPc+5nmpy83JPqFih8hJPWZXtDGFjRjn2VBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXN7pb/BWsEI/GLWXvmhIR8VYwEnpRueikF3+ShLYiL9r354SP6889SouGDW/7hcMQyfBojYjzkGIENSRNB8oBl88PDdxFM0fBkmTYdMZgURsZ/rSbUNIgl2Oiy6dojYWr1M9e+Gf0l8Uib6SWUIGfleKCSZZHKvWjok4HfCHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5F3F68BEB; Sat, 21 Dec 2024 09:10:33 +0100 (CET)
Date: Sat, 21 Dec 2024 09:10:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Zoned storage and BLK_STS_RESOURCE
Message-ID: <20241221081033.GA13103@lst.de>
References: <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org> <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk> <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org> <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk> <f41ffec1-9d05-47ed-bb0e-2c66136298b6@kernel.org> <e299e652-2904-417c-9f76-b7aec5fd066b@kernel.dk> <fb292dc8-7092-45c1-ae8a-fca1d61c6c9a@kernel.dk> <9e8e2410-53b5-4dad-8b54-b7e72647703b@kernel.org> <20241218065859.GA25215@lst.de> <78caa04c-34b6-4801-a57a-84251dd9d253@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78caa04c-34b6-4801-a57a-84251dd9d253@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 19, 2024 at 10:04:40AM -0800, Bart Van Assche wrote:
> On 12/17/24 10:58 PM, Christoph Hellwig wrote:
>> Use the new append writes that return the written offsets we've
>> talked about.
> Here is why this is not a solution for SCSI devices:
> * There is no Zone Append command in the relevant SCSI standard (ZBC).

Standard exist to be changed.  It's not like UFS folks have been pushing
all kinds of novel unproven crap all the time anyway.

