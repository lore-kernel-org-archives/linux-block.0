Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D61802A5;
	Wed, 17 Jul 2024 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233408; cv=none; b=sxJMZRgokK69WzLezrUVe97rtwu/6xPahA7xKg9Z6bo7kbHFbt2yCDDzm7VAEl5KQwCWDRIVuwRl6riVMXne2pAkmfh0P4ReFfM6VkZi4WnMRadaZbKVaBB3yVn+OLxJaZuT1tGbcXXAm6RDbVNRjZ3X7EYZ+elKU3Rm9SXHPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233408; c=relaxed/simple;
	bh=uU8IEmzWRyCnoK378H00qda3bLD/wesPzldBX4Z4OMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQkBlsxUfNIWtR3dqq+JVl80X7SOHLjWanyr1JbcjEmNQoCR+0s/qQdp/XlnsCjwdUURbZLhgZetZYNwNrACnrVxLkzakBPt1ElFjplGkqkiF1OtO+VbiSyiRuS3ZisxfAT3clEhtSV0TuFJXkYLThYUY+tcgO4fOGn5fwdhcpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sOVBNxjA; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sOVBNxjA"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WPLpP0MYjz6CmM6f;
	Wed, 17 Jul 2024 16:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721233402; x=1723825403; bh=uU8IEmzWRyCnoK378H00qda3
	bLD/wesPzldBX4Z4OMQ=; b=sOVBNxjAv6YJsSUSya6T/dizM6hWIJ9WidvOkKst
	Et6+ibJdcFyvsqlNjd+TfEI6/iWWPvIuHzezXbdMw2lGrjbac4fKmt2uidlLwflg
	r6MBQWA7qbNS+AnAY7SZbeLjOtxETHGMspxM9w0sZS3x4uNi0DXHtFgGU0A763bf
	0yJyxfBXj8/zR3WNm9UOmEsQTdE70Mu4kXmnhdNr72c0zpeO3ru9gpLcaAXQfxXz
	ceMZ9LC8W4drZMlzPOSVHLPXYlWjWl+oeyY8V6I/lDWhESCGIn5ITjDzSq7u66o6
	BzA6shftPNwINYS2qCMyx2ZKoRuUR4yTNt/XA1UYLFEQ+Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sKUJVgs91eZ1; Wed, 17 Jul 2024 16:23:22 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WPLpK36gwz6CmM6c;
	Wed, 17 Jul 2024 16:23:21 +0000 (UTC)
Message-ID: <e7c95d49-d279-451c-9bd0-3f4009c7afcd@acm.org>
Date: Wed, 17 Jul 2024 09:23:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix deadlock between sd_remove & sd_release
To: YangYang <yang.yang@vivo.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240716083801.809763-1-yang.yang@vivo.com>
 <1859a975-8c53-140c-f5b5-898ad5e7f653@huaweicloud.com>
 <451c8746-5260-4be6-b78d-54305c94ef73@vivo.com>
 <a81cdd5b-d6ad-2a4f-0f6d-40e9db6233cd@huaweicloud.com>
 <51411297-f579-4229-a72c-c5bd5f27df34@vivo.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <51411297-f579-4229-a72c-c5bd5f27df34@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/24 3:15 AM, YangYang wrote:
> These sysfs nodes are in different directories, the scsi node located
> at /sys/bus/scsi/devices/0:0:0:0 and the gendisk node located at
> /sys/block/sda. Would it be necessary to wait for the completion of
> the scsi sysfs nodes' read/write operations before removing the
> gendisk sysfs node?

No. sysfs_remove_files() waits for pending read and write operations to
complete.

Bart.

