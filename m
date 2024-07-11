Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939386AFA
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721809; cv=none; b=E63LlgqMbDzK4ZQV1CaJ8o/gmZtE0NCNKefesCbS4Y758pMONfjuJyMJjzTH8lRTkob+ygrXkGY+v6RuToFkOkJju+aXTKIHlvQ27DLSEVLuJv0GH7pm4steSZDC3/zJ3OlncY2uvuGtF/UOlpw3cqZHkO+gI8u+B2LZs10gUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721809; c=relaxed/simple;
	bh=AGDzStfjQeBg1TloixQbIG2s7D7HfuxhF42xHQc20NQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUiF7R9mLwAGdC3bxkNgNAA6mDANfsKxppqL4RoEj3AsuFxFBqqL5EC7kOlpaO2Y8tLiWm7HHA+cq9oGqi/lq5T1j9eHR+2QrKFv2k/SBOLShwJSziSkkK+DIj5ExUNAx040oDZK5wVwTkOmiweIDTUePazltllLt7BqOCT65G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mG8bp1Ao; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mG8bp1Ao"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WKjbz0C74zllBdC;
	Thu, 11 Jul 2024 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1720721805; x=1723313806; bh=AGDzStfjQeBg1TloixQbIG2s
	7D7HfuxhF42xHQc20NQ=; b=mG8bp1Ao2K+IkrO2wepGPx+qL05QbH91M656hkjG
	ZN11Kq7WfD7T2wcIzH8DSqzRYYTXyEXzl7Wvbth1Pe9ahrYs0iYOdtq/2K6jaxUN
	pTfoixRIT6dSusx7rhn8DqvOWadp0OZTg0WDb40MSfLtNPCoBzxpDKJPMgb/meIN
	Xk1tH9OGf88XpztDqkqRPmdDTi0U8McyWWbQrZxWMv15xUWdV+rMbgSai2B6zx06
	erqWZL26Tm3x+0G85mSrqEHOomuqkpBN4Ll+j0wkHaQjHbVK0Z2r78/3tjqYUXwt
	L1vjoKaB4c6B5tfThgmYz3V/kL7I2plAjU1CLCE5rn/X7A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WPzt2W0rDt1F; Thu, 11 Jul 2024 18:16:45 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WKjbx3gXxzllBd6;
	Thu, 11 Jul 2024 18:16:45 +0000 (UTC)
Message-ID: <67c8b8f0-6d35-4ace-8737-cd209c4f3bbd@acm.org>
Date: Thu, 11 Jul 2024 11:16:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] block: Catch possible entries missing from
 alloc_policy_name[]
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-7-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240711082339.1155658-7-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 1:23 AM, John Garry wrote:
> Make BLK_TAG_ALLOC_x an enum and add a "max" entry.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

