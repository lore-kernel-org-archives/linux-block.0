Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4483 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbeGXPc2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jul 2018 11:32:28 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>
Subject: Re: data corruption with 'splt' workload to XFS on DM cache with its
 3 underlying devices being on same NVMe device
Date: Tue, 24 Jul 2018 14:25:41 +0000
Message-ID: <bc63227473a19cb23d6b2bb38eefa564dfec1ffc.camel@wdc.com>
References: <20180723163357.GA29658@redhat.com>
         <e761830f-e3f7-3e88-1697-b4b150e84e5f@suse.de>
In-Reply-To: <e761830f-e3f7-3e88-1697-b4b150e84e5f@suse.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, 2018-07-24 at 08:00 +-0200, Hannes Reinecke wrote:
+AD4- So, have you tested that request-based multipathing works on a partit=
ion=20
+AD4- +AF8-at all+AF8-? I'm not sure if partition mapping is done correctly=
 here+ADs- we=20
+AD4- never remap the start of the request (nor bio, come to speak of it), =
so=20
+AD4- it looks as if we would be doing the wrong things here.
+AD4-=20
+AD4- Have you checked that partition remapping is done correctly?

I think generic+AF8-make+AF8-request() takes care of partition remapping by=
 calling
blk+AF8-partition+AF8-remap(). generic+AF8-make+AF8-request() is called by =
submit+AF8-bio(). Is
that sufficient to cover all dm drivers?

Bart.
