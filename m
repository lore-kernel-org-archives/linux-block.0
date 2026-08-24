Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD22DBF75
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603000; cv=none; b=ddEbA1disiGAgLE3mhO4+fs0L/AsvvqW/C1P2iskjpcJSZkI6M9eTmJL99vz4akgWI29q79bcuJS7L2gXq7Ht1TffGa0cOR2xxYe7DyfVJLo9aMCZsVSKVWnv8Kqv7A5aFGHS7sNg30q+8jmaFUrI+9y3BKnbDnwSdsmmP/xmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603000; c=relaxed/simple;
	bh=uqnlMNYmvVD5jKt/b0HPvHdkFFbsTC1QZsSbr2wkccY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCK+vXPv/AWzNRDw4Ew+RrkoKCiuVjOTP3LnPVO0819TH54lep7A4c0pA8Aw9Nvq38MYm9CNs+aYwkhU5Z9k3hVdA0OFFckq2H2VacQ9d4J4S05vZDnwA31UjXCNaOWuD/9muwT3OLfnN0B/akKBr8gGlpWtqHHzc19NXZbsOLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=b5c1syLO; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="b5c1syLO"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hTMml00Xpz1XLyNL;
	Mon, 24 Aug 2026 20:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1787602996; x=1790194997; bh=WDXzcOkCeF/E/L6o5eIJE0YB
	b+lczGYcfjBgBfQ8M/M=; b=b5c1syLO3RnyvRRaq+l67NInxyzUzPlbItPROAk4
	iZXJnLY/1oPzh+RKueCwFi12CktrTW9uufTYpoBb2Z5UP72F2c3/jrBCe+Qtfy54
	8hTzKCa3Rp90jS22iRnsAALekgXlCUyQESBWOFhJOxjJ8QhtFLfXqjb3jPqPm9uM
	deI3/hrcxTTtd8hHwgg5dBXv/fPlgawF1/K+VHjcvl8nkLJTpu9BOYb1yJnWMqx/
	fOuYP2z2OKokyGVc+3CWXZ907EwRZFYCec1WpcK4TJH8tHr7ovV+QT91QptmvxF1
	3pcZYCHvDh3OR9V1WYgqf6npxLhehS0rCpP2Ty1g4Z6qgw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rDUYE0vGWUbX; Mon, 24 Aug 2026 20:23:16 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:b39e:b901:b514:a851] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hTMmg4tPtz1XLyN0;
	Mon, 24 Aug 2026 20:23:15 +0000 (UTC)
Message-ID: <3161a470-6362-43dd-8cab-c3ca1859d479@acm.org>
Date: Mon, 24 Aug 2026 13:23:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] loop: Fix race conditions in loop_validate_file()
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <cover.1787255652.git.bvanassche@acm.org>
 <2b6da8a843526abf58d0d591ce487533bbce805e.1787255652.git.bvanassche@acm.org>
 <b7f88eff-7886-4a85-9c97-7c88ba856780@linux.ibm.com>
 <d998a691-4c43-4feb-ac5c-d174208c01db@acm.org>
 <2e6d7e6d-d6e2-4675-abc3-51f21e407ff4@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2e6d7e6d-d6e2-4675-abc3-51f21e407ff4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/24/26 11:06 AM, Nilay Shroff wrote:
> Okay, that makes sense. So it looks like we can't easily get rid
> of loop_validate_mutex. In that case, would it make sense to always
> acquire loop_validate_mutex rather than acquiring it conditionally
> only when the new backing file is a loop device?
> 
> I think loop_configure() and loop_change_fd() are control-plane
> operations and are relatively infrequent, so taking
> loop_validate_mutex should not add any noticeable overhead.
> In return, we would have a single locking hierarchy and
> the locking-context annotations would be much simpler and easier
> to reason about.
That's an interesting question. I will look into this.

Thanks,

Bart.
