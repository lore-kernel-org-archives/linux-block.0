Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74C2C2D0E7
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 07:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF5A207FC
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 07:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvJGneT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgCZHxo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:53:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:60602 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbgCZHxo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 03:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585209221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dULE7SmBQ9HpNKcwg+8XixgDoF5+C9tY5Fy4wSuqR/w=;
        b=WvJGneT5tr99XP/kVli7IAJO4BPNUvEZMeGJHUE9YIb+xla6eiMtzLEZP6tlr4slMY7STq
        Hfwo9P6WFhr9MjqQueYxJNL2X2hxs33eNn54GbrSpJXqzBt8WgObQNBqOGeGIftj6x+Z+i
        ecyLLMpN6PzI5imfmibokcCBdRYPA3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-xzLREPmXOoKJ--28jjhE1Q-1; Thu, 26 Mar 2020 03:53:37 -0400
X-MC-Unique: xzLREPmXOoKJ--28jjhE1Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FD8618FF661;
        Thu, 26 Mar 2020 07:53:36 +0000 (UTC)
Received: from ming.t460p (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D710F19C70;
        Thu, 26 Mar 2020 07:53:21 +0000 (UTC)
Date:   Thu, 26 Mar 2020 15:53:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v3 1/3] block/diskstats: more accurate approximation of
 io_ticks for slow disks
Message-ID: <20200326075316.GC13588@ming.t460p>
References: <158503038812.1955.7827988255138056389.stgit@buzz>
 <158503198072.1955.16227279292140721351.stgit@buzz>
 <20200324140656.GA23550@ming.t460p>
 <20200325034024.GC6086@ming.t460p>
 <841346dd-95b0-859f-79ec-dfbdedc16628@yandex-team.ru>
 <4f267148-8d6a-e3c8-2518-b2a3bd579454@yandex-team.ru>
 <20200325085432.GA31035@ming.t460p>
 <f4a84e7d-02d4-657d-c2d9-31c98ff31615@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f4a84e7d-02d4-657d-c2d9-31c98ff31615@yandex-team.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 25, 2020 at 04:02:25PM +0300, Konstantin Khlebnikov wrote:
> On 25/03/2020 11.54, Ming Lei wrote:
> > On Wed, Mar 25, 2020 at 11:02:39AM +0300, Konstantin Khlebnikov wrote=
:
> > >=20
> > >=20
> > > On 25/03/2020 09.28, Konstantin Khlebnikov wrote:
> > > >=20
> > > >=20
> > > > On 25/03/2020 06.40, Ming Lei wrote:
> > > > > On Tue, Mar 24, 2020 at 10:06:56PM +0800, Ming Lei wrote:
> > > > > > On Tue, Mar 24, 2020 at 09:39:40AM +0300, Konstantin Khlebnik=
ov wrote:
> > > > > > > Currently io_ticks is approximated by adding one at each st=
art and end of
> > > > > > > requests if jiffies counter has changed. This works perfect=
ly for requests
> > > > > > > shorter than a jiffy or if one of requests starts/ends at e=
ach jiffy.
> > > > > > >=20
> > > > > > > If disk executes just one request at a time and they are lo=
nger than two
> > > > > > > jiffies then only first and last jiffies will be accounted.
> > > > > > >=20
> > > > > > > Fix is simple: at the end of request add up into io_ticks j=
iffies passed
> > > > > > > since last update rather than just one jiffy.
> > > > > > >=20
> > > > > > > Example: common HDD executes random read 4k requests around=
 12ms.
> > > > > > >=20
> > > > > > > fio --name=3Dtest --filename=3D/dev/sdb --rw=3Drandread --d=
irect=3D1 --runtime=3D30 &
> > > > > > > iostat -x 10 sdb
> > > > > > >=20
> > > > > > > Note changes of iostat's "%util" 8,43% -> 99,99% before/aft=
er patch:
> > > > > > >=20
> > > > > > > Before:
> > > > > > >=20
> > > > > > > Device:=A0=A0=A0=A0=A0=A0=A0=A0 rrqm/s=A0=A0 wrqm/s=A0=A0=A0=
=A0 r/s=A0=A0=A0=A0 w/s=A0=A0=A0 rkB/s=A0=A0=A0 wkB/s avgrq-sz avgqu-sz=A0=
=A0 await r_await w_await=A0 svctm=A0 %util
> > > > > > > sdb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,00=A0=A0=A0=
=A0 0,00=A0=A0 82,60=A0=A0=A0 0,00=A0=A0 330,40=A0=A0=A0=A0 0,00=A0=A0=A0=
=A0 8,00=A0=A0=A0=A0 0,96=A0=A0 12,09=A0=A0 12,09=A0=A0=A0 0,00=A0=A0 1,0=
2=A0=A0 8,43
> > > > > > >=20
> > > > > > > After:
> > > > > > >=20
> > > > > > > Device:=A0=A0=A0=A0=A0=A0=A0=A0 rrqm/s=A0=A0 wrqm/s=A0=A0=A0=
=A0 r/s=A0=A0=A0=A0 w/s=A0=A0=A0 rkB/s=A0=A0=A0 wkB/s avgrq-sz avgqu-sz=A0=
=A0 await r_await w_await=A0 svctm=A0 %util
> > > > > > > sdb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0,00=A0=A0=A0=
=A0 0,00=A0=A0 82,50=A0=A0=A0 0,00=A0=A0 330,00=A0=A0=A0=A0 0,00=A0=A0=A0=
=A0 8,00=A0=A0=A0=A0 1,00=A0=A0 12,10=A0=A0 12,10=A0=A0=A0 0,00=A0 12,12=A0=
 99,99
> > > > > > >=20
> > > > > > > For load estimation "%util" is not as useful as average que=
ue length,
> > > > > > > but it clearly shows how often disk queue is completely emp=
ty.
> > > > > > >=20
> > > > > > > Fixes: 5b18b5a73760 ("block: delete part_round_stats and sw=
itch to less precise counting")
> > > > > > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-tea=
m.ru>
> > > > > > > ---
> > > > > > >  =A0 Documentation/admin-guide/iostats.rst |=A0=A0=A0 5 +++=
+-
> > > > > > >  =A0 block/bio.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 8 ++++----
> > > > > > >  =A0 block/blk-core.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0 4 ++--
> > > > > > >  =A0 include/linux/genhd.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |=A0=A0=A0 2 +-
> > > > > > >  =A0 4 files changed, 11 insertions(+), 8 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/Documentation/admin-guide/iostats.rst b/Docume=
ntation/admin-guide/iostats.rst
> > > > > > > index df5b8345c41d..9b14b0c2c9c4 100644
> > > > > > > --- a/Documentation/admin-guide/iostats.rst
> > > > > > > +++ b/Documentation/admin-guide/iostats.rst
> > > > > > > @@ -100,7 +100,7 @@ Field 10 -- # of milliseconds spent doi=
ng I/Os (unsigned int)
> > > > > > >  =A0=A0=A0=A0=A0 Since 5.0 this field counts jiffies when a=
t least one request was
> > > > > > >  =A0=A0=A0=A0=A0 started or completed. If request runs more=
 than 2 jiffies then some
> > > > > > > -=A0=A0=A0 I/O time will not be accounted unless there are =
other requests.
> > > > > > > +=A0=A0=A0 I/O time might be not accounted in case of concu=
rrent requests.
> > > > > > >  =A0 Field 11 -- weighted # of milliseconds spent doing I/O=
s (unsigned int)
> > > > > > >  =A0=A0=A0=A0=A0 This field is incremented at each I/O star=
t, I/O completion, I/O
> > > > > > > @@ -143,6 +143,9 @@ are summed (possibly overflowing the un=
signed long variable they are
> > > > > > >  =A0 summed to) and the result given to the user.=A0 There =
is no convenient
> > > > > > >  =A0 user interface for accessing the per-CPU counters them=
selves.
> > > > > > > +Since 4.19 request times are measured with nanoseconds pre=
cision and
> > > > > > > +truncated to milliseconds before showing in this interface=
.
> > > > > > > +
> > > > > > >  =A0 Disks vs Partitions
> > > > > > >  =A0 -------------------
> > > > > > > diff --git a/block/bio.c b/block/bio.c
> > > > > > > index 0985f3422556..b1053eb7af37 100644
> > > > > > > --- a/block/bio.c
> > > > > > > +++ b/block/bio.c
> > > > > > > @@ -1762,14 +1762,14 @@ void bio_check_pages_dirty(struct b=
io *bio)
> > > > > > >  =A0=A0=A0=A0=A0 schedule_work(&bio_dirty_work);
> > > > > > >  =A0 }
> > > > > > > -void update_io_ticks(struct hd_struct *part, unsigned long=
 now)
> > > > > > > +void update_io_ticks(struct hd_struct *part, unsigned long=
 now, bool end)
> > > > > > >  =A0 {
> > > > > > >  =A0=A0=A0=A0=A0 unsigned long stamp;
> > > > > > >  =A0 again:
> > > > > > >  =A0=A0=A0=A0=A0 stamp =3D READ_ONCE(part->stamp);
> > > > > > >  =A0=A0=A0=A0=A0 if (unlikely(stamp !=3D now)) {
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (likely(cmpxchg(&part->stam=
p, stamp, now) =3D=3D stamp)) {
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __part_stat_add(part, io=
_ticks, 1);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __part_stat_add(part, io=
_ticks, end ? now - stamp : 1);
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > >  =A0=A0=A0=A0=A0 }
> > > > > > >  =A0=A0=A0=A0=A0 if (part->partno) {
> > > > > > > @@ -1785,7 +1785,7 @@ void generic_start_io_acct(struct req=
uest_queue *q, int op,
> > > > > > >  =A0=A0=A0=A0=A0 part_stat_lock();
> > > > > > > -=A0=A0=A0 update_io_ticks(part, jiffies);
> > > > > > > +=A0=A0=A0 update_io_ticks(part, jiffies, false);
> > > > > > >  =A0=A0=A0=A0=A0 part_stat_inc(part, ios[sgrp]);
> > > > > > >  =A0=A0=A0=A0=A0 part_stat_add(part, sectors[sgrp], sectors=
);
> > > > > > >  =A0=A0=A0=A0=A0 part_inc_in_flight(q, part, op_is_write(op=
));
> > > > > > > @@ -1803,7 +1803,7 @@ void generic_end_io_acct(struct reque=
st_queue *q, int req_op,
> > > > > > >  =A0=A0=A0=A0=A0 part_stat_lock();
> > > > > > > -=A0=A0=A0 update_io_ticks(part, now);
> > > > > > > +=A0=A0=A0 update_io_ticks(part, now, true);
> > > > > > >  =A0=A0=A0=A0=A0 part_stat_add(part, nsecs[sgrp], jiffies_t=
o_nsecs(duration));
> > > > > > >  =A0=A0=A0=A0=A0 part_stat_add(part, time_in_queue, duratio=
n);
> > > > > > >  =A0=A0=A0=A0=A0 part_dec_in_flight(q, part, op_is_write(re=
q_op));
> > > > > > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > > > > > index abfdcf81a228..4401b30a1751 100644
> > > > > > > --- a/block/blk-core.c
> > > > > > > +++ b/block/blk-core.c
> > > > > > > @@ -1337,7 +1337,7 @@ void blk_account_io_done(struct reque=
st *req, u64 now)
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 part_stat_lock();
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 part =3D req->part;
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0 update_io_ticks(part, jiffies);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 update_io_ticks(part, jiffies, true)=
;
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 part_stat_inc(part, ios[sgrp])=
;
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 part_stat_add(part, nsecs[sgrp=
], now - req->start_time_ns);
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 part_stat_add(part, time_in_qu=
eue, nsecs_to_jiffies64(now - req->start_time_ns));
> > > > > > > @@ -1379,7 +1379,7 @@ void blk_account_io_start(struct requ=
est *rq, bool new_io)
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 rq->part =3D part;
> > > > > > >  =A0=A0=A0=A0=A0 }
> > > > > > > -=A0=A0=A0 update_io_ticks(part, jiffies);
> > > > > > > +=A0=A0=A0 update_io_ticks(part, jiffies, false);
> > > > > > >  =A0=A0=A0=A0=A0 part_stat_unlock();
> > > > > > >  =A0 }
> > > > > > > diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> > > > > > > index d5c75df64bba..f1066f10b062 100644
> > > > > > > --- a/include/linux/genhd.h
> > > > > > > +++ b/include/linux/genhd.h
> > > > > > > @@ -467,7 +467,7 @@ static inline void free_part_info(struc=
t hd_struct *part)
> > > > > > >  =A0=A0=A0=A0=A0 kfree(part->info);
> > > > > > >  =A0 }
> > > > > > > -void update_io_ticks(struct hd_struct *part, unsigned long=
 now);
> > > > > > > +void update_io_ticks(struct hd_struct *part, unsigned long=
 now, bool end);
> > > > > > >  =A0 /* block/genhd.c */
> > > > > > >  =A0 extern void device_add_disk(struct device *parent, str=
uct gendisk *disk,
> > > > > > >=20
> > > > > >=20
> > > > > > Looks fine:
> > > > > >=20
> > > > > > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> > > > >=20
> > > > > BTW, there is still some gap(%65 vs. 99%) between this fix and =
the original
> > > > > accounting(before applying Mike/Mikulas's 7 patches), and it mi=
ght be
> > > > > one thing to improve in future.
> > > > >=20
> > > > > 1) test, sda is single queue virtio-scsi, which is emulated by =
one HDD
> > > > > image
> > > > >=20
> > > > > 2) fio test script:
> > > > > fio --direct=3D1 --size=3D128G --bsrange=3D4k-4k \
> > > > >  =A0=A0=A0=A0=A0=A0=A0 --runtime=3D20 --numjobs=3D1 \
> > > > >  =A0=A0=A0=A0=A0=A0=A0 --ioengine=3Dlibaio --iodepth=3D16 \
> > > > >  =A0=A0=A0=A0=A0=A0=A0 --iodepth_batch_submit=3D16 \
> > > > >  =A0=A0=A0=A0=A0=A0=A0 --iodepth_batch_complete_min=3D16 \
> > > > >  =A0=A0=A0=A0=A0=A0=A0 --group_reporting=3D1 --filename=3D/dev/=
sda \
> > > > >  =A0=A0=A0=A0=A0=A0=A0 --name=3Dseq-test --rw=3Dread
> > > > >=20
> > > > > 3) result:
> > > > > - v5.6-rc with this patch
> > > > > Run status group 0 (all jobs):
> > > > >  =A0=A0=A0 READ: bw=3D79.4MiB/s (83.3MB/s), 79.4MiB/s-79.4MiB/s=
 (83.3MB/s-83.3MB/s), io=3D155
> > > > > 88MiB (1665MB), run=3D20001-20001msec
> > > > >=20
> > > > > Disk stats (read/write):
> > > > >  =A0=A0 sda: ios=3D25039/0, merge=3D375596/0, ticks=3D18823/0, =
in_queue=3D4330, util=3D99.43%
> > > > >=20
> > > > >=20
> > > > > - commit 112f158f66cb (which is previous commit of 5b18b5a73760=
)
> > > > > Run status group 0 (all jobs):
> > > > >  =A0=A0=A0 READ: bw=3D81.4MiB/s (85.3MB/s), 81.4MiB/s-81.4MiB/s=
 (85.3MB/s-85.3MB/s), io=3D166
> > > > > 28MiB (1707MB), run=3D20001-20001msec
> > > > >=20
> > > > > Disk stats (read/write):
> > > > >  =A0=A0 sda: ios=3D25749/0, merge=3D386236/0, ticks=3D17963/0, =
in_queue=3D12976, util=3D65.20%
> > > > >=20
> > >=20
> > > Oh, no. Your result is opposite.
> > >=20
> > > Well, 99.43% with this patch is actually more correct result:
> > > every millisecond there is at least one request in disk.
> > >=20
> > > Old code sampled in-flight at start and end of each request, not re=
gularly every jiffy.
> >=20
> > It doesn't matter if it is regularly every jiffy, or the sample point=
.
> >=20
> > It is perfect to just sample at start and end, and not necessary to
> > do it in merge.
> >=20
> > What matters is that only IO time is accounted. And when there isn't
> > any IO in-flight, the time shouldn't be accounted into io_ticks.
> > That is it, however, the new approach can't do that at all.
>=20
> Yeah, should be right but something fishy in old statistics anyway.
>=20
> It looks timestamp (part->stamp) sometimes updated non-atomically
> without queue_lock.

part->stamp is defined as 'unsigned long', and it is updated atomically.

>=20
> >=20
> > > And accounted whole jiffy as inactive if in-flight currently is zer=
o.
> > > This way statistics was biased to samples where queue is empty.
> >=20
> > It is just one sequential read test, single job, and there are lots o=
f
> > merge, so disk utilization shouldn't be close to 100%, should it?
>=20
> Why not? It doesn't took a long time to complete request and issue anot=
her.

It still takes a bit time to complete request, and there are lots of
thing to do: dio completion, aio completion, wakeup fio to reap
the aio, fio prepare & submission. In my VM, this time is often < 1ms,
actually completing one sequential IO often takes less 1ms too, so
ratio between the two is really visible. Adding extra one tick in
starting request can cause bigger utilization, given one tick is
1ms with 1000HZ.

I do have such IO trace, and I can share to you if you want to take
a look.

Similar result can be observed in single queue depth too, given it
is sequential IO, plug merge will merge all these batch submission
into one request.

I believe ~60% represents the correct util%, and the data can be
figured from userspace easily, follows the approach:

1) attache two probes on blk_account_io_start/blk_account_io_complete or
done via bcc/bpftrace

2) use the timestamp collected in above two probes to calculate %util,
and the algorithm is simple to figure out max io ranges

I have written a python script to verify the correct disk utilization,
and it shows that old kernel's result is correct.

>=20
> Look, for single-thread fio iostat show %util 100% but avgqu-sz is 1 to=
o
> it's estimated using total I/O time which counted in nanoseconds.
>=20
> Device:         rrqm/s   wrqm/s     r/s     w/s    rkB/s    wkB/s avgrq=
-sz avgqu-sz   await r_await w_await  svctm  %util
> sdb               0,00     0,00   83,30    0,00   333,20     0,00     8=
,00     1,00   11,98   11,98    0,00  12,00 100,00
>=20
> Probably old blk stack was generally slower and delayed requests somewh=
ere.

No, as you see, the throughput data is basically same.

>=20
> >=20
> > With your patch, now it is much easy to observe 100% utilization.
> >=20
> > More ticks are counted in v5.6-rc with this patch than old kernel, th=
e
> > reason is that new approach counts 1 tick for IDLE time(no any IO)
> > in blk_account_io_start(). Old approach knows if there is any in-flig=
ht
> > IO, if there isn't, the period since last stamp is thought as IO idle=
,
> > and that time won't be accounted. >
> > However, the new approach doesn't know IO IDLE period at all, just
> > add 1 tick for this period.
>=20
> There is I/O during jiffy when request starts =3D) So it's counted as 1=
.
> This kind of rounding up I/O shorter than jiffy.

Firstly if the current request is the 1st in-flight IO, the 1 tick
shouldn't be counted.

Secondly if the current started request isn't the 1st in-flight IO,
1 tick may be too much if timestamp isn't updated in last IO completion.


Thanks,
Ming

