Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34949 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754315AbdEHLzC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 May 2017 07:55:02 -0400
Received: by mail-wm0-f50.google.com with SMTP id b84so51782507wmh.0
        for <linux-block@vger.kernel.org>; Mon, 08 May 2017 04:55:01 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8C42E2D5-C58A-48BE-A041-B688D6339B93";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Large latency on blk_queue_enter
Message-Id: <1656B440-3ECA-4F2B-B95C-418CF0F347E9@lightnvm.io>
Date: Mon, 8 May 2017 13:54:58 +0200
Cc: linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_8C42E2D5-C58A-48BE-A041-B688D6339B93
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Hi,

I find an unusual added latency(~20-30ms) on blk_queue_enter when
allocating a request directly from the NVMe driver through
nvme_alloc_request. I could use some help confirming that this is a bug
and not an expected side effect due to something else.

I can reproduce this latency consistently on LightNVM when mixing I/O
from pblk and I/O sent through an ioctl using liblightnvm, but I don't
see anything on the LightNVM side that could impact the request
allocation.

When I have a 100% read workload sent from pblk, the max. latency is
constant throughout several runs at ~80us (which is normal for the media
we are using at bs=4k, qd=1). All pblk I/Os reach the nvme_nvm_submit_io
function on lightnvm.c., which uses nvme_alloc_request. When we send a
command from user space through an ioctl, then the max latency goes up
to ~20-30ms. This happens independently from the actual command
(IN/OUT). I tracked down the added latency down to the call
percpu_ref_tryget_live in blk_queue_enter. Seems that the queue
reference counter is not released as it should through blk_queue_exit in
blk_mq_alloc_request. For reference, all ioctl I/Os reach the
nvme_nvm_submit_user_cmd on lightnvm.c

Do you have any idea about why this might happen? I can dig more into
it, but first I wanted to make sure that I am not missing any obvious
assumption, which would explain the reference counter to be held for a
longer time.

Thanks!
Javier


--Apple-Mail=_8C42E2D5-C58A-48BE-A041-B688D6339B93
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZEFyTAAoJEGMfBTt1mRjKO34QAIql3CzOJA+JMTyp2NVtmRAr
ym8x9bLpIyuv/L/B1uYsv1JjcldLE2kF4AfDIF8ujmIix1MkFBxKKWwwIsMbdpfr
y8j9XrS0IH6ruEoSb9J/+kIgyDnDht5jd3ddPiXvl9A1q1sineDwxYEHi/4tdVpi
bzxQI9OJApSos8tc1xKIF+EQQjEGxXBsVeFKuIwUPccjhKrQF4XIS1ye+0pb4J8j
janMuRKaDH6gUDDffvJpsF+IY54TErKRmXY3oSE52PrnYQ5Zyttl/p6UxRKJh9po
O3Gzj3UW5fc7vIR4oJZYXJRkCTJcC8GzrU6ooji5MMcuB+Q80iKo2kXcqYwGqgUO
YlNCDlX/y3MmhV7QQe4NhsGHFKOIjgWCpCBqKBrAzqEI3KUWLWUkILrCngKwsqUN
WhMiaiY+0Avx1m+9/I4pOiU+uRkF08dFBQsVrN2Ks3PuDgqDg38lFSO9iqgKQJul
35H0JfKqrDakkPI0vm1x8odtGM/k8DCVQn5XhUM+9LwZJu/PFC4hPOe7vpMx0cjh
tMVU9i/ortgWqOh6Dkq1we8zg7HZOa+PGbRDzLz0eOpnGP33uZNGl1UdFrJ5y71T
KJHf2gT0AefXpJavvwfr1FweC/MqGgtdXdlBNtHcEWsUKSn6SF6l5HtVlxIKKutx
fyP9vEFxGEfroBpp1GwD
=mrTH
-----END PGP SIGNATURE-----

--Apple-Mail=_8C42E2D5-C58A-48BE-A041-B688D6339B93--
