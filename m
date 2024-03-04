Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9617555
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595697; cv=none; b=VcCASKdS5Izvb8fvn4xpwgp229h0Gy4Sa6YK1sdYCgEBzpezm5qR4PpP2EdB8cj1Fe+EwyY5bn890w+KbLLPhoeC7mx1xWnv+jWr67P/8zBGJKZ7NqUH9zpFor0a6J4Gqrv52tHUejnIJS/dX38TaC8M2mtira2HY11ayD2xGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595697; c=relaxed/simple;
	bh=+OTh4mfRy6Q6sCui5krbXxBLbgT3QJbwWKEy5LmNLSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObcvCC+U3JsLuYMwhppecL7rTUeqa98GTX/6bfXGvuQU2FiARHMlrIdrfY13kOequpcoSjxLqE/kfwa/KrnN4/6Pybmh9gc0cb0Tp08rxkn8J481+ZFpaOjoMf0Y0M11scuQUwT3o5zCvJQINb4Slj0KNJzrcaefZwJibQsb+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyHAOWIr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyHAOWIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725FEC433F1;
	Mon,  4 Mar 2024 23:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709595697;
	bh=+OTh4mfRy6Q6sCui5krbXxBLbgT3QJbwWKEy5LmNLSk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nyHAOWIr9HvJflGY53yDWlQ/avO4B6iuJxggF3HBqrMiTMNYiNpu7oEtMxtzsr5u3
	 dnws176BEeyG0SP0yVUDtxGbP69xNjollPrt0ozNuwwNnnsr+Fl0lCf4baDqsgM/Hk
	 mzeLkrdrZRZvGU8aOTLHZKc52sCri5ox0+auiUHaBEba3kKKTUspvoYVF3H4F1Ssfs
	 9IoZYVuIcpeF9U/9vkjVDdPFmHm687xmHsoCgtup2knkwrh3RHgXucCKybABXKIi7s
	 Aj/7558fCB+lUt3GzQgJ7vqewmW8YlfYBQqDeLPEgl578ipBTXpHz7qpOg1WgMPs0p
	 z3XsB5KtnHAaw==
Message-ID: <ddf30983-0402-441c-9925-d37114c09e71@kernel.org>
Date: Tue, 5 Mar 2024 08:41:36 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: Rename disk_set_zoned()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240301192639.410183-1-dlemoal@kernel.org>
 <20240301192639.410183-3-dlemoal@kernel.org> <20240302140755.GB1319@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240302140755.GB1319@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/24 23:07, Christoph Hellwig wrote:
> On Sat, Mar 02, 2024 at 04:26:38AM +0900, Damien Le Moal wrote:
>> The disk_set_zoned() function operates on the zoned request queue limit
>> of a block device and does not change anything to the gendisk of the
>> device. To reflect this behavior and to be consistent with other request
>> queue limit setting functions, rename disk_set_zoned() to
>> blk_queue_zoned().
> 
> Can we just hold this off a bit?  I have the big nvme queue limits series
> that removes the zns usage, and early next merge window scsi will be
> converted as well and this function will go away entirely.

I suspected as much, but sent the patches anyway.. Fine with me !

-- 
Damien Le Moal
Western Digital Research

