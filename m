Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86094C433EF
	for <linux-block@archiver.kernel.org>; Sun, 27 Feb 2022 12:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiB0MS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Feb 2022 07:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiB0MS4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Feb 2022 07:18:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F233E5CA
        for <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 04:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645964298;
        bh=mk9lV5V6F1ZfPWZvj3Illy19nAEdSkm0hach83jnvxQ=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc;
        b=Z1QGD1gmaNssiTlSVcdzAcw9vF6SnksGLKzAKaSJr6WKk80FDyLb3IQhNxKppzHJ1
         scshm+UBYWCXOz1u3F2qhTyU5TAtD56bcImkFcIPzXWbXTtnCKoViul+8CJWk7+agx
         boJKJi2dlEN/L1nBUOvoq1Hwh9Fl1SIDH4G41Zgo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.27] ([45.14.99.28]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fMe-1nH9tr3Rz0-007DVC; Sun, 27
 Feb 2022 13:18:17 +0100
Message-ID: <6f91ec31-640b-656a-5ef7-e9d348302ca3@gmx.net>
Date:   Sun, 27 Feb 2022 13:18:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   JPT <j-p-t@gmx.net>
Subject: DVD drive disappearing directly after detection
To:     linux-block@vger.kernel.org
Cc:     j-p-t@gmx.net
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NS3dDTSvXf9xiXIIqqgRgnblcttlyuivelhHOVC0TAIVGk+Q72T
 xaHi7Whcws0uNAbzuvADnGd+ukg4186Gp8k/9ApMr2vcHET9n7D8vI6NuDcgQhizy7HFtHI
 TR5EecRZJFvQtpDwgpNlhQ/i0eHkOGS1GLdCqfLOwVB/MifFxTnbapo/uw39/1q2sADehtZ
 ypeSgZTBWmVW1G0P+fteQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xww8GoD1eNc=:8YL7rzM8GAL1Ksh/PKa34J
 evurCuVcsrfBu+M85bO6Fdknoh6mCDevK5kyQVfHa9mZ45pdoChCj1lveOu5GJh2DobWBlIkA
 j1JcqGe9kJWyfvpvkST+zipTFJDy50Dj/qvWXGdz3MYEc8+XM1jc8Y0jhzM4rKyKep8BB4Z3s
 W+p299S3YugQ6w9v/LQNnFW9mG8b4YWd7PM78sSGIAVS569mcdLbzfwnfcgvA871EdP8uV+Yp
 8/SL+F+a/KmjEF0VotsToDRnPKritF2x08D450f77hCrQnPQ9Y5BTTXVduEdrkjpJ9hZUboWj
 SrwoPa/a3NwQo1FEzyI8y1AB56e6PAeXxRutJvrXmcb/lwnbzDIjkbRhqkkoRbAbP2C1OQSPd
 QedZzNwzUQN6oMnGW9HaPo/IphcZwcdOAN/w1t2BvSqRt2NQNOEeXy/YMH0apwUqUEhUDDnFq
 nQvRe0vBwBIEcx0phH14SrDiIjWW3EgaqgzKJpLYo4b9DykJDXDKya22EZxU7xe7oe4xYKqCE
 JYWo9MSTORMqheLTuZwa7mneyZ5ufY6eAm+h72z8AIWAjdSwYvoPdqvbt3dyyJSxWCu8Djck0
 D/zqyn9+ygVoRrjuqunbXBnDR/035wtV7zO6AGvUhd7b1n1yTkMmDrloIWK9QPPWCNlKT9E7M
 BJdUoEyOxY8qVmtWKVhzjPokQ0ve+C8Rmc/aWUjQ0SUN4HSrMUsvE4DR0qi7Ajk4U0OHjq72E
 X9Qw4LJAH8/W1tQH0A73zYjpQM+/ofKGTbX94LUmX9UX1a3JN63kIcNyKMrjo+Cxmud2i77eA
 FPcKMYOtqGZCgZNenCu7Ei1ajfkLNhJBQKtV6/y+F0MraL9TLFm1+tKg/3/h0tvth/IJ790b2
 7Vh/FnNK4NZxrU7r622lrp8BmpEd9cj3OVpi47vGtKir5uVEHatsvOxWrrdLEt/Qd8n/2iLZm
 vOlXm/FsVmljH4HkzBHtMVkynSid4AEzXcHzbsWal775TadDFm7rqwE3EGiHCzgXW6Xi71h7u
 egywaRzuJ5NMDLtumKqJa6Bz/7T/XAgXcqDUKwmOab2955eqQImHUWOzpY6NANDwIw==
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I've got a problem with my DVD drive. I believe it's either a problem
with ubuntu kernel/acpi or BIOS.

may I ask here or should I go somewhere else?

syslog is this:
> kernel: [865062.107497] ata2: SATA link up 1.5 Gbps (SStatus 113 SContro=
l 300)
> kernel: [865062.116903] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) su=
cceeded
> kernel: [865062.117710] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) su=
cceeded
> kernel: [865062.117713] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEAT=
URES) filtered out
> kernel: [865062.125563] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) su=
cceeded
> kernel: [865062.126358] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) su=
cceeded
> kernel: [865062.126363] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEAT=
URES) filtered out
> kernel: [865062.126642] ata2.00: configured for UDMA/100
> kernel: [865062.143373] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x write=
r dvd-ram cd/rw xa/form2 cdda tray
> kernel: [865062.275522] sr 1:0:0:0: Attached scsi CD-ROM sr0
> (sp=C3=A4teres Log)
> kernel: [  842.554177] sr 1:0:0:0: Attached scsi CD-ROM sr0
> kernel: [  842.554324] sr 1:0:0:0: Attached scsi generic sg1 type 5
> udisksd[1258]: Error probing device: Error opening device file /dev/sr0 =
while probing ATA specifics: No such device or address (udisks-error-quark=
, 0)
> kernel: [  843.022783] ata2.00: disabled
> kernel: [  843.023874] ata2.00: detaching (SCSI 1:0:0:0)
> kernel: [  843.023875] ACPI: \_SB_.PCI0.SAT1.PRT1: undocking

this looks like it is detected but /dev/sr0 immediately disappears.

Hardware: Thinkpad W530 newest BIOS, DVD-RW DS8A8SH
Software: Kubuntu 21.10 Impish Indri, kernel 5.13.0-30-generic

Workaround to make it work:
- Reboot
- Remove drive from laptop
- Insert drive again

this is what happens on hotplug:
> kernel: [   99.471480] ACPI: \_SB_.PCI0.SAT1.PRT1: docking
> kernel: [   99.834493] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl=
 300)
> kernel: [   99.836576] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) suc=
ceeded
> kernel: [   99.837569] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) suc=
ceeded
> kernel: [   99.837588] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATU=
RES) filtered out
> kernel: [   99.837949] ata2.00: ATAPI: PLDS DVD-RW DS8A8SH, KU54, max UD=
MA/100
> kernel: [   99.840730] ata2.00: ACPI cmd e3/00:1f:00:00:00:a0 (IDLE) suc=
ceeded
> kernel: [   99.841455] ata2.00: ACPI cmd e3/00:02:00:00:00:a0 (IDLE) suc=
ceeded
> kernel: [   99.841471] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATU=
RES) filtered out
> kernel: [   99.841831] ata2.00: configured for UDMA/100
> kernel: [   99.875381] scsi 1:0:0:0: CD-ROM            PLDS     DVD-RW D=
S8A8SH   KU54 PQ: 0 ANSI: 5
> kernel: [   99.954425] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer=
 dvd-ram cd/rw xa/form2 cdda tray
> kernel: [  100.042461] sr 1:0:0:0: Attached scsi CD-ROM sr0
> kernel: [  100.042726] sr 1:0:0:0: Attached scsi generic sg1 type 5

What makes it disappear again:
- standby
- attaching to dock
- removing from dock??
- rebooting

thank you very much

Jan





