Return-Path: <linux-block-owner@vger.kernel.org>
Received: from pv33p36im-asmtp001.me.com ([17.142.213.62]:57896 "EHLO
        pv33p36im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeBWDd3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 22:33:29 -0500
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] blk-throttle: avoid multiple counting for same bio
From: Chengguang Xu <cgxu519@icloud.com>
In-reply-to: <20180213144314.GP695913@devbig577.frc2.facebook.com>
Date: Fri, 23 Feb 2018 11:33:08 +0800
Cc: axboe@fb.com, shli@fb.com, vgoyal@redhat.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Message-id: <E42EF2AF-710E-4783-BFFE-D77502B4E04C@icloud.com>
References: <1518504350-139546-1-git-send-email-cgxu519@icloud.com>
 <20180213144314.GP695913@devbig577.frc2.facebook.com>
To: Tejun Heo <tj@kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Tejun,

Sorry for delayed reply, I was on vacation last week.

The problem still exists in current code of 4.16.0-rc2,=20
detail test information is below, if further info is needed please let =
me know.

Thanks.

=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
Both read/write bps are limited to 10MB/s in blkio cgroup v1 & v2

$ uname -r
4.16.0-rc2+


[Without this patch]----------------------------------------

CGROUP V1 (direct write):

$ dd if=3D/dev/zero of=3D/mnt/sdb1/20/test bs=3D1M count=3D1024 =
oflag=3Ddirect
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 102.402 s, 10.5 MB/s

8:16 Read 16384
8:16 Write 2684354560
8:16 Sync 2684370944
8:16 Async 0
8:16 Total 2684370944

CGROUP V1 (read):

$ dd if=3D/mnt/sdb1/20/test of=3D/dev/zero bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 102.412 s, 10.5 MB/s

8:16 Read 4831838208
8:16 Write 0
8:16 Sync 4831838208
8:16 Async 0
8:16 Total 4831838208


CGROUP V2 (direct write):

$ cat io.max
8:16 rbps=3Dmax wbps=3D10485760 riops=3Dmax wiops=3Dmax

$ dd if=3D/dev/zero of=3D/mnt/sdb1/20/test bs=3D1M count=3D1024 =
oflag=3Ddirect
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 102.408 s, 10.5 MB/s

8:16 rbytes=3D24576 wbytes=3D2684354560 rios=3D5 wios=3D4096


CGROUP V2 (buffered write):

$ dd if=3D/dev/zero of=3D/mnt/sdb1/20/test bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 0.637822 s, 1.7 GB/s

8:16 rbytes=3D0 wbytes=3D4831838208 rios=3D0 wios=3D4096

CGROUP V2 (read):

$ cat io.max
8:16 rbps=3D10485760 wbps=3Dmax riops=3Dmax wiops=3Dmax

$ dd if=3D/mnt/sdb1/20/test of=3D/dev/zero bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 102.409 s, 10.5 MB/s

8:16 rbytes=3D4831846400 wbytes=3D0 rios=3D4097 wios=3D0

[With this patch]----------------------------------------

CGROUP V1 (direct write):

$ dd if=3D/dev/zero of=3D/mnt/sdb1/20/test bs=3D1M count=3D1024 =
oflag=3Ddirect
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 102.402 s, 10.5 MB/s

8:16 Read 24576
8:16 Write 1073741824
8:16 Sync 1073766400
8:16 Async 0
8:16 Total 1073766400

CGROUP V1 (read):

$ dd if=3D/mnt/sdb1/20/test of=3D/dev/zero bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 102.406 s, 10.5 MB/s

8:16 Read 1073741824
8:16 Write 0
8:16 Sync 1073741824
8:16 Async 0
8:16 Total 1073741824

CGROUP V2 (direct write):

$ dd if=3D/dev/zero of=3D/mnt/sdb1/20/test bs=3D1M count=3D1024 =
oflag=3Ddirect
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 102.407 s, 10.5 MB/s

8:16 rbytes=3D16384 wbytes=3D1073741824 rios=3D4 wios=3D1024


CGROUP V2 (buffered write):

$ dd if=3D/dev/zero of=3D/mnt/sdb1/20/test bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 0.650783 s, 1.6 GB/s

8:16 rbytes=3D0 wbytes=3D1073741824 rios=3D0 wios=3D512

CGROUP V2 (read):

$ dd if=3D/mnt/sdb1/20/test of=3D/dev/zero bs=3D1M count=3D1024
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 102.411 s, 10.5 MB/s

8:16 rbytes=3D1077314048 wbytes=3D0 rios=3D572 wios=3D0


=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94


> =E5=9C=A8 2018=E5=B9=B42=E6=9C=8813=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=881=
0:43=EF=BC=8CTejun Heo <tj@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Feb 13, 2018 at 02:45:50PM +0800, Chengguang Xu wrote:
>> In current throttling/upper limit policy of blkio cgroup
>> blkio.throttle.io_service_bytes does not exactly represent
>> the number of bytes issued to the disk by the group, sometimes
>> this number could be counted multiple times of real bytes.
>> This fix introduces BIO_COUNTED flag to avoid multiple counting
>> for same bio.
>>=20
>> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
>=20
> We had a series of fixes / changes for this problem during the last
> cycle.  Can you please see whether the current linus master has the
> same problem.
>=20
> Thanks.
>=20
> --=20
> tejun
