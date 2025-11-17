Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797E134B419;
	Mon, 17 Nov 2025 20:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412315; cv=none; b=OnMmnYjfScxOV8ZMbOYX6yFGsBuNBnL15dUY8G0Y0INTql0H/wPH2Zr6/TDKa/pFWk7ViIp3HaSvu+/zFlcDf5/fbaCOJgDXjvVdPtwuZv1HXBXcuV0K8/OMVqYtw1gJ6++NAuu5FHIHn74hJtd14ciCzVIOp8oEGr+xvpHZKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412315; c=relaxed/simple;
	bh=20wLWLx00zlyT7qwZ8L720r1nk+yEHfjWa1A8lzQSz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tW8MesPvgPgWkBHWhnnGUWigM6j8OkYWr4s7bmeNLqoac1wfYFNvmyxCZi8/Al0brr5uOLpcaqY4tzTqk6SRx2/vfjxpM7pdsWQjggvkFwPwMCa4FjtgECtDXpndJ2hNsNjJgPgRfS3D0tbnGs0qdPuv5KvXaIRIflobhxkhW3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zpaWIXV7; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zpaWIXV7"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d9KWB360SzltwPH;
	Mon, 17 Nov 2025 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1763412308; x=1766004309; bh=aYMXFFSsbxMvQfP8puY/troE
	kX+lmWXsZgsFjJyFPHM=; b=zpaWIXV7O0CZjvUApImiWFlMSyI5mC0YUNlOmVKl
	deZp2Nw/BJRphZAomiQzT1g1LC6Unnmk6yg69QKhqRW6PB3DEgZTqoML91eIqZdF
	ueFglJ4aYd+xJthJzMDT9XHzEYnlFZEzLrjFyO9RPN9iQ2VSn4z+RD7sx4UMPHaK
	s4xgHjtS1TsmLnGlUEp93MNLriC4bIRy7jtdE06oOfs2Z2v5M4uqn2qMoqAbZrqW
	3Kgk81htcEzX5NL2oXktXJWNCZOBDjg8iszeYUSX+L/PBIWeNM0yMPDw6UHde88p
	RGM437gcNqpJZXrdGjLwrfg+IhcgqMV4Bemt4Ptg5VYFoQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BrXxTSAIq_r4; Mon, 17 Nov 2025 20:45:08 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d9KW138D2zltKjY;
	Mon, 17 Nov 2025 20:45:00 +0000 (UTC)
Message-ID: <32b831d6-a313-4d8c-9c2e-c24aa2cfeb56@acm.org>
Date: Mon, 17 Nov 2025 12:44:59 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] block: Remove queue freezing from several sysfs
 store callbacks
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Martin Wilck <mwilck@suse.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20251114210409.3123309-1-bvanassche@acm.org>
 <20251114210409.3123309-3-bvanassche@acm.org>
 <542de632-aace-4ff4-940e-55b57142b496@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <542de632-aace-4ff4-940e-55b57142b496@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/17/25 1:01 AM, Nilay Shroff wrote:
> This change look good to me however as I mentioned earlier,
> introducing __data_racy would break the kernel build. So
> are you going to raise a separate bug report to fix it?
> 
>    AS      .tmp_vmlinux2.kallsyms.o
>    LD      vmlinux.unstripped
>    BTFIDS  vmlinux.unstripped
> WARN: multiple IDs found for 'task_struct': 116, 10183 - using 116
> WARN: multiple IDs found for 'module': 190, 10190 - using 190
> WARN: multiple IDs found for 'vm_area_struct': 324, 10227 - using 324
> WARN: multiple IDs found for 'inode': 956, 10314 - using 956
> WARN: multiple IDs found for 'path': 989, 10344 - using 989
> WARN: multiple IDs found for 'file': 765, 10375 - using 765
> WARN: multiple IDs found for 'cgroup': 1030, 10409 - using 1030
> WARN: multiple IDs found for 'seq_file': 1358, 10593 - using 1358
> WARN: multiple IDs found for 'bpf_prog': 2054, 10984 - using 2054
> WARN: multiple IDs found for 'bpf_map': 2134, 11012 - using 2134
> [...]
> [...]
> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
> make[2]: *** Deleting file 'vmlinux.unstripped'
> make[1]: *** [/home/src/linux/Makefile:1242: vmlinux] Error 2
> make: *** [Makefile:248: __sub-make] Error 2

The kernel build is already broken without my patch series. Anyway, I
have reported this. In the kernel documentation I found the following:

**Please do NOT report BPF issues to bugzilla.kernel.org since it
is a guarantee that the reported issue will be overlooked.**

So I sent an email to the BPF mailing list reporting that the kernel
build fails if both CONFIG_DEBUG_INFO_BTF and CONFIG_KCSAN are enabled
for Linus' master branch (commit e7c375b18160 ("Merge tag
'vfs-6.18-rc7.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/
vfs/vfs")). See also
https://lore.kernel.org/bpf/2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org/.

Bart.
