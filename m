Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE1182D0;
	Tue, 12 Aug 2025 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754975985; cv=none; b=siqFHTAIXt3BnNJkXJqPYrdVZ6oZSdaX8x29mwKc+A4gSMFq8XcI/CLcnSIrvi+ELmvAt2w/y3X7Mffwbakw6SLVh+cN5vbULk+noUWOIah4okIZ2jFSqovh4k7mpOORz3JPKzDb9wQ+XyBTd7lUCYvjvpgtWLDtfHDsCk8hruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754975985; c=relaxed/simple;
	bh=J+5yvAscXrqAy3W7hvqIzP3kMrORcMX1vF02V5ClISY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMpCdQO9wsV6I63SnkVo+85FPcMyWLg20S+6TQ3ZmJ2XkY5lk81qPrJQ6iLsrAet4UmovF591AJWf44Gk/Me248L8wvqYvHvBariPR0UU1whlvbj6mnMDyrZyUJf7Mi4CJBJCMR8MeBp95Zbvn9glRD4YWBI1BrEJ5xUUmnnhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1f6Zg4Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1f6Zg4Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17928C4CEF0;
	Tue, 12 Aug 2025 05:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754975984;
	bh=J+5yvAscXrqAy3W7hvqIzP3kMrORcMX1vF02V5ClISY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o1f6Zg4Qha4hpJ/0LpTkmTnlxAWqzz7tIV1yTLTmzNnveyHOE479wWQcfVCfhmTQL
	 Qd7kmmPlYRk0q1MA/ywVXezVF6P6gZA6LESgygJ6EUMojY1pLshSTwTZXRc0niSqX5
	 Bo3f4ntOENcbAKDEl0BlNAuzdCY0YWTg8BcY5I17QAvneJobLxDAx1DvEVEJFPE1WL
	 +N2NDcLzZcCrRpbKaKELpVTC5rsRrVDTPxFb4qF6nT1ccoR6KJ20mYxAd/qkDSPQ5B
	 XdVFrRZDfkS/uU7HBLnijWZ3f3iE26L9e+yQyx9Fp9IgfUPM4xxXT3uE2aOZ7r0Hl0
	 53xhoEeFM796Q==
Message-ID: <a7cb5d59-8af5-47b2-8549-05c9322971e5@kernel.org>
Date: Tue, 12 Aug 2025 14:17:01 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] loop: use vfs_getattr_nosec() for accurate file size
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Rajeev Mishra <rajeevm@hpe.com>, axboe@kernel.dk,
 yukuai1@huaweicloud.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <a8041180-03f2-3342-b568-867b3f295239@huaweicloud.com>
 <20250812033201.225425-1-rajeevm@hpe.com>
 <34624336-331d-4047-822f-8091098eeebc@kernel.org>
 <20250812042826.GU222315@ZenIV>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250812042826.GU222315@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 1:28 PM, Al Viro wrote:
> On Tue, Aug 12, 2025 at 12:42:44PM +0900, Damien Le Moal wrote:
> 
>> Since loff_t is "long long", so a signed type, I would keep this interface and
>> add a negative error check in the 2 call sites for get_size(). That is simpler.
> 
> Umm...  First of all, what's the point of separate get_size() and loop_get_size()?
> Another thing to watch out for - replacing file needs to be careful, lest you
> replace the old file that has come to fail vfs_getattr() with new one that
> does the same thing ;-)

I did a quick grep and missed the fact that get_size() is mostly used through
get_loop_size(). So yes, making these 2 a single function will be clearer.

And indeed, that:

	/* size of the new backing store needs to be the same */
        if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
                goto out_err;

Will need some massaging.


-- 
Damien Le Moal
Western Digital Research
