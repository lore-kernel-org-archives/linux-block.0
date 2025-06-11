Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39EB74059
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658519; cv=none; b=aaW1WbbqJt+C6lCh7Zg5jc0pM86tfTtsqG5eHa9tv3vxVCTXB8HzOxDNhulfAFes3fP8+OMXIPU2ZTQUz0pqhcnzdVNL1Xcvs5rvcMZ0WhGGAFC0FOty7mxskD5xiSyJBztiH3dmfEhp2ImrHwypUR1g3fnDy7zof7TC/dhB1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658519; c=relaxed/simple;
	bh=CY72Vno9Fa9424FQVCdJE9m7fS1vG5oWAij52O8uMnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o14ExLd77+GxIwz0ObX/L7ishfq+Rn0SIPPBhcxx5MXCtsYwpA3wZn3SRfzMx6tEMtZTyls1cDOWy/i3W+8sYLpY4tFiYyKAVBOsvvAY4x86aEHGAqFWzEnxYyQJ+HbFVnvhf8yLg+pK72qNNAwLqvYyWvqhFCnkpruEyLu7a74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Zbz1gAS2; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Zbz1gAS2"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bHW383C96zm0pKg;
	Wed, 11 Jun 2025 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1749658514; x=1752250515; bh=PXctWyQLKuoDXq8i6cjHNacY
	hge7hLLISybZlK5zt7o=; b=Zbz1gAS2D2SD60Pz4qcO6HUdBJbikC3wkvHUBNu+
	NemQgb2pI959jRIIJjJz6N9Z1wF2/PqhmNQgJ4BqxK2fwIhRLJihN5tDYb0BdwkS
	EDu/J9RORP/kYwqzvFdAs/5eBycXPGTo8yMkIhdlKPuzD3nkwq8a5EuQSy3Fy7L/
	vyvnw+sC08d7HPl4Z1KomhbCo7NGcwiDx2BLb/RZMrqaX8FjMyQ5GNEdMnbVZ0J7
	dKSvIjZ2NVBjvPP7iZvVV+qR7vzcqnvs1uzavf5CCNfQnXo5nDhmKMFCvp+VjfAN
	S7PN2nl9ngd7FRg80zR8KCyJmNehVCkyo89rrWtByRCLgg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id z-iT8W2wdz-6; Wed, 11 Jun 2025 16:15:14 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bHW2z3lv6zm1Hcf;
	Wed, 11 Jun 2025 16:15:06 +0000 (UTC)
Message-ID: <1853d37f-b7b1-4266-b47f-8c2063f36b7d@acm.org>
Date: Wed, 11 Jun 2025 09:15:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Make __submit_bio_noacct() preserve the bio
 submission order
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <b130e8f0-aaf1-47c4-b35d-a0e5c8e85474@kernel.org>
 <4c66936f-673a-4ee6-a6aa-84c29a5cd620@acm.org>
 <e782f4f7-0215-4a6a-a5b5-65198680d9e6@kernel.org>
 <907cf988-372c-4535-a4a8-f68011b277a3@acm.org>
 <20250526052434.GA11639@lst.de>
 <a8a714c7-de3d-4cc9-8c23-38b8dc06f5bb@acm.org>
 <20250609035515.GA26025@lst.de>
 <83e74dd7-55bb-4e39-b7c6-e2fb952db90b@acm.org> <aEi9KxqQr-pWNJHs@kbusch-mbp>
 <20250611034031.GA2704@lst.de> <20250611042148.GC1484147@sol>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250611042148.GC1484147@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/25 9:21 PM, Eric Biggers wrote:
> blk-crypto-fallback runs at the top layer, so yes it's different from native
> inline encryption support where the encryption is done at the bottom.  (But the
> results are the same from the filesystem's perspective, since native support
> only gets passed through and used when it would give the expected result.)

Although I'm not sure Keith realizes this, his patch may move encryption 
from the top of the block driver stack (a device mapper driver) to the
bottom (something else than a device mapper driver). This may happen
because device mapper drivers do not split bios unless this is
essential, e.g. because the LBA range of a bio spans more than one entry
in the mapping table.

Is my understanding correct that this is acceptable because the
encryption IV is based on the file offset provided by the filesystem and
not on the LBA where the data is written?

> Just keep in mind that blk-crypto-fallback is meant to work on any block device
> (even ones that don't have a crypto profile, as the profile is just for the
> native support).  So we do need to make sure it always gets invoked when needed.

I propose that we require that bio-based drivers must call
bio_split_to_limits() to support inline encryption. Otherwise the
approach of Keith's patch can't work. Does this seem reasonable to you?

As far as I can tell upstream bio-based drivers already call
bio_split_to_limits().

Thanks,

Bart.
