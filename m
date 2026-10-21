Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601378;
	b=EatdvcShOWRKBgQZulwKV8ag3qVJg28kbz3EIoffVNvIOvvp9piIBGyIgyLkpfguEda0
	 BTqc4trsoqwBH8hv8ZzUt30VkzMKz48J2WxSOUjNIAxbiRheamPwKmzyMROraoJSvZy2v
	 NlZc38najixeRZOuihmkOVH/l2PpJumzZCd8zCFhIHx+nW3MWe04XlBAWyUbpxj+yijCT
	 +ddLAwe8p5EKMTZ40t56I7bdqNUHk5vasCaTiMTlbUZu0G22ZsDjiCthAaOCTMOKXiMWF
	 FDkJqERrUt9YQiHdQDd5v4jViMcRxAxmlHQmR20Aq8A7YTLj60ZEM8JW2p0Kn02mTnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=1vJnDpwVYLgb2SfwiOBBeFH79sMSFeqjlwGNgb0hChk=;
	b=kdm7N2c/3vxqBpP7czMI6EjPHofwoOZFOCGP7FgKGDRioqWbkhdKW+e5m5QnQI3TrM9t
	 SpNwO/D3Mc29Yh4mc8GOcefHdiuJor/iYe8GBuFqBj4hj8u+myi6x1qmCMy6+Kl0DWMMs
	 eFk4QYeNBZa3V1s4fstAN+M+eLKaEwdwUTtn/TiobKVOhV8qpRlhsMe0PTK91o7UmhPbl
	 tXiaNOcAvUdT+VJ4TOFfqdEADfzjc+/phUE2ozF6lx3GxVz8Nu2O55FqCoOkEKKQxm7Zh
	 czfpqlAmrSjD5zdUNbo/tdIGPmYK4PGQvC5dPKMLMYqY5F3id1QZcdRtBQvVF4hmCvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=wuv+gXee;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CC5606A31D
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 16:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77CC5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=wuv+gXee
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4j8wHN5ljzzlfvpr;
	Wed, 21 Oct 2026 16:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792601372; x=1795193373; bh=1vJnDpwVYLgb2SfwiOBBeFH7
	9sMSFeqjlwGNgb0hChk=; b=wuv+gXee1aH2CRmadClvvk4c3HwQUpVpCrBNowhi
	oSZCQhIPa1Cup180y838sxyQF3Y0LVJVAv/Yd1J30/Uc6sVoDE9DDQXg3FXVrrpH
	6WCLXMBSSi2dxNNeDkzpVZgeJpc0vaF6Mr0PkrX/d62xlga3+a+sB3xJrACF36SE
	++E1se6eITGJkWPRc9ciYlX8/gcrioHbcDP0F8+P0IchIQf5dotU6i/8jEf45n5N
	n2IWuTdr7yf+EDFzBikT3kaTtg6ToWC71dTDwShadlHuSel9/bMoxXsi6wp3i1qG
	b3wOO2YQ/F9G50Kq8wBeWPutAm+GlD/GwxA7ENDYWCyycQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id U64hflKrJ1Sm; Wed, 21 Oct 2026 16:49:32 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4j8wHH6SPCzlfvpd;
	Wed, 21 Oct 2026 16:49:31 +0000 (UTC)
Message-ID: <97c82167-7760-4baa-add5-64abb1e909dc@acm.org>
Date: Wed, 21 Oct 2026 09:49:31 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't take i_rwsem twice in the direct write
 fallback
To: Zhenxian Ma <mzx199711@gmail.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: hch@lst.de, syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com,
 Tal Zussman <tz2294@columbia.edu>, Julian Sun <sunjunchao@bytedance.com>
References: <20261021093332.17334-1-mzx199711@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261021093332.17334-1-mzx199711@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 2:33 AM, Zhenxian Ma wrote:
> commit 2fec4fd97cc3 ("block: take i_rwsem for the direct I/O write
> fallback") takes i_rwsem around blkdev_buffered_write() in the direct
> write fallback.  commit 1b1be9ea4e34 ("block: take the inode lock for
> buffered write fallback") fixes the same race by taking i_rwsem inside
> blkdev_buffered_write().  With both applied, the fallback takes i_rwsem
> shared twice.
> 
> Drop the outer locking in the fallback.
> 
> Fixes: 1b1be9ea4e34 ("block: take the inode lock for buffered write fallback")
> Reported-by: syzbot+bd975ef54294bec73f0e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bd975ef54294bec73f0e
> Cc: Tal Zussman <tz2294@columbia.edu>
> Cc: Julian Sun <sunjunchao@bytedance.com>
> Assisted-by: LLM
> Signed-off-by: Zhenxian Ma <mzx199711@gmail.com>
> ---
>   block/fops.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 0e4c42c8b74f..ddab4940d76b 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -809,13 +809,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   				else if (!blkdev_dio_fua(iocb, bdev))
>   					need_sync = true;
>   			} else {
> -				ssize_t ret2;
> -
> -				inode_lock_shared(bd_inode);
> -				ret2 = blkdev_buffered_write(iocb, from);
> -				inode_unlock_shared(bd_inode);
>   				ret = direct_write_fallback(iocb, from, ret,
> -							    ret2);
> +						blkdev_buffered_write(iocb, from));
>   				need_sync = true;
>   			}
>   		} else if (ret > 0 && !blkdev_dio_fua(iocb, bdev)) {

Please keep the ret2 variable and its assignment. I prefer to see
function calls appear in the code in the same order as they are called.

Additionally, please improve the patch description:
* "takes i_rwsem shared twice" doesn't say why that's a problem. Please
   explain that rw_semaphore read locks aren't recursive.
* Including a short excerpt of the syzbot report about the deadlock
   would help.

Thanks,

Bart.
