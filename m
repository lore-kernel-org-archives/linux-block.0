Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A941F4174
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531603; cv=none; b=cgg0wXeEwyJ7YGea4P+mXsGJI9ybaD5YWgZ65VCI5GwHnUabTkkgyQeFQ+GIABrmYeANmaX13djZOt9tOlbfXWLEMH6AU3r2HbGqiu5c2QIvod12WIKApKsTdK+zr4+ODZJrGPy8k1uqqjriOz/vEjdybowtln66sfs0JoPiVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531603; c=relaxed/simple;
	bh=YRlR9clv49PcDh2tM8zSSnHhjlHRQ/TRaoS74urn668=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjuWOfQ+h3+lNJrgoLWOg0k6B2879XmieIm/gmklJM5Jwt0zRjhBSbdUjC7MCSZE6aSUPZMkYWhGXuXNPHy+dNqeA43LkknQ0lfeYNJNmxrP8oKP2KvtzAdrS6iyhuf/4wckN4yMfSQiVTl7+QsCLZjqu2hGFgRG0KBp3k5HTpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NZOmFKxy; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NZOmFKxy"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d33pS6Tk3zm0ySK;
	Fri,  7 Nov 2025 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762531599; x=1765123600; bh=o4i378Pm58XfLQDYME4HWjsF
	y+wQAprLMmkPZ06LY/4=; b=NZOmFKxy89FrhiiDJTOj0saKg05Ze/YWFc6HUekC
	+cfsaNQUDZLbow8z9XefKKVqjFuMGu/2lAwXHOMqqGiWike52o6fo58q1quxNAjn
	ZXmBOcKbQEhbKX8EROmV0FIRB6Ol+Wi8oB9k8pkb+tyRKFuBK6PQL4iOtCLnnZ4U
	RTApL3iBrWpGzku63A22Xv21b81FG/Zzp0z/QWHQ99tPGT48BBS/dD04LOQOOnZl
	MvxSDHeuKfGbJ1lvpnYPFweepVBTe07iU2kGjOVAZWzYQrFQbHHX55LxrKAWsKWz
	H499jOYHJTiqQlEbMnx8N76CYtl5k2kcnIssE4plO+yJOg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PHwXd0b3TIyq; Fri,  7 Nov 2025 16:06:39 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d33pL74Drzm0ySN;
	Fri,  7 Nov 2025 16:06:33 +0000 (UTC)
Message-ID: <69d8e466-dd52-4726-aff0-b4be10cee567@acm.org>
Date: Fri, 7 Nov 2025 08:06:31 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] block: refactor disk_zone_wplug_sync_wp_offset()
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
References: <20251107063844.151103-1-dlemoal@kernel.org>
 <20251107063844.151103-3-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251107063844.151103-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/25 10:38 PM, Damien Le Moal wrote:
> The helper function blk_zone_wp_offset() is called from
> disk_zone_wplug_sync_wp_offset(), and again called from
> blk_revalidate_seq_zone() right after the call to
> disk_zone_wplug_sync_wp_offset().
> 
> Change disk_zone_wplug_sync_wp_offset() to return the value of obtained
> with blk_zone_wp_offset() to avoid this double call, which simplifies a
> little blk_revalidate_seq_zone().
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
