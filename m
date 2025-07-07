Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BE21FF25;
	Mon,  7 Jul 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909998; cv=none; b=tQ+/AlSYWTA2Ue3KDAjPQoZhz+pWZp0Jufv3bVwCB6D+O9ZZQwcQKp4Ctwe5SH0pjsFu79J5s8fDpOQFc0MLnnd3xP+skx9jiye9LtlgYjh8tuXQRGTkx8lifhctTQWPu5Et6mz/a5x+rXxjrcOxe0xjFEx6ecW05zUqsmqGpDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909998; c=relaxed/simple;
	bh=XmTOTUwfpQebFQ3AejzO16POnbpNVtdewYMRmEHOYVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5ZzfVdrnRECSk03EThgTXYFuNK0ltd6er8ceuBsMNNJGHR9H5uPmTs/h5mpOKrsALFNC106qJWn5ldaepvVUcdVChizi9Cerpjz/1trUnsO/InjSYdlbVr3EITKJwBqjbYLjfjTX8JmlK9DWvZFUekBmhsDaj5W4oQlsadzvpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XRufL2tJ; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XRufL2tJ"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bbWhq5bKDzm0ySG;
	Mon,  7 Jul 2025 17:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751909993; x=1754501994; bh=jo1ezI3yg8pDe+rN9VdHGNjY
	QJTmcSIi+8PfDwfiijE=; b=XRufL2tJdVxjU2RRAyaT2I38aGt8E1OjOCkP4dN7
	AXalL2QIKRBBI774gtJ0hNpeTOpO1oZQN4Q353+PE0Lp/lWrtOpwPYhHYkWO1Uie
	X9qRaF2dhUURQA63yUPzlazquMBmDILjywVquRYqngRouSvAWm+wCOpRgLHdzJB/
	joq7VJEZwxc4lAaZceTaOHWB9hYf0936iHdnYcl3RDnw7kxQ+VoPMdXOMO63Nnmk
	ZjLsyJG4qoaUSXiP/6JYpSmZaIM7wpnztlP9ICij2790239b/T4FqA7tgc0Q7IBA
	5BoLTl2uewN8Bc3cUQ+3VB8h+8IiH1EK8+/NjX7VqQf1hg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id j79FvH-RSEao; Mon,  7 Jul 2025 17:39:53 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bbWhf5Qptzm0yTF;
	Mon,  7 Jul 2025 17:39:45 +0000 (UTC)
Message-ID: <f6909d1f-0a53-447c-b3d0-369574d2d721@acm.org>
Date: Mon, 7 Jul 2025 10:39:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [nbd?] possible deadlock in nbd_queue_rq
To: Hillf Danton <hdanton@sina.com>,
 syzbot <syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-kernel@vger.kernel.org, nbd@other.debian.org,
 syzkaller-bugs@googlegroups.com
References: <20250707005946.2669-1-hdanton@sina.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250707005946.2669-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/25 5:59 PM, Hillf Danton wrote:
> and given the second one, the report is false positive.

Whether or not this report is a false positive, the root cause should be
fixed because lockdep disables itself after the first circular locking
complaint. From print_usage_bug() in kernel/locking/lockdep.c:

	if (!debug_locks_off() || debug_locks_silent)
		return;

Bart.
