Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBB912E1C7
	for <linux-block@vger.kernel.org>; Mon, 26 Aug 2024 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657642; cv=none; b=fN/eg0HZvI2jEzOk219kl/v2CR+EabPR+DJqVocvukRkqaX3TbEpnGQSuh7W6N1zSQqdykvyDOh/zv5WFyQ5nSGqVmfeuS2zKzlW0bPYeH99qM1WaEbMmLdaW3JuAx6pauwfBIuC2RnRXmWCCQF/tVdHeVgbPACW++lBOvSi+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657642; c=relaxed/simple;
	bh=nDmwfZb3zAoHaIov3BpMiaPHaRy3b1QEPWCy5Od8fvk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qzk+F06jOvRFQxaU5TpzV7/xA7M+hnF3qa9yt+Bi7BFkwRv5yoVBzrdVIjFiykDw34AQU0By9zlVFlcSrWWOmVAQTUeo5WhQEUro1VN95fCM5fmAw2QRl/uSbzzpQ3RTNpf5Q4t0qN0DEp7NmDcbzsd0MsIzMUhZBlmzTzTmidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RcZ8QGe4; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RcZ8QGe4"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724657637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9v9WEqDip3i21pJBqBZAVyHYygHv4sd7F9tl+2YhKg=;
	b=RcZ8QGe4gpLFLi/AQ6FlHq/y8+D/aII/F31LemP17YUySU51i03x0tmyJZG3XnamaoetRi
	Eo1BOh49ANslw/M2ZSJGt6MhKr0rO1d5CT4p8Xf65dVDNC9gOYvJ/EZbbvpYiRmeHonHRn
	3+x+l+fVRGpBNAJXJ+edXY1V2HbLM2U=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH 4/4] block: fix fix ordering between checking
 QUEUE_FLAG_QUIESCED and adding requests to hctx->dispatch
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CAMZfGtW-AG9gBD2f=FwNAZqxoFZwoEECbS0+4eurnSoxN5AhRg@mail.gmail.com>
Date: Mon, 26 Aug 2024 15:33:18 +0800
Cc: Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <45A22FCE-10FA-485C-8624-F1F22086B5E9@linux.dev>
References: <20240811101921.4031-1-songmuchun@bytedance.com>
 <20240811101921.4031-5-songmuchun@bytedance.com> <ZshyPVEc9w4sqXJy@fedora>
 <CAMZfGtW-AG9gBD2f=FwNAZqxoFZwoEECbS0+4eurnSoxN5AhRg@mail.gmail.com>
To: Muchun Song <songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 26, 2024, at 15:06, Muchun Song <songmuchun@bytedance.com> =
wrote:
>=20
> On Fri, Aug 23, 2024 at 7:28=E2=80=AFPM Ming Lei <ming.lei@redhat.com> =
wrote:
>>=20
>> On Sun, Aug 11, 2024 at 06:19:21 PM +0800, Muchun Song wrote:
>>> Supposing the following scenario.
>>>=20
>>> CPU0                                                                =
CPU1
>>>=20
>>> blk_mq_request_issue_directly()                                     =
blk_mq_unquiesce_queue()
>>>    if (blk_queue_quiesced())                                         =
  blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)   3) store
>>>        blk_mq_insert_request()                                       =
  blk_mq_run_hw_queues()
>>>            /*                                                        =
      blk_mq_run_hw_queue()
>>>             * Add request to dispatch list or set bitmap of          =
          if (!blk_mq_hctx_has_pending())     4) load
>>>             * software queue.                  1) store              =
              return
>>>             */
>>>        blk_mq_run_hw_queue()
>>>            if (blk_queue_quiesced())           2) load
>>>                return
>>>            blk_mq_sched_dispatch_requests()
>>>=20
>>> The full memory barrier should be inserted between 1) and 2), as =
well as
>>> between 3) and 4) to make sure that either CPU0 sees =
QUEUE_FLAG_QUIESCED is
>>> cleared or CPU1 sees dispatch list or setting of bitmap of software =
queue.
>>> Otherwise, either CPU will not re-run the hardware queue causing =
starvation.
>>=20
>> Memory barrier shouldn't serve as bug fix for two slow code paths.
>>=20
>> One simple fix is to add helper of blk_queue_quiesced_lock(), and
>> call the following check on CPU0:
>>=20
>>        if (blk_queue_quiesced_lock())
>>         blk_mq_run_hw_queue();
>=20
> This only fixes blk_mq_request_issue_directly(), I think anywhere that
> matching this
> pattern (inserting a request to dispatch list and then running the
> hardware queue)
> should be fixed. And I think there are many places which match this
> pattern (E.g.
> blk_mq_submit_bio()). The above graph should be adjusted to the =
following.
>=20
> CPU0                                        CPU1
>=20
> blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
> blk_mq_run_hw_queue()
> blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
>    if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
>        return                                      =
blk_mq_run_hw_queue()
>    blk_mq_sched_dispatch_requests()                    if
> (!blk_mq_hctx_has_pending())     4) load
>                                                            return

Sorry. There is something wrong with my email client. Resend the graph.

CPU0                                        CPU1

blk_mq_insert_request()         1) store    blk_mq_unquiesce_queue()
blk_mq_run_hw_queue()                       =
blk_queue_flag_clear(QUEUE_FLAG_QUIESCED)       3) store
    if (blk_queue_quiesced())   2) load         blk_mq_run_hw_queues()
        return                                      =
blk_mq_run_hw_queue()
    blk_mq_sched_dispatch_requests()                    if =
(!blk_mq_hctx_has_pending())     4) load
                                                            return

>=20
> So I think fixing blk_mq_run_hw_queue() could cover all of the =
situations.
> Maybe I thought wrongly. Please correct me.
>=20
> Muchun,
> Thanks.


