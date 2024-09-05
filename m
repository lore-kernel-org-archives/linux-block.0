Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F86193400;
	Thu,  5 Sep 2024 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568707; cv=none; b=ZQz4No2eLj/lwDONcG/zvY9HCtuMuBdcCuVITSZ2SqBb2deXInvxT262/h4WkGoAnQJ+PhSQVxiw3hHAQyArK0A9Q1DjHn0zxrq3msqI/01WhT0Zvp7jMf9UbXbk0o7R6QTAKrkW4NoXVOBYmDGm1HhBaL03EiZhJdkh+AvV9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568707; c=relaxed/simple;
	bh=6tBwo+Oh3Srb9HWDuAHjRXTojYO1L4LBivigqMLJF50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aH/jaexNRJcllgz40Tp8Ps2l8IEdxPG5Ypkf5iCxqbYx+K8/dj6kTOCM7SZbJdck2AwfVck1C0OKkhhKlG6V9toRR9SFeLtLcqj3heY3iV5VkfzM4oxWd64JnG2a7yNU80E5lCO7ZD8/t7A1gTDOgOvXOzIk0SDf51lASaW3XFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rjZG3Axq; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rjZG3Axq"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CEC7042B25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725568706; bh=MIMTJ1IqKe5zbWCjoP/nzOxRPsxYChGqQf1HDlixYjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rjZG3AxqG5Dsc4ESW4xx36yUmG6T2tF7TR8BddudTGTTnQ0JZntUR3b3B0hmnUyxD
	 6V0iyzZyzaK86Aqn8Z9GvZyEkbbUqo9PTRWmmIhawSrpJdft3vIkxV+yzQzot4fPvM
	 dtzSOGwtSHZOSvL7X8aRgGPfXLUAbNUdA///v4dtRLv1d/VtEDzudFpYt/RvVKVhVt
	 12aERltaO1kQmYlorONaOC0X/kffxuh31Iso4X4HcHq9xWxQdO6f3OZ4XhWlCGnkad
	 ycCjcevf2a+La4tq/c6r24515G6lqd3OUgzk9Mq8OAhiqPEgAbpAl1A/An/Avg0uAO
	 v6gV51z4O7fMQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CEC7042B25;
	Thu,  5 Sep 2024 20:38:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Karol Przybylski <karprzy7@gmail.com>, paolo.valente@unimore.it,
 axboe@kernel.dk
Cc: Karol Przybylski <karprzy7@gmail.com>, linux-block@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: block: Fix grammar and spelling mistakes in
 bfq-iosched.rst
In-Reply-To: <20240814155558.3672833-1-karprzy7@gmail.com>
References: <20240814155558.3672833-1-karprzy7@gmail.com>
Date: Thu, 05 Sep 2024 14:38:25 -0600
Message-ID: <87plphg7jy.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karol Przybylski <karprzy7@gmail.com> writes:

> This patch corrects several grammar and spelling errors in the
> Documentation/block/bfq-iosched.rst file. These changes improve
> the clarity and readability of the documentation.
>
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> ---
>  Documentation/block/bfq-iosched.rst | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Applied, thanks.

jon
