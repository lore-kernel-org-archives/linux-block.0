Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE40F173338
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345985; cv=none; b=eVJSxipG6a+VDM0xRXHdY6IzBAciQpf/7W4vCjvbVXJc9yTlRMN17mSaUwDeO7wBvM1oYrTqHQK8F3ftF4oZCuVn4lkgGjJBO/w5QGnhUQp4mocVUiGwB8rcZ6kTgRsynG2mVFVh4wa9f95lRYJtjtbUth9R5CMv86jR2lW6Xso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345985; c=relaxed/simple;
	bh=N/MUnwSFcKU1QCD68bXewV/8KIZ/4GGzEreLTMkSJPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GAfZnvvTv9jN1Rrh/exdG3Kit00N9NAUYTuxOyBDEp+OKJym0XTc9fEgEF+31AGScJgoCwjYHBr3JY4BfYBXf6kMacaEpz1XgIzfQqrZ6xDSdjNg/LG3ZOMafHIoTeLZyYVrRGQR2svnQitKhP9qMG1BYOO8jefgPMTMrOILyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WVnq9KQh; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WVnq9KQh"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VB82R2yd0z6ChQlw;
	Fri,  5 Apr 2024 19:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712345982; x=1714937983; bh=N/MUnwSFcKU1QCD68bXewV/8
	KIZ/4GGzEreLTMkSJPI=; b=WVnq9KQh3LOpZmQqqoO8Q5qNcd92DQ8nHuiuAvb1
	YFTC0aFCD2A91F/BCtpsIuzwZt2FvleTTypF7qcpZa7xyXsqqGV9OjuyR9K7Fap4
	nrU77XFHzR1H8ZzqoLXb5jtLl1SwZViPfmxvj7+bWA3SHLBFJl4lBJN4kSiIQyiY
	pUuPF+aH9TwB5qaS7Rd7y8aAm5o/XyV5gDYObqsVQehWlSQBkkAoubo241Y9+m0f
	UpH9GC5FZ8/1xUv/EMt6qER7Z8eUFMCvaDUci/0Fois93iUvPUCt3R2/b8mgc5B9
	OAzW4ALP23zGBBDrSoIn2a+Flz1qOR8wmM6cbMe/KvuIoA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rbWxRhHTSTPY; Fri,  5 Apr 2024 19:39:42 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VB82Q2T6vz6CkhHv;
	Fri,  5 Apr 2024 19:39:42 +0000 (UTC)
Message-ID: <acd30989-1437-447a-a97e-613b51b8f6fc@acm.org>
Date: Fri, 5 Apr 2024 12:39:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: sysfs-block: change hidden sysfs entry listing
 order
Content-Language: en-US
To: Tokunori Ikegami <ikegami.t@gmail.com>, linux-block@vger.kernel.org
References: <20240405165401.12637-1-ikegami.t@gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240405165401.12637-1-ikegami.t@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 09:54, Tokunori Ikegami wrote:
> List entries in alphabetical order.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
