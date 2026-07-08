Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97388379C26;
	Wed,  8 Jul 2026 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525883; cv=none; b=TnKpPLetuU3mJBatzErCNhAdhETFlQmBvCKElZqrwYiIK9IrnvBjKYIVmGaoRBUft8FR6lEdJtFmQq5dwJGR1/n72pLWVUhMT92TaEvkJm/UHjTXT5Zi6CLEWZd8oKlp+b5kyiFPyzuB5b9tw/YCv3qctXOKjhGUsNj7ysnCM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525883; c=relaxed/simple;
	bh=446ZFUxtgE805uDH7O3m7bDfMbViwP3bgXWYJZ6awG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Io3Y26rDoj7LFGud4kgQflGncGAFyOZA3ayo8j7UwWTFFpxmKDBm/SCfRrgH9EpSJAOAz8uzMSONg00RJQoMxhMWEpZydLNFtsjj+P96ZaZYJsa/8n6rM5L50y4n6W8PGPv3Ckdn7tG/AYJxvyCUuKLbx0K0MJ21u5VkddgGkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=R553JWlZ; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="R553JWlZ"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gwMyf11Qyz1XM0pF;
	Wed,  8 Jul 2026 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783525877; x=1786117878; bh=446ZFUxtgE805uDH7O3m7bDf
	MbViwP3bgXWYJZ6awG4=; b=R553JWlZ9Y1yQZgWoWZhG7lSOva+V2fx25YpG2n1
	t6JST/yizyeDLgIucz5E/vTQXRZOe3N6ZQzGM1DT/cX0MKKGFHe+IOC7YdZrVqPm
	nBCOxhEQIhULsR+i237Tkyq0THu3eFF6kX7p4BJ4j1bRJEWUtmRKH/+9kCcqhYlH
	kKlJfpwovxyCEE4M5R/iiwQJIJEn5gCfb+FOWvysGuINhhQ69O8pHulxaoEaVjVv
	dQkZICVD+v2SNccosqpeMsVuLt3+Cks2yG9O3XkNHQiWxZjtw5KdLxVEjx6vK/om
	7XVF4UuGB7EY8Vf1TcaAoEbfVcIAh2x3m/VCBfkqMDlEAg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Pxes1YXhNpvh; Wed,  8 Jul 2026 15:51:17 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gwMyV0qPjz1XM6Ht;
	Wed,  8 Jul 2026 15:51:13 +0000 (UTC)
Message-ID: <e299cdd7-a709-400d-8dd8-751971b76275@acm.org>
Date: Wed, 8 Jul 2026 08:51:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/6] null_blk: register configfs subsystem after
 creating default devices
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260708073917.2172392-1-wozizhi@huaweicloud.com>
 <20260708073917.2172392-3-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260708073917.2172392-3-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 12:39 AM, Zizhi Wo wrote:
> For simplicity, move configfs_register_subsystem() to the end to solve
> the problems above.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
