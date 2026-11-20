Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.116.240.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171149;
	b=n792u5AGAxePMwECyN+KfBZud7R+Jb53Czk3La9c9PGXt5dCaXA5KoiGNFQXl+6n7nhi
	 y+PI5IxBZacPfrmJL0EKNBtBVKVUsg8x/U9WWQRPVIQspoxuAkKqwdmh5RV+h/yES09qO
	 W9FjkFq7gnrjkFnDTnIAlmLNqEg/DLnpRpby6qM+7YyORWhJxu2y4Mkvf1O0TWqHxxEDy
	 D3K3/9/fv95dnKmvFVBHQzr5CAQGRXaHKNjgbEsri8wqHmcBxueTFlfjBfvcn42eST7tS
	 SSN0JmVcSGDnH4t/bXjFxAf6W2rjLxG1ZZzRJ0wW6xczLBPYZsY3WLS/xMPTnKKH5Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171149;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To;
	bh=zlkamX5Jctv2QPEDuxaMTq34VUUNBdtzDbfXWAEi37o=;
	b=49RWs5kTp0Ots6Y3cOkRumHAwGzyBu106n8eYvoKDbGO7QoPijBAPEMzcc0edpMQvCN4
	 gNxYUvSi4vAMiIYV/FiMFaAoLxlGFLOHFRM52MDw5KlFquNQVNWMvBPwk7C0j5ujVqqV3
	 AbIsVCyPQLmavp6GcVaXmn7anbcSDHsJ5yoPftucBBkgRZlfbjVXZAhmN/wdhMobZ2Jxb
	 zc5ELzEwmY3Rr3v+Dw8HiIU/Za0zk8Qkodn4FgDdtyPQmUyflIp9qgrPnLuns/pAh2apo
	 hS2zlTfAdhnU6Na26ITuFxK75YucxJMrK0I7AIvdfgsxYUbgc4fDCaF8hwyr5ejyqVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamax.eu;
	spf=pass smtp.mailfrom=arkamax.eu;
	dkim=pass header.d=arkamax.eu header.i=@arkamax.eu header.a=rsa-sha256 header.s=mail1 header.b=DL4KBPCU;
	arc=none smtp.remote-ip=128.116.240.228
Received: from arkamax.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB9606A320;
	Fri, 20 Nov 2026 10:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7DB9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arkamax.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamax.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arkamax.eu header.i=@arkamax.eu header.a=rsa-sha256 header.s=mail1 header.b=DL4KBPCU
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=zlkamX5Jctv2QP
	EDuxaMTq34VUUNBdtzDbfXWAEi37o=; h=in-reply-to:references:cc:to:from:
	subject:date; d=arkamax.eu; b=DL4KBPCUkFcb3TR4cUmvv2Iy0VIf5v46WaNTNNPK
	hDP++nfFvvFweTRJnH7gase5TjG4AqFX4zEfuOuwO6JvrKiTd21NvXcsGiqTxLu2MU+QTW
	biFWOXNZJGeJc+HRAOxLFt3FSno0jKpRMV4ou/Jr/C1WP2fugZKad4+Hg8Ouh25smtOy0I
	ZSAguwkKOoHs67naxN1FSfWqwECkQhk/lzdRaYGuTCt14/3jCiVy8ZQIqOuHlsisgvjN6Z
	1ICHvacvzcbUH1rYOv8D8G2QZii0tVI3BYJvuyzaOAiVgLD0MT6PDF7Pl+lGKE9XskR3Nx
	NoBrnG8gBUkdPZgsOIXIEg==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 8a545b90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 11:38:59 +0100 (CET)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 11:38:58 +0100
Message-Id: <DMZZ2434KSYI.25CV1W4LPLQ6@arkamax.eu>
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>
Cc: "Ming Lei" <ming.lei@redhat.com>, "Surabhi Gogte"
 <sgogte@purestorage.com>, "Hannes Reinecke" <hare@kernel.org>, "Nilay
 Shroff" <nilay@linux.ibm.com>, "Frederic Weisbecker" <frederic@kernel.org>,
 "Aaron Tomlin" <atomlin@atomlin.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
 <a979c78b-40f9-4777-b76f-fb257120a93c@flourine.local>
In-Reply-To: <a979c78b-40f9-4777-b76f-fb257120a93c@flourine.local>

On Thu Nov 12, 2026 at 10:09 AM CET, Daniel Wagner wrote:
>
> Keith, Jens: any chance to get this one picked up?

Hello, gentle ping: any reason why this has not been picked up yet?

Thanks,
Maurizio

