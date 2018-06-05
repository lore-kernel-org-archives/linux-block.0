Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:15769 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751734AbeFEQQN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Jun 2018 12:16:13 -0400
Date: Tue, 5 Jun 2018 10:18:53 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        osandov@osandov.com, linux-nvme@lists.infradead.org,
        ming.lei@redhat.com
Subject: Re: blktests block/019 lead system hang
Message-ID: <20180605161853.GB16899@localhost.localdomain>
References: <838678680.4693215.1527664726174.JavaMail.zimbra@redhat.com>
 <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, May 30, 2018 at 03:26:54AM -0400, Yi Zhang wrote:
> Hi Keith
> I found blktest block/019 also can lead my NVMe server hang with 4.17.0-rc7, let me know if you need more info, thanks. 
> 
> Server: Dell R730xd
> NVMe SSD: 85:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller 172X (rev 01)
> 
> Console log:
> Kernel 4.17.0-rc7 on an x86_64
> 
> storageqe-62 login: [ 6043.121834] run blktests block/019 at 2018-05-30 03:16:34
> [ 6049.108476] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 3
> [ 6049.108478] {1}[Hardware Error]: event severity: fatal
> [ 6049.108479] {1}[Hardware Error]:  Error 0, type: fatal
> [ 6049.108481] {1}[Hardware Error]:   section_type: PCIe error
> [ 6049.108482] {1}[Hardware Error]:   port_type: 6, downstream switch port
> [ 6049.108483] {1}[Hardware Error]:   version: 1.16
> [ 6049.108484] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
> [ 6049.108485] {1}[Hardware Error]:   device_id: 0000:83:05.0
> [ 6049.108486] {1}[Hardware Error]:   slot: 0
> [ 6049.108487] {1}[Hardware Error]:   secondary_bus: 0x85
> [ 6049.108488] {1}[Hardware Error]:   vendor_id: 0x10b5, device_id: 0x8734
> [ 6049.108489] {1}[Hardware Error]:   class_code: 000406
> [ 6049.108489] {1}[Hardware Error]:   bridge: secondary_status: 0x0000, control: 0x0003
> [ 6049.108491] Kernel panic - not syncing: Fatal hardware error!
> [ 6049.108514] Kernel Offset: 0x25800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Sounds like your platform fundamentally doesn't support surprise link
down if it considers the event a fatal error. That's sort of what this
test was supposed to help catch so we know what platforms can do this
vs ones that can't.

The test does check that the slot is hotplug capable before running,
so it's supposed to only run the test on slots that claim to be capable
of handling the event. I just don't know of a good way to query platform
firmware to know what it will do in response to such an event.
