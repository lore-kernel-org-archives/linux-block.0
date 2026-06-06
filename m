Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57822253B0;
	Sat,  6 Jun 2026 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780730429; cv=none; b=sxCOhh8dGT2njCeoxh8fwYf0rAVFgxFg/o8vO/Ed5lnf8HkEu6TVDLLyIr+DCTXmlIwm8k26XfH1LfJoTgjselHn6Tsh4ZP9+YTIO4RIAFbQhlDoR8109T49DfEAzX1tHZz6k+vxX91eFzXMwv4mXPR1pJ5ScF+4Rw4W0oPZvJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780730429; c=relaxed/simple;
	bh=YB2cR5AVk4YpTzDnqiM5TTTglr81HrF/neI0EmnMzKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CI68BxEicyqh80vymD/fb826RrGRvtZmIgEx5A7TMHZeEj7stf/wb+b6uTb/zTllQbaUat73d3bk92KUuF3J6JIq7gjLojxIYAlo+R3NaHd+7mtFvlBVMXFrGIfnyaX1gZ4ZfNLRHrzITDBeVfOm0dPH8CwYkZq+3Hg3yMiHRvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6nlRls5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6nlRls5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C65A1F00893;
	Sat,  6 Jun 2026 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780730428;
	bh=RP3mn0kdgyvLGaS9ImYD6iXJDSRSS3hCrPGPXerPjko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z6nlRls5EWvkEnt5P7sFbdZUGqVMF5ofUJ89h2vRgsZs1050GzD4+NBqgoEuBVFy+
	 sKJUa6UqjhsPIqgodXA8owCazflcz91Ss3o/JGqsWJo4bF4sYIueEYwkkcXu3csbDZ
	 FH4CEvaRn9iDt0UhX3YmzhAMWVmu9poWxC/6IdIuCT3/qO0JbTO/jivjYTmgcUGg8A
	 xWH8srU2sATgK/Ykp+eQ2wx4WtODbCJWt7LcEYT5mwkueoWZmedx70RxadfKEkF2A5
	 UAnaNCNybUBjsRWptdqxlR697m4QQzspAJJk9FTMBI+55yR0bGt/1eJzxMEX4Zq/uT
	 m10VyBQ8yM4qA==
Message-ID: <df293644-78ff-499b-bdfd-105b4e030c00@kernel.org>
Date: Sat, 6 Jun 2026 15:20:21 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] block: add a "tag" for block status codes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20260605184441.590927-1-hch@lst.de>
 <20260605184441.590927-3-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260605184441.590927-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/06/06 2:44, Christoph Hellwig wrote:
> The full name of the status codes is not good for user interfaces as it
> can contain white spaces.  Add the name of the status code without the
> BLK_STS_ prefix as a tag so that it can be used for user interfaces.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
