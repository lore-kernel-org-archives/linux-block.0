Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28433 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeHWFUx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Aug 2018 01:20:53 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>
CC: "osandov@fb.com" <osandov@fb.com>,
        "msnitzer@redhat.com" <msnitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/3] Add NVMeOF multipath tests
Date: Thu, 23 Aug 2018 01:53:33 +0000
Message-ID: <775a05ab91aed62b980ecfff1525ac3d71017752.camel@wdc.com>
References: <20180815203728.19521-1-bart.vanassche@wdc.com>
         <20180820073059.quvg3bh4ngv5ka4x@linux-x5ow.site>
         <ee851ae7b88a93b9b5c9f1b0c6e206944c0b3c64.camel@wdc.com>
         <20180821064619.7tyhlst74qkrw4fi@linux-x5ow.site>
In-Reply-To: <20180821064619.7tyhlst74qkrw4fi@linux-x5ow.site>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2018-08-21 at 08:46 +-0200, Johannes Thumshirn wrote:
+AD4- On Mon, Aug 20, 2018 at 03:46:45PM +-0000, Bart Van Assche wrote:
+AD4- +AD4- Moving these tests into the nvme directory is possible but will=
 make it
+AD4- +AD4- harder to run the NVMeOF multipath tests separately. Are you fi=
ne with this?
+AD4-=20
+AD4- Both way's have it's up and downsides, I agree.
+AD4-=20
+AD4- Having two distinct groups requires to run './check nvme nvmeof-mp' t=
o
+AD4- run full coverage with nvme.
+AD4-=20
+AD4- Having it all in one group would require to run './check nvme 18 19 2=
0
+AD4- 21 22 23 24 ...' to get only the dm-mpath ones.
+AD4-=20
+AD4- Honestly I hate both but your's (the two distinct groups) is probably
+AD4- easier to handle in the end, I have to admit.

Omar, do you have a preference for one of the two aforementioned approaches=
?

Thanks,

Bart.
