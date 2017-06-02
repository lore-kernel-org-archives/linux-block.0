Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32228 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBWiy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jun 2017 18:38:54 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@fb.com" <axboe@fb.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Block device integrity support
Date: Fri, 2 Jun 2017 22:38:48 +0000
Message-ID: <1496443127.1214.27.camel@sandisk.com>
References: <1496440434.1214.23.camel@sandisk.com>
         <yq1lgpahvtp.fsf@oracle.com>
In-Reply-To: <yq1lgpahvtp.fsf@oracle.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-06-02 at 18:24 -0400, Martin K. Petersen wrote:
> > then the output shown below appears in the kernel log. Does anyone know=
 how
> > to fix this? Sorry but I'm not really familiar with the integrity
> > code.
>=20
> Dmitry posted a fix for this a few weeks ago.

Ah, that's right. Jens, had you noticed this message:
https://www.spinics.net/lists/fstests/msg06214.html?

Thanks,

Bart.=
