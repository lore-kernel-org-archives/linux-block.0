Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3224C96
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 05:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749531861; cv=none; b=Dhf8C45ReyUnSgBG86oKLW3BsxdbXQT8hkywtpvR1ydACnskxxCkQxtUpX9+qsg0Z56XZbyUqYXr06U2f4EIHLey02MQqAFHVXk03FEttl6Dd+PTloy255GvROJd2heiBIcrAS0RPPKmF/4hqNIRNcoLV+EfHBNbwmasO2bbQR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749531861; c=relaxed/simple;
	bh=Ncm7ohjFSf78pV5r24JWVmmPIcaeBhPrW5Bnm9tF9Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYLiDls3UmwDfUSnHWcfsLKKJtlMeg2rxM4gwcc6jADRL0HYJe6NRU0mZiIqeSW7CgDztzJ7feIA62rFZ3yLXl4Je8KNq1wdcZxIwzo9yURRx8cidEQbovcS1NIjfoxUcnCyLB+2M+i0SkuA55P5SQ69TtN8XbEMlY0NIQG+yzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6918068C4E; Tue, 10 Jun 2025 07:04:15 +0200 (CEST)
Date: Tue, 10 Jun 2025 07:04:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
Message-ID: <20250610050415.GA25014@lst.de>
References: <20250521055319.GA3109@lst.de> <24b5163c-1fc2-47a6-9dc7-2ba85d1b1f97@acm.org> <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org> <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org> <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org> <907cf988-372c-4535-a4a8-f68011b277a3@acm.org> <20250526052434.GA11639@lst.de> <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org> <d8f5f6eb-42b8-4ce8-ac86-18db6d3d03d0@kernel.org> <a0c89df8-4b33-409c-ba43-f9543fb1b091@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0c89df8-4b33-409c-ba43-f9543fb1b091@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 09, 2025 at 01:48:06PM -0700, Bart Van Assche wrote:
> On 6/8/25 3:47 PM, Damien Le Moal wrote:
>> So yes, we need a fix. Can you work on one ?
>
> The patch below seems to be sufficient but I'm not sure whether this
> approach is acceptable:

It's still the wrong approach.  Please add the splitting needed for
the blk-crypt fallback to __bio_split_to_limits instead.

