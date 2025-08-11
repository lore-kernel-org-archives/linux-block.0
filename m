Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD432DE6E8;
	Mon, 11 Aug 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919861; cv=none; b=XEK9Vr616HhmZ4r/NFjC07ziOqOaIyp+tUvq5ShrbIdgeMgV3jBfIcm4j+5sLHfJhsyJjZejHkZg8w0Dh6vzhxPcM3RH5VsjXX3vjlqg0P4QA3lI1lv5MDM872gTVaz3IU5nT55UAiFUuO2wfuALrsEDkUzVoBI9rA9fhH7+MRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919861; c=relaxed/simple;
	bh=pKtU50/hE56IG22i7Ja8Ynys/datUkTG1hi1/AORHa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSmPqi2LTTRfSRCFnY/6ZHRzXR89k2Pu10TQT7oT6/FA9h6fEyl3lqj+vyUmYPNpvm5Z+0+Y4wRQnCyhW/ryeloo9U5ANyt9Wvwi6FuoQ68LgXE11AlCtCVG/n8ADNrOxw+ay6db5dG0GORNpwOGb4g9jrR5+QHELntom6Jky24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vnBct1Xt; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vnBct1Xt"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c0wph1WmjzlgqVH;
	Mon, 11 Aug 2025 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1754919850; x=1757511851; bh=6RgpocCbKdVK3rc0ouSRaRbC
	uDPNs0B+gHPMVM2wrSs=; b=vnBct1XtLEmuWRMwhpQxh3008HbQS4f/9t+Kpm6N
	MZLmGuJnFN3K6+NLl59WG1eFBv5js+ZWTuiRWovAIhjbBAVuYtBrrsR9rUGV5IY8
	z90sHuF7C5Nq6Gid/5FwhLT169NHs8viX/Z3rAOXsKaQ5LcOisegWMykZX8Agjbc
	8ZDGxQVTToUJKHOn/dlXmpoqAIbFJQuBft5gvf8VysExz8ezU+IBRGURYghKvEO5
	HW0P7ctLhWLa1PLxm/ddoA0RQdQMwrgMiVkD4KjnJ9l4Lt1M+098YxfMGMBd4Zji
	urN+4YfslxDNO8d9iwgBCLozeTavC0WkgJtLBLREwRpARA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9mPmr6_UW5sq; Mon, 11 Aug 2025 13:44:10 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c0wpZ1BwpzlrnQ6;
	Mon, 11 Aug 2025 13:44:04 +0000 (UTC)
Message-ID: <7a2534f5-bf20-4d3c-afe7-afcb8f340929@acm.org>
Date: Mon, 11 Aug 2025 06:44:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] f2fs: introduce flush_policy sysfs entry
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20250807034838.3829794-1-chao@kernel.org>
 <aJnLXmepVBD4V2QH@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aJnLXmepVBD4V2QH@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/25 3:52 AM, Christoph Hellwig wrote:
> On Thu, Aug 07, 2025 at 11:48:38AM +0800, Chao Yu wrote:
>> This patch introduces a new sysfs entry /sys/fs/f2fs/<disk>/flush_policy
>> in order to tune performance of f2fs data flush flow.
>>
>> For example, checkpoint will use REQ_FUA to persist CP metadata, however,
>> some kind device has bad performance on REQ_FUA command, result in that
>> checkpoint being blocked for long time, w/ this sysfs entry, we can give
>> an option to use REQ_PREFLUSH command instead of REQ_FUA during checkpoint,
>> it can help to mitigate long latency of checkpoint.
> 
> That's and odd place to deal with this.  If that's a real issue it
> should be a block layer tweak to disable FUA, potentially with a quirk
> entry in the driver to disable it rather than having to touch a file
> system sysfs attribute.

Chao, two years ago Christoph already suggested to integrate this
functionality in the UFS driver. From
https://lore.kernel.org/linux-scsi/Y+NCDzvuLJYGwyhC@infradead.org/:
"Please add quirks for the actually affected devices, and do not
block fua for an entire transport."

See also the ufs_fixups[] array in drivers/ufs/core/ufshcd.c.

Bart.
