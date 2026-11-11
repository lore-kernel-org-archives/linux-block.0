Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417230;
	b=SuyvHAXaFttMOXqraLMs6jFxYNa0TWFPaQgPQVB2GK5iKtXLfw28KD3JGN1adlGk1rGu
	 ewTuZgLNPUqjVFWZkG6j3eHsI47JCXr0+5VFmDW8VBnuXPRoBLTpdpk3H1IKFHyuHoUmc
	 g6MV/cb/iQhnbfvg2zvVtevQv/Wc8/j7maVV+Va8zH0Kn/cIU4cCGFdWE6xQ4zhxJavO/
	 JGI2yKOTeAJ/vsscl/RJeJW0mMxmy/keR5O+aplwZv2Nx56s2HfD2HZYxEBBNocYAWGWF
	 Tsv2i9v4iMHJDFyKLa+neu7+d5oxK/Sunyi7ykB3xTC68bdKifSLp+jYiuPCSKOzoMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Pmc0sNWGC7k0bEkstele7ct2HavJeGya5bgJWGmK6yk=;
	b=OERDZpjuJJJC784dFtChvUFk3yp19ELJaX0SfqFqiD9XJP2uRvxkaEFNHwIIScL4nawT
	 K338bvcsv4cD4ZMz6B0+HNkcYYePeoOyIkdwNUllXaBN0nlZdHr893tJp+hUEQcywP6aM
	 rO5ZMhJTiqYk22ViSkB4d4DwhEG1j9Jp5lpwcorloorXB+K3PeWAdTh6ylYs4Qv/2FYz7
	 j+Rx4vIGwReHrMC4qFZ2T2G1uSypv8xIgm5lMSY3lIC9U+h8yR6KCncFFwzK3rCWjSqJ/
	 B25e6XSmVsuzPeV52+jLX9pVmZoiZc8CpoXxn0MbdZGeHBPYm3Jek6WBKu+7i7lRyCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="10P/U8sv";
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C82606A321;
	Wed, 11 Nov 2026 17:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69C82606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=10P/U8sv
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jPqqd6hCSzllB7V;
	Wed, 11 Nov 2026 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794417227; x=1797009228; bh=Pmc0sNWGC7k0bEkstele7ct2
	HavJeGya5bgJWGmK6yk=; b=10P/U8sv49eM/t25mzJ4heBUeXZmxqGV9zp4QtRN
	kHkTrsGJmLQxvVQNXTSwv72ao5w/5L/P6Y3+eKFEL5WbEoJ/phKKnZrTlC+/pruK
	xLq/W1HGhDiMUrthb34ENgGivCKWSRHGdv5WBn3GwLtTphnxsuGd2+R7wU9kTyMQ
	ZZZwvstvfhNeu2Zt/KbIcC0RwsYSSprVP9Ha3VrO73xBXBXxPcbZV4myJDEK/RYq
	dmZqAUN9qrIJ5CURGLcI0HCBM0G3Kn+soEqvkeQsHAAW5/s89gVpxZp3HSs/OMql
	uKaypl2HIwMghi6RClOcHq+AJQ6+p3RZgUFZjYoIfjGihA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OhkyM4DcAA0J; Wed, 11 Nov 2026 17:13:47 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jPqqZ4V9Kzlfcln;
	Wed, 11 Nov 2026 17:13:46 +0000 (UTC)
Message-ID: <c2f4dbce-f8e0-4f04-8dee-3f8d413f4d0d@acm.org>
Date: Wed, 11 Nov 2026 09:13:45 -0800
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
Subject: Re: [PATCH] nbd: fix circular lock dependency
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, nbd@other.debian.org,
 syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
References: <20261111101919.215767-1-trintaeoitogc@gmail.com>
 <20261111113814.221685-1-trintaeoitogc@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261111113814.221685-1-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/26 3:38 AM, Guilherme Giacomo Simoes wrote:
 > After tested, how can I mention this in my patch?

If syzbot confirms the fix, you can either:
- Add a "Tested-by: syzbot..." tag if syzkaller provides one, or
- Mention it below the "---" separator in your patch (in the changelog/notes
   section), e.g.:
   Tested against syzbot reproducer via #syz test: <link-to-syzbot-result>

 > What do you think now? We will call nbd_reclassify_socket() inside
 > nbd_get_socket() and call this only one time? Or is a better way call the
 > nbd_reclassify_socket() inside nbd_genl_reconnect_sock_cb() when we 
have sure
 > that we will use the socket?

Calling nbd_reclassify_socket(sock) directly inside
nbd_genl_reconnect_sock_cb() (right after nbd_get_socket()) is definitely
the best approach:
1. It is a 1-line addition to nbd_genl_reconnect_sock_cb().
2. It mirrors what nbd_add_socket() already does.
3. No code needs to be moved around, keeping the git diff minimal and making
    the fix trivial to review and backport to stable kernels.

 > What do you think:
 > ```
 > nbd: must reclassify socket when socket is created
 >
 > When we need to connect or reconnect a new socket, we need to call
 > nbd_reclassify_socket() to ensure that a false positive lock_dep
 > circular warning fires. [...]
 > ```

Please use the imperative mood, e.g. as follows:

nbd: Reclassify sockets in the reconnect path

Commit d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular 
dependency") introduced nbd_reclassify_socket() to prevent lockdep false 
positives when NBD sockets are used in memory reclaim paths. While 
nbd_add_socket() reclassifies newly added sockets, 
nbd_genl_reconnect_sock_cb() omitted this call when replacing dead 
sockets during reconnection. Consequently, reconnected sockets retain 
the generic socket lockdep class and trigger false-positive lockdep reports.

Fix this by reclassifying the replacement socket in 
nbd_genl_reconnect_sock_cb().

Fixes: d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular 
dependency")
Reported-by: syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com 
Closes: https://syzkaller.appspot.com/bug?extid=d7d72f3d467710442af0



Thanks,

Bart.
