Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD371531D5
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909172; cv=none; b=Qv383athmJ521OEi0PmCXCr9gfaAuucrSQ/zNnoavPVZDS2weFmnBZG+CA1rooVEGqJfDkHmTHOzkGCA7LyEt35ozdo58rDL0ggHbBWGRw1HR05hU+6VW04Qji1I3al0hDGQxGm2me3AAXxLDDPl2GmwBpnf5RZo83fZbgHWLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909172; c=relaxed/simple;
	bh=ffd1lv3TZuHF9hAnP/ZwJT8am8FyPRA8V6CiULBQDcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJ7PB2zBg9+KYcQLQiQDxz8s1eROap+ukRamp5ypVusu7pAQzngBcAU4a4odjGjQQ3ZDi8QJQBtbPIUbuo5OuXjnqZzheSl3clD9Jrjud4fRNFkR+ath5nHslroXhu45MsQQosaLY0bh7tI49xUK8Me7QqlUcLNixNrGzTxB2KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rfJZGRUd; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rfJZGRUd"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bbWNx3V78zm0yVD;
	Mon,  7 Jul 2025 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751909168; x=1754501169; bh=ffd1lv3TZuHF9hAnP/ZwJT8a
	m8FyPRA8V6CiULBQDcs=; b=rfJZGRUdIKRURPu0OshGGURtwAS739ahgn15zLG3
	/FA8SmvHWaJy4ucOsY6rynDZonkpYPF4ahajLHLYZRQ8dz0oc2K8uw+3tiexprsP
	7CPYMrxoC/bI/Bm2TNV93Nznnc3vUCAXTfmp32NRMixQeOgkyXhaW+IEqAo6EWF8
	1qGP1I3RGZA9frEdoKZigtnNFhkajwjYP+uGTGSlJ1PPGk9lSdQzZIaoHVAPOHWW
	BA+jUjfrz4QRGhRGVax5xO2GmVlowiAl6KDvWNSnZANAW9ZtNhnGD90BKrvjHDun
	OgEu3fTRSDUOQE23jIqVlAZ+uus8ltPJ1woX1N3gI24FBg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BAae-LKsBSl9; Mon,  7 Jul 2025 17:26:08 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bbWNt2LMgzm0ySG;
	Mon,  7 Jul 2025 17:26:05 +0000 (UTC)
Message-ID: <d51daad2-dde4-4a74-9b74-5d0a87424834@acm.org>
Date: Mon, 7 Jul 2025 10:26:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] common/null_blk: check FULL file availability
 before write
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>
References: <20250704105425.127341-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250704105425.127341-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/25 3:54 AM, Shin'ichiro Kawasaki wrote:
> Commit e2805c7911a4 ("common/null_blk: Log null_blk configuration
> parameters") introduced the write to the $FULL file in
> _configure_null_blk(). However, the $FULL file is not available when
> _configure_null_blk() is called in the fallback_device() context. In
> this case, the write fails with the error "No such file or directory".
> To avoid the error, confirm that $FULL is available before write to it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

