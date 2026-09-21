Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B24DAF88;
	Mon, 21 Sep 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790011877; cv=none; b=jxOWhT10P+4w11h0CEDddmKbPcmlpm0c4XvpUXAYEq6eU8aOnv1gyq0Fil/XRkMK88k1RxDJzym2og0N7eutwfGr8UabNR4lkFYI6/nUufmdSj4i1YEuoeu7LUIxvBMTOfNebO0hXFFa3iflDsONSC4xP6LsmkAeny6A1Ak6XZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790011877; c=relaxed/simple;
	bh=WAlg+NgYN3PFQZPZlQG0D5Z+U9dqgkY4iSarDhh+ufU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMZMV5X+IWbtJVGWUFVVuuHWG09BlemnBxFl7/PirNoiEGl3r85k8RDT/+vrLq7PLCnCIgqVjF3vUd3lTe+Rx4u9KxzpPLWqbjFz8ueZ4abgceA4IRMP8+8FNXV9J1M241WWLHwpgqxp3EwoFDtc1Z8ZHjRB4I7W8xErtJjs40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=eGNFKy2R; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="eGNFKy2R"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hpVdG6VFDz1XM4Tn;
	Mon, 21 Sep 2026 17:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790011863; x=1792603864; bh=jP5FCtxufYPRZynrdKUIASYe
	ZQcPiCGX3xQ0AJVXg1s=; b=eGNFKy2RXutDgQ3wcUJ/sbyAlGvjPNWd4g9RkEAG
	VyhmbLEmp4cqffMb2xt3NgDdhJtA6Uczitfo9R3CAdbhdxP5IPljw01HkI9Gl5Ny
	rSmUS4EjTj38K647Vj50+6Ph+eVo8q1Q0fpX+qxd8x8TWk15WcEiLBQPyLb800os
	bqtzeUFs2DIwOKlmbYLsTx37cF6Hb9USxr1tcOWL7nrHNvbxMwhgpjSj4BVTLTlX
	zGRd1xhItJzEQiqxNwLu2V1EWkHPcN+7Or2uBucBUDHUsqBUEyJNsczaFW0y6E4Z
	oZOYlmY7wD1kf1P0FSVSfGag9gAHj63mBrZMJuz95cWjuA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id M7ca7zn0lZMn; Mon, 21 Sep 2026 17:31:03 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hpVct0pCtz1XM4TB;
	Mon, 21 Sep 2026 17:30:53 +0000 (UTC)
Message-ID: <d4c22222-07ee-47ea-9877-1c30b7222c91@acm.org>
Date: Mon, 21 Sep 2026 10:30:52 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] loop: Perform __loop_clr_fd() from run_todo
 callback.
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 rust-for-linux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <e615fb71-f386-4029-8ceb-22e375ad9e94@I-love.SAKURA.ne.jp>
 <1b6728b4-3232-4ba6-8114-a3d04d694c62@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1b6728b4-3232-4ba6-8114-a3d04d694c62@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/26 3:51 AM, Tetsuo Handa wrote:
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 758c20678bf6..86ddcd9dadf0 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -75,6 +75,7 @@ struct loop_device {
>   	struct gendisk		*lo_disk;
>   	struct mutex		lo_mutex;
>   	bool			idr_visible;
> +	struct task_struct	*rundown_owner; /* current or NULL */

The comment next to rundown_owner is not useful. Please improve it or
remove it. Once this issue has been addressed, feel free to add:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
