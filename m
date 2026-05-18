Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2853E63A6;
	Mon, 18 May 2026 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096870; cv=none; b=BvKvEB+M49D4eOMhOvUXVnQo/fXxq9OVDvLHhKcZEVJq0y90MJVD8G45us10iF8Q2St5I94rDc5m5gA4ZRyr4AVpjP/osLfGsVGN4CphIwzOM4tMgAobfqMYXNxBR9aQK4H3lSQwfPZP5V1WWHEaBph+V0t5gNsZWqnd3Yf9dOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096870; c=relaxed/simple;
	bh=+1Ca5B7fiteZR8bm0b/sp26p+0ol/3sAFadxd1Dmwf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3+NUBU2x/GTrZyp5bcEwLTejYZJw0slITWmLYTk3BnjH2K3S5wYEgOhTzyzOgd2S43UvPdxMWZm4ivh30r0kTO7GZf4uYTyYIKh741G0eXk3yvNpfSSyUofV/6B3rNKWsRpPOJPH/B5BtxWOOo0jbyAhsBq3OQlI6D2KZhV0EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcXU2c8r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcXU2c8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D86C2BCB7;
	Mon, 18 May 2026 09:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779096869;
	bh=+1Ca5B7fiteZR8bm0b/sp26p+0ol/3sAFadxd1Dmwf8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WcXU2c8r65eSum8uTdqPpVjKTSqyjyZbBZDjlRtuMDoMXkbL5rnQ/Lj8Uy/65RthF
	 uyeIlJoKh+nJTwG1Eachd8Q8mgFwA8D1KDrbOHXwh9GdXmBo6pnVPIw6VR2R9OKVSv
	 gKvTMqf45fDnYpgQma/OELNq7lak0dESLR6u/XF73IQroYjM3BsDGcCJ28UebthTHA
	 VjkeUpnSIQv02P9psh93ZP5FP5THwiEKLkkxYMqss84+VxPNe4+xA/Q4f5EOoEQJEe
	 RWKM75joyMldN4mdGvj29xdP2v9BhTfNhnnUHwLL23RQ2mBCeCmFdc6jiYXyvkbFAt
	 wJ69OZApGorEg==
Message-ID: <f678b51d-a31f-4140-90f9-8ebf30500fb9@kernel.org>
Date: Mon, 18 May 2026 11:34:26 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: don't set BIO_QUIET for BLK_STS_AGAIN
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20260518063336.507369-1-hch@lst.de>
 <20260518063336.507369-3-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260518063336.507369-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/05/18 8:33, Christoph Hellwig wrote:
> Commit abb30460bda2 ("block: mark bio_wouldblock_error() bio with
> BIO_QUIET") added this to suppress buffer_head warnings, but neither
> when this commit was added nor now any buffer_head using code actually
> ever sets REQ_NOWAIT which can lead to BLK_STS_AGAIN.
> 
> Remove the special handling for now.  If we ever plan to use REQ_NOWAIT
> for buffer_head based I/O we're better off handling BLK_STS_AGAIN in
> the completion handler as it actually needs to retry the I/O as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research
