Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102E2010EE
	for <linux-block@vger.kernel.org>; Sat, 28 Feb 2026 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772256625; cv=none; b=sf3/RzlIQcgwmSJOpeeYkB//9s/AHC1gxlNS3vCYCGrgiihsPulYd0tDbLOOP6ckbBhgqzj8s3yhHfovJGOnwVFPyr5Wdb/FnJqCfmD3z2jIXrxXly8xPE1gl5PDzLlbhrwPQWuDq06KU3Lh2DCQfs2B4OwFmBxCDN4HkotEF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772256625; c=relaxed/simple;
	bh=LlyluqpCLr8xXr4N+PaQww8E31YD6Woivb6MqoHtBZg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K8XuyC8plIPFGdOPIoD7kYU3u85dtmMVrzMYZy5WKwhOzBUngITYyTNXl26kwERe+KXQ4spqUi64GhRVUPXTedtDGpD60u5q90HAVCaaBJ/Ma+Vq13CAqbgoQDJOQoEeVsNskLdTO+ZwSfxF6eFFlUWfqDUOtq2R9mpW2IZFxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=did/jYkI; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="did/jYkI"
X-Virus-Scanned: Yes
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1772256619; bh=LlyluqpCLr8xXr4N+PaQww8E31YD6Woivb6MqoHtBZg=;
	h=Subject:From:In-Reply-To:Cc:References:To;
	b=did/jYkIh8EDIGSPB62s2bbP/2M8wvLE9//4cvW1n5hRtelckCqfOfwRRyAh1kEDH
	 OFbJon4UAOyQYk9+a6w4zPKis3+Uy6eDfFREnmSqOokY20prtdEBC1/jIQVwCj19be
	 uc7bNnorNZlrSoTwqZgDBKbgbU3KeuU+7AONvvHqUVmqy5r+u0G/WPB5EwEy/WFYtj
	 oxo+1QfcfI8vYKdrIRtigNsovzAGyHdwZmX/5WlE/uE+dFyr2q0DjFSCw28ctdIvfg
	 M5lDcWOkV3zFtvxrK+xcS3f9b4f5i4qs2qb3MadqOBJKfetrdEIF7d6yqr+02GlQ7E
	 7+WEf2Tawd7aKkBc51w5ZChT0typteNJd9rCPis4Bhwk06auDEurh54pYoT8Rp4dep
	 CejkVfG6ee+Y5gnxjGlrlrmPs/io8zqIQlfiNSoFoe4zuVWEuFteWKiDdhkiqGB+y0
	 LYrbWJ5hFLgfIbxJ1puOMIa5jxHxY4HNCazhLNQNsBxoXRtiWdpF4QZsMAqFfeVEUT
	 jOoqsSQm0hjIIyeWfPl3J/y51zb5KWrlsQhZdCFpnHtlIUROLDfJl95RsFVUQB/y86
	 Q4E7lMKY9KbeDe1u5uvKKOBrIrvD+aMApK2vWCFk4CB2MtmsSNnO12GmPDyYA6u8X5
	 Vmc8H/cBF6C9SaB5jDM4Yw9U=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] ublk: cleanup partition flags handling and
 introduce UBLK_F_NO_PARTITONS
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <aaJNp6Ga-EdscEny@fedora>
Date: Sat, 28 Feb 2026 07:30:06 +0200
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FFAFFDEB-59D2-4905-9696-B845EE56BF59@zazolabs.com>
References: <20260227145756.3877069-1-alex@zazolabs.com>
 <20260227145756.3877069-2-alex@zazolabs.com>
 <CADUfDZqo2KWB9aDjAgxwKQkJLK-TU1GuWtqcdLCnRpLrfMmHKg@mail.gmail.com>
 <aaJNp6Ga-EdscEny@fedora>
To: Ming Lei <ming.lei@redhat.com>



> On 28 Feb 2026, at 4:06, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Fri, Feb 27, 2026 at 10:29:56AM -0800, Caleb Sander Mateos wrote:
>> On Fri, Feb 27, 2026 at 7:07=E2=80=AFAM Alexander Atanasov =
<alex@zazolabs.com> wrote:
>>>=20
>>> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
>>> as it tries to use it as a switch for the auto partition scan.
>>> To fully disable creation of partitions GENHD_FL_NO_PART must
>>> be used, switch code to use it instead GD_SUPPRESS_PART_SCAN.
>>>=20
>>> Rules for partitions become:
>>> - Unprivileged daemons - never scan partitions, they have
>>> GENHD_FL_NO_PART always set - they are devices without partitions.
>>>=20
>>> - Trusted daemons - by default have partitions enabled,
>>> automatic initial scan can be disabled via UBLK_F_NO_AUTO_PART_SCAN =
flag.
>>> Partitions can be disabled via UBLK_F_NO_PARTITIONS flag.
>>>=20
>>> Rework the code to work as described above:
>>> - remove checks in ublk_partition_scan_work and rely on
>>> the caller to schedule the work only if it has to be done.
>>> - set GENHD_FL_NO_PART on unprivileged devices
>>> - set GENHD_FL_NO_PART depending on UBLK_F_NO_PARTITIONS on trusted
>>> devices.
>>>=20
>>> Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature =
flag")
>>> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
>>> ---
>>> drivers/block/ublk_drv.c      | 23 +++++++++--------------
>>> include/uapi/linux/ublk_cmd.h |  3 +++
>>> 2 files changed, 12 insertions(+), 14 deletions(-)
>>>=20
>>> -v1->v2:
>>>  - remove code duplication and extra flag settings
>>>  - switch from out-in to out-out to preserve backwards compatibility
>>>=20
>>>=20
>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>> index 3c918db4905c..36da63ba2a57 100644
>>> --- a/drivers/block/ublk_drv.c
>>> +++ b/drivers/block/ublk_drv.c
>>> @@ -81,6 +81,7 @@
>>>                | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? =
UBLK_F_INTEGRITY : 0) \
>>>                | UBLK_F_SAFE_STOP_DEV \
>>>                | UBLK_F_BATCH_IO \
>>> +               | UBLK_F_NO_PARTITIONS \
>>>                | UBLK_F_NO_AUTO_PART_SCAN)
>>>=20
>>> #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>>> @@ -2361,14 +2362,9 @@ static void ublk_partition_scan_work(struct =
work_struct *work)
>>>        if (!disk)
>>>                return;
>>>=20
>>> -       if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
>>> -                                            &disk->state)))
>>> -               goto out;
>>> -
>>>        mutex_lock(&disk->open_mutex);
>>>        bdev_disk_changed(disk, false);
>>>        mutex_unlock(&disk->open_mutex);
>>> -out:
>>>        ublk_put_disk(disk);
>>> }
>>>=20
>>> @@ -4409,10 +4405,10 @@ static int ublk_ctrl_start_dev(struct =
ublk_device *ub,
>>>         * wait while holding ub->mutex, which can deadlock with =
other
>>>         * operations that need the mutex. Defer partition scan to =
async
>>>         * work.
>>> -        * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set
>>> -        * permanently.
>>> +        * For unprivileged daemons, set GENHD_FL_NO_PART to
>>> +        * disable partitions.
>>>         */
>>> -       set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>>> +       disk->flags |=3D GENHD_FL_NO_PART;
>>>=20
>>>        ublk_get_device(ub);
>>>        ub->dev_info.state =3D UBLK_S_DEV_LIVE;
>>> @@ -4429,12 +4425,11 @@ static int ublk_ctrl_start_dev(struct =
ublk_device *ub,
>>>=20
>>>        set_bit(UB_STATE_USED, &ub->state);
>>>=20
>>> -       /* Skip partition scan if disabled by user */
>>> -       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
>>> -               clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>>> -       } else {
>>> -               /* Schedule async partition scan for trusted daemons =
*/
>>> -               if (!ub->unprivileged_daemons)
>>> +       if (!ub->unprivileged_daemons && !(ub->dev_info.flags & =
UBLK_F_NO_PARTITIONS)) {
>>> +               /* Enable partitions on device */
>>> +               disk->flags &=3D ~GENHD_FL_NO_PART;
>>=20
>> Is it safe to modify disk->flags after the disk has been added? This =
looks racy.
>=20
> Yeah, GENHD_FL_NO_PART should cover unprivileged_daemons & =
UBLK_F_NO_PARTITIONS only
> in static way.


Once set disk->flags are not modified anywhere. Where modifications are =
required then there is a disk->state.
No one inside the driver can touch the disk since the mutex is held.
Outside the driver flags are only checked.
add_disk(..) does not start any asynchronous operations, that=E2=80=99s =
the reason there is a work queue.
So where do you see a race ?


> Normal partition scanning still need GD_SUPPRESS_PART_SCAN.
>=20


static inline bool disk_has_partscan(struct gendisk *disk)
{
        return !(disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN)) &&
                !test_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
}


GD_SUPPRESS_PART_SCAN is a state.
GENHD_FL_NO_PART is permanent disable.

It is enough to prevent partition scanning triggered from add_disk(=E2=80=A6=
) and
that is the goal. I can=E2=80=99t see a reason to manage both as they =
effectively=20
do the same.



Regards,
Alexander Atanasov



