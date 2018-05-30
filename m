Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935385AbeE3H0z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 May 2018 03:26:55 -0400
Date: Wed, 30 May 2018 03:26:54 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: Keith Busch <keith.busch@intel.com>
Cc: ming.lei@redhat.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, osandov@osandov.com
Message-ID: <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
In-Reply-To: <838678680.4693215.1527664726174.JavaMail.zimbra@redhat.com>
Subject: blktests block/019 lead system hang
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Keith
I found blktest block/019 also can lead my NVMe server hang with 4.17.0-rc7, let me know if you need more info, thanks. 

Server: Dell R730xd
NVMe SSD: 85:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller 172X (rev 01)

Console log:
Kernel 4.17.0-rc7 on an x86_64

storageqe-62 login: [ 6043.121834] run blktests block/019 at 2018-05-30 03:16:34
[ 6049.108476] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 3
[ 6049.108478] {1}[Hardware Error]: event severity: fatal
[ 6049.108479] {1}[Hardware Error]:  Error 0, type: fatal
[ 6049.108481] {1}[Hardware Error]:   section_type: PCIe error
[ 6049.108482] {1}[Hardware Error]:   port_type: 6, downstream switch port
[ 6049.108483] {1}[Hardware Error]:   version: 1.16
[ 6049.108484] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
[ 6049.108485] {1}[Hardware Error]:   device_id: 0000:83:05.0
[ 6049.108486] {1}[Hardware Error]:   slot: 0
[ 6049.108487] {1}[Hardware Error]:   secondary_bus: 0x85
[ 6049.108488] {1}[Hardware Error]:   vendor_id: 0x10b5, device_id: 0x8734
[ 6049.108489] {1}[Hardware Error]:   class_code: 000406
[ 6049.108489] {1}[Hardware Error]:   bridge: secondary_status: 0x0000, control: 0x0003
[ 6049.108491] Kernel panic - not syncing: Fatal hardware error!
[ 6049.108514] Kernel Offset: 0x25800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)


Best Regards,
  Yi Zhang
