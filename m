Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B034A3A7
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444982; cv=none; b=GGWPILzQyRqS28prCGBCEewtpGneRRIqgo0vjzSlg+gYN3tY4EYMGQdZXgovhbf9iVwUtLbaiwkXNjMwJY9yDRlU8+fOJ8Nn9lPBACmY1eLn6YFNDhzLUXR24TP28nJt6JUzeR3tc0jhXz1Ktj6JtHECcUI4IiDkkIXLLxDciso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444982; c=relaxed/simple;
	bh=wPbmgXKRZnr/cFhNAsNKbmrEI/iivaEszlnkS3OPdxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDC8wkckfKVMljCO3Ahwn6XBeRP5zj0JaMUf1EFWSWSqp+jdxPM4h4vT2IFTdFXfuETDPUz63HU+4Fw08CytrJeXkL/Vl2saViwtB77apX3prnyqlP1XMu1aAE6WNvcaEG0Zwg+mYx8s5NZGXXIkGUcE/MrDKafyes4IMDSZQdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=17qNhsus; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="17qNhsus"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d2RmY2YktzltPtV;
	Thu,  6 Nov 2025 16:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762444972; x=1765036973; bh=wPbmgXKRZnr/cFhNAsNKbmrE
	I/iivaEszlnkS3OPdxs=; b=17qNhsusT80umUj+XYaOQKfiFWbn1eoDTMpj+1mj
	W7SFEdl3R2CGTKmyvFkeKGOqt/HLV8mqp6qqVCr6mWmztBtOg8g2Eza3AwcK0GuZ
	fwZx+/0R4WT+QQRFITPTZjk10SKynsgE+SIydq5nz7+IakPOzDjpBdpOZcJMBTIV
	WPfHgXFR3V+/68/Pe/IVRsVbGjGwl3YO0L9fSWNLF/fFml5j1CGL2CRJKzlf5yg1
	rV8cC0N/2Wau+BvM7VdptGXnPpmZBQN9WAns04dFWLgvfuMmof1o+0t+L9cxKsNs
	XzcBN+bgKtvPt5GDmnqz/twJzu5vzBJwC/Ppk0X1rGhmJQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WVoXY5rz9MIJ; Thu,  6 Nov 2025 16:02:52 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d2RmS4P9GzltKNH;
	Thu,  6 Nov 2025 16:02:47 +0000 (UTC)
Message-ID: <fb5be2a5-b0f1-420d-9479-77fab63682db@acm.org>
Date: Thu, 6 Nov 2025 08:02:46 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: introduce bdev_zone_start()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20251106070627.96995-1-dlemoal@kernel.org>
 <20251106070627.96995-3-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251106070627.96995-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 11:06 PM, Damien Le Moal wrote:
> Introduce the function bdev_zone_start() as a more explicit (and clear)
> replacement for ALIGN_DOWN() to get the start sector of a zone
> containing a particular sector of a zoned block device.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

