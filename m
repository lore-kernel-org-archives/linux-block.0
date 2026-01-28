Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3E32BF41;
	Wed, 28 Jan 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620486; cv=none; b=TTuFi5JuR254LyUWu3vlpuga8ayLeNqOx5Ase+fIa5lIdrfaW+mnjLLvPOdgZjE0epyvyO2wivA20ktMb2O1SMLv0tQPwWiarueWgRn91CprX8zuzaqaqZzv0shyu7UM3lEY6pHLJUOw+gQd1N2qRCTuYxlvOzfys8GmUYqj6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620486; c=relaxed/simple;
	bh=uJmOXwecgfaKijpkk3nPT+5dUyYku1dakt4++ErgJyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgGUP46JOr+q6ZIos3yVewRCIPNLiIgW7wJhR/zCsvPcGXm31vLJXI9i4OayTURL5V1UKVAzP6dOdOqKlPq4fh1VNfYju+qar1vef8zEQG2JqcZg7xzZiJ2dvT1ZKvuHzlcXkEJdfIIE1ic9ykifLPgXDrO4gX7KY3RI8Yhfw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4DAxXZ0I; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4DAxXZ0I"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f1TR53xR9z1XMG4k;
	Wed, 28 Jan 2026 17:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769620479; x=1772212480; bh=uJmOXwecgfaKijpkk3nPT+5d
	UyYku1dakt4++ErgJyY=; b=4DAxXZ0ItLJw2yMC4dQjwhoNRcwamfyxc/NiUnos
	3ud5meI7sXXoahmhlOi9Qd8fI8apTaWaw7PbYLfi8TvOWt4QOXPmQcv1DrKBv435
	/tuow1vri+vbEghrUKntNdkYsjb9btR0lGc3xyYocQ2nIeWo/dthF3tT4PIzSIxD
	6uyxICQmpnnhUuIxniYO6WYEuH47dQa9E4I0rzM24eL2Pp3b8w8POJLbqyRbRpwO
	db9vBV5nTtwqRcznZXnYOSZjB4smmYjtzn6IK4YO1NoEdT+k7Gj3W802O7lxVTzK
	AuunAT4/PwZxnPYGfkL4SZgfC6aNcqVMEgjJD6R1ksbVgA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7YScFzrTrQAT; Wed, 28 Jan 2026 17:14:39 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f1TR15dnkz1XMG4X;
	Wed, 28 Jan 2026 17:14:37 +0000 (UTC)
Message-ID: <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org>
Date: Wed, 28 Jan 2026 09:14:36 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Ulf Hansson <ulf.hansson@linaro.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Ricky WU <ricky_wu@realtek.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev>
 <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com>
 <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
 <380f75c7adc04cbab38cfd2f82bd0c6d@realtek.com>
 <d46dcebe-ca58-44c4-87ee-cade2e478572@linux.dev>
 <4205fde06ecd4a7489b03ef25e5e4011@realtek.com>
 <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/26 5:23 AM, Ulf Hansson wrote:
> How does other block device drivers do this?

The role of the Linux kernel is to provide mechanisms while remaining as
policy-neutral as possible. In other words, it is up to user space to
decide whether to enable or to disable runtime PM.

For UFS devices some form of runtime PM is enabled by default for
battery-powered devices because otherwise the impact on battery life
would be unacceptable. If the latency impact of runtime resume is not
acceptable for some applications then it is up to user space software to
tune runtime power management as necessary.

Additionally, cpu_latency_qos_update_request() is called by the UFS
driver during runtime suspend and resume to prevent that CPU frequency
scaling negatively affects UFS processing latency. I'd like to move
these cpu_latency_qos_update_request() calls from the UFS driver into
the block layer core because I think that every block driver that
supports runtime power management needs this.

Bart.
