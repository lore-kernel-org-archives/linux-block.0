Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751117AbdDEEb3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Apr 2017 00:31:29 -0400
From: NeilBrown <neilb@suse.com>
To: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 05 Apr 2017 14:31:20 +1000
Cc: Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loop: Add PF_LESS_THROTTLE to block/loop device thread.
In-Reply-To: <CACVXFVO54OseKKpZXEju9a+GWYkTFRt9qHT22zzcTjOqGnanmw@mail.gmail.com>
References: <871staffus.fsf@notabene.neil.brown.name> <CACVXFVO54OseKKpZXEju9a+GWYkTFRt9qHT22zzcTjOqGnanmw@mail.gmail.com>
Message-ID: <87zifvh3vr.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Tue, Apr 04 2017, Ming Lei wrote:

> On Mon, Apr 3, 2017 at 9:18 AM, NeilBrown <neilb@suse.com> wrote:
>>
>> When a filesystem is mounted from a loop device, writes are
>> throttled by balance_dirty_pages() twice: once when writing
>> to the filesystem and once when the loop_handle_cmd() writes
>> to the backing file.  This double-throttling can trigger
>> positive feedback loops that create significant delays.  The
>> throttling at the lower level is seen by the upper level as
>> a slow device, so it throttles extra hard.
>>
>> The PF_LESS_THROTTLE flag was created to handle exactly this
>> circumstance, though with an NFS filesystem mounted from a
>> local NFS server.  It reduces the throttling on the lower
>> layer so that it can proceed largely unthrottled.
>>
>> To demonstrate this, create a filesystem on a loop device
>> and write (e.g. with dd) several large files which combine
>> to consume significantly more than the limit set by
>> /proc/sys/vm/dirty_ratio or dirty_bytes.  Measure the total
>> time taken.
>>
>> When I do this directly on a device (no loop device) the
>> total time for several runs (mkfs, mount, write 200 files,
>> umount) is fairly stable: 28-35 seconds.
>> When I do this over a loop device the times are much worse
>> and less stable.  52-460 seconds.  Half below 100seconds,
>> half above.
>> When I apply this patch, the times become stable again,
>> though not as fast as the no-loop-back case: 53-72 seconds.
>>
>> There may be room for further improvement as the total overhead still
>> seems too high, but this is a big improvement.
>>
>> Signed-off-by: NeilBrown <neilb@suse.com>
>> ---
>>  drivers/block/loop.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 0ecb6461ed81..a7e1dd215fc2 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -1694,8 +1694,11 @@ static void loop_queue_work(struct kthread_work *work)
>>  {
>>         struct loop_cmd *cmd =
>>                 container_of(work, struct loop_cmd, work);
>> +       int oldflags = current->flags & PF_LESS_THROTTLE;
>>
>> +       current->flags |= PF_LESS_THROTTLE;
>>         loop_handle_cmd(cmd);
>> +       current->flags = (current->flags & ~PF_LESS_THROTTLE) | oldflags;
>>  }
>
> You can do it against 'lo->worker_task' instead of doing it in each
> loop_queue_work(),
> and this flag needn't to be restored because the kernel thread is loop
> specialized.
>

good point.  I'll do that.  Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAljkcxgACgkQOeye3VZi
gbkRCQ//ZXP+V7DavU/0u71sg3SPH2ddQBE1yJqZP+fs6YTWz0nsqA4sxoGsNe2T
ldBJ2O2MFRlgFTmu2Fnk//KmLLyEMA4I9JjGElscfcK/cWHH3yVmC3WeVYwDZP/D
uKn1EfmAI4nKdLs4mjSEDa+NZSV5A+RPwwDVETemsCpLFd8YNJ2fGDZcFBa9Obm2
kyuNfrsdVS/E7hPVJn/a37zZiY6ybIZc9972m1IzwQFZETDcY56Sad+9uHV09YHY
n3XkYYVi4l7Mge3EvUUkiY620r+VmhCtwrT0demy9pt5airq9syMthKzlZzYle2g
WZ2Q2xKgpmEDg4oZC1lFtirdgDPgOXYJfzC/3q1hwF8eB3607wzUMDmVBOTdXsTO
vDQ8VaU5zHwKmR8BtSHTYcnFKKcVRnvffXsCqJ/EPjRppu+UQEaq3Jvpp73Unvnr
Be0InhW7y/gVmquoLghocegLjKyWIDW0qhMcrYsA3S4LMAgys7RHcg1BaO8PmVsI
xL7FZEmiaYiSAf+mSmcY/BUJOKui3AmTf8OX/HKj0Z5ShiNcsHjgUCwHPfW7Uadc
hvns3Lnz7Ehu+pS/aMVxG/jqy+tFl2I/uNSVZzZr8ekrHr0auj5yRYE99yyhQe2x
WkKFLRZdy2xUGb0noCWU5W72/7hHuMrmnppLNvo7Y7kqxtS4dmY=
=BBID
-----END PGP SIGNATURE-----
--=-=-=--
