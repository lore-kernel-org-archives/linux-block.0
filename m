Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E0EC3A5A1
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 13:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0381721726
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 13:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfHVNOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:14:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfHVNOK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 09:14:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CEA27F749;
        Thu, 22 Aug 2019 13:14:10 +0000 (UTC)
Received: from localhost (ovpn-117-251.ams2.redhat.com [10.36.117.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50EC35C226;
        Thu, 22 Aug 2019 13:14:07 +0000 (UTC)
Date:   Thu, 22 Aug 2019 14:14:06 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Roman Penyaev <rpenyaev@suse.de>,
        Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] tools/io_uring: Fix memory ordering
Message-ID: <20190822131406.GH20491@stefanha-x1.localdomain>
References: <20190820172958.92837-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <20190820172958.92837-1-bvanassche@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Thu, 22 Aug 2019 13:14:10 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2019 at 10:29:58AM -0700, Bart Van Assche wrote:
> Order head and tail stores properly against CQE / SQE memory accesses.
> Use <asm/barrier.h> instead of the io_uring "barrier.h" header file.

Where does this header file come from?

Linux has an asm-generic/barrier.h file which is not uapi and therefore
not installed in /usr/include.

I couldn't find an asm/barrier.h in the Debian packages collection
either.

>=20
> Cc: Roman Penyaev <rpenyaev@suse.de>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tools/io_uring/Makefile         |  2 +-
>  tools/io_uring/barrier.h        | 16 ---------------
>  tools/io_uring/io_uring-bench.c | 20 +++++++++---------
>  tools/io_uring/liburing.h       |  9 ++++-----
>  tools/io_uring/queue.c          | 36 +++++++++++----------------------
>  5 files changed, 26 insertions(+), 57 deletions(-)
>  delete mode 100644 tools/io_uring/barrier.h
>=20
> diff --git a/tools/io_uring/Makefile b/tools/io_uring/Makefile
> index 00f146c54c53..bbec91c6274c 100644
> --- a/tools/io_uring/Makefile
> +++ b/tools/io_uring/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for io_uring test tools
> -CFLAGS +=3D -Wall -Wextra -g -D_GNU_SOURCE
> +CFLAGS +=3D -Wall -Wextra -g -D_GNU_SOURCE -I../include
>  LDLIBS +=3D -lpthread
> =20
>  all: io_uring-cp io_uring-bench
> diff --git a/tools/io_uring/barrier.h b/tools/io_uring/barrier.h
> deleted file mode 100644
> index ef00f6722ba9..000000000000
> --- a/tools/io_uring/barrier.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -#ifndef LIBURING_BARRIER_H
> -#define LIBURING_BARRIER_H
> -
> -#if defined(__x86_64) || defined(__i386__)
> -#define read_barrier()	__asm__ __volatile__("":::"memory")
> -#define write_barrier()	__asm__ __volatile__("":::"memory")
> -#else
> -/*
> - * Add arch appropriate definitions. Be safe and use full barriers for
> - * archs we don't have support for.
> - */
> -#define read_barrier()	__sync_synchronize()
> -#define write_barrier()	__sync_synchronize()
> -#endif
> -
> -#endif
> diff --git a/tools/io_uring/io_uring-bench.c b/tools/io_uring/io_uring-be=
nch.c
> index 0f257139b003..29971a2a1c74 100644
> --- a/tools/io_uring/io_uring-bench.c
> +++ b/tools/io_uring/io_uring-bench.c
> @@ -28,9 +28,9 @@
>  #include <string.h>
>  #include <pthread.h>
>  #include <sched.h>
> +#include <asm/barrier.h>
> =20
>  #include "liburing.h"
> -#include "barrier.h"
> =20
>  #define min(a, b)		((a < b) ? (a) : (b))
> =20
> @@ -199,8 +199,7 @@ static int prep_more_ios(struct submitter *s, unsigne=
d max_ios)
>  	next_tail =3D tail =3D *ring->tail;
>  	do {
>  		next_tail++;
> -		read_barrier();
> -		if (next_tail =3D=3D *ring->head)
> +		if (next_tail =3D=3D smp_load_acquire(ring->head))
>  			break;
> =20
>  		index =3D tail & sq_ring_mask;
> @@ -211,10 +210,11 @@ static int prep_more_ios(struct submitter *s, unsig=
ned max_ios)
>  	} while (prepped < max_ios);
> =20
>  	if (*ring->tail !=3D tail) {
> -		/* order tail store with writes to sqes above */
> -		write_barrier();
> -		*ring->tail =3D tail;
> -		write_barrier();
> +		/*
> +		 * Ensure that the kernel sees the SQE updates before it sees
> +		 * the tail update.
> +		 */
> +		smp_store_release(ring->tail, tail);
>  	}
>  	return prepped;
>  }
> @@ -251,8 +251,7 @@ static int reap_events(struct submitter *s)
>  	do {
>  		struct file *f;
> =20
> -		read_barrier();
> -		if (head =3D=3D *ring->tail)
> +		if (head =3D=3D smp_load_acquire(ring->tail))
>  			break;
>  		cqe =3D &ring->cqes[head & cq_ring_mask];
>  		if (!do_nop) {
> @@ -270,8 +269,7 @@ static int reap_events(struct submitter *s)
>  	} while (1);
> =20
>  	s->inflight -=3D reaped;
> -	*ring->head =3D head;
> -	write_barrier();
> +	smp_store_release(ring->head, head);
>  	return reaped;
>  }
> =20
> diff --git a/tools/io_uring/liburing.h b/tools/io_uring/liburing.h
> index 5f305c86b892..15b29bfac811 100644
> --- a/tools/io_uring/liburing.h
> +++ b/tools/io_uring/liburing.h
> @@ -10,7 +10,7 @@ extern "C" {
>  #include <string.h>
>  #include "../../include/uapi/linux/io_uring.h"
>  #include <inttypes.h>
> -#include "barrier.h"
> +#include <asm/barrier.h>
> =20
>  /*
>   * Library interface to io_uring
> @@ -82,12 +82,11 @@ static inline void io_uring_cqe_seen(struct io_uring =
*ring,
>  	if (cqe) {
>  		struct io_uring_cq *cq =3D &ring->cq;
> =20
> -		(*cq->khead)++;
>  		/*
> -		 * Ensure that the kernel sees our new head, the kernel has
> -		 * the matching read barrier.
> +		 * Ensure that the kernel only sees the new value of the head
> +		 * index after the CQEs have been read.
>  		 */
> -		write_barrier();
> +		smp_store_release(cq->khead, *cq->khead + 1);
>  	}
>  }
> =20
> diff --git a/tools/io_uring/queue.c b/tools/io_uring/queue.c
> index 321819c132c7..ada05bc74361 100644
> --- a/tools/io_uring/queue.c
> +++ b/tools/io_uring/queue.c
> @@ -4,9 +4,9 @@
>  #include <unistd.h>
>  #include <errno.h>
>  #include <string.h>
> +#include <asm/barrier.h>
> =20
>  #include "liburing.h"
> -#include "barrier.h"
> =20
>  static int __io_uring_get_cqe(struct io_uring *ring,
>  			      struct io_uring_cqe **cqe_ptr, int wait)
> @@ -20,14 +20,12 @@ static int __io_uring_get_cqe(struct io_uring *ring,
>  	head =3D *cq->khead;
>  	do {
>  		/*
> -		 * It's necessary to use a read_barrier() before reading
> -		 * the CQ tail, since the kernel updates it locklessly. The
> -		 * kernel has the matching store barrier for the update. The
> -		 * kernel also ensures that previous stores to CQEs are ordered
> +		 * It's necessary to use smp_load_acquire() to read the CQ
> +		 * tail. The kernel uses smp_store_release() for updating the
> +		 * CQ tail to ensure that previous stores to CQEs are ordered
>  		 * with the tail update.
>  		 */
> -		read_barrier();
> -		if (head !=3D *cq->ktail) {
> +		if (head !=3D smp_load_acquire(cq->ktail)) {
>  			*cqe_ptr =3D &cq->cqes[head & mask];
>  			break;
>  		}
> @@ -73,12 +71,11 @@ int io_uring_submit(struct io_uring *ring)
>  	int ret;
> =20
>  	/*
> -	 * If we have pending IO in the kring, submit it first. We need a
> -	 * read barrier here to match the kernels store barrier when updating
> -	 * the SQ head.
> +	 * If we have pending IO in the kring, submit it first. We need
> +	 * smp_load_acquire() here to match the kernels smp_store_release()
> +	 * when updating the SQ head.
>  	 */
> -	read_barrier();
> -	if (*sq->khead !=3D *sq->ktail) {
> +	if (smp_load_acquire(sq->khead) !=3D *sq->ktail) {
>  		submitted =3D *sq->kring_entries;
>  		goto submit;
>  	}
> @@ -94,7 +91,6 @@ int io_uring_submit(struct io_uring *ring)
>  	to_submit =3D sq->sqe_tail - sq->sqe_head;
>  	while (to_submit--) {
>  		ktail_next++;
> -		read_barrier();
> =20
>  		sq->array[ktail & mask] =3D sq->sqe_head & mask;
>  		ktail =3D ktail_next;
> @@ -108,18 +104,10 @@ int io_uring_submit(struct io_uring *ring)
> =20
>  	if (*sq->ktail !=3D ktail) {
>  		/*
> -		 * First write barrier ensures that the SQE stores are updated
> -		 * with the tail update. This is needed so that the kernel
> -		 * will never see a tail update without the preceeding sQE
> -		 * stores being done.
> +		 * Use smp_store_release() so that the kernel will never see a
> +		 * tail update without the preceding sQE stores being done.
>  		 */
> -		write_barrier();
> -		*sq->ktail =3D ktail;
> -		/*
> -		 * The kernel has the matching read barrier for reading the
> -		 * SQ tail.
> -		 */
> -		write_barrier();
> +		smp_store_release(sq->ktail, ktail);
>  	}
> =20
>  submit:
> --=20
> 2.23.0.rc1.153.gdeed80330f-goog
>=20

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1elR4ACgkQnKSrs4Gr
c8hcrQf/Q80QGC2yni1grrVJTuKAvEl4t9Rig6MPKn+SpTGfHsIRCTUh9I7Y4+h+
e2bYAuYGDWKk29tDOic1tnl+nnW6RUqkyepX3vTHtxc7eAotZ3f4a6r3r4jKGT0N
vJr1vOpCh2qqpja1AZjh9eFZAEVxY9QzuT/nO6bLhx0fEvAAzK0A2uamcLFCiXNp
diTTiiJWS8o3vqAVGlH/jSloxRhtVQNFCSetXjLQVrQZkL+KuYgg+KRg/BlU2yep
jIY8KrAHPnQLOsrC3zBT4Ns0tUwQU1w5PpjjI39UDiPbfR+daaynQ6AaJb9rzXdR
wJmqwqwH1RvjfFeoFwCkDf4UUD8J/A==
=kJSi
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
