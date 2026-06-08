Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BBB3AFD04;
	Mon,  8 Jun 2026 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955505; cv=none; b=Gs1eGzJfi2PiEMfKSrlZCXJ0iX36eTKQ8zYoaCkgvV+9UozxmrJlfc3yGqsmz/5WFN4ki4HMV0j7WhCbbr5Moj4zERKUAX0P0Qznx/EceVKnwNNfDId3KnSj1/dLoYjJS9DKig8wcGuCX3t8dhUayp2+CtNDVvFdMBEPluIVmzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955505; c=relaxed/simple;
	bh=ji2SRD9OiIlpJ0oQRCfY44OaehHQo9epvoidbcDoeLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dbr2vj6+sf+2Xsv2OoL9RjlWzeQR/riuk8uREv5uYqnNIpRXJ/9u9IeCy3Gyp234BHvTtc+KZqDZ3n3Y2tAfBGrH2/SGse+YEJ6PQ30BiJmlPxFvoftuic/p6dnkGx2+mgBI2NyedgBNadbRdYtjqxBi805KkYFEAaBG+U0Yuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=z+H+Qlz+; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="z+H+Qlz+"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gZ5NH6hJHz1XM0p0;
	Mon,  8 Jun 2026 21:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780955500; x=1783547501; bh=ji2SRD9OiIlpJ0oQRCfY44Oa
	ehHQo9epvoidbcDoeLg=; b=z+H+Qlz+5i8np5k0LbDlUEMj5JI82BOj6ajwjVyG
	OqZ5NGhqC1eHcTKbsr9zV3+/v8qOWAwymfYTqRDclpuBPmoCVRhOr3/8bimzuqjz
	W0h00m9NpdJuLxRclg54TZBJDFWJWBzHVMiOChXAqo02QWMVq6FrHa3YQ7h9Ep6s
	vJVc58HlZNsT7nubZTTSpzHTXuDTXGlgNKGVIcNI1V7DLGZLYsKUwouSHkBiTCKN
	+rWHJlg6b0emy7Q4ecZrxvlkmWF27NsDnaAzKcPetvQZIeXjcW3/BLcEpAn73ZXX
	Q2K5XbXQ7FX22mKMxFpSeN7WO7xD2E7ag21aZQ/wWji4Qw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dWStyjP05Ljw; Mon,  8 Jun 2026 21:51:40 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gZ5N953fzz1XM0nt;
	Mon,  8 Jun 2026 21:51:37 +0000 (UTC)
Message-ID: <0074f8eb-993c-4c03-ac04-7588d4333e13@acm.org>
Date: Mon, 8 Jun 2026 14:51:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] block: add a macro to initialize the status table
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>
References: <20260608051416.1205282-1-hch@lst.de>
 <20260608051416.1205282-2-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260608051416.1205282-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/26 10:14 PM, Christoph Hellwig wrote:
> Prepare for adding a new value to the error table by adding a macro
> to fill it.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
