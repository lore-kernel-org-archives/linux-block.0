Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9831E847
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576530; cv=none; b=qfDQLHbIcXrKxIyOxcbGcBT+KRAV33oI01No2gw/Gx54tavX9e6zTObwBTOg7uudQt6iAOZUPbsulFn8SdIhi/3fPeccw2MFXCbdXHwyZiLy2MiUon2rb0lfjKQyc1sna+9xUZ2v01gT22gxu3j+mGyDEYC1kK5YWSepZ/iHL4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576530; c=relaxed/simple;
	bh=g2yNSUOpVj9x/RwQEndXc6a39WqTjU32k+8bKu/TDbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=el++4GcDxdV49FQv4RWJkmNlg+Kl8CcbW9+yqTRuirbpRgI055KiRgxvHCws/u0JEk64WApaEqu1NYv0z40hAqL2JJQe1dx6yjIWPUGTZACmkpA/r6lhJc0j7+dxE/iOG3QFaNPr4bbuwmT3QsURC5mPs+6TJ3Cicm050/EZr3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3ZarFLHx; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3ZarFLHx"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fhkHh4Ynlz1XM0nj;
	Fri, 27 Mar 2026 01:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774576525; x=1777168526; bh=PfgZkkS3AXTXsFq0Vg60Euwq
	Grjhw3CefMM6qWfXTbs=; b=3ZarFLHx6PM7g/heVIaiCf3z5jo89kLG6wawi1xp
	z0HlbTdPQJaiaRaLnxErPYE4DkZZUA/unqzMKJAfPbkWSNGg1+8yU8Nth9op16cP
	dWa6QL9MvmAehpeDT50oPTv7i+fUBSyurMUL4mTGPVJig/A37/PKfqj783R2vqKj
	MV8ol/8oFeXzU9Ti/KicFpnqO5kmS546DcIgpcmjhkQOv48qS6Jm2yRSe3A4K60h
	4n5LkIzAmfBegGB4Z1NEjH/KAPGFxiJSCYi0cZxLYINUxWT/zFxnwn1ZKrwPbI6Y
	lBR598PDBcWYKDJqufyiOdf7NdZeUdRp4NNXPZeaPYsgNA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Oe-uZ0Zhz0DL; Fri, 27 Mar 2026 01:55:25 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fhkHb1TRRz1XM31H;
	Fri, 27 Mar 2026 01:55:22 +0000 (UTC)
Message-ID: <5b684845-55ec-4e52-998a-8b2991f2e03b@acm.org>
Date: Thu, 26 Mar 2026 18:55:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] block: Remove a DMA segment boundary mask check
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 Hannes Reinecke <hare@suse.de>
References: <20260325213719.2850619-1-bvanassche@acm.org>
 <20260325213719.2850619-4-bvanassche@acm.org> <acVIDQp5WWerx3lA@fedora>
 <8c956003-e652-4dd0-a4d1-438d82cb543e@acm.org> <acXUvfopQqMm4Qov@fedora>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <acXUvfopQqMm4Qov@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/26 5:52 PM, Ming Lei wrote:
> But why do you remove the check? Looks you just encourage driver to use insane
> lim->seg_boundary_mask. IMO, it is just fragile.

Hi Ming,

Users cannot and should not modify lim->seg_boundary_mask. Only block 
drivers should set this mask.

A possible alternative to removing this check is to change it into the
following:

	if (WARN_ON_ONCE(lim->seg_boundary_mask < SZ_4K - 1))
		return -EINVAL;

All block and SCSI drivers I know of have a seg_boundary_mask that is
greater than or equal to 4095. Does this look better to you?

Here is an example of a driver with DMA boundary (the SCSI name for the
segment boundary mask) equal to 4095:

drivers/scsi/qedi/qedi.h:67:#define QEDI_HW_DMA_BOUNDARY	0xfff
drivers/scsi/qedi/qedi_iscsi.c:59:	.dma_boundary = QEDI_HW_DMA_BOUNDARY,

Thanks,

Bart.
