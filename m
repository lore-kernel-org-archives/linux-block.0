Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4039E5632B1;
	Wed, 23 Sep 2026 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183126; cv=none; b=hsiz4aepJe2U8Hz5kgCpV3NDCSBTYe3yoIK/XAh6BgKA9/n+5sF8VlWkDiH3rE91noL6ef8Ln0mCUv8HpxwlbcAzIfOesRwcG5P8/R8Kcx/nQiTogbwjJh0NxBMJ//vt8dNvzLwV6JHcPzF5IQb6KcuZyR8mo1h8JYL3aDvx1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183126; c=relaxed/simple;
	bh=6tBxyJgxdNerK82P7vUt7sp6cimA4C0a4+ZGuOo528U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpUGRH2nRUOP9AWAfsVrt2go76E8l15pe1F/IUxAU/Vzzh7+ShTcFZoJ400PPrgBLa0Qhb3osIa8oKOGxgCrqksNRqz8boYyBhh130HTK0grUGsWPOED1BSaD69oidJYSyihTgNnpfb3hThhV1FYdGcqfmN5r+uaLKrzBD9x9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UqAryOWF; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UqAryOWF"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hqjyP0358z1XM5kW;
	Wed, 23 Sep 2026 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790183108; x=1792775109; bh=6tBxyJgxdNerK82P7vUt7sp6
	cimA4C0a4+ZGuOo528U=; b=UqAryOWFZpU6mEJEXF8dfeid9DYIxg+8DniRbklF
	Jyt5BS7qimL1gaX/th/8q9k0j1gFXwfNcXr6qyGA+CsJ6vz51ybcX8npFy2RKUB4
	gdIGMekD3Ax/1Zct5HRepIi4qggs56+YKGP1vRMVee7TLckzWXI0sfh23FtuWDeo
	OrjDxV78mYFSWA7CoD3DlQV7V84fumu17tTlYbh4EMkEc8tlY2IbRCxbQbqbbXVV
	SbvhF0Q9EHkRVfENmA4BEQWHB8o9HRNBFH9Iy3rtCorj4L2rZ1e6nFfR7sBiUfUC
	FFRaWVYIymha+KQy4ZDu/xeFwjeC/sj8bJOLDujBb8j4wg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Oweng5elX4Wu; Wed, 23 Sep 2026 17:05:08 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hqjy76kWcz1XM4Sx;
	Wed, 23 Sep 2026 17:05:03 +0000 (UTC)
Message-ID: <03832dd0-16bd-4fd3-a689-9f956221cc22@acm.org>
Date: Wed, 23 Sep 2026 10:05:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] block: Add run_todo() operation
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
 <afbf50a0-d409-45a3-8e95-99c04ca0e302@acm.org>
 <24ef93b9-7385-4dda-8912-f7c78f9705d1@I-love.SAKURA.ne.jp>
 <ac1d3825-8a10-42e1-9eaa-f2ba51216660@acm.org>
 <d83d3f4e-759c-4218-adfc-82eecdc5b84b@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d83d3f4e-759c-4218-adfc-82eecdc5b84b@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 10:26 PM, Tetsuo Handa wrote:
> The v5 patchset passed sashiko's review. Can we apply the v5 ?

That's up to Jens to decide. I think reviews from other block layer
experts would make it easier for him to decide whether or not to queue
this patch series.

Thanks,

Bart.
