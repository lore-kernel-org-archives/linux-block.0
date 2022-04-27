Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC993C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 08:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiD0I6s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 04:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiD0I6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 04:58:47 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225AE109D97
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 01:55:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0BADA5C019B;
        Wed, 27 Apr 2022 04:55:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 27 Apr 2022 04:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1651049733; x=1651136133; bh=9K
        qvwk8DuG21amaS1dU1Tj+9i2baaFbdlJEWjDdCtjI=; b=SYipdKNvG2yxISFXJU
        6qWiOWEoStR7+wNyVlnL83ko20oVyeyOhMM2Du6o6TdiYIPU69Ny9vNyCwQb5U5b
        XpySjMFYuPA9GgK4ttM/g0aVxYhv01ge9kiqIN+lUexXTPxa5xjSB0Py3YjjP2tQ
        jv4PAFnEBKDyiGngJ//10KCFK6t25PTTQu57r/+l98yo1haki2CDb4KZ1cMVNbBz
        ZoTKg6qWd9KUqZyTIXE2mSO1s7PWjvpSXFKi1+zkn2C+cyaxQG8/w3oq6IS0Nc5v
        HK8AV4+EiP46FDVvcFhkgyyDrYx/Oehnikyajuj5+95M3XJBGEDshuFq0/hqRRQZ
        B26g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651049733; x=
        1651136133; bh=9Kqvwk8DuG21amaS1dU1Tj+9i2baaFbdlJEWjDdCtjI=; b=a
        zmQG/As8AOQOsvoSTYVaUGo2cXZt6SULeuNz0g/TWBeOIlvnZPX009PmtqJY6MY3
        0rX3q91vXZw15LDOXYfC/4pE3z+33QqJhtVeEMPtBBZYefeotUqYfpZg/yR6H6oe
        ouQzTRYKiqBnp7vXw9sgG5mm0yHU7EEXXDlfyK17AFDlpF6YQ5pz9SP4WH9qtqQJ
        6XQwTlrWGdFY6hUlECBJnIP5tjsWRdl+c8lI9mjCosFiMYh/95tDqT11dqSCAGkO
        5J8QoIUkBKqG444grMDFC6xX7RenbL62nXBUIqF+bHMz+cr+y5JtVrmBy+orLwXh
        +3+ZgGSnajQcazTPcDuJA==
X-ME-Sender: <xms:BAVpYrp0wAcpoSUPHCboHqqZCh6e1nJ7WBENoYxwPPBJrbAz98QtFw>
    <xme:BAVpYlrrPmU4QIGl4wVfGW0YIdkdYkhwaewTjbrLcYG8oQDoiDoSptJhS5KdHb3ue
    mEKW8LKSTCLGvEiSTg>
X-ME-Received: <xmr:BAVpYoNplZ1wjLXarFrTm04HnEPp-HYFKPsn0EmjNcNZFw3EYd2G1XM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhs
    ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
    gvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffej
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehith
    hssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:BAVpYu4KEXlX8IJKyWx4k3r0sa70bXnZ2bqmT_2R7LlO5oJGN3p1EQ>
    <xmx:BAVpYq4_v48oJpIzu24C0OD0R7vJC59M2FEYEU2N01-DhFA2NoO_JQ>
    <xmx:BAVpYmgN8yCZ7akyAF88flpVc8EQzEOWaZJw4W7Yt4uMCug3vjCUpA>
    <xmx:BQVpYsu4zVTvxrjboWMffj0Jt1f_tVbgM9dBTrQfiqznZvVuP7ax6Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Apr 2022 04:55:30 -0400 (EDT)
Date:   Wed, 27 Apr 2022 10:55:29 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Message-ID: <YmkFAYXL/xgBSMA8@apples>
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
 <20220420055429.t5ni7yah4p4yxgsq@shindev>
 <YmGbo5Pvv9bOMqmt@bombadil.infradead.org>
 <20220427050825.rkn633nevijh3ux5@shindev>
 <YmjzrLo0/zW3Ou03@apples>
 <a57a8b0a-f5fd-6925-89e4-68b90ea5d387@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="alnHZZi+cva+bVFj"
Content-Disposition: inline
In-Reply-To: <a57a8b0a-f5fd-6925-89e4-68b90ea5d387@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--alnHZZi+cva+bVFj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 27 17:39, Damien Le Moal wrote:
> On 4/27/22 16:41, Klaus Jensen wrote:
> > On Apr 27 05:08, Shinichiro Kawasaki wrote:
> >> On Apr 21, 2022 / 11:00, Luis Chamberlain wrote:
> >>> On Wed, Apr 20, 2022 at 05:54:29AM +0000, Shinichiro Kawasaki wrote:
> >>>> On Apr 14, 2022 / 15:02, Luis Chamberlain wrote:
> >>>>> Hey folks,
> >>>>>
> >>>>> While enhancing kdevops [0] to embrace automation of testing with
> >>>>> blktests for ZNS I ended up spotting a possible false positive RCU =
stall
> >>>>> when running zbd/006 after zbd/005. The curious thing though is that
> >>>>> this possible RCU stall is only possible when using the qemu
> >>>>> ZNS drive, not when using nbd. In so far as kdevops is concerned
> >>>>> it creates ZNS drives for you when you enable the config option
> >>>>> CONFIG_QEMU_ENABLE_NVME_ZNS=3Dy. So picking any of the ZNS drives
> >>>>> suffices. When configuring blktests you can just enable the zbd
> >>>>> guest, so only a pair of guests are reated the zbd guest and the
> >>>>> respective development guest, zbd-dev guest. When using
> >>>>> CONFIG_KDEVOPS_HOSTS_PREFIX=3D"linux517" this means you end up with
> >>>>> just two guests:
> >>>>>
> >>>>>   * linux517-blktests-zbd
> >>>>>   * linux517-blktests-zbd-dev
> >>>>>
> >>>>> The RCU stall can be triggered easily as follows:
> >>>>>
> >>>>> make menuconfig # make sure to enable CONFIG_QEMU_ENABLE_NVME_ZNS=
=3Dy and blktests
> >>>>> make
> >>>>> make bringup # bring up guests
> >>>>> make linux # build and boot into v5.17-rc7
> >>>>> make blktests # build and install blktests
> >>>>>
> >>>>> Now let's ssh to the guest while leaving a console attached
> >>>>> with `sudo virsh vagrant_linux517-blktests-zbd` in a window:
> >>>>>
> >>>>> ssh linux517-blktests-zbd
> >>>>> sudo su -
> >>>>> cd /usr/local/blktests
> >>>>> export TEST_DEVS=3D/dev/nvme9n1
> >>>>> i=3D0; while true; do ./check zbd/005 zbd/006; if [[ $? -ne 0 ]]; t=
hen echo "BAD at $i"; break; else echo GOOOD $i ; fi; let i=3D$i+1; done;
> >>>>>
> >>>>> The above should never fail, but you should eventually see an RCU
> >>>>> stall candidate on the console. The full details can be observed on=
 the
> >>>>> gist [1] but for completeness I list some of it below. It may be a =
false
> >>>>> positive at this point, not sure.
> >>>>>
> >>>>> [493272.711271] run blktests zbd/005 at 2022-04-14 20:03:22
> >>>>> [493305.769531] run blktests zbd/006 at 2022-04-14 20:03:55
> >>>>> [493336.979482] nvme nvme9: I/O 192 QID 5 timeout, aborting
> >>>>> [493336.981666] nvme nvme9: Abort status: 0x0
> >>>>> [493367.699440] nvme nvme9: I/O 192 QID 5 timeout, reset controller
> >>>>> [493388.819341] rcu: INFO: rcu_preempt detected stalls on CPUs/task=
s:
> >>>>
> >>>> Hello Luis,
> >>>>
> >>>> I run blktests zbd group on several QEMU ZNS emulation devices for e=
very rcX
> >>>> kernel releases. But, I have not ever observed the symptom above. No=
w I'm
> >>>> repeating zbd/005 and zbd/006 using v5.18-rc3 and a QEMU ZNS device,=
 and do
> >>>> not observe the symptom so far, after 400 times repeat.
> >>>
> >>> Did you try v5.17-rc7 ?
> >>
> >> I hadn't tried it. Then I tried v5.17-rc7 and observed the same sympto=
m.
> >>
> >>>
> >>>> I would like to run the test using same ZNS set up as yours. Can you=
 share how
> >>>> your ZNS device is set up? I would like to know device size and QEMU=
 -device
> >>>> options, such as zoned.zone_size or zoned.max_active.
> >>>
> >>> It is as easy as the above make commands, and follow up login command=
s.
> >>
> >> I managed to run kdevops on my machine, and saw the I/O timeout and ab=
ort
> >> messages. Using similar QEMU ZNS set up as kdevops, the messages were =
recreated
> >> in my test environment also (the reset controller message and RCU rele=
gated
> >> error were not observed).
> >>
> >=20
> > Can you extract the relevant part of the QEMU parameters? I tried to
> > reproduce this, but could not with a 10G, neither with discard=3Don or
> > off, qcow2 or raw.
> >=20
> >> [  214.134083][ T1028] run blktests zbd/005 at 2022-04-22 21:29:54
> >> [  246.383978][ T1142] run blktests zbd/006 at 2022-04-22 21:30:26
> >> [  276.784284][  T386] nvme nvme6: I/O 494 QID 4 timeout, aborting
> >> [  276.788391][    C0] nvme nvme6: Abort status: 0x0
> >>
> >> The conditions to recreate the I/O timeout error are as follows:
> >>
> >> - Larger size of QEMU ZNS drive (10GB)
> >>     - I use QEMU ZNS drives with 1GB size for my test runs. With this =
smaller
> >>       size, the I/O timeout is not observed.
> >>
> >> - Issue zone reset command for all zones (with 'blkzone reset' command=
) just
> >>   after zbd/005 completion to the drive.
> >>     - The test case zbd/006 calls the zone reset command. It's enough =
to repeat
> >>       zbd/005 and zone reset command to recreate the I/O timeout.
> >>     - When 10 seconds sleep is added between zbd/005 run and zone rese=
t command,
> >>       the I/O timeout was not observed.
> >>     - The data write pattern of zbd/005 looks important. Simple dd com=
mand to
> >>       fill the device before 'blkzone reset' did not recreate the I/O =
timeout.
> >>
> >> I dug into QEMU code and found that it takes long time to complete zon=
e reset
> >> command with all zones flag. It takes more than 30 seconds and looks t=
riggering
> >> the I/O timeout in the block layer. The QEMU calls fallocate punch hol=
e to the
> >> backend file for each zone, so that data of each zone is zero cleared.=
 Each
> >> fallocate call is quick but between the calls, 0.7 second delay was ob=
served
> >> often. I guess some fsync or fdatasync operation would be running and =
causing
> >> the delay.
> >>
> >=20
> > QEMU uses a write zeroes for zone reset. This is because of the
> > requirement that block in empty zones must be considered deallocated.
> >=20
> > When the drive is configured with `discard=3Don`, these write zeroes
> > *should* turn into discards. However, I also tested with discard=3Doff =
and
> > I could not reproduce it.
> >=20
> > It might make sense to force QEMU to use a discard for zone reset in all
> > cases, and then change the reported DLFEAT appropriately, since we
> > cannot guarantee zeroes then.
>=20
> Why not punch a hole in the backing store file with fallocate() with mode
> set to FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE ? That would be way
> faster than a write zeroes which potentially actually do the writes,
> leading to large command processing times. Reading in a hole in a file is
> guaranteed to return zeroes, at least on Linux.
>=20

In almost all cases, that is what QEMU will do since we set the
BDRV_REQ_MAY_UNMAP flag.

> If the backingstore is a block device, then sure, write zeroes is the only
> solution. Discard should be used with caution since that is a hint only
> and some drives may actually do nothing.
>=20

Yes, that is why we do it with an explicit write zeroes which guarantees
zeroing behavior regardless of if or not discards "do something" (this
depends on the underlying block implementation).

> >=20
> >> In other words, QEMU ZNS zone reset for all zones is so slow depending=
 on the
> >> ZNS drive's size and status. Performance improvement of zone reset is =
desired in
> >> QEMU. I will seek for the chance to work on it.
> >>
> >=20
> > Currently, each zone is a separate discard/write zero call. It would be
> > fair to special case all zones and do it in much larger chunks.
>=20
> Yep, for a backing file, a full file fallocate(FALLOC_FL_PUNCH_HOLE) would
> do nicely. Or truncate(0) + truncate(storage size) would do too.
>=20
> Since resets are always all zones or one zone, special optimized handling
> of the reset all case will definitely have huge benefits for that command.
>=20

Yes. I think that is the best approach. While we might reset a bunch of
zones that are already empty, it should speed things up substantially.

--alnHZZi+cva+bVFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmJpBP4ACgkQTeGvMW1P
DeneBwgAoy8g0qX+k6QGxraLHEm/LUw20M6/iSvGzAWNV+YLy7FuGbtH+DgDWO87
ga7dCyvaFLGp+vAvnf+YwFXhudRxs7FWbAphyfKD2UBfdrJQytgxON5zLYmYMJLI
ZMrZgqIWbh3ZMQvOQNFhnPPzFOsroeMxIgXgB7jqYvDWErO8VAoSu1cZ5hdLPHfT
2WvJ2jecVolKYcfRkGQLRe8MDmFkXhmfvlspyCQ/FoQKnuHPfrcXaBtpsgeduk+G
2Mc5vYpZ2X75/unVKDPp2XHxFgVyg9rJfvQKZUpmfJL9OYiR59KRf+28hUdOeEoP
ckfcuEvKEsHcHONvf/nHbh8e/6o6RQ==
=KCmA
-----END PGP SIGNATURE-----

--alnHZZi+cva+bVFj--
