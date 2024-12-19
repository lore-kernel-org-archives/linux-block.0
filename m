Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67B1F868D
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 06:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588921; cv=none; b=iWx5q4PZSOFXSUelmjp1P+DdjW752pOZDcYWW395OBmVuVufdt+j9LUq9lAWHeE/veg2SmDUOI0XlGwcuehcfZ+lBnXRRcxRoQlIDJoNDEge7ClRqrtIg4s+Rn5dXhitd5cs1HHaeYf2f2CaT+geWztfWtT/dFMqvI7qNhQaMYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588921; c=relaxed/simple;
	bh=LJehYAvQmo7ZBxCZwWRM8UOhcjGXocNsI8D5I887Txg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB7cPq7cnhRpAD70TPhJhr/fL4QqCuvEIWjRN1c4iYt8fZBOwfZ0mNPELUM5ftmBvQg03S92g6seiGstTVjAmJhO4Xai1isj0ZxRKjEzwLGtA6UAdq7aCk5GHeO40GwMl1tRTXYK3dRXJI0tTrhkNZ2N4UJbyt+s8IuDIdbWFGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C812768AFE; Thu, 19 Dec 2024 07:15:14 +0100 (CET)
Date: Thu, 19 Dec 2024 07:15:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs
 for atomic update queue limits
Message-ID: <20241219061514.GA19575@lst.de>
References: <20241216080206.2850773-1-ming.lei@redhat.com> <20241216080206.2850773-2-ming.lei@redhat.com> <20241216154901.GA23786@lst.de> <Z2DZc1cVzonHfMIe@fedora> <20241217044056.GA15764@lst.de> <Z2EizLh58zjrGUOw@fedora> <20241217071928.GA19884@lst.de> <Z2Eog2mRqhDKjyC6@fedora> <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org> <Z2Iu1CAAC-nE-5Av@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2Iu1CAAC-nE-5Av@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 18, 2024 at 10:09:24AM +0800, Ming Lei wrote:
> This way looks good, just commit af2814149883 ("block: freeze the queue in
> queue_attr_store") needs to be reverted, and freeze/unfreeze has to be
> added to each queue attribute .store() handler.

Actually the sysfs handlers need a lot more work, including sorting
out the sysfs_lock mess.  Gimme a little time to work on it.

