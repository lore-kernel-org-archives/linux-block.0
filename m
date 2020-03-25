Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23820C18E5B
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 08:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EBB206F8
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 08:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJyIpqcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgCYIzI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:55:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49746 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbgCYIzI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 04:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585126506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DxukBkLgxcAXY0WM/4OPDb9cSuXPpn7bjD9YeTKOQcY=;
        b=MJyIpqcAt9CPzsv8A7J0K0yKNC3AzQol0IiPfdPBrOLnExmaGQ6B0YhatGd75oXMr6pLEa
        1DLPEb66OebOhnr6wCEk5j3nSkH43OiiK6VvGMd/KpMqllZusRHOK2XGsXa8ZIONglOdxt
        ndTjdnbuS/RPT2z0JermzYWmE0r5wsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-UKSI2ddSP0iG120Xj_F9zA-1; Wed, 25 Mar 2020 04:55:04 -0400
X-MC-Unique: UKSI2ddSP0iG120Xj_F9zA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5647D800D4E;
        Wed, 25 Mar 2020 08:55:03 +0000 (UTC)
Received: from ming.t460p (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57C1C1036D00;
        Wed, 25 Mar 2020 08:54:37 +0000 (UTC)
Date:   Wed, 25 Mar 2020 16:54:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v3 1/3] block/diskstats: more accurate approximation of
 io_ticks for slow disks
Message-ID: <20200325085432.GA31035@ming.t460p>
References: <158503038812.1955.7827988255138056389.stgit@buzz>
 <158503198072.1955.16227279292140721351.stgit@buzz>
 <20200324140656.GA23550@ming.t460p>
 <20200325034024.GC6086@ming.t460p>
 <841346dd-95b0-859f-79ec-dfbdedc16628@yandex-team.ru>
 <4f267148-8d6a-e3c8-2518-b2a3bd579454@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4f267148-8d6a-e3c8-2518-b2a3bd579454@yandex-team.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 25, 2020 at 11:02:39AM +0300, Konstantin Khlebnikov wrote:
>=20
>=20
> On 25/03/2020 09.28, Konstantin Khlebnikov wrote:
> >=20
> >=20
> > On 25/03/2020 06.40, Ming Lei wrote:
> > > On Tue, Mar 24, 2020 at 10:06:56PM +0800, Ming Lei wrote:
> > > > On Tue, Mar 24, 2020 at 09:39:40AM +0300, Konstantin Khlebnikov w=
rote:
> > > > > Currently io_ticks is approximated by adding one at each start =
and end of
> > > > > requests if jiffies counter has changed. This works perfectly f=
or requests
> > > > > shorter than a jiffy or if one of requests starts/ends at each =
jiffy.
> > > > >=20
> > > > > If disk executes just one request at a time and they are longer=
 than two
> > > > > jiffies then only first and last jiffies will be accounted.
> > > > >=20
> > > > > Fix is simple: at the end of request add up into io_ticks jiffi=
es passed
> > > > > since last update rather than just one jiffy.
> > > > >=20
> > > > > Example: common HDD executes random read 4k requests around 12m=
s.
> > > > >=20
> > > > > fio --name=3Dtest --filename=3D/dev/sdb --rw=3Drandread --direc=
t=3D1 --runtime=3D30 &
> > > > > iostat -x 10 sdb
> > > > >=20
> > > > > Note changes of iostat's "%util" 8,43% -> 99,99% before/after p=
atch:
> > > > >=20
> > > > > Before:
> > > > >=20
> > > > > Device:=A0=A0=A0=A0=A0=A0=A0=A0 rrqm/s=A0=A0 wrqm/s=A0=A0=A0=A0=
 r/s=A0=A0=A0=A0 w/s=A0=A0=A0 rkB/s=A0=A0=A0 wkB/s avgrq-sz avgqu-sz=A0=A0=
 await r_await w_await=A0 svctm=A0 %util
> > > > > sdb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,00=A0=A0=A0=A0 =
0,00=A0=A0 82,60=A0=A0=A0 0,00=A0=A0 330,40=A0=A0=A0=A0 0,00=A0=A0=A0=A0 =
8,00=A0=A0=A0=A0 0,96=A0=A0 12,09=A0=A0 12,09=A0=A0=A0 0,00=A0=A0 1,02=A0=
=A0 8,43
> > > > >=20
> > > > > After:
> > > > >=20
> > > > > Device:=A0=A0=A0=A0=A0=A0=A0=A0 rrqm/s=A0=A0 wrqm/s=A0=A0=A0=A0=
 r/s=A0=A0=A0=A0 w/s=A0=A0=A0 rkB/s=A0=A0=A0 wkB/s avgrq-sz avgqu-sz=A0=A0=
 await r_await w_await=A0 svctm=A0 %util
> > > > > sdb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,00=A0=A0=A0=A0 =
0,00=A0=A0 82,50=A0=A0=A0 0,00=A0=A0 330,00=A0=A0=A0=A0 0,00=A0=A0=A0=A0 =
8,00=A0=A0=A0=A0 1,00=A0=A0 12,10=A0=A0 12,10=A0=A0=A0 0,00=A0 12,12=A0 9=
9,99
> > > > >=20
> > > > > For load estimation "%util" is not as useful as average queue l=
ength,
> > > > > but it clearly shows how often disk queue is completely empty.
> > > > >=20
> > > > > Fixes: 5b18b5a73760 ("block: delete part_round_stats and switch=
 to less precise counting")
> > > > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru=
>
> > > > > ---
> > > > > =A0 Documentation/admin-guide/iostats.rst |=A0=A0=A0 5 ++++-
> > > > > =A0 block/bio.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 8 ++++----
> > > > > =A0 block/blk-core.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 4 ++--
> > > > > =A0 include/linux/genhd.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0=A0 2 +-
> > > > > =A0 4 files changed, 11 insertions(+), 8 deletions(-)
> > > > >=20
> > > > > diff --git a/Documentation/admin-guide/iostats.rst b/Documentat=
ion/admin-guide/iostats.rst
> > > > > index df5b8345c41d..9b14b0c2c9c4 100644
> > > > > --- a/Documentation/admin-guide/iostats.rst
> > > > > +++ b/Documentation/admin-guide/iostats.rst
> > > > > @@ -100,7 +100,7 @@ Field 10 -- # of milliseconds spent doing I=
/Os (unsigned int)
> > > > > =A0=A0=A0=A0=A0 Since 5.0 this field counts jiffies when at lea=
st one request was
> > > > > =A0=A0=A0=A0=A0 started or completed. If request runs more than=
 2 jiffies then some
> > > > > -=A0=A0=A0 I/O time will not be accounted unless there are othe=
r requests.
> > > > > +=A0=A0=A0 I/O time might be not accounted in case of concurren=
t requests.
> > > > > =A0 Field 11 -- weighted # of milliseconds spent doing I/Os (un=
signed int)
> > > > > =A0=A0=A0=A0=A0 This field is incremented at each I/O start, I/=
O completion, I/O
> > > > > @@ -143,6 +143,9 @@ are summed (possibly overflowing the unsign=
ed long variable they are
> > > > > =A0 summed to) and the result given to the user.=A0 There is no=
 convenient
> > > > > =A0 user interface for accessing the per-CPU counters themselve=
s.
> > > > > +Since 4.19 request times are measured with nanoseconds precisi=
on and
> > > > > +truncated to milliseconds before showing in this interface.
> > > > > +
> > > > > =A0 Disks vs Partitions
> > > > > =A0 -------------------
> > > > > diff --git a/block/bio.c b/block/bio.c
> > > > > index 0985f3422556..b1053eb7af37 100644
> > > > > --- a/block/bio.c
> > > > > +++ b/block/bio.c
> > > > > @@ -1762,14 +1762,14 @@ void bio_check_pages_dirty(struct bio *=
bio)
> > > > > =A0=A0=A0=A0=A0 schedule_work(&bio_dirty_work);
> > > > > =A0 }
> > > > > -void update_io_ticks(struct hd_struct *part, unsigned long now=
)
> > > > > +void update_io_ticks(struct hd_struct *part, unsigned long now=
, bool end)
> > > > > =A0 {
> > > > > =A0=A0=A0=A0=A0 unsigned long stamp;
> > > > > =A0 again:
> > > > > =A0=A0=A0=A0=A0 stamp =3D READ_ONCE(part->stamp);
> > > > > =A0=A0=A0=A0=A0 if (unlikely(stamp !=3D now)) {
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (likely(cmpxchg(&part->stamp, st=
amp, now) =3D=3D stamp)) {
> > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __part_stat_add(part, io_tic=
ks, 1);
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __part_stat_add(part, io_tic=
ks, end ? now - stamp : 1);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > =A0=A0=A0=A0=A0 }
> > > > > =A0=A0=A0=A0=A0 if (part->partno) {
> > > > > @@ -1785,7 +1785,7 @@ void generic_start_io_acct(struct request=
_queue *q, int op,
> > > > > =A0=A0=A0=A0=A0 part_stat_lock();
> > > > > -=A0=A0=A0 update_io_ticks(part, jiffies);
> > > > > +=A0=A0=A0 update_io_ticks(part, jiffies, false);
> > > > > =A0=A0=A0=A0=A0 part_stat_inc(part, ios[sgrp]);
> > > > > =A0=A0=A0=A0=A0 part_stat_add(part, sectors[sgrp], sectors);
> > > > > =A0=A0=A0=A0=A0 part_inc_in_flight(q, part, op_is_write(op));
> > > > > @@ -1803,7 +1803,7 @@ void generic_end_io_acct(struct request_q=
ueue *q, int req_op,
> > > > > =A0=A0=A0=A0=A0 part_stat_lock();
> > > > > -=A0=A0=A0 update_io_ticks(part, now);
> > > > > +=A0=A0=A0 update_io_ticks(part, now, true);
> > > > > =A0=A0=A0=A0=A0 part_stat_add(part, nsecs[sgrp], jiffies_to_nse=
cs(duration));
> > > > > =A0=A0=A0=A0=A0 part_stat_add(part, time_in_queue, duration);
> > > > > =A0=A0=A0=A0=A0 part_dec_in_flight(q, part, op_is_write(req_op)=
);
> > > > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > > > index abfdcf81a228..4401b30a1751 100644
> > > > > --- a/block/blk-core.c
> > > > > +++ b/block/blk-core.c
> > > > > @@ -1337,7 +1337,7 @@ void blk_account_io_done(struct request *=
req, u64 now)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 part_stat_lock();
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 part =3D req->part;
> > > > > -=A0=A0=A0=A0=A0=A0=A0 update_io_ticks(part, jiffies);
> > > > > +=A0=A0=A0=A0=A0=A0=A0 update_io_ticks(part, jiffies, true);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 part_stat_inc(part, ios[sgrp]);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 part_stat_add(part, nsecs[sgrp], no=
w - req->start_time_ns);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 part_stat_add(part, time_in_queue, =
nsecs_to_jiffies64(now - req->start_time_ns));
> > > > > @@ -1379,7 +1379,7 @@ void blk_account_io_start(struct request =
*rq, bool new_io)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 rq->part =3D part;
> > > > > =A0=A0=A0=A0=A0 }
> > > > > -=A0=A0=A0 update_io_ticks(part, jiffies);
> > > > > +=A0=A0=A0 update_io_ticks(part, jiffies, false);
> > > > > =A0=A0=A0=A0=A0 part_stat_unlock();
> > > > > =A0 }
> > > > > diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> > > > > index d5c75df64bba..f1066f10b062 100644
> > > > > --- a/include/linux/genhd.h
> > > > > +++ b/include/linux/genhd.h
> > > > > @@ -467,7 +467,7 @@ static inline void free_part_info(struct hd=
_struct *part)
> > > > > =A0=A0=A0=A0=A0 kfree(part->info);
> > > > > =A0 }
> > > > > -void update_io_ticks(struct hd_struct *part, unsigned long now=
);
> > > > > +void update_io_ticks(struct hd_struct *part, unsigned long now=
, bool end);
> > > > > =A0 /* block/genhd.c */
> > > > > =A0 extern void device_add_disk(struct device *parent, struct g=
endisk *disk,
> > > > >=20
> > > >=20
> > > > Looks fine:
> > > >=20
> > > > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > >=20
> > > BTW, there is still some gap(%65 vs. 99%) between this fix and the =
original
> > > accounting(before applying Mike/Mikulas's 7 patches), and it might =
be
> > > one thing to improve in future.
> > >=20
> > > 1) test, sda is single queue virtio-scsi, which is emulated by one =
HDD
> > > image
> > >=20
> > > 2) fio test script:
> > > fio --direct=3D1 --size=3D128G --bsrange=3D4k-4k \
> > > =A0=A0=A0=A0=A0=A0=A0 --runtime=3D20 --numjobs=3D1 \
> > > =A0=A0=A0=A0=A0=A0=A0 --ioengine=3Dlibaio --iodepth=3D16 \
> > > =A0=A0=A0=A0=A0=A0=A0 --iodepth_batch_submit=3D16 \
> > > =A0=A0=A0=A0=A0=A0=A0 --iodepth_batch_complete_min=3D16 \
> > > =A0=A0=A0=A0=A0=A0=A0 --group_reporting=3D1 --filename=3D/dev/sda \
> > > =A0=A0=A0=A0=A0=A0=A0 --name=3Dseq-test --rw=3Dread
> > >=20
> > > 3) result:
> > > - v5.6-rc with this patch
> > > Run status group 0 (all jobs):
> > > =A0=A0=A0 READ: bw=3D79.4MiB/s (83.3MB/s), 79.4MiB/s-79.4MiB/s (83.=
3MB/s-83.3MB/s), io=3D155
> > > 88MiB (1665MB), run=3D20001-20001msec
> > >=20
> > > Disk stats (read/write):
> > > =A0=A0 sda: ios=3D25039/0, merge=3D375596/0, ticks=3D18823/0, in_qu=
eue=3D4330, util=3D99.43%
> > >=20
> > >=20
> > > - commit 112f158f66cb (which is previous commit of 5b18b5a73760)
> > > Run status group 0 (all jobs):
> > > =A0=A0=A0 READ: bw=3D81.4MiB/s (85.3MB/s), 81.4MiB/s-81.4MiB/s (85.=
3MB/s-85.3MB/s), io=3D166
> > > 28MiB (1707MB), run=3D20001-20001msec
> > >=20
> > > Disk stats (read/write):
> > > =A0=A0 sda: ios=3D25749/0, merge=3D386236/0, ticks=3D17963/0, in_qu=
eue=3D12976, util=3D65.20%
> > >=20
>=20
> Oh, no. Your result is opposite.
>=20
> Well, 99.43% with this patch is actually more correct result:
> every millisecond there is at least one request in disk.
>=20
> Old code sampled in-flight at start and end of each request, not regula=
rly every jiffy.

It doesn't matter if it is regularly every jiffy, or the sample point.

It is perfect to just sample at start and end, and not necessary to
do it in merge.

What matters is that only IO time is accounted. And when there isn't
any IO in-flight, the time shouldn't be accounted into io_ticks.
That is it, however, the new approach can't do that at all.

> And accounted whole jiffy as inactive if in-flight currently is zero.
> This way statistics was biased to samples where queue is empty.

It is just one sequential read test, single job, and there are lots of
merge, so disk utilization shouldn't be close to 100%, should it?

With your patch, now it is much easy to observe 100% utilization.

More ticks are counted in v5.6-rc with this patch than old kernel, the
reason is that new approach counts 1 tick for IDLE time(no any IO)
in blk_account_io_start(). Old approach knows if there is any in-flight
IO, if there isn't, the period since last stamp is thought as IO idle,
and that time won't be accounted.

However, the new approach doesn't know IO IDLE period at all, just
add 1 tick for this period.


Thanks,
Ming

