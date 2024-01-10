Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D822A1D3
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MN/7JULD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D86BC433C7;
	Wed, 10 Jan 2024 06:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704867509;
	bh=W8s95Q/9nXvXzlmYFrYMo3b8nPY7qHuGguPj8ngukLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MN/7JULDIuoNLN6oeNUDfIH6e3oUHnfjc0J7OZdB47KEvgXhtAE5HaY0rVUwlgAQB
	 IqaT9q0ji/VwL7ZrS7O4ZWA+qrnPS9hap1a5JHmY1CTW6VgAdSavY22iHp0ZTahSur
	 LLuRBgT6wY7N5cZQh3BbBwew0VOq88dolZEPgn1bULY/PIp33qegM8Iz7u98ZuoVp4
	 b2kGHh4DOthTEUAc4HWs3G4CsNp2tSxuUSSL10J1Md19D7e0s78aUK4aNkWzBYE613
	 jDiSzHaNRRLPd1AB1rZ1azrkiqiN2mpf5XXBhbmOkIUh8xx+ewPt5goglJ5ZXrH1Fj
	 XAy1kZmyqGryw==
Message-ID: <599edd2f-e749-4d85-82f9-2322ff5c30dc@kernel.org>
Date: Wed, 10 Jan 2024 15:18:28 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix partial zone append completion handling in
 req_bio_endio()
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20240110051559.223436-1-dlemoal@kernel.org>
 <ZZ40YzBnZ639Zttm@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZZ40YzBnZ639Zttm@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/24 15:08, Christoph Hellwig wrote:
> On Wed, Jan 10, 2024 at 02:15:59PM +0900, Damien Le Moal wrote:
>> Partial completions of zone append request is not allowed but if a zone
>> append completion indicates a number of completed bytes different from
>> the original BIO size, only the BIO status is set to error. This leads
>> to bio_advance() not setting the BIO size to 0 and thus to not call
>> bio_endio() at the end of req_bio_endio().
>>
>> Make sure a partially completed zone append is failed and completed
>> immediately by forcing the completed number of bytes (nbytes) to be
>> equal to the BIO sizei, thus ensuring that bio_endio() is called.
> 
> This really is a should not ever happen case.  But if it does happen
> anyway for some reason, this is the right way to deal with it, so:

Yes, that is likely impossible for NVMe ZNS. But that is definitely in the realm
of the possible for SMR drives with zone append emulation using regular writes.
ATA drives will never partially complete, but SAS drives may do so.

> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.

-- 
Damien Le Moal
Western Digital Research

