Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E11CC6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 08:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCVIrn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 04:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCVIri (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 04:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643C94FCFC
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679474814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPoKK5bMKHLE/U3jZ5mvUI6T0TmBUVr6mgejY8PRil0=;
        b=CZiebdXpESw+6Fl55ycHb3KyQdvs82O4FRVPaDnEWX1UklQbNvtmQTxzUqUb/RcKnLpJSN
        rNKriLcWXMph2iiBQdzPx2V1Cb+UJon0ddKh0oVf9+hKnWRg05j0hCNfO0mCvcHldwRnIp
        pS7RoohNHvl2o+I4Ggg3LOuNhNp4MG8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-Mpgd2x3oMX-lgYoLtSS89Q-1; Wed, 22 Mar 2023 04:46:53 -0400
X-MC-Unique: Mpgd2x3oMX-lgYoLtSS89Q-1
Received: by mail-ed1-f69.google.com with SMTP id c1-20020a0564021f8100b004acbe232c03so25537636edc.9
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 01:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679474811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPoKK5bMKHLE/U3jZ5mvUI6T0TmBUVr6mgejY8PRil0=;
        b=vvImkR09cQBY4NRoTcfK2Po46mkRWUqfyC4e2ZEdr9LWiPw6CbSCjmaSmLYJ+/6d6u
         S5PiHEAP7M90SMJqSme8J5ZCCkVX4NboYQn++pcE7ae/vqZI/TYX1CYrDWWrs1ePCkw4
         LO0Fgd6mLAe2Z3ySe9xXxWHl5wYJ+k4G3Nrz26mgPoMOyoQMcNOshWnT4vjb6tnnl0OM
         uBreUh22oQh17o15cJKs2ouQHKoqSzjdZBVjJubUlAavAetRGrIFKkI8tRuDe2VtzvD2
         I+eoJqvXrPbdeh22m9LNfrIfiNr3mKo8Fz1VFfy3us8yxpNi0UqNr0Btnhw4+HUhlSBJ
         spPA==
X-Gm-Message-State: AO0yUKVV0dYkVkZnmRROGRO88x6qizhJtBYcTxd67VPrhppVwr4hyYUk
        YoAIPVXEzQzRlOKO+P4DiTql4wqzsbbNEC7YTUgWhhmF5cqa9yB2J6ajnPqrGex4Jc7QK7SxAy6
        0fC4/QpmCLEoPFYFUnwcWmzVmbSjYRxRB3/GiEak=
X-Received: by 2002:a50:c3ce:0:b0:4fa:ce07:639f with SMTP id i14-20020a50c3ce000000b004face07639fmr2975465edf.5.1679474810685;
        Wed, 22 Mar 2023 01:46:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set926BO2iMMWOMdUvHxcpSw9xg8Cb1J3Gi+jqgCu/+f+JDEQh/n2leowYIxvaFu74AyUJPx9IjzLcYRBbZ+e548=
X-Received: by 2002:a50:c3ce:0:b0:4fa:ce07:639f with SMTP id
 i14-20020a50c3ce000000b004face07639fmr2975459edf.5.1679474810351; Wed, 22 Mar
 2023 01:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAGVVp+VB8_8uySZgX2R-rXrTWaL+P0SB4ghKe_4uObqwAgHQHg@mail.gmail.com>
 <71f21703-a682-c148-1064-f9ab18c83480@acm.org>
In-Reply-To: <71f21703-a682-c148-1064-f9ab18c83480@acm.org>
From:   Changhui Zhong <czhong@redhat.com>
Date:   Wed, 22 Mar 2023 16:46:38 +0800
Message-ID: <CAGVVp+XRW=16ddp7W=Ujd9yjzWWg3tNqMgowrBVhHwesvWNDvA@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 11 PID: 4009 at fs/proc/generic.c:718 remove_proc_entry+0x192/0x1a0
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi=EF=BC=8CBart

I test the latest Linus' master branch, which include patch
be03df3d4bfe ("scsi: core: Fix a procfs host directory removal
regression")=EF=BC=8C
I cannot trigger this issue on it=EF=BC=8Cbut get some error info with bloc=
k/001 test=EF=BC=8C

[root@storageqe-103 blktests]# uname -r
6.3.0-rc3+
[root@storageqe-103 blktests]#
[root@storageqe-103 blktests]# ./check block/001
block/001 (stress device hotplugging)                        [passed]
    runtime    ...  40.589s
[root@storageqe-103 blktests]#

[root@storageqe-103 ~]# dmesg
[ 1745.496434] run blktests block/001 at 2023-03-22 04:26:41
[ 1745.540541] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw =3D (0/1)
[ 1745.550666] scsi host14: scsi_debug: version 0191 [20210520]
                 dev_size_mb=3D8, opts=3D0x0, submit_queues=3D1, statistics=
=3D0
[ 1745.551189] scsi 14:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 1745.551489] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw =3D (0/1)
[ 1745.552148] sd 14:0:0:0: Attached scsi generic sg4 type 0
[ 1745.552268] sd 14:0:0:0: Power-on or device reset occurred
[ 1745.554409] sd 14:0:0:0: [sde] 16384 512-byte logical blocks: (8.39
MB/8.00 MiB)
[ 1745.555429] sd 14:0:0:0: [sde] Write Protect is off
[ 1745.555434] sd 14:0:0:0: [sde] Mode Sense: 73 00 10 08
[ 1745.557460] sd 14:0:0:0: [sde] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[ 1745.560504] sd 14:0:0:0: [sde] Preferred minimum I/O size 512 bytes
[ 1745.560508] sd 14:0:0:0: [sde] Optimal transfer size 524288 bytes
[ 1745.561622] scsi host15: scsi_debug: version 0191 [20210520]
                 dev_size_mb=3D8, opts=3D0x0, submit_queues=3D1, statistics=
=3D0
[ 1745.567986] scsi 15:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 1745.568338] sd 15:0:0:0: Attached scsi generic sg5 type 0
[ 1745.568516] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw =3D (0/1)
[ 1745.568557] sd 15:0:0:0: Power-on or device reset occurred
[ 1745.578636] scsi host16: scsi_debug: version 0191 [20210520]
                 dev_size_mb=3D8, opts=3D0x0, submit_queues=3D1, statistics=
=3D0
[ 1745.585028] scsi 16:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 1745.585345] scsi_debug:sdebug_driver_probe: scsi_debug: trim
poll_queues to 0. poll_q/nr_hw =3D (0/1)
[ 1745.585566] sd 16:0:0:0: Attached scsi generic sg6 type 0
[ 1745.585617] sd 16:0:0:0: Power-on or device reset occurred
[ 1745.586907] sd 15:0:0:0: [sdf] 16384 512-byte logical blocks: (8.39
MB/8.00 MiB)
[ 1745.587702] sd 16:0:0:0: [sdg] 16384 512-byte logical blocks: (8.39
MB/8.00 MiB)
[ 1745.587927] sd 15:0:0:0: [sdf] Write Protect is off
[ 1745.587931] sd 15:0:0:0: [sdf] Mode Sense: 73 00 10 08
[ 1745.588738] sd 16:0:0:0: [sdg] Write Protect is off
[ 1745.588748] sd 16:0:0:0: [sdg] Mode Sense: 73 00 10 08
[ 1745.589957] sd 15:0:0:0: [sdf] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[ 1745.590814] sd 16:0:0:0: [sdg] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[ 1745.593002] sd 15:0:0:0: [sdf] Preferred minimum I/O size 512 bytes
[ 1745.593006] sd 15:0:0:0: [sdf] Optimal transfer size 524288 bytes
[ 1745.593865] sd 16:0:0:0: [sdg] Preferred minimum I/O size 512 bytes
[ 1745.593869] sd 16:0:0:0: [sdg] Optimal transfer size 524288 bytes
[ 1745.595450] scsi host17: scsi_debug: version 0191 [20210520]
                 dev_size_mb=3D8, opts=3D0x0, submit_queues=3D1, statistics=
=3D0
[ 1745.595981] scsi 17:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 1745.601970] sd 17:0:0:0: Attached scsi generic sg7 type 0
[ 1745.601993] sd 17:0:0:0: Power-on or device reset occurred
[ 1745.610165] sd 14:0:0:0: [sde] Attached SCSI disk
[ 1745.610193] sd 17:0:0:0: [sdh] 16384 512-byte logical blocks: (8.39
MB/8.00 MiB)
[ 1745.611217] sd 17:0:0:0: [sdh] Write Protect is off
[ 1745.611223] sd 17:0:0:0: [sdh] Mode Sense: 73 00 10 08
[ 1745.613274] sd 17:0:0:0: [sdh] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[ 1745.616342] sd 17:0:0:0: [sdh] Preferred minimum I/O size 512 bytes
[ 1745.616347] sd 17:0:0:0: [sdh] Optimal transfer size 524288 bytes
[ 1745.622325] sd 16:0:0:0: [sdg] Attached SCSI disk
[ 1745.624206] sd 15:0:0:0: [sdf] Attached SCSI disk
[ 1745.640200] sd 17:0:0:0: [sdh] Attached SCSI disk
[ 1745.799001] sd 15:0:0:0: [sdf] Synchronizing SCSI cache
[ 1745.799462] scsi 15:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 1745.799908] sd 15:0:0:0: Attached scsi generic sg4 type 0
[ 1745.800081] sd 15:0:0:0: Power-on or device reset occurred
[ 1745.806324] sd 15:0:0:0: [sdf] Read Capacity(16) failed: Result:
hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[ 1745.806333] sd 15:0:0:0: [sdf] Sense not available.
[ 1745.806343] sd 15:0:0:0: [sdf] Read Capacity(10) failed: Result:
hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[ 1745.806346] sd 15:0:0:0: [sdf] Sense not available.
[ 1745.806358] sd 15:0:0:0: [sdf] 0 512-byte logical blocks: (0 B/0 B)
[ 1745.806361] sd 15:0:0:0: [sdf] 0-byte physical blocks
[ 1745.806367] sd 15:0:0:0: [sdf] Write Protect is off
[ 1745.806371] sd 15:0:0:0: [sdf] Mode Sense: 00 00 00 00
[ 1745.806376] sd 15:0:0:0: [sdf] Asking for cache data failed
[ 1745.807002] sd 14:0:0:0: [sde] Synchronizing SCSI cache
[ 1745.812631] sd 15:0:0:0: [sdf] Assuming drive cache: write through
[ 1745.813105] scsi 14:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 1745.819610] sd 15:0:0:0: [sdf] Preferred minimum I/O size 512 bytes
not a multiple of physical block size (0 bytes)
[ 1745.819880] sd 14:0:0:0: Attached scsi generic sg4 type 0
[ 1745.820072] sd 14:0:0:0: Power-on or device reset occurred
[ 1745.822211] sd 14:0:0:0: [sde] 16384 512-byte logical blocks: (8.39
MB/8.00 MiB)
[ 1745.823232] sd 14:0:0:0: [sde] Write Protect is off
[ 1745.823237] sd 14:0:0:0: [sde] Mode Sense: 73 00 10 08
[ 1745.825264] sd 14:0:0:0: [sde] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[ 1745.828307] sd 14:0:0:0: [sde] Preferred minimum I/O size 512 bytes
[ 1745.828311] sd 14:0:0:0: [sde] Optimal transfer size 524288 bytes
[ 1745.831270] sd 15:0:0:0: [sdf] Optimal transfer size 524288 bytes
not a multiple of physical block size (0 bytes)
[ 1745.849240] sd 15:0:0:0: [sdf] Attached SCSI disk
[ 1745.849984] sd 16:0:0:0: [sdg] Synchronizing SCSI cache
[ 1745.850013] sd 17:0:0:0: [sdh] Synchronizing SCSI cache
[ 1745.850735] scsi 17:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 1745.850753] scsi 16:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 1745.851601] sd 16:0:0:0: Attached scsi generic sg4 type 0
[ 1745.851648] sd 17:0:0:0: Power-on or device reset occurred
[ 1745.851650] sd 16:0:0:0: Power-on or device reset occurred
[ 1745.851689] sd 17:0:0:0: Attached scsi generic sg5 type 0
[ 1745.857798] sd 17:0:0:0: [sdh] Read Capacity(16) failed: Result:
hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[ 1745.863934] sd 17:0:0:0: [sdh] Sense not available.
[ 1745.863953] sd 17:0:0:0: [sdh] Read Capacity(10) failed: Result:
hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[ 1745.863959] sd 17:0:0:0: [sdh] Sense not available.
[ 1745.863959] sd 16:0:0:0: [sdg] Read Capacity(16) failed: Result:
hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[ 1745.863964] sd 16:0:0:0: [sdg] Sense not available.
[ 1745.863973] sd 17:0:0:0: [sdh] 0 512-byte logical blocks: (0 B/0 B)
[ 1745.863978] sd 16:0:0:0: [sdg] Read Capacity(10) failed: Result:
hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[ 1745.863979] sd 17:0:0:0: [sdh] 0-byte physical blocks
[ 1745.863985] sd 16:0:0:0: [sdg] Sense not available.
[ 1745.863988] sd 17:0:0:0: [sdh] Write Protect is off
[ 1745.863994] sd 17:0:0:0: [sdh] Mode Sense: 00 00 00 00
[ 1745.863996] sd 16:0:0:0: [sdg] 0 512-byte logical blocks: (0 B/0 B)
[ 1745.864001] sd 16:0:0:0: [sdg] 0-byte physical blocks
[ 1745.864003] sd 17:0:0:0: [sdh] Asking for cache data failed
[ 1745.864009] sd 16:0:0:0: [sdg] Write Protect is off
[ 1745.870234] sd 17:0:0:0: [sdh] Assuming drive cache: write through
[ 1745.870236] sd 16:0:0:0: [sdg] Mode Sense: 00 00 00 00
[ 1745.877139] sd 16:0:0:0: [sdg] Asking for cache data failed
[ 1745.877146] sd 17:0:0:0: [sdh] Preferred minimum I/O size 512 bytes
not a multiple of physical block size (0 bytes)
[ 1745.883366] sd 16:0:0:0: [sdg] Assuming drive cache: write through
[ 1745.895019] sd 17:0:0:0: [sdh] Optimal transfer size 524288 bytes
not a multiple of physical block size (0 bytes)
[ 1745.901926] sd 16:0:0:0: [sdg] Preferred minimum I/O size 512 bytes
not a multiple of physical block size (0 bytes)
[ 1745.913855] sd 17:0:0:0: [sdh] Attached SCSI disk
[ 1745.925034] sd 16:0:0:0: [sdg] Optimal transfer size 524288 bytes
not a multiple of physical block size (0 bytes)
[ 1745.925464] sd 16:0:0:0: [sdg] Attached SCSI disk
[ 1745.929026] device offline error, dev sde, sector 0 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 2
[ 1745.929040] Buffer I/O error on dev sde, logical block 0, async page rea=
d
[ 1745.929068] device offline error, dev sde, sector 0 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 2
[ 1745.929074] Buffer I/O error on dev sde, logical block 0, async page rea=
d
[ 1745.929091] device offline error, dev sde, sector 0 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 2
[ 1745.929096] Buffer I/O error on dev sde, logical block 0, async page rea=
d
[ 1745.929112] device offline error, dev sde, sector 0 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 2
[ 1745.929117] Buffer I/O error on dev sde, logical block 0, async page rea=
d
[ 1745.929134] device offline error, dev sde, sector 0 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 2
[ 1745.929139] Buffer I/O error on dev sde, logical block 0, async page rea=
d
[ 1745.929155] device offline error, dev sde, sector 0 op 0x0:(READ)
flags 0x0 phys_seg 1 prio class 2
[ 1745.929161] Buffer I/O error on dev sde, logical block 0, async page rea=
d
[ 1745.929169]  sde: unable to read partition table
[ 1745.929228] sd 14:0:0:0: [sde] Attached SCSI disk
[ 1746.062453] scsi 15:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 1746.062920] sd 15:0:0:0: Attached scsi generic sg4 type 0
[ 1746.063160] sd 15:0:0:0: Power-on or device reset occurred
[ 1746.064448] scsi 14:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 1746.069338] sd 15:0:0:0: [sdf] Read Capacity(16) failed: Result:
hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[ 1746.069347] sd 15:0:0:0: [sdf] Sense not available.
[ 1746.069357] sd 15:0:0:0: [sdf] Read Capacity(10) failed: Result:
hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[ 1746.069360] sd 15:0:0:0: [sdf] Sense not available.
[ 1746.069372] sd 15:0:0:0: [sdf] 0 512-byte logical blocks: (0 B/0 B)
[ 1746.069375] sd 15:0:0:0: [sdf] 0-byte physical blocks
[ 1746.069381] sd 15:0:0:0: [sdf] Write Protect is off
[ 1746.069385] sd 15:0:0:0: [sdf] Mode Sense: 00 00 00 00
[ 1746.069389] sd 15:0:0:0: [sdf] Asking for cache data failed
[ 1746.069654] sd 14:0:0:0: Power-on or device reset occurred
[ 1746.069679] sd 14:0:0:0: Attached scsi generic sg4 type 0
[ 1746.071478] scsi 17:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 1746.072390] sd 17:0:0:0: Attached scsi generic sg4 type 0
[ 1746.072429] sd 17:0:0:0: Power-on or device reset occurred
[ 1746.073489] sd 17:0:0:0: [sdh] Read Capacity(16) failed: Result:
hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[ 1746.073496] sd 17:0:0:0: [sdh] Sense not available.
[ 1746.073505] sd 17:0:0:0: [sdh] Read Capacity(10) failed: Result:
hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK
[ 1746.073508] sd 17:0:0:0: [sdh] Sense not available.
[ 1746.073519] sd 17:0:0:0: [sdh] 0 512-byte logical blocks: (0 B/0 B)
[ 1746.073522] sd 17:0:0:0: [sdh] 0-byte physical blocks
[ 1746.073527] sd 17:0:0:0: [sdh] Write Protect is off
[ 1746.073531] sd 17:0:0:0: [sdh] Mode Sense: 00 00 00 00
[ 1746.073535] sd 17:0:0:0: [sdh] Asking for cache data failed
[ 1746.073538] sd 17:0:0:0: [sdh] Assuming drive cache: write through
[ 1746.073552] sd 17:0:0:0: [sdh] Preferred minimum I/O size 512 bytes
not a multiple of physical block size (0 bytes)
[ 1746.073556] sd 17:0:0:0: [sdh] Optimal transfer size 524288 bytes
not a multiple of physical block size (0 bytes)

Thanks=EF=BC=8C
Changhui


On Wed, Mar 22, 2023 at 1:23=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 3/20/23 20:16, Changhui Zhong wrote:
> > [  259.090462] remove_proc_entry: removing non-empty directory
> > 'scsi/scsi_debug', leaking at least '12'
>
> Please merge Linus' master branch into your branch to help with
> verifying whether the following patch fixes this issue: be03df3d4bfe
> ("scsi: core: Fix a procfs host directory removal regression").
>
> Thanks,
>
> Bart.
>


--=20

Changhui  Zhong

Quality Engineer,Kernel QE

Red Hat

Red Hat Beijing - Raycom

