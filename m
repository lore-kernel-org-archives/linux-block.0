Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCE518C326
	for <linux-block@vger.kernel.org>; Mon,  7 Oct 2024 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728341293; cv=none; b=PetYLnOS7L9Dv+hfLqPOcooIMscwjOaYidOqWSIRowv9KxuMiPxfYMrjUc4YZNZrO6PFNM+hZDqEJf/1oKFYircFuLp/Hx2Qdjt72HRaHHtG0VRIzly9WPJK6eDGb0C57/W1zH44WT+VkyibqvDrADj8N4IzGSX2d3/OP3USCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728341293; c=relaxed/simple;
	bh=46NEkZ8Cr3aYwI7hEIs0XlOt0tqAlmPDZdgJi2BsoxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiIS1bRVdh5G0bqzI7l8fcw0BOVDqVaTmIf6Uv1qxJ4hjDrYv60vM+RU4M/JK+E61aTBMI3I0YCe7EINXza6qfO5uC0NqVI5TyHTBWaTg0gyqEe68vpv8/EvCY8G+5Y+mEWeARopE17wB6EXtH0n1U6FrRDUx+wkDLegKam56yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXGYL6Kz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXGYL6Kz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C8AC4CEC6;
	Mon,  7 Oct 2024 22:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728341293;
	bh=46NEkZ8Cr3aYwI7hEIs0XlOt0tqAlmPDZdgJi2BsoxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jXGYL6Kz0loGLLBm8zAZyDA7YgwAZfktw8XsZMdBp2H53Qpwl4hgTPcPpus3ueU23
	 hAxtlAijqqPznWOmDj+3jHrfOPAU7xHiujy+4EzHeoL2C/Hgl7NJYcToiLWCtYAnWm
	 KNzz/6XEkqCSVgzyV5W+vS93x5dYhdlPPdiTNEjCoYoyZYoZMQYRfWlo1kglX+HN10
	 xdlg2ponfxUysxCqSvYbgthE9+dky6DE+CJoEnqvhxz3YXZqOQEIXUS1PMKfs3Yoif
	 88tv42jAGRyGKGET8LexXpVfwLDAnldL9kj2pu6C8KL4gq1cDm4Nl6cFULCdRu+5wu
	 h5n9BBvIFhRSA==
Message-ID: <ee7bcfc3-ce25-4cdd-95c0-c96585128424@kernel.org>
Date: Tue, 8 Oct 2024 07:48:10 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Fix elv_iosched_local_module handling of "none"
 scheduler
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Richard W . M . Jones" <rjones@redhat.com>, Ming Lei <ming.lei@redhat.com>,
 Jeff Moyer <jmoyer@redhat.com>, Jiri Jaburek <jjaburek@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240917133231.134806-1-dlemoal@kernel.org>
 <87ed4snq2h.fsf@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <87ed4snq2h.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 19:51, Andreas Hindborg wrote:
> Hi Damien,
> 
> Damien Le Moal <dlemoal@kernel.org> writes:
> 
>> Commit 734e1a860312 ("block: Prevent deadlocks when switching
>> elevators") introduced the function elv_iosched_load_module() to allow
>> loading an elevator module outside of elv_iosched_store() with the
>> target device queue not frozen, to avoid deadlocks. However, the "none"
>> scheduler does not have a module and as a result,
>> elv_iosched_load_module() always returns an error when trying to switch
>> to this valid scheduler.
> 
> The commit message here is a bit misleading. The problem is not that
> `request_module` can fail, the problem is that some failure modes cause
> this function to return a positive integer. This is not caught by
> callers and it ends up causing all kinds of problems in user space.
> 
> Perhaps it makes sense to check for a positive return value at the call
> site of the `load_module` pointer in `queue_attr_store`, so this does
> not repeat at some point in the future?

Well, the patch version that went upstream totally ignores the return value of
request_module(), as it did before. So I do not think there are any issues
anymore... ? Might be good to add a comment about it above that request_module()
call in elv_iosched_load_module().

> 
> Or maybe document that `load_module` implementations should not return a
> positive value unless it actually wants to send this to user space as
> the result of a write to the `scheduler` sysfs file?

Yes, ->load_module() should return 0 on success and negative error code on
error. Otherwise, a positive error may be interpreted by user space as a success
write to the sysfs attribute. Adding a comment for that will be good too.

Care to send a patch ?

-- 
Damien Le Moal
Western Digital Research
