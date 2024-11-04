Received: from iris.vrvis.at (iris.vrvis.at [92.60.8.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5EB79FD;
	Mon,  4 Nov 2024 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.60.8.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728981; cv=none; b=AVslKd8RVFoYvp7MXeafxPGon9XX/6+yXfw3iZyV3S7OrhuZ1UZlIJ7tNkW+5VilFmlHV/P83Gj/T71ck+XDpuapU+kewNw9XruFTgssKR5QyOxHu7MfOxmJJAButnVtDoqQyA3ljvQafKSvtTCe0x9PG334LQ+s4FZHn3Y8G0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728981; c=relaxed/simple;
	bh=y3xUGoTiwWbNHmzbVTOKiy20Euy7zT27n/ImmVpE8YQ=;
	h=Message-ID:Date:MIME-Version:Cc:To:References:From:In-Reply-To:
	 Content-Type:Subject; b=L/oNLtTlQ0pN4ztejdz2B8+0pdLFaLZ110Fd3fAJJZP4TSTwaccUP9+i7I8QnTMNNXlzcSLeAku2lI9P1hPkNZqLPivDGmBk/Q/7N4hxszd5rIvCL+UwvjJyE3NWiEkiIrSrVynfaZ2XDM6N+eW5tFQ8134ZUGzJb7BEJqHT18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at; spf=pass smtp.mailfrom=vrvis.at; arc=none smtp.client-ip=92.60.8.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrvis.at
Received: from whiskey.org.vrvis.lan ([10.42.2.171])
	by iris.vrvis.at with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(ESMPT Server)
	(envelope-from <valentin@vrvis.at>)
	id 1t7xHg-0003Tp-1b;
	Mon, 04 Nov 2024 14:38:26 +0100
Message-ID: <a471d233-8fbd-4a67-a50b-6686566f8103@vrvis.at>
Date: Mon, 4 Nov 2024 14:38:20 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>, Justin Sanders
 <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Emelianov <xemul@openvz.org>, Kirill Korotaev <dev@openvz.org>,
 "David S . Miller" <davem@davemloft.net>, Nicolai Stange <nstange@suse.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: joeyli <jlee@suse.com>
References: <20240912102935.31442-1-jlee@suse.com>
 <9371a3ab-3637-4106-bee5-9280abb5f5ae@vrvis.at>
 <20241002055338.GI3296@linux-l9pv.suse>
Content-Language: en-US, de-AT-frami
From: Valentin Kleibel <valentin@vrvis.at>
In-Reply-To: <20241002055338.GI3296@linux-l9pv.suse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -4.5 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -0.1 GREYLIST_ISWHITE The incoming server has been whitelisted for this
	*      receipient and sender
Subject: Re: [PATCH v2] aoe: fix the potential use-after-free problem in more
 places
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)

Hi Joey,

>> We've tested your patch on our servers and ran into an issue.
>> With heavy I/O load the aoe device had stale I/Os (e.g. rsync waiting
>> indefinetly on one core) that can be "fixed" by running aoe-revalidate on
>> that device.
[...]> For the reference count debugging, I have sent a patch series here:
> 
> [RFC PATCH 0/2] tracking the references of net_device in aoe
> https://lore.kernel.org/lkml/20241002040616.25193-1-jlee@suse.com/T/#t
> 
> Base on my testing, the number of dev_hold(nd) and dev_put(nd) are balance
> in aoe after the this 'aoe: fix the potential use-after-free problem in more places'
> patch be applied on v6.11 kernel. I have tested add/modify/delete files in remote
> target by aoe. My testing is not a heavy I/O testing. But the result is
> balance.
> 
> Could you please help to try the above debug patch series for looking at the
> refcnt value in aoe in your side?

Thanks for your work, i can confirm refcnt value is balanced and the 
issue is fixed now.

However, the I/O waiting issue reported before is still there, and 
occurs more often now.
This problem started with the first patch CVE-2023-6270 applied in 
commit f98364e92662.
This only happens with heavy I/O on our "older" storage systems with 
spinning disks. Unfortunately we do not know how we could debug this, 
have you got any hints what we could do?

Thanks,
Valentin

PS: sorry for the delay, I'm now back from a long vacation
