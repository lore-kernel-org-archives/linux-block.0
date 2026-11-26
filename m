Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687594;
	b=x91l68QyrcQb1yGrnMjBZesd+z2/2DFQTe7OZPfVEbRk8TVneCEUU9gUvew9iLdR3Eh9
	 h5/oQiPS/I5f2phtCGMDLuZbVZw7W6MmMke4oofoNYBG2cdyiSAYsjRWGl1rpN0MQcK7r
	 NgITLWuU+daTkW1JpufOMnhuT4bb4J/vXqxOs9wG2DqvdPPKpGb5oJXlfgZ8OXg25cfip
	 E0Cc54Zh6S+b5I9MajF7C8KPPkDRoc2shgC/xrNAJL9GCrP6G0Luqyf8Pkr8oLfYMKGX8
	 zWKKUDWCwv+XvDDCk1vE+zoQRVxG94tXue7R3BJXHY04UHuC1cAoYBcCu8tvH+FwKRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687594;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LMMzqw31ZU0RiKKL7WMLIwENWzBxfv0mqYOyr2TaD2A=;
	b=1ZdQKWRt6+YAvKXSN8HqVD0mENussO3S2+l45EMLyfCDxjmmDt8xJccTs1GkDM8+Djhx
	 U0DmB7vUQlB87SSrrY4Oq1fNiO2j6yGw/hL3dMCXW/EFAT8P2gjwQBrS5IgiV0bbGw358
	 7vJuA2diUHt9Ukuy7eUXXJm1fh1T4pv29OxuvN6io22Wbpfy6wjFB1d0U55Vf9cMdlouX
	 cVKegrvWxlQgylkY4zLvxAq42nOx2Uq9hZvhMauPz/0Uwu3sbJDKHhlOyqkiOACu/GxBx
	 7825qf75wwfnh6lgTvqaQw5q6OthvfCwPYI6qR8/Dq7HXbMYnFs8COttBpCJk3/U0sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="onGrBZU/";
	arc=none smtp.remote-ip=91.218.175.246
Received: from mta0.migadu.com (out-246.mta0.migadu.com [91.218.175.246])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F4606A31E
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 10:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E3F4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=onGrBZU/
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+0RS0xiYs/lGHswPGl72t+eKpn20fk7GmNjlh8RHSZE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795687591; v=1; x=1796292391;
 b=onGrBZU/or0XZ/tQVw//J1dmrKK3aPrGP+hfuLWe8vxMh1uxAMYLtw65pLqYIMN8ccm7puxX
 6ALiEzWhZFpja108AZFoNbJ92PEYGEvLFSGkuIF8BN3T+aCPNWcGlDBhTY0VnEMkclm2CLT9vvo
 jkaLLb+7iJ6feS680aE2OinA=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d9cff11a4d1b2971;
	Thu, 26 Nov 2026 10:06:31 +0000
X-Mizu-Trace-ID: d9cff11a4d1b2971
X-Migadu-Flow: FLOW_OUT
Message-ID: <7ad89439-5921-4dce-8da1-7c9321930ce9@linux.dev>
Date: Thu, 26 Nov 2026 18:06:16 +0800
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
Cc: cui.tao@linux.dev, cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v8] loop: defer the queue limits clear to a workqueue
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20261126054223.176824-1-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261126054223.176824-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Bart,

在 2026/11/26 13:42, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> loop_clear_limits() calls queue_limits_commit_update() directly from
> the loop workqueue that processes the request.  That does a
> non-atomic struct assignment to q->limits without freezing the queue,
> which races with lockless readers of q->limits on other CPUs, such
> as bio splitting reading max_hw_sectors and the discard path reading
> max_hw_discard_sectors, letting them observe torn values.  The
> trigger is a discard or write-zeroes request on a loop device whose
> backing file does not support the corresponding fallocate operation.
> 
> The code already has an XXX comment saying this should move to a
> workqueue.  Do that: schedule a work item on the system workqueue,
> where it is safe to freeze the queue around the limits update.  The
> unsupported modes live under a new mutex, lo->clear_limits_lock,
> guarded by a backing-file check that drops records from a racing
> unbind or rebind.  The work item is scheduled while holding that
> lock, so an unbind resets the verdicts under the lock before calling
> cancel_work_sync() and cannot miss a schedule from a request that is
> still in flight.  Requests that arrive while the clear is in flight
> fail quietly, so the console report stays at the first failure.
> loop_remove() also cancels the work item before the queue becomes
> unreachable.
> 

Sashiko reported three issues against v8 [1]; all are real and fixed in
v9 below, so v8 can be skipped.

> Does freezing lo->lo_queue before queue_limits_start_update() invert the
> block layer lock ordering between queue freeze and q->limits_lock?

Yes, the work item froze first.  v9 takes limits_lock before freezing,
like loop_set_dio() and loop_set_block_size().

The splat and deadlock part I could not reproduce: since f1be1788a32e
("block: model freeze & enter queue as lock for supporting lockdep")
the freeze path annotates io_lockdep_map as a trylock, so the reversed
order does not become a recorded dependency, and requests never take
limits_lock so a freezing caller's drain always completes.  Interleaved
LOOP_SET_BLOCK_SIZE, LOOP_SET_DIRECT_IO, write-zeroes and rebind churn
under PROVE_LOCKING stay quiet on both v8 and v9.  FWIW the same
applies to loop_set_status() in my dma-alignment patch: I'll reorder it
in v2 for consistency rather than wait for a report.

> If LOOP_SET_BLOCK_SIZE is called on a bound loop device after an
> unsupported mode has been recorded in lo->clear_limits_seen, can the
> cleared queue limits end up permanently re-enabled?

Yes.  v9 resets clear_limits_seen inside the recompute's freeze so the
next failure reschedules the clear.

> Can calling lo_unsupported() when !bdev_max_discard_sectors(lo->lo_device)
> falsely disable FALLOC_FL_ZERO_RANGE or latch FALLOC_FL_PUNCH_HOLE when
> discard was only disabled via sysfs?

Yes.  v9 gates on the per-mode hardware limits instead of the shared
bdev_max_discard_sectors().

Tested with PROVE_LOCKING enabled: loop/011, the concurrency sweep, the
interleave and the mkfs/unbind stress run clean, v8 as a negative
control included.

Thanks,
Tao.

[1] https://sashiko.dev/#/patchset/20261126054223.176824-1-cui.tao@linux.dev
