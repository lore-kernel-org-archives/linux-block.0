Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D522E1F06
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110851; cv=none; b=tzyc3lWI+BCN6mc61HVDNCX858/TdrcBc4LgEiz0uzwfTs8aGudBZaByLs8CC6lEeDI17LUFojFOrBikD3aTMCoNDeN38ZJ1je6TVFj3ljI2R4bpypxhm9U6R/f3Gq1moCDO6ezgDXwI1XG8RI4utV7qm4UxG+GfGK0stIntIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110851; c=relaxed/simple;
	bh=uFxxSHS4W1Q7XEiAdSTeUQU8KqXEJA57SZWTjbUIu8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlmS0RoZ5TOgCzwjFLwd1Jy+6GCY6lE3A5n5bq+HR1P5h93ckYSx5fz5N36Brnh6T74UXZkXHrahhQyDlPI5BreUkQOk7QoW6aCcEOHw2I7vXsKelUUXRlrlmGb2Fg9oVZ9D6tAsB43JuWNxsziJM67vVSyxfJW5pEaVin486gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vnm/afO1; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vnm/afO1"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gbBqk14wnz1XLyhV;
	Wed, 10 Jun 2026 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781110846; x=1783702847; bh=uFxxSHS4W1Q7XEiAdSTeUQU8
	KqXEJA57SZWTjbUIu8I=; b=vnm/afO1elu/FzodIHoQbcy4YtE7+1DjqArQbgUE
	ZKSjGDA9twRFDIbP3yieNgxenbS8Bo0wFcFu9LODLNrpU3G9WoGy/RUOeA7S8BxL
	6uFRMZ1gYtVJ+vvtKOBVTpoYDtMNmPV+UClgsl5PvPkeBiSzcyXmwBkgUQg2Rsnl
	k9Efti8mIPX7WD85VPgwFG3nvMhNoLIRx4j17wK/kEWfyjSjR7lKvOeo/exAc7AA
	cTghJPtgSD7YeI8enlfFY6tSNSq7gNi9Oma0pc6N4w7UqofB6QdTjp8LteI4++Vo
	WC3qUTRZ1Rtjenb2iF3ThYsVeIAgZEaNlVOoHve31BFeng==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id yAmyiZMSDc-t; Wed, 10 Jun 2026 17:00:46 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gbBqd6sgqz1XLyhT;
	Wed, 10 Jun 2026 17:00:45 +0000 (UTC)
Message-ID: <2d6b3c81-b998-4edc-b853-c1d02f43351b@acm.org>
Date: Wed, 10 Jun 2026 10:00:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] Enable lock context analysis in drivers/block/
To: Christoph Hellwig <hch@infradead.org>, Marco Elver <elver@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <cover.1781042470.git.bvanassche@acm.org>
 <aij3e1WKFQunNUS2@infradead.org>
 <CANpmjNORsF2oExcOphnGgnTt3hJEWP0tB6zua0sTG=n7gJbEZA@mail.gmail.com>
 <ailK6eqeWrwRLPkz@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ailK6eqeWrwRLPkz@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/10/26 4:30 AM, Christoph Hellwig wrote:
> Bart: maytbe for next version just enable it on a per-driver basis.
> Once all are covered we can switch to directory-wide.

I can do that. Since the merge window likely will open this Monday, I
probably should wait with reposting any patches from this series until
after the merge window has closed.

Thanks for having taken the time to review this patch series.

Bart.
