Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6F50B8B2;
	Fri, 18 Sep 2026 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746594; cv=none; b=LpY3/yAWvcxp27jJpINnj2gOi723JhOSgJzNTUuLsBX2hX/YTYutq6J3djhAAgKBgQzc4uXrtvt3QEoo7op7CIU7teRBMQDmh1wqFuJmpMRITS4OGPusxFhzmEldU0jLsvpwADIasVd9rk0IAw4ejd/cvDI5aHMY+P9y2ITMgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746594; c=relaxed/simple;
	bh=YOmjtTP9hBIv8SRjvRP7NZRivy6SLW56fE6T5NNzLGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAtwdycsUtayfJzC3BMgaTL1Qdds93/OP797ZaoAaQh8uXG5Mj2qZG77Iak+8xnrPXYkfY7QJgPMgwAEeHyyS0z9OkbqE2SwC7ByhIgBCPe/60mxEChtO9Lw82KVwk8XYOedTVofT88qJCiWF7VX5kZBFdPL3gyHER2gTR4Z1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OljsyqW7; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OljsyqW7"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hmcWZ0Jw7z1XM30w;
	Fri, 18 Sep 2026 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789746578; x=1792338579; bh=IbaS2m5CcjUy2X4JY9w1U2nF
	X8P4qK2roi8UKmX7/rs=; b=OljsyqW7xuHcrt72thp6q65dKZz5LX12ugybU7k+
	qvvmUJ7IxjpZRiWQGVibT01NTpLG9vlk/1eDHE65miwSSYtS0AxV+bGuXZF3I11L
	R+Z54Suz5rkiyoSMrprNM15TmSgT4mPKvmcRPM6N+QQmS26QsMhfdSPnTHCrYD8i
	gWNF0RnvjaTd753xeA3wXal7NIC4ARlmSXAs94OKL+u8S4Ri0vALQfNHQTHZO9X/
	gp9KOPOPuYf+ODDRJFqCIPaeOEEC24cvnVAQ0LM67kGSUmPInz2i45sZHEIXei9W
	0I8APWA1Ie53lZKTv7rSy9Obl6ikTk4CA643EJ8+emTXaQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id C_aNzpbo7tBp; Fri, 18 Sep 2026 15:49:38 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:e6da:4727:8acc:70cf] (unknown [104.135.182.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hmcWJ6fC9z1XM5kD;
	Fri, 18 Sep 2026 15:49:32 +0000 (UTC)
Message-ID: <b9fb6da9-00be-4fb0-853b-ae37cb917fc9@acm.org>
Date: Fri, 18 Sep 2026 08:49:30 -0700
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <8ac41772-c397-4069-8878-7a1924e8b8a3@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 8:00 AM, Tetsuo Handa wrote:
>    for it seems that Vart wants to let current thread run __loop_clr_fd() instead of
>    offloading to WQ context and letting current thread call flush_work(). Vart can apply

I see that my first name has been misspelled twice. Since it happened
twice, this probably happened on purpose. Misspelling someone's name on
purpose is childish behavior.

Bart.
