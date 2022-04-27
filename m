Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A69C433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 07:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358973AbiD0Hov (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358974AbiD0Hot (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 03:44:49 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9641B2FFCE
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 00:41:37 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D39F45C020C;
        Wed, 27 Apr 2022 03:41:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Apr 2022 03:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1651045296; x=1651131696; bh=Fs
        ENXXhdJVzCfn5vl1nmZjeXmyKietzVHvN42bHy9oU=; b=LYrNdbjdXzfgeJGATU
        pqZ7shgmY5K8YMUEIySowPIlXfiw62+3havSrLOcaVvefibYUn6EfzE3xu/FsdH/
        6m7BC9S6kCW6UWjCrRGwVBGTinSBXWqrN0gh+wvTvYq1EdWP0l3DBSEnKlWAIvUy
        YQZZ/TyEc18fsVUuqJ8+BDZ4aSEJ1BVRlLp4a4u5Li79XayiysS+iJmifCJirOyt
        8PFaV6BoE7KhtD+B16qGv2fXXWvrDFfgu4HZlMV15NJY/D/AoXfVG8WlCbeM6gI4
        U2NFZNX8G/pg6eP+ga6DvakoORgN6tEABJ3Razvi1s2khz7+aUuL7d0fbdMDT0R5
        szRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651045296; x=
        1651131696; bh=FsENXXhdJVzCfn5vl1nmZjeXmyKietzVHvN42bHy9oU=; b=v
        uEso3Qm18aaWyFspKwbQl0v5A6KfumW98RssJBlGekTNzW6Q2LyGTqSK48/n+PNH
        nzaF1LaIa/MJdGeY7GApneP+xU6KLXuWuY0vLl+n/K2orhrHPjf3KTJ5srt5Fjne
        QngH0skoqS5C2JTlEoTKB4cY4CjpOjJy48DXXfayPi3STLk6DSEmYF6aK86JRaG8
        4b9vrn+HE244gntgKLCfnDi/f+Nhm0APBkihWZjTUG608ZW3TnYTiZjVT4PECr7s
        ioz9LpPGpTO6YMWWdA5OfBz3qXMOr6kksdOvWY+xlu3hR4fQeJ9jZlQjWuIJbzCa
        O9+gK0Qq52GLk3fTkrzFQ==
X-ME-Sender: <xms:r_NoYr4wARTm4FJr1uJfkYBOUaqHgRqv7-1pAtIMhMfqcYJU0KaO3A>
    <xme:r_NoYg6RapG0eK_kAcW97fvXfUJB5QJN6uIahr5f5n0ElV41sZs2rWY_psOKKxj9Q
    DJo43soZ84Rjs4KZg4>
X-ME-Received: <xmr:r_NoYiev-nwPdNcoa1V-Q6DL_oQ9U8Ylv6VlLNAlos3dPzGGwYXqGI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeggdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghu
    shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
    htvghrnhepjefgjeefffdvuefhieefhffggfeuleehudekveejvedtuddugeeigeetffff
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:r_NoYsIJ8f6Umm7bnPSmHFltcEtyK4LnSPnpC_a5YH0SwXtyDJ11AA>
    <xmx:r_NoYvI3gZIJoiUMhyWYQlghjrzhGq2PIEkxjdl5rjggdmqObd92jw>
    <xmx:r_NoYlzaRmmIo4GEEaQhsGt4c7CyKEKJ48s6cpdmtWWGT-Ef9zssyQ>
    <xmx:sPNoYsp68q2BGCvrWspNzdv_LMVraXPOpyBi5GnlHyfy1JF0-iVdkg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Apr 2022 03:41:33 -0400 (EDT)
Date:   Wed, 27 Apr 2022 09:41:32 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Message-ID: <YmjzrLo0/zW3Ou03@apples>
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
 <20220420055429.t5ni7yah4p4yxgsq@shindev>
 <YmGbo5Pvv9bOMqmt@bombadil.infradead.org>
 <20220427050825.rkn633nevijh3ux5@shindev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R9u7S9q74UjXJBtA"
Content-Disposition: inline
In-Reply-To: <20220427050825.rkn633nevijh3ux5@shindev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--R9u7S9q74UjXJBtA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 27 05:08, Shinichiro Kawasaki wrote:
> On Apr 21, 2022 / 11:00, Luis Chamberlain wrote:
> > On Wed, Apr 20, 2022 at 05:54:29AM +0000, Shinichiro Kawasaki wrote:
> > > On Apr 14, 2022 / 15:02, Luis Chamberlain wrote:
> > > > Hey folks,
> > > >=20
> > > > While enhancing kdevops [0] to embrace automation of testing with
> > > > blktests for ZNS I ended up spotting a possible false positive RCU =
stall
> > > > when running zbd/006 after zbd/005. The curious thing though is that
> > > > this possible RCU stall is only possible when using the qemu
> > > > ZNS drive, not when using nbd. In so far as kdevops is concerned
> > > > it creates ZNS drives for you when you enable the config option
> > > > CONFIG_QEMU_ENABLE_NVME_ZNS=3Dy. So picking any of the ZNS drives
> > > > suffices. When configuring blktests you can just enable the zbd
> > > > guest, so only a pair of guests are reated the zbd guest and the
> > > > respective development guest, zbd-dev guest. When using
> > > > CONFIG_KDEVOPS_HOSTS_PREFIX=3D"linux517" this means you end up with
> > > > just two guests:
> > > >=20
> > > >   * linux517-blktests-zbd
> > > >   * linux517-blktests-zbd-dev
> > > >=20
> > > > The RCU stall can be triggered easily as follows:
> > > >=20
> > > > make menuconfig # make sure to enable CONFIG_QEMU_ENABLE_NVME_ZNS=
=3Dy and blktests
> > > > make
> > > > make bringup # bring up guests
> > > > make linux # build and boot into v5.17-rc7
> > > > make blktests # build and install blktests
> > > >=20
> > > > Now let's ssh to the guest while leaving a console attached
> > > > with `sudo virsh vagrant_linux517-blktests-zbd` in a window:
> > > >=20
> > > > ssh linux517-blktests-zbd
> > > > sudo su -
> > > > cd /usr/local/blktests
> > > > export TEST_DEVS=3D/dev/nvme9n1
> > > > i=3D0; while true; do ./check zbd/005 zbd/006; if [[ $? -ne 0 ]]; t=
hen echo "BAD at $i"; break; else echo GOOOD $i ; fi; let i=3D$i+1; done;
> > > >=20
> > > > The above should never fail, but you should eventually see an RCU
> > > > stall candidate on the console. The full details can be observed on=
 the
> > > > gist [1] but for completeness I list some of it below. It may be a =
false
> > > > positive at this point, not sure.
> > > >=20
> > > > [493272.711271] run blktests zbd/005 at 2022-04-14 20:03:22
> > > > [493305.769531] run blktests zbd/006 at 2022-04-14 20:03:55
> > > > [493336.979482] nvme nvme9: I/O 192 QID 5 timeout, aborting
> > > > [493336.981666] nvme nvme9: Abort status: 0x0
> > > > [493367.699440] nvme nvme9: I/O 192 QID 5 timeout, reset controller
> > > > [493388.819341] rcu: INFO: rcu_preempt detected stalls on CPUs/task=
s:
> > >=20
> > > Hello Luis,
> > >=20
> > > I run blktests zbd group on several QEMU ZNS emulation devices for ev=
ery rcX
> > > kernel releases. But, I have not ever observed the symptom above. Now=
 I'm
> > > repeating zbd/005 and zbd/006 using v5.18-rc3 and a QEMU ZNS device, =
and do
> > > not observe the symptom so far, after 400 times repeat.
> >=20
> > Did you try v5.17-rc7 ?
>=20
> I hadn't tried it. Then I tried v5.17-rc7 and observed the same symptom.
>=20
> >=20
> > > I would like to run the test using same ZNS set up as yours. Can you =
share how
> > > your ZNS device is set up? I would like to know device size and QEMU =
-device
> > > options, such as zoned.zone_size or zoned.max_active.
> >=20
> > It is as easy as the above make commands, and follow up login commands.
>=20
> I managed to run kdevops on my machine, and saw the I/O timeout and abort
> messages. Using similar QEMU ZNS set up as kdevops, the messages were rec=
reated
> in my test environment also (the reset controller message and RCU relegat=
ed
> error were not observed).
>=20

Can you extract the relevant part of the QEMU parameters? I tried to
reproduce this, but could not with a 10G, neither with discard=3Don or
off, qcow2 or raw.

> [  214.134083][ T1028] run blktests zbd/005 at 2022-04-22 21:29:54
> [  246.383978][ T1142] run blktests zbd/006 at 2022-04-22 21:30:26
> [  276.784284][  T386] nvme nvme6: I/O 494 QID 4 timeout, aborting
> [  276.788391][    C0] nvme nvme6: Abort status: 0x0
>=20
> The conditions to recreate the I/O timeout error are as follows:
>=20
> - Larger size of QEMU ZNS drive (10GB)
>     - I use QEMU ZNS drives with 1GB size for my test runs. With this sma=
ller
>       size, the I/O timeout is not observed.
>=20
> - Issue zone reset command for all zones (with 'blkzone reset' command) j=
ust
>   after zbd/005 completion to the drive.
>     - The test case zbd/006 calls the zone reset command. It's enough to =
repeat
>       zbd/005 and zone reset command to recreate the I/O timeout.
>     - When 10 seconds sleep is added between zbd/005 run and zone reset c=
ommand,
>       the I/O timeout was not observed.
>     - The data write pattern of zbd/005 looks important. Simple dd comman=
d to
>       fill the device before 'blkzone reset' did not recreate the I/O tim=
eout.
>=20
> I dug into QEMU code and found that it takes long time to complete zone r=
eset
> command with all zones flag. It takes more than 30 seconds and looks trig=
gering
> the I/O timeout in the block layer. The QEMU calls fallocate punch hole t=
o the
> backend file for each zone, so that data of each zone is zero cleared. Ea=
ch
> fallocate call is quick but between the calls, 0.7 second delay was obser=
ved
> often. I guess some fsync or fdatasync operation would be running and cau=
sing
> the delay.
>=20

QEMU uses a write zeroes for zone reset. This is because of the
requirement that block in empty zones must be considered deallocated.

When the drive is configured with `discard=3Don`, these write zeroes
*should* turn into discards. However, I also tested with discard=3Doff and
I could not reproduce it.

It might make sense to force QEMU to use a discard for zone reset in all
cases, and then change the reported DLFEAT appropriately, since we
cannot guarantee zeroes then.

> In other words, QEMU ZNS zone reset for all zones is so slow depending on=
 the
> ZNS drive's size and status. Performance improvement of zone reset is des=
ired in
> QEMU. I will seek for the chance to work on it.
>=20

Currently, each zone is a separate discard/write zero call. It would be
fair to special case all zones and do it in much larger chunks.

--R9u7S9q74UjXJBtA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmJo86cACgkQTeGvMW1P
DenxDgf4nGFjRDTQZsvH3TNZdhqwupCMmfovFAzfb5+f1OeP7RtI6uwS6NjFUCKE
navIdZ1gGfPI44A6FbikBF47TWvbUGOAg8p/bgbNNKUvLu2RvIuJ++opNV2GvuDM
e6o4hveSMAlBDACEHQBtcS1JSf7qtRqzqEnQdgQ7E2c8VS6fbPbI+GsUYGdB4Djr
8z/+OzMGNfRf3zkb39PMpVIIxJz2s6Gbs+9aWwZkpbZGzQXCTSEJVjjMJyu3pf9L
tYT9wJg1stkixmkO6PTBTEka4UsiquOIglER0JhODYstIoisbHLjY2iqBvgyTPwC
5pFzw+9De/ZovWWByj5yzCLiF/ne
=2twX
-----END PGP SIGNATURE-----

--R9u7S9q74UjXJBtA--
