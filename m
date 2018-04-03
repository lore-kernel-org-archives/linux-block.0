Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46181 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753216AbeDCTBc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Apr 2018 15:01:32 -0400
Message-Id: <1522782091.951690.1325310168.33572B11@webmail.messagingengine.com>
From: Nikolaus Rath <nikolaus@rath.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Date: Tue, 03 Apr 2018 20:01:31 +0100
Subject: bcache: bad block header
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

[ Re-send to both linux-block and linux-bcache ]

Hi,

A few days ago, my system refused to boot because it couldn't find the root=
 filesystem anymore. The root filesystem is ext4 on LVM on dm-crypt on bcac=
he, using kernel 4.9.92 (from Debian stretch). Booting from a recovery medi=
um with Kernel 4.16, I got:

[=C2=A0=C2=A0 84.551715] bcache: register_bcache() error /dev/sda4: device =
already registered
[=C2=A0=C2=A0 84.553188] bcache: register_bcache() error /dev/sdc2: device =
already registered
[=C2=A0=C2=A0 84.616438] bcache: error on 1330b5f6-0c13-43ec-b925-2ee2734b1=
35f:
[=C2=A0=C2=A0 84.616440] bad btree header at bucket 85065, block 0, 0 keys
[=C2=A0=C2=A0 84.616442] , disabling caching
[=C2=A0=C2=A0 84.616445] bcache: register_cache() registered cache device s=
db2
[=C2=A0=C2=A0 84.616597] bcache: cache_set_free() Cache set 1330b5f6-0c13-4=
3ec-b925-2ee2734b135f unregistered
[=C2=A0=C2=A0 85.375933]=C2=A0 sdb: sdb1 sdb2 sdb4 < sdb5 >
[=C2=A0=C2=A0 85.416610] bcache: error on 1330b5f6-0c13-43ec-b925-2ee2734b1=
35f:
[=C2=A0=C2=A0 85.416612] bad btree header at bucket 85065, block 0, 0 keys
[=C2=A0=C2=A0 85.416614] , disabling caching
[=C2=A0=C2=A0 85.416618] bcache: register_cache() registered cache device s=
db2
[=C2=A0=C2=A0 85.416624] bcache: register_bcache() error /dev/sdc2: device =
already registered
[=C2=A0=C2=A0 85.416626] bcache: register_bcache() error /dev/sda4: device =
already registered
[=C2=A0=C2=A0 85.416796] bcache: cache_set_free() Cache set 1330b5f6-0c13-4=
3ec-b925-2ee2734b135f unregistered
[=C2=A0=C2=A0 85.488246] bcache: error on 1330b5f6-0c13-43ec-b925-2ee2734b1=
35f:
[=C2=A0=C2=A0 85.488249] bad btree header at bucket 85065, block 0, 0 keys
[=C2=A0=C2=A0 85.488251] , disabling caching
[=C2=A0=C2=A0 85.488254] bcache: register_cache() registered cache device s=
db2
[=C2=A0=C2=A0 85.488429] bcache: cache_set_free() Cache set 1330b5f6-0c13-4=
3ec-b925-2ee2734b135f unregistered
[=C2=A0=C2=A0 85.560003] bcache: error on 1330b5f6-0c13-43ec-b925-2ee2734b1=
35f:
[=C2=A0=C2=A0 85.560006] bad btree header at bucket 85065, block 0, 0 keys
[=C2=A0=C2=A0 85.560008] , disabling caching
[=C2=A0=C2=A0 85.560013] bcache: register_cache() registered cache device s=
db2
[=C2=A0=C2=A0 85.560017] bcache: register_bcache() error /dev/sda4: device =
already registered
[=C2=A0=C2=A0 85.560217] bcache: cache_set_free() Cache set 1330b5f6-0c13-4=
3ec-b925-2ee2734b135f unregistered
[=C2=A0=C2=A0 85.571950] bcache: register_bcache() error /dev/sdc2: device =
already registered
[=C2=A0=C2=A0 85.580628] bcache: register_bcache() error /dev/sdc2: device =
already registered
[=C2=A0=C2=A0 85.761969] bcache: register_bcache() error /dev/sda4: device =
already registered
[=C2=A0=C2=A0 85.792749] bcache: register_bcache() error /dev/sda4: device =
already registered
[=C2=A0=C2=A0 85.952931] bcache: register_bcache() error /dev/sda4: device =
already registered
[=C2=A0=C2=A0 85.955640] bcache: register_bcache() error /dev/sda4: device =
already registered
[...]

These are the first messages that mention bcache. Note that the first messa=
ge is that the device is already registered - is that normal?

smartctl does not report any errors on backing or caching disks, and the sy=
stem was shutdown cleanly.

The only possibly related thing that comes to mind is that a few days ago I=
 hibernated and resumed the system (this is something I normally don't do).=
 Resume worked fine as far as I could tell though, and there have been no u=
nclean shutdowns.

Is there a way to narrow down what may have caused this corruption?

And, is there a way to gracefully recover from this situation without wipin=
g everything? Since the message mentions only problems with one block, can =
I maybe tell bcache to just ignore/drop this specific block?

Thanks!
-Nikolaus
--
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=AB
