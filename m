Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001A1E520
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031996; cv=none; b=hFZdG9ug9w6SemUeAO/rAiPv1S9vmntLZ6ysMtWYG3vCyTo+SSRn6/n8ZRkWUFh3Y/hMZkQPzLuGDdFK+BvdbcyFbOsh18HXc6G7AsuQyxDsbgwsW54JzpPI6K/0tHOdojoQvlSMe486/dhpDr9p0JPQ6bZn+hAzO24F+a1Gswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031996; c=relaxed/simple;
	bh=TQ5xSoB9yVygyRE8xMBf6WUm5k0FArXdWCNhXUNEk0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqHVoJu+AkA/Ix8nVVgaaIW037qhzxB4KOcZrHWIg2yqOAxJNwedAllnQaunuYQc9/pnrmf3kflrQj1sO7IbL/JmM5PGbebMCJzANSQ7IfBL2A8QG9GafbHqYnonnWEZU5F7Zqo4V6S8rtwrqzeaXG8SShixDQHsYeQrsQBOID8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXfRFUOO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXfRFUOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DC7C2BBFC;
	Mon, 10 Jun 2024 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718031996;
	bh=TQ5xSoB9yVygyRE8xMBf6WUm5k0FArXdWCNhXUNEk0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXfRFUOOeXcyPgNztpWE1aYYATLWK4yGakltZyyLthfgEI4MZliXhDzlvFURrytPB
	 jt/cNyEM8HrIwXLP9CMRfdYRlj5imD+uuMHX3CkUzK3MlKfn9Zu+hQTyn8KaF5l3Dv
	 0kqpuGx9TjTF7H7rRKNImfe4P9O+qyiPXeCqU1b9fl81IwDGJBn9xe0iFEvHkahcM7
	 6UrWejzw2WVu0vX+Wz6fyH4HWF0MzhDXz5auFVxdn0mNL+pP+7wcHK/FtVkJggnZBZ
	 PZwnUX422GHZQAETmFBzxfU4OAfmiwEGQwDTCokvi1eCfKUVtJQhjrPA/SAjdt1aTx
	 Aw8b1iRmrGWLg==
Date: Mon, 10 Jun 2024 09:06:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-block@vger.kernel.org
Subject: Re: [bug report] block/bio: remove duplicate append pages code
Message-ID: <ZmcWeQhlbgnINVRO@kbusch-mbp.dhcp.thefacebook.com>
References: <af595d26-f8f2-4b84-81fd-09cc81049cf2@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af595d26-f8f2-4b84-81fd-09cc81049cf2@moroto.mountain>

On Sat, Jun 08, 2024 at 05:20:26PM +0300, Dan Carpenter wrote:
>     1303                 struct page *page = pages[i];
>     1304 
>     1305                 len = min_t(size_t, PAGE_SIZE - offset, left);
>     1306                 if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
> --> 1307                         ret = bio_iov_add_zone_append_page(bio, page, len,
>                                                                     ^^^
> bio->bi_bdev is dereferenced inside the function

You can't use REQ_OP_ZONE_APPEND for anything that fails
"bdev_is_zoned()", which requires a bdev, so I think we're safe. 
