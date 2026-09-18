Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B118E502558;
	Fri, 18 Sep 2026 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762829; cv=none; b=UX6adBBL2N3SAxweRSp1eZvt6Vj0VLDuSG/+ITaPEUPAb5HBEz3vypIsuzDySy68aDizS7cFEm46MNr3J4qWh7J1z7geclNM3knjvqHN8TePcsd8KzNK5gRtfkMGJE6fHeNfIVZ+sV0/v191OkJl0pa+BOH+z3FkkgiorJvo/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762829; c=relaxed/simple;
	bh=ATE535qOgeH3dUuboJa2YHL0NzFXwL2lkii1KkqivLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QepcyfbuGV82ZZQL2PgibX4Q8TWTAmyqBDuHAWoXvmRRkWJMnVm+KPqgtuQdsBNxvkgokq0SMw3xkV1WDJB5cmPJop2Tnypp5dbhUNoKj5mDGRoKX0XB3zUQjM+sBfUrmn55n/NknkF/wjTwvcb5B0KwzWmTEuv3spfaxp9KXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=l/gyG0IT; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="l/gyG0IT"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hmkWt6xYgzlfwgF;
	Fri, 18 Sep 2026 20:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789762820; x=1792354821; bh=ATE535qOgeH3dUuboJa2YHL0
	NzFXwL2lkii1KkqivLY=; b=l/gyG0ITHBsODErTb931EP8VWlDSY+hx7LHZVcIW
	H/JhDj2ZM2VeDMEPByj2c70h/jXBmPzVYFjV6p9tGXFGMx2DGbej94hGoysD85hG
	4ItpDWSILEDXt9CzrFBe9IPWd3SSjYdaO40D2toUkWIPIJTYneR6yNnYoy8sgIEX
	a5DtjTK/hBoJhyMyyF+opyooyTN6E+I/a5EWEbDXwW8h1E3YiJNBZmgMBljL+EnC
	tHq8AIehdYy8dRR90jQu2EiqkwVfdo5Dh0dnSM3m6jI7NKOGkMqtHn5uOgOFpHX6
	p6lP5OOn4VZvgwImJjEA39vDiUvfzXn5JXLBcao5dkyZlQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vOdSRJuhC8Da; Fri, 18 Sep 2026 20:20:20 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:b7f7:46ab:3d6:cc97] (unknown [104.135.182.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hmkWf5tchzlfvpc;
	Fri, 18 Sep 2026 20:20:14 +0000 (UTC)
Message-ID: <52d45cd3-6328-4548-8012-46da8377ac65@acm.org>
Date: Fri, 18 Sep 2026 13:20:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] loop: Perform __loop_clr_fd() after
 disk->open_mutex is dropped.
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
References: <f597b6e6-77a7-4c09-9d72-e5a9cbe6d7c2@I-love.SAKURA.ne.jp>
 <8ac41772-c397-4069-8878-7a1924e8b8a3@I-love.SAKURA.ne.jp>
 <b9fb6da9-00be-4fb0-853b-ae37cb917fc9@acm.org>
 <760558e1-7b19-4686-9d3f-11fc1ccd8372@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <760558e1-7b19-4686-9d3f-11fc1ccd8372@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/18/26 9:03 AM, Tetsuo Handa wrote:
> But do we want to make post_release() callback be called when release()
> callback is called from open() path?

I think so.

Bart.
