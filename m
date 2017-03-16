Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58195 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdCPVgO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2017 17:36:14 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "tom.leiming@gmail.com" <tom.leiming@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "yizhan@redhat.com" <yizhan@redhat.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] blk-mq: don't complete un-started request in
 timeout handler
Date: Thu, 16 Mar 2017 21:35:54 +0000
Message-ID: <1489700141.2574.16.camel@sandisk.com>
References: <1489064578-17305-1-git-send-email-tom.leiming@gmail.com>
         <1489064578-17305-3-git-send-email-tom.leiming@gmail.com>
         <1489536441.2676.21.camel@sandisk.com> <20170315121851.GA15807@ming.t460p>
         <20170315124024.GA16549@ming.t460p> <1489592177.2660.1.camel@sandisk.com>
         <20170315162158.GA18768@ming.t460p> <1489613678.2660.9.camel@sandisk.com>
         <20170316000747.GA19948@ming.t460p>
In-Reply-To: <20170316000747.GA19948@ming.t460p>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-03-16 at 08:07 +0800, Ming Lei wrote:
> > * Check whether REQ_ATOM_STARTED has been set.
> > * Check whether REQ_ATOM_COMPLETE has not yet been set.
> > * If both conditions have been met, set REQ_ATOM_COMPLETE.
> >=20
> > I don't think there is another solution than using a single state varia=
ble to
> > represent the REQ_ATOM_STARTED and REQ_ATOM_COMPLETE states instead of =
two
> > independent bits. How about the patch below?
>=20
> I would review it if you can confirm me that it is a real issue, :-)

Hello Ming,

I was chasing a v4.11 regression in the SCSI stack. Since my tests of today
revealed that it's probably not a block layer issue, let's proceed with you=
r
patch.

Bart.=
