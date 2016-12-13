Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35515 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932543AbcLMQQW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2016 11:16:22 -0500
Received: by mail-wm0-f44.google.com with SMTP id a197so114716272wmd.0
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2016 08:15:23 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCHSET/RFC v2] blk-mq scheduling framework
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20161213151739.GA32618@kernel.dk>
Date: Tue, 13 Dec 2016 17:15:19 +0100
Cc: linux-block@vger.kernel.org,
        Linux-Kernal <linux-kernel@vger.kernel.org>, osandov@fb.com
Message-Id: <DB8071E8-E3C2-4DA1-9716-987D84C078C3@linaro.org>
References: <1481228005-9245-1-git-send-email-axboe@fb.com> <9D1F7CB5-4043-448B-A553-D6A9804D5089@linaro.org> <20161213151739.GA32618@kernel.dk>
To: Jens Axboe <axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> Il giorno 13 dic 2016, alle ore 16:17, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> On Tue, Dec 13 2016, Paolo Valente wrote:
>>=20
>>> Il giorno 08 dic 2016, alle ore 21:13, Jens Axboe <axboe@fb.com> ha =
scritto:
>>>=20
>>> As a followup to this posting from yesterday:
>>>=20
>>> https://marc.info/?l=3Dlinux-block&m=3D148115232806065&w=3D2
>>>=20
>>> this is version 2. I wanted to post a new one fairly quickly, as =
there
>>> ended up being a number of potential crashes in v1. This one should =
be
>>> solid, I've run mq-deadline on both NVMe and regular rotating =
storage,
>>> and we handle the various merging cases correctly.
>>>=20
>>> You can download it from git as well:
>>>=20
>>> git://git.kernel.dk/linux-block blk-mq-sched.2
>>>=20
>>> Note that this is based on for-4.10/block, which is in turn based on
>>> v4.9-rc1. I suggest pulling it into my for-next branch, which would
>>> then merge nicely with 'master' as well.
>>>=20
>>=20
>> Hi Jens,
>> this is just to tell you that I have finished running some extensive
>> tests on this patch series (throughput, responsiveness, low latency
>> for soft real time).  No regression w.r.t. blk detected, and no
>> crashes or other anomalies.
>>=20
>> Starting to work on BFQ port.  Please be patient with my little
>> expertise on mq environment, and with my next silly questions!
>=20
> No worries, ask away if you have questions. As you might have seen, =
it's
> still a little bit of a moving target, but it's getting closer every
> day. I'll post a v3 later today hopefully that will be a good fix =
point
> for you. I'll need to add the io context setup etc, that's not there
> yet, as only cfq/bfq uses that.
>=20

You anticipated the question that was worrying me more, how to handle
iocontexts :) I'll go on studying your patches while waiting for this
(last, right?) missing piece for bfq.

Should you implement a modified version of cfq, to test your last
extensions, I would of course appreciate very much to have a look at
it (if you are willing to share it, of course).

Thanks,
Paolo


> --=20
> Jens Axboe

