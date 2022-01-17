Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99EDC433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 08:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiAQICy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:02:54 -0500
Received: from m12-12.163.com ([220.181.12.12]:12901 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235363AbiAQICy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 03:02:54 -0500
X-Greylist: delayed 918 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 03:02:52 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=0xWEv
        jxkBNiGQJ1tJZJhccHXlw6lxvHUxfHle5nno3c=; b=d0rc4CBl6mOB3WIUjGPji
        Doex4OAgrRS9ARSRPEadhpmXXMtdBrVAWRv8qSyQKbcnqT+k5Mn7uoiJRbFJzgiO
        WS8riU9xOlKJBVZUDP7TxuRqqyPBZpBBQtMVQYerTXzr7e0teRAyVqSohRQe5yvK
        OudLZYgA+Op7+w9xQOhP/g=
Received: from smtpclient.apple (unknown [117.89.129.245])
        by smtp8 (Coremail) with SMTP id DMCowADnffLnHuVhT3yUAg--.24998S3;
        Mon, 17 Jan 2022 15:46:48 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [RFC PATCH 0/7] block: improve iops limit throttle
From:   163 <lining2020x@163.com>
X-Priority: 3
In-Reply-To: <d7c6f47.2d01.17e51b058cc.Coremail.lining2020x@163.com>
Date:   Mon, 17 Jan 2022 15:46:44 +0800
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>,
        "weijia.liu@transwarp.io" <weijia.liu@transwarp.io>,
        "chao.yang@transwarp.io" <chao.yang@transwarp.io>,
        ning.a.li@transwarp.io
Content-Transfer-Encoding: quoted-printable
Message-Id: <30812A09-5FB4-4ED0-81ED-CE80D82870B7@163.com>
References: <20220111115532.497117-1-ming.lei@redhat.com>
 <4666c796.5083.17e4d67bb88.Coremail.lining2020x@163.com>
 <d7c6f47.2d01.17e51b058cc.Coremail.lining2020x@163.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-CM-TRANSID: DMCowADnffLnHuVhT3yUAg--.24998S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xr4fWr1xXr1DZw13Xw15XFb_yoWxXF4Upa
        yfGa1agr18tF4DK3WSgwn09FWFv3yUArZxA3Z0g3y3AFyq9rn7trZrZr4F9F9FgF9ruF4F
        vw4kXay8KF1UX37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjksgUUUUU=
X-Originating-IP: [117.89.129.245]
X-CM-SenderInfo: polqx0bjsqjir06rljoofrz/1tbiLQiLNlSIoTcA0gAAsA
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

( Sorry for sending this mail again,  I am not sure you saw that for the =
last one was not in pure text format.)

Hi all,

In short, Ming=E2=80=99s patchset was tested against kernel master and =
works well.  Tested-by: lining <lining2020x@163.com>=20


The iops limit test result on thin-dm lv shows quite perfect and IO was =
much more smooth during the testing, very cool!=20

The origin issue is #bz2027241 named `cgroup2: wiops limit doesn't work =
when doing sequential write on a thin provisioned lv`,
There are more details about this issue and patch work in this bugzilla =
ticket [1].

Follows my test result and test script (iops was limit to 10 in my =
case):
- dm thin case test result: https://pastebin.com/raw/VgvB2TFY
- dm plain case test result: https://pastebin.com/raw/UVZMYjTp
- test script: https://pastebin.com/raw/YXEDH6Ss
=20
Here is my code tree info for testing:
```
root@ubuntu-r:~/backup/linux# git remote -v=20
origin	https://github.com/torvalds/linux.git (fetch)
origin	https://github.com/torvalds/linux.git (push)

root@ubuntu-r:~/backup/linux# git branch -a
* master
  remotes/origin/master

root@ubuntu-r:~/backup/linux# git log --oneline -10
9b977519b97c (HEAD -> master) block: revert 4f1e9630afe6 ("blk-throtl: =
optimize IOPS throttle for large IO scenarios")
36beefdf7492 block: don't try to throttle split bio if iops limit isn't =
set
722ff89df455 block: throttle split bio in case of iops limit
778b7c819d8c block: don't check bio in blk_throtl_dispatch_work_fn
c803548b4623 block: allow to bypass bio check before submitting bio
936bc02492c2 block: move blk_crypto_bio_prep() out of blk-mq.c
98e2c0e19ca6 block: move submit_bio_checks() into submit_bio_noacct
455e73a07f6e (origin/master) Merge tag 'clk-for-linus' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux

d9b5941bb593 Merge tag 'leds-5.17-rc1' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds

4eb766f64d12 Merge tag 'devicetree-for-5.17' of=20
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux

```


[1] bz2027241:  https://bugzilla.redhat.com/show_bug.cgi?id=3D2027241
=20
Thanks,
Ning

> 2022=E5=B9=B41=E6=9C=8813=E6=97=A5 =E4=B8=8B=E5=8D=8812:26=EF=BC=8CNing =
Li <lining2020x@163.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi all,
>=20
> The iops limit test result on thin-dm lv shows quite perfect, very =
cool!  Tested-by: lining <lining2020x@163.com>
>=20
> The origin issue is #bz2027241 named `cgroup2: wiops limit doesn't =
work when doing sequential write on a thin provisioned lv`,
> There are more details about this issue and patch work in this =
bugzilla ticket [1].
>=20
> Follows my test result and test script (iops was limit to 10 in my =
case):
> - dm thin case test result: https://pastebin.com/raw/VgvB2TFY
> - dm plain case test result: https://pastebin.com/raw/UVZMYjTp
> - test script: https://pastebin.com/raw/YXEDH6Ss
> =20
> Here is my code tree info for testing:
> ```
> root@ubuntu-r:~/backup/linux# git remote -v
> origin	https://github.com/torvalds/linux.git (fetch)
> origin	https://github.com/torvalds/linux.git (push)
>=20
> root@ubuntu-r:~/backup/linux# git branch -a
> * master
>   remotes/origin/master
>=20
> root@ubuntu-r:~/backup/linux# git log --oneline -10
> 9b977519b97c (HEAD -> master) block: revert 4f1e9630afe6 ("blk-throtl: =
optimize IOPS throttle for large IO scenarios")
> 36beefdf7492 block: don't try to throttle split bio if iops limit =
isn't set
> 722ff89df455 block: throttle split bio in case of iops limit
> 778b7c819d8c block: don't check bio in blk_throtl_dispatch_work_fn
> c803548b4623 block: allow to bypass bio check before submitting bio
> 936bc02492c2 block: move blk_crypto_bio_prep() out of blk-mq.c
> 98e2c0e19ca6 block: move submit_bio_checks() into submit_bio_noacct
> 455e73a07f6e (origin/master) Merge tag 'clk-for-linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> d9b5941bb593 Merge tag 'leds-5.17-rc1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds
> 4eb766f64d12 Merge tag 'devicetree-for-5.17' of =
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> ```
>=20
>=20
> [1] bz2027241:  https://bugzilla.redhat.com/show_bug.cgi?id=3D2027241
> =20
> Thanks,
> Ning
>=20
>=20
> At 2022-01-12 16:29:10, "Ning Li" <lining2020x@163.com> wrote:
>=20
> Cool, I will test it later.
>=20
> Thanks,=20
> Ning
> At 2022-01-11 19:55:25, "Ming Lei" <ming.lei@redhat.com> wrote:
> >Hello Guys,
> >
> >Lining reported that iops limit throttle doesn't work on dm-thin, =
also
> >iops limit throttle works bad on plain disk in case of excessive =
split.
> >
> >Commit 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO =
scenarios")
> >was for addressing this issue, but the taken approach is just to run
> >post-accounting, then current split bios won't be throttled actually,
> >so actual iops throttle result isn't good in case of excessive bio
> >splitting.
> >
> >The 1st two patches are cleanup.
> >
> >The 3rd and 4th patches add one new helper of __submit_bio_noacct() =
for
> >blk_throtl_dispatch_work_fn(), so that bios won't be throttled any =
more
> >when blk-throttle code dispatches throttled bios.
> >
> >The 5th and 6th patch makes the real difference for throttling split =
bio wrt.
> >iops limit.
> >
> >The last patch is to revert commit 4f1e9630afe6 ("blk-throtl: =
optimize IOPS
> >throttle for large IO scenarios").
> >
> >Lining, you should get exact IOPS throttling in your dm-thin test =
with
> >this patchset, please test and feedback.
> >
> >
> >Ming Lei (7):
> >  block: move submit_bio_checks() into submit_bio_noacct
> >  block: move blk_crypto_bio_prep() out of blk-mq.c
> >  block: allow to bypass bio check before submitting bio
> >  block: don't check bio in blk_throtl_dispatch_work_fn
> >  block: throttle split bio in case of iops limit
> >  block: don't try to throttle split bio if iops limit isn't set
> >  block: revert 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for
> >    large IO scenarios")
> >
> > block/blk-core.c       | 32 +++++++++-------------
> > block/blk-merge.c      |  2 --
> > block/blk-mq.c         |  3 ---
> > block/blk-throttle.c   | 61 =
+++++++++++++++---------------------------
> > block/blk-throttle.h   | 16 ++++++-----
> > include/linux/blkdev.h |  7 ++++-
> > 6 files changed, 51 insertions(+), 70 deletions(-)
> >
> >--=20
> >2.31.1
>=20
>=20
>=20
> =20
>=20
>=20
> =20

