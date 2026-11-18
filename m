Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018069;
	b=AVLvTx6j11OshUKZ9uYx5Gk9qh7pqQoQhGj/55tSldqSUvzicAavXliMIGbSax5/i4Ss
	 CN5UQpEwQVU423XFBYQRjiv0V/e6I4NXiroKzqDUWAPiC0DVrdYcecva3VHAmY7fMUEGe
	 sKGFMLs8/TAZQXt+lwvxSWLJMRbIAPonMcA+G6XKEqyjFFktDKSvCgPvOEclxm9poaliQ
	 WZBdGwmWoIW1/sJzqpz7ZsoDaKgZzeZ4ZXvlr8U37QWFwZkWtaN22+iIb6cyYUvWTLiPK
	 MvrXCagq4T/PMZw0sQzA2iDd8bmxIqIA6R+VqQ53VsFDJqVPOeuqXTvj9nQyExIr9Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=uMY6Jb3UDbPrg75ENQ5Iey0rgsluCVDooajDuLXd0cE=;
	b=oW/5QTCLHOTjshNHQXsH6FRxrvcq/vCXJte6gV7gAp6L22J/jkYTRDCKIUbZ3nnXJG5Y
	 RMgf2RoYG4XR/0wKqIf2DEKIiemUHtHEyrB+7mQk0Lm9mki1ncLieiKrCgETGB3ZiRc7f
	 2BP6yfAS5By6dAUl4IFCQo0jQbObyYEABfY9Y5yhhUGusyvXqdm46EEQa7be4QpwlaaDB
	 fdZgw0k8RwGY2IOBqR0gwFGsLfEsozMc8PTwYkIBLOuEPkl6LlaxyOI5ScGhL6+A6ISOH
	 7saGJXZMGkS7KzZ73MJBMadNJaxGSV40PjYAPAqnikZbypSUHcHeTVbzPbteP0Z93WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="K2kH/UYx";
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972F60A5BC7
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 16:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5972F60A5BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=K2kH/UYx
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-48ed188ee81so664405fac.1
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018068; x=1795622868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMY6Jb3UDbPrg75ENQ5Iey0rgsluCVDooajDuLXd0cE=;
        b=K2kH/UYxJ1s9QIk2I+iFE+8oy6FJi8D0+gEKDqY+gZ6pmW+8qIuvQdlK1zDDZ2tqn9
         +grxhnhVVFi4vC6NoXujmaBAsELkdHD/ni+akIyIdYfnQVXIUdefoLtZsRuvr+oAWjod
         D2kOcmXFzzguDmC6XlwD514NWwSbkg28+3FtOt4YIfS+BzJB8WflsXo9S0UVl6D+SSMZ
         CeUaoy++aAN5yOC7dc450MBb2IQmziuDqQJL1p/6pk+Bkx7pDd2i+HrMHxPHvS7zRqnm
         RGaipKK3GMXRuwVd3yNsQnE8F9AoDHxyWIXb8pin1xjuivCgF6cf5Uuo6uS+rfAjDy+w
         RNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018068; x=1795622868;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMY6Jb3UDbPrg75ENQ5Iey0rgsluCVDooajDuLXd0cE=;
        b=NbxEpK7YzaCXrysimpgQkW1Cj5wX1imgb/N/e2xLr5HaS7O0E68OtgMFPATi5H+gnL
         QJsvmFeJgIcrQj3GJWpfxkjOq+RGbocc5Gztv9ZnFTR8PAOqYCcphf8XDWryi+xjBaOo
         wHNix0j9DiVJqLVf4gXPvil4AL6hY2JndyPmiYQpMhnFx6cisSp7Bt4cJvZ65THFKLqs
         q526UI8ehJU1rY9aXVztO1KPsdYfmYHcsB65VcP5H33SkKaXvBezJNmnr7OqgY8DZH/H
         mYN91BN/jv7aGDJlUNe1K6GwF1SErKeBnn+AJ6PSrLtNDRVp07EeTIyIZU8eNgXYy4EK
         lFFQ==
X-Forwarded-Encrypted: i=1; AL+hErEAptGEWcB2QQJGn3mfJ3njbsHP7YYbNuKUSBWMcbiW+Z6CUPVl9glK63GF9fYYxLmYu//eIarlqF69GQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZZ4jYNuR9lFS24X3L6kIzqLlDYXrRptNMhV1LUOJK0KMXBe+g
	ULrl08u1YGQbZWehLUXRTsL2fKpXwNPXqQZCmfP9Qh6Dz/3NQZ8uKzPmpPEWbthYzoQ=
X-Gm-Gg: AYBFou3WHUEZLCfGdBmS2YyPZfQH/a2VgWKzwphgt87jn0b5p3CCqMAYcLt7hImEo8v
	OTRDqP21PMKQduIJw9SoDn/OatWuFzC52YAZi8VDPyIxkwFKTIJTNtnCfgj9oxq+rPzoeNT6hmJ
	4oTk3+08kiPUfNs9Pu5NzTyoUsaSPS4KjVfRpBj5dBXmXweXME0qI32XowDUn4N10hxPv1iYqWr
	d2uHA6VzjLF7nkMh/6MqI0/1hHocCPTs814GMaAYcodz0yzFyG8H4tpVUFXELceOYp988J1l7Fn
	3Uw/9bYaVUgpKRDlIPvrTsg3iFmGysopcj92z5QY7eYVakqtGTrLlX2O84/36ZehIm4ehgpTCSX
	KxSPGHD84DQM4jEUj4Fzsfb0UvmtfFs5vH2KWzClVc3LO/YzJ3ASJJkCBtgy6IAdGZ2/t6TQPFc
	LlXrfGxcr2vl3hbwii/vA3TD7VP3UCXBxnM6enj8/mgi+Nih+iHTX+Io5wTmE7q1JNkioBiG4O0
	J/Uu0Bqc/amxK8Vmg85lEFLIxBKBMpK4iqd5o6JDcV0Zu8B4GjbP1CE4I53f6hGtCNdk2L63rig
	P/mQLFK9/MQYlxgd4J8p9ay3YwLvu28GxPtZI5Kjuu/RVukk6tsPqw0TP76jUdoQIAzwY0RvFBd
	fAKtvG9L5VaDuN92CyJJ/YHOiX04k2tv8HBMYHQ0wR7wH6spcwi0TiW4CtHdvcWvS/U5GViO+
X-Received: by 2002:a05:6870:4692:b0:486:c1b6:643a with SMTP id 586e51a60fabf-4b75c3790dfmr2555326fac.19.1795018068283;
        Wed, 18 Nov 2026 08:07:48 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Mani Tofigh <mt4022@columbia.edu>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, 
 Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>, 
 Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>, 
 Nilay Shroff <nilay@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tz2294@columbia.edu, stable@vger.kernel.org
In-Reply-To: <20261106-blk-mq-del-quiesce-lock-v2-1-cd4f72a6eb03@columbia.edu>
References: <20261106-blk-mq-del-quiesce-lock-v2-1-cd4f72a6eb03@columbia.edu>
Subject: Re: [PATCH v2] blk-mq: take quiesce_lock when removing a queue
 from the tag set
Message-Id: <179501806686.17649.15466634007148423129.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:46 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 06 Nov 2026 11:53:21 -0500, Mani Tofigh wrote:
> Unquiescing a tag set can run the hw queues of a queue whose hctxs were
> already freed.  blk_mq_unquiesce_tagset() walks the tag set's queues
> under quiesce_lock and rcu_read_lock().  Commit 71ec3c7d6db8 ("blk-mq:
> quiesce a queue that joins a quiesced tag set") added quiesce_lock to
> the walks and to adding a queue, but blk_mq_del_queue_tag_set() still
> removes a queue without it.  The hctxs are then freed right away since
> RCU only keeps the request_queue itself alive:
> 
> [...]

Applied, thanks!

[1/1] blk-mq: take quiesce_lock when removing a queue from the tag set
      commit: 495f22c5a99ac38e527294cdc4f3972718b9bee0

Best regards,
-- 
Jens Axboe



