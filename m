Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A91CCB4D
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020886; cv=none; b=FBle9lw/rdV+SRFfyNGDgIucpck3Jaj/n74rGMp2C2e5M0X4hJkqXTdBNTi6hef2THTOgsLl5BLEM4JbXds5uVCIG5+BSW235GxHCQlpbWdm3FlmTZBqxIhpB1zhGFSmG9aSwNF++yntS42I92OYSdhPD/JSa4oQMhc44yvdJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020886; c=relaxed/simple;
	bh=0wPbq+1eRnZaEL11TacRg/0k/Agmt5atEP661GUrEK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8FswZ85ii3iNtUldwT2H8xUyVuPReB3pOjRjV27TBwGTFjMUQoDapVougsDGsx+vDED5Mx/bgz6U+Jo58rJEy2BZHwt0KAuCZRAnFgyu+SwA5RIfsrMmSzYQg3P2KJ+e35A7t0GN2sD4470EOV2ukqw//ZhjM+jo29BJcQa4ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A4F868D81; Tue, 19 Nov 2024 13:54:41 +0100 (CET)
Date: Tue, 19 Nov 2024 13:54:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: return unsigned int from bdev_io_min
Message-ID: <20241119125440.GA31381@lst.de>
References: <20241119072602.1059488-1-hch@lst.de> <5108f61a-c471-457c-ba32-3003925a4de1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5108f61a-c471-457c-ba32-3003925a4de1@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 19, 2024 at 12:52:40PM +0000, John Garry wrote:
> On 19/11/2024 07:26, Christoph Hellwig wrote:
>> The underlying limit is defined as an unsigned int, so return that from
>> bdev_io_min as well.
>>
>
> There seem to be other helpers with the same condition.
>
> Even bdev_io_opt() is defined as returning an int, but actually returns an 
> unsigned int. And even though not a bdev helper, queue_dma_alignment() is 
> similar.

True.  I'll cook up patches - I just noticed this one because of a
series that added casts to the return value which made me look there.

