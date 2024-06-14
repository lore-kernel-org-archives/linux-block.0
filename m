Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E86317FAA4;
	Fri, 14 Jun 2024 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382965; cv=none; b=QZ6piptG1EHYhQZktJF1JL1fSxEit+ENTtywQfmSDN0fAavkDEycAEYhWDdcku4ungdiJQwuKos5h4T/OK82CXQK7gpRwTxxaaj7X7Tcp6gEKedcKKXsdFA9lCf/Wj0kNzD+IfCqCv+DgcmHJf9ge7prpM8IWoN9DGSpa3/D4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382965; c=relaxed/simple;
	bh=QPWeq1tbqscA7WvkcKk4xfM2/9YvQIV5vOoCCspyWgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqDzBYbzsNfJJFz/l2hsNpTQwiJVqezpIoenJ6QpwfIh7M4qFWDymgru5adnh5A3URSlLe2cX2WCl4QIBj/8lVqmh6+sYKAmKQXtXQ0IOEl9OP6oTIOX/S+p6Af2AA2KfGgRlz80zbM3IYEzzbB46Mz5/dnT5R6hUMxbncBol04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=iK4x9ufm; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="iK4x9ufm"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4W14fB55Crz6Cnk9V;
	Fri, 14 Jun 2024 16:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718382960; x=1720974961; bh=QPWeq1tbqscA7WvkcKk4xfM2
	/9YvQIV5vOoCCspyWgc=; b=iK4x9ufmsEAF5woO/Ge0MisPhyGbhkirDBYWsAAB
	CEMtIfIr2PN8CEVCHrzsMcOCO1ymTbz7tSRw1iA9vH/RtE84eIAcC7Mr//zfEXkx
	vk9SBJh1x89jjiAGS1TXNzONAGwjW1gI8tuRvcm4DXvX3YfIRG4lWR0hCQ69sOh6
	o2kygbkec5s9tjJkKBmydFJXwXtbLngRNsWBMXyofein7O1K9aaPq3S+iaoVC9g+
	cLanYRwTUa+J1W7TmzZgi2dnl4JOtcmVXQ9VmlxOOavf6eynNkT7/BZC9fY6TRmk
	ewwzMVEuS1dulzNNDRTl4DD9izUtLBu/d3A5Ll6MTiuT2Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id E-dWPsyZXQ5m; Fri, 14 Jun 2024 16:36:00 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4W14f745S9z6Cnk9T;
	Fri, 14 Jun 2024 16:35:59 +0000 (UTC)
Message-ID: <16e6501c-c8ae-4f18-9fef-fa9ab32d069d@acm.org>
Date: Fri, 14 Jun 2024 09:35:58 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] bdev: make blockdev_mnt static
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
 paolo.valente@unimore.it
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 jiapeng.chong@linux.alibaba.com, hch@lst.de,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240614090345.655716-1-john.g.garry@oracle.com>
 <20240614090345.655716-2-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240614090345.655716-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/24 2:03 AM, John Garry wrote:
> The blockdev_mnt are not used outside the file bdev.c, so the modification
> is defined as static.

If this patch would be reposted, please rewrite the above description such that
it becomes comprehensible.

> jpg: Remove closes bugzilla link

The above text should be surrounded with square brackets.

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
