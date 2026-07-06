Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAD3A6F1A;
	Mon,  6 Jul 2026 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343877; cv=none; b=aBNq4jeouXduoQRjqPDDXTvWANdJ4II0L8o9y+ALGMshPXTDJNWEWUDAsBtkgRatJMdO3ca4Pttm+n3JQeZgfn61KribgkGuisENR0rloUgBx9P0jYTU5KCTNuCCWARCr5Z2AISZYCK1we8s0+mHzBqyYrhatRrqmR85+/L1+88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343877; c=relaxed/simple;
	bh=GMYs631LM/wSAnR2CKbcgZ17HXBXBKFsWvHS7HXtp0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQsR53ejnqvhuJVe6jlj+T0qFMCxZk2YitEfnCAdm1EejSiL1v7d+USdE2Vdi7ChlqORzXa4+gPPi2nrLn2wZAfIzQtWal5QDrxYHTh5WqRA+Zj7QCUAqbC6uaQ6Yuh/Ov/7Uhl0XbQz8AX3acvQ12a61CljG+46pbLrcdvrLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3f8Nfv6R; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3f8Nfv6R"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gv4fW3ST7zlfvq8;
	Mon,  6 Jul 2026 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783343870; x=1785935871; bh=27VfUN2HGkJPNvTeZZsRNxNP
	KvnuhvxZ1ic0HHAooMA=; b=3f8Nfv6RbCGvaggaOxYToOM5yc7DASZC1rDV2pwl
	8jSdVhg+DwDZZXg4cTxbKJykQRJ82sK4eJQE1K9ycBnnk8aWtZ7ZpbJvZJge8qqW
	MkuIL7/h/5XesH/pIzwJNIKYZREitSsGTfzcXa40rPuLOfeAcSYZ39JpzWg9mkwW
	5Htplkvf75C2gbamdKPG8h4MgRde821p8gG6Joq1V+HSO1quQD5Lhd+5UE/e68BV
	hnH2Z161ZbrPlSKIVv4LUM3wJyJaWZm77EvVJlAzJXQqXxn26V9gciRRjTYhSsmC
	rmj4vPi1xfWVoeQChmp/c4yj6d334pClHJNrwcbpI3cUzw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id f_y3W3MOFfrA; Mon,  6 Jul 2026 13:17:50 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gv4fK5fkXzlgtcn;
	Mon,  6 Jul 2026 13:17:45 +0000 (UTC)
Message-ID: <490008e2-2345-48ea-bd8e-c078d828a43f@acm.org>
Date: Mon, 6 Jul 2026 06:17:43 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] null_blk: register configfs subsystem after creating
 default devices
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, dlemoal@kernel.org,
 nilay@linux.ibm.com, linux-block@vger.kernel.org, kch@nvidia.com,
 johannes.thumshirn@wdc.com, kbusch@kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, wozizhi@huawei.com
References: <20260706123507.3809871-1-wozizhi@huaweicloud.com>
 <20260706123507.3809871-4-wozizhi@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260706123507.3809871-4-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 5:35 AM, Zizhi Wo wrote:
> @@ -2187,8 +2185,6 @@ static int __init null_init(void)
>   		null_destroy_dev(nullb);
>   	}
>   	unregister_blkdev(null_major, "nullb");
> -err_conf:
> -	configfs_unregister_subsystem(&nullb_subsys);
>   	return ret;
>   }

Please make null_exit() consistent with the cleanup path in null_init().
null_exit() calls unregister_blkdev() before it destroys the null_blk
instances. That doesn't look right to me.

Thanks,

Bart.



