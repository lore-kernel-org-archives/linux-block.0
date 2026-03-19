Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571D023D2A1
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955104; cv=none; b=TqdYYTUf59hBDVTRzX2INHqM12CNI2CGKbp1WjiDpn2oi5d652d8rb9RMEmDWRn2Wsq1HhcvQ9nhcFOG9Yvihh4WCoikPxsp62N5lNuPPlJ6BkwEWnrjgDbiasa37XjdauuiXoOpxBPVaolVLOyoEUR8VY6+9UtEA9yeAVIe49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955104; c=relaxed/simple;
	bh=OjPHejI0ISfk18csC75FRhA7+tY20ANSZMAywihGRMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVBjLkIeh6i9xsI9CSrZ0R2j/3TEHxrYcEfJEKa9TzNDpyUPKYKePtXB8siihkYxre4ji0w3yf/Y7Bqr1TE3p3+DUaJSpIwKOfKiHjqkiaVuyX2jvkvt6GzpO20DE+4owWLuFwudubjASMTwpj3pDS6sSiYUUriAxN6h8bEJnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=N04XPbzz; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="N04XPbzz"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fcJTB6LPpzlgqsJ;
	Thu, 19 Mar 2026 21:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773955100; x=1776547101; bh=xaNiNhFVKjE5IkNWjRLyTL7X
	JgxbSfLdk63kLvZF+w0=; b=N04XPbzzBGjwqSBCnxgQtK5CCxwigRI13PS9x/1F
	oq61cttaZvERZUJr4GHKJPT3sen09D+g/YArvTh26si3Ngl8CfJVYWYO038Ccnlu
	UCjM0xPVawZl09Pna330XEkfpJubag9QbPnNTJZDacOyjKG3MAhSawQfe5X4IPzE
	DNladgbgQkcAnQ7ec82Wxt0WLDdYppaUZsre5n3540YZ4+4bigoG9++NbmdMQR3h
	oi/GkZoHBZZuizK+AGviLRw+glghXvUDgi/51OVi0B76gh0ihEQGukvc3su7tLy8
	cW/+4OxSAyl84s4t5dnPEfGm/aGdY49uFgiBaCxFD6t7lw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id iu5Fsm32VdGH; Thu, 19 Mar 2026 21:18:20 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fcJT740C7zlfvq8;
	Thu, 19 Mar 2026 21:18:19 +0000 (UTC)
Message-ID: <91069086-95c4-4cd6-95ba-4d59d57bf001@acm.org>
Date: Thu, 19 Mar 2026 14:18:18 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: add a "discard cache" debug option to zloop v2
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20260319060246.2084931-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260319060246.2084931-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 11:02 PM, Christoph Hellwig wrote:
> this series adds a new option to zloop to lose data not committed to
> stable storage using a flush operation on device removal.  The idea is
> to help testing that file system code does the right thing in face of
> volatile write caches.  For conventional devices, this can be tested
> using dm-log-writes, but the concepts there don't work for sequential
> write required zones.  Instead this adds an option to zloop, which
> records the write pointer at the last cache flush for each zone file in
> an xattr, and truncates the files down to that value on removal,
> simulating losing the contents of the volatile write cache.

For the series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

