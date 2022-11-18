Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5C6C433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Nov 2022 09:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbiKRJi1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241411AbiKRJi0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 04:38:26 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D0BD94
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 01:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668764304; x=1700300304;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=NEfUoc/WpFoL0cvn0e8HHHfU/KYnX66lNMTOtzhj0L8=;
  b=eYZ67s4l5QG/G+LwzTNxkUI4cnKoVd8cXUdw+vu6qSVbKdZNyuuaEsXj
   JHb1w1p+FxUI0U2+AHVE5MezcvZ5i1nRBEkilSNIvdSbIn2Gs1gEIQCHY
   PYZHcDEA99A5T2boUTuPj3/4DT/CAWn08tJ1KYgRaU+nyicmo5DfXb4cY
   2e0ghl3f5jLJutIku0gTjqqj/zaOJCqwHRLtD+EOu+EBv1smNJU+hzcle
   PS1NYNMKkyrUCrhpDwlCNttrf3tqooX0gVBybjnp90jV4uOsDcTwCkDL2
   is59Z6CxXHzLknZtQA8TayAWEoPbFAgnXhqeYMU6H2x9pzqQJtZ3y57io
   g==;
X-IronPort-AV: E=Sophos;i="5.96,173,1665417600"; 
   d="scan'208";a="216602075"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Nov 2022 17:38:24 +0800
IronPort-SDR: SnnKoI8PT4DTD5Ngxi/TGI0nGgcpXiwLQ5VXOYktXT3SR/2+Y5alRBmkrNBB8G8R34P9AZS106
 B233JUu+IKU4DLvc8PRqopuuG+BUmBF7ezryQE1egGBsIkVexTBqu2bMqSf0Gw/o4jnCONu2+G
 fwdJ5T1eIqFV6Ub8e+n1TOgx4UYRc8LAZvQfWdsKr9390eH8U6QsaY4+GYEAbVnIwQgwm/B0ST
 xYT4BfzoY+YZHNFngkJx8QYORQVOZX58c5sLHxtQXfX+LhkbEebWqrq2iWVsVzfFOK2OSG3EoF
 Rmw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2022 00:57:18 -0800
IronPort-SDR: rFaMu2wcfbuizobfXDvj48XYLcXuO+L3dUe0OnJOrR5l3wQ7MqzluKZ7kLdk0ev47cjf4GjOE1
 cUjb7RKX+JZEJRbL7CrsK+nE71Dt6UTxnEWsELCs8mREVur5Ct2WsgL14OOPYdsrAB9NVriQHi
 cA9hhcpZO/ltYgclGmXziZCZe+EzwWs6/gtdrCCYuS59nWnvKug7Q3TfROJ6Gqyv+w7vYpnvxU
 629qwbzLtj9x7eSh/DM6Xh+bm+Ccp8twaa81YJ5erkPU0EKMZ7XPhUvgNeDJbS3skXvZQGCrEU
 SFc=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO localhost) ([10.200.210.81])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Nov 2022 01:38:23 -0800
References: <87sfii99e7.fsf@wdc.com> <Y3WZ41tKFZHkTSHL@T590>
 <87o7t67zzv.fsf@wdc.com> <Y3X2M3CSULigQr4f@T590> <87k03u7x3r.fsf@wdc.com>
 <Y3YfUjrrLJzPWc4H@T590> <87fseh92aa.fsf@wdc.com>
 <b8c15259-f8ab-6c47-46ab-872c658f1052@opensource.wdc.com>
 <87bkp58zuw.fsf@wdc.com>
 <0f0ef3e2-5585-6187-6f61-d2fb1af54441@opensource.wdc.com>
User-agent: mu4e 1.8.11; emacs 28.2.50
From:   Andreas Hindborg <andreas.hindborg@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Andreas Hindborg <andreas.hindborg@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: Reordering of ublk IO requests
Date:   Fri, 18 Nov 2022 10:29:15 +0100
In-reply-to: <0f0ef3e2-5585-6187-6f61-d2fb1af54441@opensource.wdc.com>
Message-ID: <877czs8uwh.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Damien Le Moal <damien.lemoal@opensource.wdc.com> writes:

[...]
>> Unless I am reading the trace wrong there are 3 reads issued to 259,1
>> sectors 6144, 4096 and 2048 in that order. This is the order userspace
>> is issuing the reads, so the trace matches what I would expect. But now
>> you tell me that the mq-deadline scheduler should reorder the requests
>> based on LBA? But maybe the ordering by LBA is only for writes? I'll
>> rerun the test with writes.
>
> Nope. Reordering is for reads too. But reordering happens only if the
> commands are issued in batch or if the drive is busy (all tags used) and
> commands accumulate in the scheduler.
>
> If the user issues these reads one at a time, they will go through the
> scheduler without reordering. You can see that with blktrace:
> If you see a G-Q-I-D sequence for each read, then it is not a batch and
> they are going through as is. If you see G-Q-I-G-Q-I-G-Q-I-D-D-D, then
> that was a batch and the "D" should be ordered in increasing LBA, even if
> the I (insert) where out of order.

I see. Looking at the full trace it does show that only part of the
series of the reversed requests from ublksrv are batched up. They are
not submitted in one go from ublksrv.

Thanks,
Andreas
