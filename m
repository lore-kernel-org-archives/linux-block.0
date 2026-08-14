Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DF448D890
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728131; cv=none; b=CTHwdfHbYNQ+vndo37McHuPdiz+HlOhyBd3ODW6l5gDXWpfHLLuv3BQZdsJ6uOQH/A3xHRv/Rr/axvxmFyRRm4J3w4KtRQg/VEx8S17BVHIv6wA5OUY+m4NYQEgnrXOL/RFJ1AhkftLi3rJi/QLeWV9A51iE9yKTM1SubRZOt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728131; c=relaxed/simple;
	bh=DAVDkVmS97VcEiL2yjwW0isavq6ACpG64YS53Dinc2w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dWes5KaR7+OweGXl8/69rN/rrr2guheUm0jOqCU84dIuX4z0IMMff07G91IelGL48Re7ISDyXYe5vJmxxBqlU46gZCjbJsVK59QfXNyI6KkVtcwJUEoUO8cOhci/v1HlZX/tRAqvrPlYRy2AT6ERZptgLUSV+E7YgK6JslCXnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XkHI5qjb; arc=none smtp.client-ip=95.215.58.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XkHI5qjb"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DAVDkVmS97VcEiL2yjwW0isavq6ACpG64YS53Dinc2w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786728127; v=1; x=1787332927;
 b=XkHI5qjb61XSORceAr0XPygrEDSW2mIuR95qnlkmrGyh39TpwiAFhd3++6EWJMD3I2VogROY
 df6rjxRUOIXHr+ULpe3ZOwKYr7qeOgS6sF9KD/gdqd9jEbff9dr+hjpz514ke0FgPlcOxxk7sW+
 oavdnD/yzMAx44H47Zspimh4=
X-Envelope-To: linux-block@vger.kernel.org
Received: from ehlo.thunderbird.net (111.162.215.50)
	by smtp.migadu.com with ESMTPS id 60154f793e81620a;
	Fri, 14 Aug 2026 17:22:07 +0000
X-Migadu-Flow: FLOW_OUT
Date: Sat, 15 Aug 2026 01:21:56 +0800
From: Tao Cui <cui.tao@linux.dev>
To: Hongfu Li <hongfu.li@linux.dev>, axboe@kernel.dk, bvanassche@acm.org
CC: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 hongfu.li@linux.dev, Hongfu Li <lihongfu@kylinos.cn>
Subject: Re: [PATCH v2] block/mq-deadline: Drop unused dd parameters
User-Agent: Thunderbird for Android
In-Reply-To: <20260812040729.27551-1-hongfu.li@linux.dev>
References: <20260812040729.27551-1-hongfu.li@linux.dev>
Message-ID: <0D9DBF17-41D9-40D8-A6A5-1921C1F84BEA@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E4=BA=8E 2026=E5=B9=B48=E6=9C=8812=E6=97=A5 GMT+08:00 12:07:29=EF=BC=8CHo=
ngfu Li <hongfu=2Eli@linux=2Edev> =E5=86=99=E9=81=93=EF=BC=9A
>From: Hongfu Li <lihongfu@kylinos=2Ecn>
>
>Commit c807ab520fc3 ("block/mq-deadline: Add I/O priority support")
>left the dd parameter unused in deadline_move_request()=2E
>
>Commit fde02699c242 ("block: mq-deadline: Remove support for zone
>write locking") left dd unused in deadline_fifo_request() and
>deadline_next_request()=2E
>
>Remove these unused function parameters=2E
>
>Signed-off-by: Hongfu Li <lihongfu@kylinos=2Ecn>
>---
>v2:
>- Adjust code formatting=2E
>- No functional changes=2E
>---
> block/mq-deadline=2Ec | 25 +++++++++++--------------
> 1 file changed, 11 insertions(+), 14 deletions(-)
>
>diff --git a/block/mq-deadline=2Ec b/block/mq-deadline=2Ec
>index 824bfc17b2c6=2E=2E5f643c0ce2a8 100644
>--- a/block/mq-deadline=2Ec
>+++ b/block/mq-deadline=2Ec
>@@ -233,9 +233,8 @@ static void dd_merged_requests(struct request_queue *=
q, struct request *req,
> /*
>  * move an entry to dispatch queue
>  */
>-static void
>-deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_=
prio,
>-		      struct request *rq)
>+static void deadline_move_request(struct dd_per_prio *per_prio,
>+				  struct request *rq)
> {
> 	/*
> 	 * take it off the sort and fifo list
>@@ -269,9 +268,8 @@ static inline bool deadline_check_fifo(struct dd_per_=
prio *per_prio,
>  * For the specified data direction, return the next request to
>  * dispatch using arrival ordered lists=2E
>  */
>-static struct request *
>-deadline_fifo_request(struct deadline_data *dd, struct dd_per_prio *per_=
prio,
>-		      enum dd_data_dir data_dir)
>+static struct request *deadline_fifo_request(struct dd_per_prio *per_pri=
o,
>+					     enum dd_data_dir data_dir)
> {
> 	if (list_empty(&per_prio->fifo_list[data_dir]))
> 		return NULL;
>@@ -283,9 +281,8 @@ deadline_fifo_request(struct deadline_data *dd, struc=
t dd_per_prio *per_prio,
>  * For the specified data direction, return the next request to
>  * dispatch using sector position sorted lists=2E
>  */
>-static struct request *
>-deadline_next_request(struct deadline_data *dd, struct dd_per_prio *per_=
prio,
>-		      enum dd_data_dir data_dir)
>+static struct request *deadline_next_request(struct dd_per_prio *per_pri=
o,
>+					     enum dd_data_dir data_dir)
> {
> 	return deadline_from_pos(per_prio, data_dir,
> 				 per_prio->latest_pos[data_dir]);
>@@ -334,7 +331,7 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd,
> 	/*
> 	 * batches are currently reads XOR writes
> 	 */
>-	rq =3D deadline_next_request(dd, per_prio, dd->last_dir);
>+	rq =3D deadline_next_request(per_prio, dd->last_dir);
> 	if (rq && dd->batching < dd->fifo_batch) {
> 		/* we have a next request and are still entitled to batch */
> 		data_dir =3D rq_data_dir(rq);
>@@ -349,7 +346,7 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd,
> 	if (!list_empty(&per_prio->fifo_list[DD_READ])) {
> 		BUG_ON(RB_EMPTY_ROOT(&per_prio->sort_list[DD_READ]));
>=20
>-		if (deadline_fifo_request(dd, per_prio, DD_WRITE) &&
>+		if (deadline_fifo_request(per_prio, DD_WRITE) &&
> 		    (dd->starved++ >=3D dd->writes_starved))
> 			goto dispatch_writes;
>=20
>@@ -379,14 +376,14 @@ static struct request *__dd_dispatch_request(struct=
 deadline_data *dd,
> 	/*
> 	 * we are not running a batch, find best request for selected data_dir
> 	 */
>-	next_rq =3D deadline_next_request(dd, per_prio, data_dir);
>+	next_rq =3D deadline_next_request(per_prio, data_dir);
> 	if (deadline_check_fifo(per_prio, data_dir) || !next_rq) {
> 		/*
> 		 * A deadline has expired, the last request was in the other
> 		 * direction, or we have run out of higher-sectored requests=2E
> 		 * Start again from the request with the earliest expiry time=2E
> 		 */
>-		rq =3D deadline_fifo_request(dd, per_prio, data_dir);
>+		rq =3D deadline_fifo_request(per_prio, data_dir);
> 	} else {
> 		/*
> 		 * The last req was the same dir and we have a next request in
>@@ -409,7 +406,7 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd,
> 	 * rq is the selected appropriate request=2E
> 	 */
> 	dd->batching++;
>-	deadline_move_request(dd, per_prio, rq);
>+	deadline_move_request(per_prio, rq);
> 	return dd_start_request(dd, data_dir, rq);
> }
>=20

Reviewed-by: Tao Cui <cuitao@kylinos=2Ecn>
