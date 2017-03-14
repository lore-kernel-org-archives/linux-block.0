Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22569 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbdCNVWO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2017 17:22:14 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH rfc 04/10] block: Add a non-selective polling interface
Date: Tue, 14 Mar 2017 21:21:59 +0000
Message-ID: <1489526506.2676.13.camel@sandisk.com>
References: <1489065402-14757-1-git-send-email-sagi@grimberg.me>
         <1489065402-14757-5-git-send-email-sagi@grimberg.me>
         <1489076712.2597.1.camel@sandisk.com>
         <b8124df3-bd09-2eb2-9899-3c9195605510@grimberg.me>
In-Reply-To: <b8124df3-bd09-2eb2-9899-3c9195605510@grimberg.me>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2017-03-13 at 10:15 +0200, Sagi Grimberg wrote:
> > Additionally, I think making the hardware context an argument of this f=
unction
> > instead of using blk_mq_map_queue(q, smp_processor_id()) would make thi=
s
> > function much more versatile.
>=20
> What do you mean? remember that the callers interface to the device is
> a request queue, it doesn't even know if its a blk-mq device. Can you
> explain in more details what you would like to see?

Have you considered to make the CPU ID an argument instead of using the
smp_processor_id() result?

Bart.=
