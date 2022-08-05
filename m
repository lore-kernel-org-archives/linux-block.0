Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6F2C19F2D
	for <linux-block@archiver.kernel.org>; Fri,  5 Aug 2022 01:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiHEByg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Aug 2022 21:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiHEByf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Aug 2022 21:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9EB4101D0
        for <linux-block@vger.kernel.org>; Thu,  4 Aug 2022 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659664471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y7IhJ1I8ah4rV6RHwLX4QE30pMbYUMMqZT9Ptmd/kFY=;
        b=KBc/W/GKQRq9LeVHbgFup1aJ3S+Yu8C+7bCgeN65s19ePlVjW4EF4Xm0kCoyzuF0iZrbZ+
        u+SZ5q/0mtpvTmO6PX84FHvEOOoMZv23ay2UrbMcjWNhq4uxsD/EQpMXpBKCtbpxs7BYHn
        bKO/XwKWcF4U8TpdXMaABvbyP2jget8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-531-KTYT6FOJOHWR4cThxmuGvA-1; Thu, 04 Aug 2022 21:54:27 -0400
X-MC-Unique: KTYT6FOJOHWR4cThxmuGvA-1
Received: by mail-ed1-f71.google.com with SMTP id m22-20020a056402431600b0043d6a88130aso728319edc.18
        for <linux-block@vger.kernel.org>; Thu, 04 Aug 2022 18:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=y7IhJ1I8ah4rV6RHwLX4QE30pMbYUMMqZT9Ptmd/kFY=;
        b=Ufad3O6dwZLfLSdZqAz8YO5QfK7zxOXGtA7p/X4UNweDmyRO6neXWOToLKdn4VEbMq
         iviAzC4WBLx6lnYIZ7PH3EMZlHFghz1VSXaAWLYWu2t72tZoobgC9qXEeblNIOpGk5Lk
         twbz4pjXUfy5quUZxUMCsYykyqM3Pj+XktJwHZYyPM9tvbRQ1g7gIXSOCP14UVWznOPi
         Qxy/FX2RPudIEJmxFrSW5Y+CJ+eB454cLszpizZuVX/ox1nOkAxgWQ/eyyU5nr9A6dXx
         6AccZJiHVm8fYwA4u3pNdOlGgD4/3l0BMVDHaz1+IICJl3DZkjia4KjEHjQRRyNEU7uO
         5wTg==
X-Gm-Message-State: ACgBeo1UEuqGWh07ctMiRGEfDGEr3JrPtK7528MD7EawMZs49ghmVW6M
        nB1gvD4YObriKkxCA7+RSLC+n+LdmbX9FNqMhwDh8se6xrn7OurxHzOXm1GrZ1udIsgBw8u/zG+
        R0fTCM+fp0V405g7pwXNivLcu2Wl2IQ26JF06/B0=
X-Received: by 2002:a17:907:2707:b0:730:af0b:3572 with SMTP id w7-20020a170907270700b00730af0b3572mr3470747ejk.411.1659664465253;
        Thu, 04 Aug 2022 18:54:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR74RTewyMa7O/I2xMhBnqBZBsUiyfFq0a7xkoP5eRl1uObEC5aFFPzKGIyVS1EF1S2JKCzHtrlmc4MIzhTEX6A=
X-Received: by 2002:a17:907:2707:b0:730:af0b:3572 with SMTP id
 w7-20020a170907270700b00730af0b3572mr3470730ejk.411.1659664464847; Thu, 04
 Aug 2022 18:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_7kR6DXi19CWh3veespFT=cJSTD0YGEFt8tw_Y8fEqZA@mail.gmail.com>
 <CAHj4cs8zXRTPpHt0Xu5BtSGtERK8cgniwrRPygEL9R=6qxjT5w@mail.gmail.com>
 <3af8153e-5e7a-f803-4dd4-cf7088a9d7d4@nvidia.com> <CAHj4cs90B+=Sjr43Xf+DWXw=oMCFLNPmMdenhyQn9fG=-ZXtVA@mail.gmail.com>
 <SJ0PR19MB45449CEC5FCA24EBE6C9BB90F29F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB45449CEC5FCA24EBE6C9BB90F29F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 5 Aug 2022 09:54:13 +0800
Message-ID: <CAHj4cs82ssuVX25yeHXhtqkkApxJbWDaoyOgq=0u5C4LWF2btg@mail.gmail.com>
Subject: Re: [bug report][bisected] blktests nvme/tcp nvme/030 failed on
 latest linux-block/for-next
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "Belanger, Martin" <Martin.Belanger@dell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 5, 2022 at 2:07 AM Belanger, Martin
<Martin.Belanger@dell.com> wrote:
>
> > -----Original Message-----
> > From: Yi Zhang <yi.zhang@redhat.com>
> > Sent: Thursday, August 4, 2022 5:50 AM
> > To: linux-block; open list:NVM EXPRESS DRIVER
> > Cc: Belanger, Martin; Chaitanya Kulkarni; Sagi Grimberg
> > Subject: Re: [bug report][bisected] blktests nvme/tcp nvme/030 failed o=
n
> > latest linux-block/for-next
> >
> >
> > [EXTERNAL EMAIL]
> >
> > I tried manually running the test, find after the discover cmd, the tar=
get was
> > connected, maybe that's why it break nvme/03 fail.
> >
> > # nvme discover -t tcp -a 127.0.0.1 -s 4420 Discovery Log Number of Rec=
ords 3,
> > Generation counter 4 =3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=
=3D=3D
> > trtype:  tcp
> > adrfam:  ipv4
> > subtype: current discovery subsystem
> > treq:    not specified, sq flow control disable supported
> > portid:  0
> > trsvcid: 4420
> > subnqn:  nqn.2014-08.org.nvmexpress.discovery
> > traddr:  127.0.0.1
> > eflags:  not specified
> > sectype: none
> > =3D=3D=3D=3D=3DDiscovery Log Entry 1=3D=3D=3D=3D=3D=3D
> > trtype:  tcp
> > adrfam:  ipv4
> > subtype: nvme subsystem
> > treq:    not specified, sq flow control disable supported
> > portid:  0
> > trsvcid: 4420
> > subnqn:  blktests-subsystem-2
> > traddr:  127.0.0.1
> > eflags:  not specified
> > sectype: none
> > =3D=3D=3D=3D=3DDiscovery Log Entry 2=3D=3D=3D=3D=3D=3D
> > trtype:  tcp
> > adrfam:  ipv4
> > subtype: nvme subsystem
> > treq:    not specified, sq flow control disable supported
> > portid:  0
> > trsvcid: 4420
> > subnqn:  blktests-subsystem-1
> > traddr:  127.0.0.1
> > eflags:  not specified
> > sectype: none
> >
> > # lsblk
> > NAME                              MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
> > loop0                               7:0    0   512M  0 loop
> > sda                                 8:0    0 119.2G  0 disk
> > =E2=94=9C=E2=94=80sda1                              8:1    0   600M  0 =
part /boot/efi
> > =E2=94=9C=E2=94=80sda2                              8:2    0     1G  0 =
part /boot
> > =E2=94=94=E2=94=80sda3                              8:3    0 117.7G  0 =
part
> >   =E2=94=94=E2=94=80fedora_amd--speedway--01-root 253:0    0 117.7G  0 =
lvm  /
> > zram0                             252:0    0     8G  0 disk [SWAP]
> > nvme1n1                           259:1    0   512M  0 disk
> > nvme2n1                           259:3    0   512M  0 disk
> >
> > [  189.518600] nvmet: adding nsid 1 to subsystem blktests-subsystem-2
> > [  189.536068] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [  189.591744] nvmet_tcp: enabling port 0 (127.0.0.1:4420) [  205.97873=
9]
> > nvmet: creating discovery controller 1 for subsystem nqn.2014-
> > 08.org.nvmexpress.discovery for NQN nqn.2014-
> > 08.org.nvmexpress:uuid:03000200-0400-0500-0006-000700080009.
> > [  206.000205] nvme nvme0: new ctrl: NQN "nqn.2014-
> > 08.org.nvmexpress.discovery", addr 127.0.0.1:4420 [  206.017512] nvme
> > nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> > [  206.152307] nvmet: creating discovery controller 1 for subsystem nqn=
.2014-
> > 08.org.nvmexpress.discovery for NQN nqn.2014-
> > 08.org.nvmexpress:uuid:03000200-0400-0500-0006-000700080009.
> > [  206.172131] nvme nvme0: new ctrl: NQN "nqn.2014-
> > 08.org.nvmexpress.discovery", addr 127.0.0.1:4420 [  206.205785] nvmet:
> > creating nvm controller 2 for subsystem
> > blktests-subsystem-2 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:03000200-0400-0500-0006-000700080009.
> > [  206.224652] nvme nvme1: creating 128 I/O queues.
> > [  206.341565] nvme nvme1: mapped 128/0/0 default/read/poll queues.
> > [  206.463025] nvme nvme1: new ctrl: NQN "blktests-subsystem-2", addr
> > 127.0.0.1:4420
> > [  206.495150] nvmet: creating nvm controller 3 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:03000200-0400-0500-0006-000700080009.
> > [  206.512928] nvme nvme2: creating 128 I/O queues.
> > [  206.637515] nvme nvme2: mapped 128/0/0 default/read/poll queues.
> > [  206.749717] nvme nvme2: new ctrl: NQN "blktests-subsystem-1", addr
> > 127.0.0.1:4420
> > [  206.761617] nvme nvme0: Removing ctrl: NQN "nqn.2014-
> > 08.org.nvmexpress.discovery"
> >
> > On Thu, Aug 4, 2022 at 3:37 AM Chaitanya Kulkarni <chaitanyak@nvidia.co=
m>
> > wrote:
> > >
> > > (++ Martin Belanger)
> > >
> > > Martin,
> > >
> > > On 8/3/22 09:43, Yi Zhang wrote:
> > > > So the bisect shows it was introduced from the below commit:
> > > >
> > > > commit 86c2457a8e8112f16af8fd10a3e1dd7a302c3c3e (refs/bisect/bad)
> > > > Author: Martin Belanger <martin.belanger@dell.com>
> > > > Date:   Tue Feb 8 14:33:46 2022 -0500
> > > >
> > > >      nvme: expose cntrltype and dctype through sysfs
> > > >
> > > > On Mon, Aug 1, 2022 at 8:37 PM Yi Zhang <yi.zhang@redhat.com> wrote=
:
> > > >>
> > > >> Hello
> > > >>
> > > >> nvme/030 triggered several errors during CKI tests on
> > > >> linux-block/for-next, pls help check it, and feel free to let me
> > > >> know if you need any test/info, thanks.
>
> Hi Chaitanya and Yi,
>
> This commit (submitted last February) simply exposes two read-only attrib=
utes
> to the sysfs.

Seems it was not the culprit, but nvme/030 can pass after I revert
that commit on v5.19.

Hi Sagi

I did more testing and finally found that reverting this udev rule
change in nvme-cli fix the nvme/030 failure issue,  could you check
it?

commit f86faaaa2a1ff319bde188dc8988be1ec054d238 (refs/bisect/bad)
Author: Sagi Grimberg <sagi@grimberg.m
Date:   Mon Jun 27 11:06:50 2022 +0300

    udev: re-read the discovery log page when a discovery controller reconn=
ected

    When using persistent discovery controllers, if the discovery
    controller loses connectivity and manage to reconnect after a while,
    we need to retrieve again the discovery log page in order to learn
    about possible changes that may have occurred during this time as
    discovery log change events were lost.

    Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
    Signed-off-by: Daniel Wagner <dwagner@suse.de>
    Link: https://lore.kernel.org/r/20220627080650.108936-1-sagi@grimberg.m=
e

>
> Sorry, but I'm not familiar with these test reports. What issue should I =
be
> looking for? I see a line with a "WARNING" label. Is that the problem?

yeah, from the below log, seems there are at least two issues, and I
saw Maurizio already submit two patch to fix them:

[   87.107679] WARNING at kernel/locking/mutex.c:582 __mutex_lock+0xf73/0x1=
3a0
[   86.814147] nvmet_tcp: queue 60 unhandled state 5

https://lore.kernel.org/linux-nvme/20220802151922.480571-1-mlombard@redhat.=
com/
https://lore.kernel.org/linux-nvme/20220801080900.391575-1-mlombard@redhat.=
com/

> Martin
>
> > > >>
> > > >> # nvme_trtype=3Dtcp ./check nvme/030
> > > >> nvme/030 (ensure the discovery generation counter is updated
> > > >> appropriately)
> > > >> WARNING: Test did not clean up tcp device: nvme0
> > > >> nvme/030 (ensure the discovery generation counter is updated
> > > >> appropriately) [failed]
> > > >>      runtime    ...  1.037s
> > > >>      --- tests/nvme/030.out 2022-07-31 21:17:30.609784852 -0400
> > > >>      +++ /root/blktests/results/nodev/nvme/030.out.bad 2022-08-01
> > > >> 08:27:44.503898074 -0400
> > > >>      @@ -1,2 +1,3 @@
> > > >>       Running nvme/030
> > > >>      +failed to lookup subsystem for controller nvme0
> > > >>       Test complete
> > > >>
> > > >> [   85.915692] run blktests nvme/030 at 2022-08-01 08:27:43
> > > >> [   86.114525] nvmet: adding nsid 1 to subsystem blktests-subsyste=
m-1
> > > >> [   86.140842] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > > >> [   86.214420] nvmet: creating discovery controller 1 for subsyste=
m
> > > >> nqn.2014-08.org.nvmexpress.discovery for NQN
> > > >> nqn.2014-08.org.nvmexpress:uuid:03000200-0400-0500-0006-
> > 000700080009.
> > > >> [   86.237110] nvme nvme0: new ctrl: NQN
> > > >> "nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
> > > >> [   86.253530] nvme nvme0: Removing ctrl: NQN
> > > >> "nqn.2014-08.org.nvmexpress.discovery"
> > > >> [   86.331176] nvmet: adding nsid 1 to subsystem blktests-subsyste=
m-2
> > > >> [   86.383550] nvmet: creating discovery controller 1 for subsyste=
m
> > > >> nqn.2014-08.org.nvmexpress.discovery for NQN
> > > >> nqn.2014-08.org.nvmexpress:uuid:03000200-0400-0500-0006-
> > 000700080009.
> > > >> [   86.403330] nvme nvme0: new ctrl: NQN
> > > >> "nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
> > > >> [   86.434229] nvmet: creating discovery controller 2 for subsyste=
m
> > > >> nqn.2014-08.org.nvmexpress.discovery for NQN
> > > >> nqn.2014-08.org.nvmexpress:uuid:03000200-0400-0500-0006-
> > 000700080009.
> > > >> [   86.454261] nvme nvme1: new ctrl: NQN
> > > >> "nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
> > > >> [   86.469065] nvme nvme1: Removing ctrl: NQN
> > > >> "nqn.2014-08.org.nvmexpress.discovery"
> > > >> [   86.493389] nvmet: creating nvm controller 3 for subsystem
> > > >> blktests-subsystem-1 for NQN
> > > >> nqn.2014-08.org.nvmexpress:uuid:03000200-0400-0500-0006-
> > 000700080009.
> > > >> [   86.514580] nvme nvme2: creating 128 I/O queues.
> > > >> [   86.635316] nvme nvme2: mapped 128/0/0 default/read/poll queues=
.
> > > >> [   86.781777] nvme nvme0: starting error recovery
> > > >> [   86.788446] nvmet_tcp: queue 0 unhandled state 5
> > > >> [   86.790669] nvmet: connect request for invalid subsystem
> > > >> blktests-subsystem-1!
> > > >> [   86.794306] nvme nvme0: Reconnecting in 10 seconds...
> > > >> [   86.814147] nvmet_tcp: queue 60 unhandled state 5
> > > >> [   86.819045] nvmet_tcp: queue 59 unhandled state 5
> > > >> [   86.821804] nvmet_tcp: queue 122 unhandled state 5
> > > >> [   86.823923] nvmet_tcp: queue 58 unhandled state 5
> > > >> [   86.828818] nvmet_tcp: queue 121 unhandled state 5
> > > >> [   86.833634] nvmet_tcp: queue 57 unhandled state 5
> > > >> [   86.838816] nvmet_tcp: queue 126 unhandled state 5
> > > >> [   86.843361] nvmet_tcp: queue 56 unhandled state 5
> > > >> [   86.848247] nvmet_tcp: queue 125 unhandled state 5
> > > >> [   86.853066] nvmet_tcp: queue 55 unhandled state 5
> > > >> [   86.857953] nvmet_tcp: queue 124 unhandled state 5
> > > >> [   86.862757] nvmet_tcp: queue 55 unhandled state 5
> > > >> [   86.862787] nvmet_tcp: queue 54 unhandled state 5
> > > >> [   86.862842] nvmet_tcp: queue 53 unhandled state 5
> > > >> [   86.862894] nvmet_tcp: queue 52 unhandled state 5
> > > >> [   86.862948] nvmet_tcp: queue 51 unhandled state 5
> > > >> [   86.862999] nvmet_tcp: queue 50 unhandled state 5
> > > >> [   86.863046] nvmet_tcp: queue 62 unhandled state 5
> > > >> [   86.863095] nvmet_tcp: queue 61 unhandled state 5
> > > >> [   86.867681] nvmet_tcp: queue 123 unhandled state 5
> > > >> [   86.872592] nvmet_tcp: queue 56 unhandled state 5
> > > >> [   86.872606] nvmet_tcp: queue 57 unhandled state 5
> > > >> [   86.872616] nvmet_tcp: queue 58 unhandled state 5
> > > >> [   86.877402] nvmet_tcp: queue 129 unhandled state 5
> > > >> [   86.882190] nvmet_tcp: queue 59 unhandled state 5
> > > >> [   86.882202] nvmet_tcp: queue 60 unhandled state 5
> > > >> [   86.887055] nvmet_tcp: queue 128 unhandled state 5
> > > >> [   86.891819] nvmet_tcp: queue 61 unhandled state 5
> > > >> [   86.891830] nvmet_tcp: queue 62 unhandled state 5
> > > >> [   86.896677] nvmet_tcp: queue 127 unhandled state 5
> > > >> [   86.901354] nvmet_tcp: queue 121 unhandled state 5
> > > >> [   86.901365] nvmet_tcp: queue 122 unhandled state 5
> > > >> [   87.088674] nvme nvme0: Removing ctrl: NQN
> > > >> "nqn.2014-08.org.nvmexpress.discovery"
> > > >> [   87.096908] nvme nvme0: Property Set error: 880, offset 0x14
> > > >> [   87.102953] ------------[ cut here ]------------
> > > >> [   87.107668] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> > > >> [   87.107679] WARNING: CPU: 30 PID: 2499 at
> > > >> kernel/locking/mutex.c:582 __mutex_lock+0xf73/0x13a0
> > > >> [   87.121591] Modules linked in: loop nvmet_tcp nvmet nvme_tcp
> > > >> nvme_fabrics nvme_core intel_rapl_msr intel_rapl_common
> > amd64_edac
> > > >> edac_mce_amd rfkill kvm_amd sunrpc vfat kvm fat ipmi_ssif joydev
> > > >> irqbypass acpi_ipmi rapl e1000e pcspkr ipmi_si ipmi_devintf
> > > >> i2c_piix4 k10temp ipmi_msghandler acpi_cpufreq fuse zram xfs
> > > >> libcrc32c ast i2c_algo_bit drm_vram_helper sd_mod t10_pi
> > > >> drm_kms_helper crc64_rocksoft_generic syscopyarea sysfillrect
> > > >> crc64_rocksoft sysimgblt crc64 fb_sys_fops drm_ttm_helper
> > > >> crct10dif_pclmul crc32_pclmul ttm crc32c_intel ahci libahci
> > > >> ghash_clmulni_intel drm libata ccp sp5100_tco dm_mod
> > > >> [   87.175439] CPU: 30 PID: 2499 Comm: nvme Not tainted 5.19.0-rc8=
+ #1
> > > >> [   87.181737] Hardware name: AMD Corporation Speedway/Speedway,
> > BIOS
> > > >> RSW100BB 11/14/2018
> > > >> [   87.189857] RIP: 0010:__mutex_lock+0xf73/0x13a0
> > > >> [   87.194388] Code: 08 84 d2 0f 85 0f 04 00 00 8b 05 60 28 f2 01 =
85
> > > >> c0 0f 85 f4 f1 ff ff 48 c7 c6 a0 46 6a ac 48 c7 c7 20 44 6a ac e8
> > > >> ad
> > > >> f1 ea ff <0f> 0b e9 da f1 ff ff e8 d1 de 5a fe e9 c6 f1 ff ff 48 c=
7
> > > >> c7
> > > >> 80 19
> > > >> [   87.213587] RSP: 0018:ffff889604037af0 EFLAGS: 00010286
> > > >> [   87.218916] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> > 0000000000000000
> > > >> [   87.226184] RDX: 0000000000000001 RSI: 0000000000000004 RDI:
> > ffffed12c0806f4e
> > > >> [   87.233453] RBP: ffff889604037c40 R08: 0000000000000001 R09:
> > ffff889c1d7efccb
> > > >> [   87.240728] R10: ffffed1383afdf99 R11: 0000000000000014 R12:
> > 0000000000000000
> > > >> [   87.247995] R13: dffffc0000000000 R14: ffff888e01517860 R15:
> > ffff889604037dc0
> > > >> [   87.255263] FS:  00007f0036b9a780(0000) GS:ffff889c1d600000(000=
0)
> > > >> knlGS:0000000000000000
> > > >> [   87.263503] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >> [   87.269359] CR2: 000055f3e1307000 CR3: 00000015c466c000 CR4:
> > 00000000003506e0
> > > >> [   87.276540] Call Trace:
> > > >> [   87.279099]  <TASK>
> > > >> [   87.281245]  ? mark_held_locks+0xa5/0xf0
> > > >> [   87.285253]  ? nvme_tcp_stop_queue+0x50/0xa0 [nvme_tcp]
> > > >> [   87.290498]  ? mutex_lock_io_nested+0x1220/0x1220
> > > >> [   87.295352]  ? __cancel_work_timer+0x202/0x450
> > > >> [   87.299800]  ? lockdep_hardirqs_on+0x79/0x100
> > > >> [   87.304306]  ? mod_delayed_work_on+0xf0/0xf0
> > > >> [   87.308575]  ? del_timer+0x110/0x110
> > > >> [   87.312282]  ? lockdep_hardirqs_on_prepare.part.0+0x19f/0x390
> > > >> [   87.318058]  ? nvme_tcp_stop_queue+0x50/0xa0 [nvme_tcp]
> > > >> [   87.323437]  nvme_tcp_stop_queue+0x50/0xa0 [nvme_tcp]
> > > >> [   87.328502]  nvme_tcp_delete_ctrl+0x93/0xd0 [nvme_tcp]
> > > >> [   87.333798]  nvme_do_delete_ctrl+0x133/0x13d [nvme_core]
> > > >> [   87.339224]  nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
> > > >> [   87.344564]  kernfs_fop_write_iter+0x359/0x530
> > > >> [   87.349012]  new_sync_write+0x2b9/0x500
> > > >> [   87.352985]  ? new_sync_read+0x4f0/0x4f0
> > > >> [   87.356990]  ? lock_downgrade+0x130/0x130
> > > >> [   87.361082]  ? lock_is_held_type+0xdd/0x130
> > > >> [   87.365351]  ? lock_is_held_type+0xdd/0x130
> > > >> [   87.369538]  vfs_write+0x639/0x9b0
> > > >> [   87.373063]  ksys_write+0x106/0x1e0
> > > >> [   87.376623]  ? __ia32_sys_read+0xa0/0xa0
> > > >> [   87.380629]  ? lockdep_hardirqs_on_prepare.part.0+0x19f/0x390
> > > >> [   87.386486]  ? syscall_enter_from_user_mode+0x20/0x70
> > > >> [   87.391639]  do_syscall_64+0x3a/0x90
> > > >> [   87.395291]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >> [   87.400354] RIP: 0033:0x7f0036cb5bd4
> > > >> [   87.404064] Code: 15 51 72 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff =
ff
> > > >> ff eb b7 0f 1f 00 f3 0f 1e fa 80 3d 2d fa 0d 00 00 74 13 b8 01 00
> > > >> 00
> > > >> 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 5=
4
> > > >> 24
> > > >> 18 48
> > > >> [   87.423163] RSP: 002b:00007ffea6c242b8 EFLAGS: 00000202 ORIG_RA=
X:
> > > >> 0000000000000001
> > > >> [   87.430875] RAX: ffffffffffffffda RBX: 000055f3e1306b30 RCX:
> > 00007f0036cb5bd4
> > > >> [   87.438059] RDX: 0000000000000001 RSI: 00007f0036de475e RDI:
> > 0000000000000003
> > > >> [   87.445293] RBP: 000055f3e1306610 R08: 000055f3e1307010 R09:
> > 0000000000000073
> > > >> [   87.452623] R10: 0000000000000000 R11: 0000000000000202 R12:
> > 0000000000000003
> > > >> [   87.459890] R13: 0000000000000000 R14: 000055f3e1306610 R15:
> > 00007ffea6c26109
> > > >> [   87.467164]  </TASK>
> > > >> [   87.469398] irq event stamp: 18139
> > > >> [   87.472869] hardirqs last  enabled at (18139): [<ffffffffa9e7a0=
e9>]
> > > >> __cancel_work_timer+0x179/0x450
> > > >> [   87.482082] hardirqs last disabled at (18138): [<ffffffffa9e79a=
3f>]
> > > >> try_to_grab_pending+0x1ef/0x630
> > > >> [   87.491294] softirqs last  enabled at (18104): [<ffffffffac4006=
93>]
> > > >> __do_softirq+0x693/0xafb
> > > >> [   87.499890] softirqs last disabled at (17945): [<ffffffffa9e23e=
a7>]
> > > >> __irq_exit_rcu+0x1c7/0x2c0
> > > >> [   87.508668] ---[ end trace 0000000000000000 ]---
> > > >> [   87.546650] nvme nvme2: Removing ctrl: NQN "blktests-subsystem-=
1"
> > > >> [   87.553627] nvme nvme2: Connect command failed, error wo/DNR bi=
t:
> > -16388
> > > >> [   87.560479] nvme nvme2: failed to connect queue: 122 ret=3D-4
> > > >> [   87.566195]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > > >> [   87.573540] BUG: KASAN: use-after-free in
> > blk_mq_tagset_busy_iter+0xa7c/0xd40
> > > >> [   87.578916] nvme nvme2: failed to send request -32
> > > >> [   87.580720] Read of size 4 at addr ffff8896046c7604 by task nvm=
e/2308
> > > >>
> > > >> [   87.580731] CPU: 75 PID: 2308 Comm: nvme Tainted: G        W
> > > >>   5.19.0-rc8+ #1
> > > >> [   87.585689] nvme nvme2: Property Set error: 880, offset 0x14
> > > >> [   87.592213] Hardware name: AMD Corporation Speedway/Speedway,
> > BIOS
> > > >> RSW100BB 11/14/2018
> > > >> [   87.592220] Call Trace:
> > > >> [   87.592224]  <TASK>
> > > >> [   87.619909]  ? blk_mq_tagset_busy_iter+0xa7c/0xd40
> > > >> [   87.624695]  dump_stack_lvl+0x4c/0x63
> > > >> [   87.628492]  print_address_description.constprop.0+0x1f/0x1e0
> > > >> [   87.634340]  ? blk_mq_tagset_busy_iter+0xa7c/0xd40
> > > >> [   87.639212]  ? blk_mq_tagset_busy_iter+0xa7c/0xd40
> > > >> [   87.644083]  print_report.cold+0x58/0x26b
> > > >> [   87.648164]  ? rcu_read_lock_sched_held+0x10/0x70
> > > >> [   87.652950]  ? lock_acquired+0x288/0x360
> > > >> [   87.656945]  ? blk_mq_tagset_busy_iter+0xa7c/0xd40
> > > >> [   87.661815]  kasan_report+0xe3/0x120
> > > >> [   87.665451]  ? blk_mq_tagset_busy_iter+0xa7c/0xd40
> > > >> [   87.670323]  blk_mq_tagset_busy_iter+0xa7c/0xd40
> > > >> [   87.675020]  ? rcu_read_lock_sched_held+0x10/0x70
> > > >> [   87.679803]  ? blk_mq_cancel_work_sync+0x50/0x50
> > > >> [   87.684500]  ? percpu_ref_tryget_many.constprop.0+0x1a0/0x1a0
> > > >> [   87.690347]  ? percpu_ref_tryget_many.constprop.0+0x1a0/0x1a0
> > > >> [   87.696191]  ? wait_for_completion_io_timeout+0x20/0x20
> > > >> [   87.701512]  blk_mq_tagset_wait_completed_request+0x81/0xc0
> > > >> [   87.707180]  ? blk_mq_tagset_busy_iter+0xd40/0xd40
> > > >> [   87.711966]  nvme_tcp_configure_io_queues.cold+0x90c/0xbc9
> > [nvme_tcp]
> > > >> [   87.718499]  ? nvme_tcp_alloc_queue+0x1e50/0x1e50 [nvme_tcp]
> > > >> [   87.724326]  ? nvme_tcp_configure_admin_queue+0x688/0x840
> > [nvme_tcp]
> > > >> [   87.730789]  nvme_tcp_setup_ctrl+0x1b8/0x590 [nvme_tcp]
> > > >> [   87.736103]  ? rcu_read_lock_sched_held+0x3f/0x70
> > > >> [   87.740886]  nvme_tcp_create_ctrl+0x92d/0xbb0 [nvme_tcp]
> > > >> [   87.746291]  nvmf_create_ctrl+0x2ee/0x8c0 [nvme_fabrics]
> > > >> [   87.751697]  nvmf_dev_write+0xd3/0x170 [nvme_fabrics]
> > > >> [   87.756749]  vfs_write+0x1bc/0x9b0
> > > >> [   87.760280]  ksys_write+0x106/0x1e0
> > > >> [   87.763829]  ? __ia32_sys_read+0xa0/0xa0
> > > >> [   87.767818]  ? lockdep_hardirqs_on_prepare.part.0+0x19f/0x390
> > > >> [   87.773660]  ? syscall_enter_from_user_mode+0x20/0x70
> > > >> [   87.778802]  do_syscall_64+0x3a/0x90
> > > >> [   87.782440]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >> [   87.787492] RIP: 0033:0x7ffb8ff34bd4
> > > >> [   87.791204] Code: 15 51 72 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff =
ff
> > > >> ff eb b7 0f 1f 00 f3 0f 1e fa 80 3d 2d fa 0d 00 00 74 13 b8 01 00
> > > >> 00
> > > >> 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 5=
4
> > > >> 24
> > > >> 18 48
> > > >> [   87.810293] RSP: 002b:00007fff0fd6ca18 EFLAGS: 00000202 ORIG_RA=
X:
> > > >> 0000000000000001
> > > >> [   87.817904] RAX: ffffffffffffffda RBX: 0000563964c22df0 RCX:
> > 00007ffb8ff34bd4
> > > >> [   87.825231] RDX: 00000000000000b2 RSI: 0000563964c22df0 RDI:
> > 0000000000000004
> > > >> [   87.832484] RBP: 0000000000000004 R08: 00000000000000b2 R09:
> > 0000563964c22df0
> > > >> [   87.839650] R10: 0000000000000000 R11: 0000000000000202 R12:
> > 0000563964c20540
> > > >> [   87.846978] R13: 00000000000000b2 R14: 00007ffb90063100 R15:
> > 00007ffb9006313d
> > > >> [   87.854238]  </TASK>
> > > >>
> > > >> [   87.857974] Allocated by task 2308:
> > > >> [   87.861523]  kasan_save_stack+0x2f/0x50
> > > >> [   87.865425]  __kasan_kmalloc+0x88/0xb0
> > > >> [   87.869237]  blk_mq_init_tags+0x59/0x140
> > > >> [   87.873137]  blk_mq_alloc_map_and_rqs+0x96/0x300
> > > >> [   87.877904]  blk_mq_alloc_set_map_and_rqs+0x1b5/0x5d0
> > > >> [   87.883042]  blk_mq_alloc_tag_set+0x4d4/0x920
> > > >> [   87.887474]  nvme_tcp_configure_io_queues.cold+0x708/0xbc9
> > [nvme_tcp]
> > > >> [   87.894025]  nvme_tcp_setup_ctrl+0x1b8/0x590 [nvme_tcp]
> > > >> [   87.899341]  nvme_tcp_create_ctrl+0x92d/0xbb0 [nvme_tcp]
> > > >> [   87.904746]  nvmf_create_ctrl+0x2ee/0x8c0 [nvme_fabrics]
> > > >> [   87.910149]  nvmf_dev_write+0xd3/0x170 [nvme_fabrics]
> > > >> [   87.915288]  vfs_write+0x1bc/0x9b0
> > > >> [   87.918747]  ksys_write+0x106/0x1e0
> > > >> [   87.922294]  do_syscall_64+0x3a/0x90
> > > >> [   87.925928]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >>
> > > >> [   87.932579] Freed by task 2504:
> > > >> [   87.935771]  kasan_save_stack+0x2f/0x50
> > > >> [   87.939669]  kasan_set_track+0x21/0x30
> > > >> [   87.943479]  kasan_set_free_info+0x20/0x40
> > > >> [   87.947642]  __kasan_slab_free+0x108/0x170
> > > >> [   87.951806]  slab_free_freelist_hook+0x11e/0x1d0
> > > >> [   87.956502]  kfree+0xe1/0x320
> > > >> [   87.959518]  __blk_mq_free_map_and_rqs+0x15c/0x240
> > > >> [   87.964390]  blk_mq_free_tag_set+0x65/0x3a0
> > > >> [   87.968644]  nvme_tcp_teardown_io_queues.part.0+0x20a/0x2a0
> > [nvme_tcp]
> > > >> [   87.975282]  nvme_tcp_delete_ctrl+0x47/0xd0 [nvme_tcp]
> > > >> [   87.980507]  nvme_do_delete_ctrl+0x133/0x13d [nvme_core]
> > > >> [   87.985919]  nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
> > > >> [   87.991242]  kernfs_fop_write_iter+0x359/0x530
> > > >> [   87.995765]  new_sync_write+0x2b9/0x500
> > > >> [   87.999663]  vfs_write+0x639/0x9b0
> > > >> [   88.003121]  ksys_write+0x106/0x1e0
> > > >> [   88.006578]  do_syscall_64+0x3a/0x90
> > > >> [   88.010198]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >>
> > > >> [   88.016920] The buggy address belongs to the object at
> > ffff8896046c7600
> > > >>                  which belongs to the cache kmalloc-256 of size 25=
6
> > > >> [   88.029648] The buggy address is located 4 bytes inside of
> > > >>                  256-byte region [ffff8896046c7600,
> > > >> ffff8896046c7700)
> > > >>
> > > >> [   88.042919] The buggy address belongs to the physical page:
> > > >> [   88.048583] page:000000003565eedb refcount:1 mapcount:0
> > > >> mapping:0000000000000000 index:0xffff8896046c5e00 pfn:0x16046c0
> > > >> [   88.059561] head:000000003565eedb order:3 compound_mapcount:0
> > > >> compound_pincount:0
> > > >> [   88.067172] flags:
> > > >> 0xd7ffffc0010200(slab|head|node=3D3|zone=3D2|lastcpupid=3D0x1fffff=
)
> > > >> [   88.074701] raw: 00d7ffffc0010200 ffff889480000950 ffff88948000=
0950
> > > >> ffff88810004cd80
> > > >> [   88.082486] raw: ffff8896046c5e00 0000000000400010 00000001ffff=
ffff
> > > >> 0000000000000000
> > > >> [   88.090432] page dumped because: kasan: bad access detected
> > > >>
> > > >> [   88.097608] Memory state around the buggy address:
> > > >> [   88.102478]  ffff8896046c7500: fc fc fc fc fc fc fc fc fc fc fc=
 fc
> > > >> fc fc fc fc
> > > >> [   88.109821]  ffff8896046c7580: fc fc fc fc fc fc fc fc fc fc fc=
 fc
> > > >> fc fc fc fc
> > > >> [   88.117164] >ffff8896046c7600: fa fb fb fb fb fb fb fb fb fb fb=
 fb
> > > >> fb fb fb fb
> > > >> [   88.124507]                    ^
> > > >> [   88.127790]  ffff8896046c7680: fb fb fb fb fb fb fb fb fb fb fb=
 fb
> > > >> fb fb fb fb
> > > >> [   88.135133]  ffff8896046c7700: fc fc fc fc fc fc fc fc fc fc fc=
 fc
> > > >> fc fc fc fc
> > > >> [   88.142476]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > > >> [   88.149905] ------------[ cut here ]------------
> > > >> [   88.154619] refcount_t: underflow; use-after-free.
> > > >> [   88.159439] WARNING: CPU: 75 PID: 2308 at lib/refcount.c:28
> > > >> refcount_warn_saturate+0x12a/0x190
> > > >> [   88.168241] Modules linked in: loop nvmet_tcp(-) nvmet nvme_tcp
> > > >> nvme_fabrics nvme_core intel_rapl_msr intel_rapl_common
> > amd64_edac
> > > >> edac_mce_amd rfkill kvm_amd sunrpc vfat kvm fat ipmi_ssif joydev
> > > >> irqbypass acpi_ipmi rapl e1000e pcspkr ipmi_si ipmi_devintf
> > > >> i2c_piix4 k10temp ipmi_msghandler acpi_cpufreq fuse zram xfs
> > > >> libcrc32c ast i2c_algo_bit drm_vram_helper sd_mod t10_pi
> > > >> drm_kms_helper crc64_rocksoft_generic syscopyarea sysfillrect
> > > >> crc64_rocksoft sysimgblt crc64 fb_sys_fops drm_ttm_helper
> > > >> crct10dif_pclmul crc32_pclmul ttm crc32c_intel ahci libahci
> > > >> ghash_clmulni_intel drm libata ccp sp5100_tco dm_mod
> > > >> [   88.222334] CPU: 75 PID: 2308 Comm: nvme Tainted: G    B   W
> > > >>   5.19.0-rc8+ #1
> > > >> [   88.230129] Hardware name: AMD Corporation Speedway/Speedway,
> > BIOS
> > > >> RSW100BB 11/14/2018
> > > >> [   88.238187] RIP: 0010:refcount_warn_saturate+0x12a/0x190
> > > >> [   88.243602] Code: eb a1 0f b6 1d 87 59 2c 03 80 fb 01 0f 87 85 =
9e
> > > >> 30 01 83 e3 01 75 8c 48 c7 c7 60 99 8a ac c6 05 6b 59 2c 03 01 e8
> > > >> c6
> > > >> 98 29 01 <0f> 0b e9 72 ff ff ff 0f b6 1d 56 59 2c 03 80 fb 01 0f 8=
7
> > > >> 42 9e 30
> > > >> [   88.262611] RSP: 0018:ffff8881695cfc68 EFLAGS: 00010282
> > > >> [   88.267995] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> > 0000000000000000
> > > >> [   88.275261] RDX: 0000000000000001 RSI: ffffffffac8ae120 RDI:
> > ffffed102d2b9f7d
> > > >> [   88.282525] RBP: 0000000000000003 R08: 0000000000000001 R09:
> > ffff888c2ebfd387
> > > >> [   88.289707] R10: ffffed1185d7fa70 R11: 0000000063666572 R12:
> > ffff8888875e0490
> > > >> [   88.297031] R13: ffff8888875e0000 R14: 00000000fffffffc R15:
> > 0000000000000000
> > > >> [   88.304208] FS:  00007ffb8fe39780(0000) GS:ffff888c2ea00000(000=
0)
> > > >> knlGS:0000000000000000
> > > >> [   88.312417] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >> [   88.318334] CR2: 0000563964c22860 CR3: 0000000dc1fb0000 CR4:
> > 00000000003506e0
> > > >> [   88.325510] Call Trace:
> > > >> [   88.328073]  <TASK>
> > > >> [   88.330218]  nvme_tcp_configure_io_queues.cold+0xb5c/0xbc9
> > [nvme_tcp]
> > > >> [   88.336782]  ? nvme_tcp_alloc_queue+0x1e50/0x1e50 [nvme_tcp]
> > > >> [   88.342464]  ? nvme_tcp_configure_admin_queue+0x688/0x840
> > [nvme_tcp]
> > > >> [   88.348999]  nvme_tcp_setup_ctrl+0x1b8/0x590 [nvme_tcp]
> > > >> [   88.354331]  ? rcu_read_lock_sched_held+0x3f/0x70
> > > >> [   88.359127]  nvme_tcp_create_ctrl+0x92d/0xbb0 [nvme_tcp]
> > > >> [   88.364477]  nvmf_create_ctrl+0x2ee/0x8c0 [nvme_fabrics]
> > > >> [   88.369843]  nvmf_dev_write+0xd3/0x170 [nvme_fabrics]
> > > >> [   88.375051]  vfs_write+0x1bc/0x9b0
> > > >> [   88.378524]  ksys_write+0x106/0x1e0
> > > >> [   88.382084]  ? __ia32_sys_read+0xa0/0xa0
> > > >> [   88.386085]  ? lockdep_hardirqs_on_prepare.part.0+0x19f/0x390
> > > >> [   88.391939]  ? syscall_enter_from_user_mode+0x20/0x70
> > > >> [   88.397091]  do_syscall_64+0x3a/0x90
> > > >> [   88.400737]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >> [   88.405888] RIP: 0033:0x7ffb8ff34bd4
> > > >> [   88.409446] Code: 15 51 72 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff =
ff
> > > >> ff eb b7 0f 1f 00 f3 0f 1e fa 80 3d 2d fa 0d 00 00 74 13 b8 01 00
> > > >> 00
> > > >> 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 5=
4
> > > >> 24
> > > >> 18 48
> > > >> [   88.428608] RSP: 002b:00007fff0fd6ca18 EFLAGS: 00000202 ORIG_RA=
X:
> > > >> 0000000000000001
> > > >> [   88.436319] RAX: ffffffffffffffda RBX: 0000563964c22df0 RCX:
> > 00007ffb8ff34bd4
> > > >> [   88.443583] RDX: 00000000000000b2 RSI: 0000563964c22df0 RDI:
> > 0000000000000004
> > > >> [   88.450760] RBP: 0000000000000004 R08: 00000000000000b2 R09:
> > 0000563964c22df0
> > > >> [   88.458001] R10: 0000000000000000 R11: 0000000000000202 R12:
> > 0000563964c20540
> > > >> [   88.465328] R13: 00000000000000b2 R14: 00007ffb90063100 R15:
> > 00007ffb9006313d
> > > >> [   88.472509]  </TASK>
> > > >> [   88.474798] irq event stamp: 160688
> > > >> [   88.478354] hardirqs last  enabled at (160687):
> > > >> [<ffffffffac0a20d0>] _raw_spin_unlock_irqrestore+0x30/0x60
> > > >> [   88.488184] hardirqs last disabled at (160688):
> > > >> [<ffffffffac08bae7>] __schedule+0xb37/0x1820
> > > >> [   88.496781] softirqs last  enabled at (160660):
> > > >> [<ffffffffac400693>] __do_softirq+0x693/0xafb
> > > >> [   88.505459] softirqs last disabled at (160651):
> > > >> [<ffffffffa9e23ea7>] __irq_exit_rcu+0x1c7/0x2c0
> > > >> [   88.514318] ---[ end trace 0000000000000000 ]---
> > > >> [   88.518959] general protection fault, probably for non-canonica=
l
> > > >> address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > >> [   88.530580] KASAN: null-ptr-deref in range
> > > >> [0x0000000000000000-0x0000000000000007]
> > > >> [   88.538276] CPU: 75 PID: 2308 Comm: nvme Tainted: G    B   W
> > > >>   5.19.0-rc8+ #1
> > > >> [   88.546062] Hardware name: AMD Corporation Speedway/Speedway,
> > BIOS
> > > >> RSW100BB 11/14/2018
> > > >> [   88.554112] RIP: 0010:__blk_mq_free_map_and_rqs+0x88/0x240
> > > >> [   88.559690] Code: 00 00 48 8b 6b 68 41 89 f4 49 c1 e4 03 4c 01 =
e5
> > > >> 45 85 ed 0f 85 07 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 e9
> > > >> 48
> > > >> c1 e9 03 <80> 3c 01 00 0f 85 2e 01 00 00 4c 8b 6d 00 4d 85 ed 0f 8=
4
> > > >> df
> > > >> 00 00
> > > >> [   88.578774] RSP: 0018:ffff8881695cfc00 EFLAGS: 00010256
> > > >> [   88.584088] RAX: dffffc0000000000 RBX: ffff8888875e0008 RCX:
> > 0000000000000000
> > > >> [   88.591254] RDX: 0000000000000080 RSI: 0000000000000000 RDI:
> > ffff8888875e0060
> > > >> [   88.598583] RBP: 0000000000000000 R08: 0000000000000001 R09:
> > ffff888c2ebfd387
> > > >> [   88.605837] R10: ffffed1185d7fa70 R11: 0000000063666572 R12:
> > 0000000000000000
> > > >> [   88.613090] R13: 0000000000000000 R14: ffff8888875e0070 R15:
> > 0000000000000000
> > > >> [   88.620255] FS:  00007ffb8fe39780(0000) GS:ffff888c2ea00000(000=
0)
> > > >> knlGS:0000000000000000
> > > >> [   88.628552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >> [   88.634394] CR2: 0000563964c22860 CR3: 0000000dc1fb0000 CR4:
> > 00000000003506e0
> > > >> [   88.641648] Call Trace:
> > > >> [   88.644046]  <TASK>
> > > >> [   88.646253]  blk_mq_free_tag_set+0x65/0x3a0
> > > >> [   88.650507]  ? refcount_warn_saturate+0x12c/0x190
> > > >> [   88.655291]  nvme_tcp_configure_io_queues.cold+0xb86/0xbc9
> > [nvme_tcp]
> > > >> [   88.661845]  ? nvme_tcp_alloc_queue+0x1e50/0x1e50 [nvme_tcp]
> > > >> [   88.667602]  ? nvme_tcp_configure_admin_queue+0x688/0x840
> > [nvme_tcp]
> > > >> [   88.674066]  nvme_tcp_setup_ctrl+0x1b8/0x590 [nvme_tcp]
> > > >> [   88.679381]  ? rcu_read_lock_sched_held+0x3f/0x70
> > > >> [   88.684077]  nvme_tcp_create_ctrl+0x92d/0xbb0 [nvme_tcp]
> > > >> [   88.689553]  nvmf_create_ctrl+0x2ee/0x8c0 [nvme_fabrics]
> > > >> [   88.694957]  nvmf_dev_write+0xd3/0x170 [nvme_fabrics]
> > > >> [   88.700007]  vfs_write+0x1bc/0x9b0
> > > >> [   88.703541]  ksys_write+0x106/0x1e0
> > > >> [   88.707000]  ? __ia32_sys_read+0xa0/0xa0
> > > >> [   88.711063]  ? lockdep_hardirqs_on_prepare.part.0+0x19f/0x390
> > > >> [   88.716907]  ? syscall_enter_from_user_mode+0x20/0x70
> > > >> [   88.722045]  do_syscall_64+0x3a/0x90
> > > >> [   88.725682]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >> [   88.730819] RIP: 0033:0x7ffb8ff34bd4
> > > >> [   88.734455] Code: 15 51 72 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff =
ff
> > > >> ff eb b7 0f 1f 00 f3 0f 1e fa 80 3d 2d fa 0d 00 00 74 13 b8 01 00
> > > >> 00
> > > >> 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 5=
4
> > > >> 24
> > > >> 18 48
> > > >> [   88.753451] RSP: 002b:00007fff0fd6ca18 EFLAGS: 00000202 ORIG_RA=
X:
> > > >> 0000000000000001
> > > >> [   88.761132] RAX: ffffffffffffffda RBX: 0000563964c22df0 RCX:
> > 00007ffb8ff34bd4
> > > >> [   88.768371] RDX: 00000000000000b2 RSI: 0000563964c22df0 RDI:
> > 0000000000000004
> > > >> [   88.775700] RBP: 0000000000000004 R08: 00000000000000b2 R09:
> > 0000563964c22df0
> > > >> [   88.782865] R10: 0000000000000000 R11: 0000000000000202 R12:
> > 0000563964c20540
> > > >> [   88.790192] R13: 00000000000000b2 R14: 00007ffb90063100 R15:
> > 00007ffb9006313d
> > > >> [   88.797452]  </TASK>
> > > >> [   88.799672] Modules linked in: loop nvmet_tcp(-) nvmet nvme_tcp
> > > >> nvme_fabrics nvme_core intel_rapl_msr intel_rapl_common
> > amd64_edac
> > > >> edac_mce_amd rfkill kvm_amd sunrpc vfat kvm fat ipmi_ssif joydev
> > > >> irqbypass acpi_ipmi rapl e1000e pcspkr ipmi_si ipmi_devintf
> > > >> i2c_piix4 k10temp ipmi_msghandler acpi_cpufreq fuse zram xfs
> > > >> libcrc32c ast i2c_algo_bit drm_vram_helper sd_mod t10_pi
> > > >> drm_kms_helper crc64_rocksoft_generic syscopyarea sysfillrect
> > > >> crc64_rocksoft sysimgblt crc64 fb_sys_fops drm_ttm_helper
> > > >> crct10dif_pclmul crc32_pclmul ttm crc32c_intel ahci libahci
> > > >> ghash_clmulni_intel drm libata ccp sp5100_tco dm_mod
> > > >> [   88.853746] ---[ end trace 0000000000000000 ]---
> > > >> [   88.858451] RIP: 0010:__blk_mq_free_map_and_rqs+0x88/0x240
> > > >> [   88.863950] Code: 00 00 48 8b 6b 68 41 89 f4 49 c1 e4 03 4c 01 =
e5
> > > >> 45 85 ed 0f 85 07 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 e9
> > > >> 48
> > > >> c1 e9 03 <80> 3c 01 00 0f 85 2e 01 00 00 4c 8b 6d 00 4d 85 ed 0f 8=
4
> > > >> df
> > > >> 00 00
> > > >> [   88.883111] RSP: 0018:ffff8881695cfc00 EFLAGS: 00010256
> > > >> [   88.888440] RAX: dffffc0000000000 RBX: ffff8888875e0008 RCX:
> > 0000000000000000
> > > >> [   88.895621] RDX: 0000000000000080 RSI: 0000000000000000 RDI:
> > ffff8888875e0060
> > > >> [   88.902946] RBP: 0000000000000000 R08: 0000000000000001 R09:
> > ffff888c2ebfd387
> > > >> [   88.910216] R10: ffffed1185d7fa70 R11: 0000000063666572 R12:
> > 0000000000000000
> > > >> [   88.917489] R13: 0000000000000000 R14: ffff8888875e0070 R15:
> > 0000000000000000
> > > >> [   88.924757] FS:  00007ffb8fe39780(0000) GS:ffff888c2ea00000(000=
0)
> > > >> knlGS:0000000000000000
> > > >> [   88.932998] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >> [   88.938854] CR2: 0000563964c22860 CR3: 0000000dc1fb0000 CR4:
> > 00000000003506e0
> > > >>
> > > >> --
> > > >> Best Regards,
> > > >>    Yi Zhang
> > > >
> > >
> > > Please have a look at this.
> > >
> > > -ck
> > >
> > >
> >
> >
> > --
> > Best Regards,
> >   Yi Zhang
>


--
Best Regards,
  Yi Zhang

