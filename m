Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA2226CFE;
	Tue,  9 Jun 2026 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991163; cv=none; b=OBzuk7azsVd7lLIacE50gYqSqhPZkuZ8b2g7uil+Ba8tYGSLlKD0iuyemE6tIJ7dGz7OyuJQXLOtFAsW4gszafYwmRFdn/xAJH0+bxQeKoLJGk9uGupVrEIcOP0VbrwOCTIHbxK2M6+Egzm+BtobD+/V8MZcxrAhUpOorv1tk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991163; c=relaxed/simple;
	bh=pz9yiqDjBu9r2Wei3+P7L8usowMFyLxDI0wN0AsaewU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDM60E8uFqPxmY72j0FGE0PNjPuwwUJz+6GjVFD3Bdh0JC2rpO+5KtPo2BnNZ+9ylDzJnp7DqolX1N7G3tmmgd0GqwWql5iUOLUDuWjay8WUsUcK6IH922aDReej7oEZWbt0qumO/WbKuObVWCNM5KSihz8DbxO+Q4lFToZ2N8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7465B68B05; Tue,  9 Jun 2026 09:45:47 +0200 (CEST)
Date: Tue, 9 Jun 2026 09:45:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH 3/4] block: add a str_to_blk_op helper
Message-ID: <20260609074546.GD6877@lst.de>
References: <20260608051416.1205282-1-hch@lst.de> <20260608051416.1205282-4-hch@lst.de> <5e738f79-e1d9-4224-ae85-322967682a1a@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e738f79-e1d9-4224-ae85-322967682a1a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 08, 2026 at 02:57:40PM -0700, Bart Van Assche wrote:
> On 6/7/26 10:14 PM, Christoph Hellwig wrote:
>> +enum req_op str_to_blk_op(const char *op)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(blk_op_name); i++)
>> +		if (blk_op_name[i] && !strcmp(blk_op_name[i], op))
>> +			return (enum req_op)i;
>> +	return REQ_OP_LAST;
>> +}
> The above function is similar but not identical to
> __sysfs_match_string(). Is __sysfs_match_string() good enough in this
> context?

__sysfs_match_string exists as soon as an array entry is NULL, but
blk_status values are not fully contiguous, so no.

