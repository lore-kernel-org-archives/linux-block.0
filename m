Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF81288A4
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721780; cv=none; b=EbKg6UZBx+DIu82Qnz6AHuj/omohXIz+Waz50WE4vVBoTtdPneWlBAEi5VfHu+Lbsv2DW9spXekWnbCWQOuPbpY5iZLr7GAtmU7RvaAgyVBEotlNkrH89dbVZCr6OG6oSapZrkUDrzpwb5+mHH2+/Ht0ejmF0chXwSiGdLp49aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721780; c=relaxed/simple;
	bh=VB9gGBYIPqAwopuZkfhM1PPC73/vUeYxtusehX/MRw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2ANucASfRk+mnxGF1HjP93jpI79FGmRNw4GsZvt2W1QlcmfmLkRpVt5MfLY4uckqhhn8JMOmfUT+00Y+FncF2Clp/8JK5h98z3L//qA0d6u13LTmYUChF9tddaytM4Ouer2xHtWJ0SotYjWSbdpuFnKXw16iTHStdBT8KqiC1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=uCTS4S/1; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="uCTS4S/1"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WKjbQ5CD6z6CmM6f;
	Thu, 11 Jul 2024 18:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720721777; x=1723313778; bh=VB9gGBYIPqAwopuZkfhM1PPC
	73/vUeYxtusehX/MRw4=; b=uCTS4S/1+YiHsyRhM3XgiAHw44bxN7+jBD9a0NNQ
	Mw3/93JPsT8X2Yn++vjRSWwPHx3hqpUEQ8IUfBTif01faUCURuJKIIlo2o0NSQwK
	b7d/Gybq+FOQmXN04/N6zKEBb2bv4OEQo3NL/2V8sfxFJjcd1WwkUjGwYWQp1ioZ
	zavKN2ZhVRgE4hy+XRvFhbxlQ9YqeD5A2rZdqbHXIHhlIbyUQ8XIQuCpb46wTg6Q
	5cSjYVrRxCEi0ElVSQ6NHr0DdCVB31rnaaPDTNHt9cn02GhqZyOZpdzEou8RF4DH
	Ll5pjLY/1zYmBVIxM16GYldC3vjfM6fJ4haC2FWHr7IE4A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 63PQLjUMvOvs; Thu, 11 Jul 2024 18:16:17 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjbP13TLz6CmM6X;
	Thu, 11 Jul 2024 18:16:17 +0000 (UTC)
Message-ID: <b502e436-e71a-400e-b984-8db8242cb3b1@acm.org>
Date: Thu, 11 Jul 2024 11:16:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] block: Add missing entries from cmd_flag_name[]
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-8-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711082339.1155658-8-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 1:23 AM, John Garry wrote:
> Add missing entries for req_flag_bits.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
