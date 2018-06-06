Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtprelay6.synopsys.com ([198.182.37.59]:37714 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbeFFHff (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jun 2018 03:35:35 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4F5011E04A3
        for <linux-block@vger.kernel.org>; Wed,  6 Jun 2018 09:35:34 +0200 (CEST)
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
To: Christoph Hellwig <hch@infradead.org>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
CC: "\"Jens Axboe <axboe@kernel.dk>; Hannes Reinecke <hare@suse.com>;
        Johannes Thumshirn <jthumshirn@suse.de>; Omar Sandoval <osandov@fb.com>;
        Mike Snitzer <snitzer@redhat.com>; Shaohua Li <shli@fb.com>; Bart Van
        Assche <bart.vanassche@wdc.com> ; Keith Busch <keith.busch@intel.com>;
        Ming Lei\"@synopsys.com <\"Jens Axboe <axboe@kernel.dk>; Hannes Reinecke
        <hare@suse.com>; Johannes Thumshirn <jthumshirn@suse.de>; Omar Sandoval
        <osandov@fb.com>; Mike Snitzer <snitzer@redhat.com>; Shaohua Li
        <shli@fb.com>; Bart Van Ass"
        <"keith.busch@intel.com>; Ming Lei\""@synopsys.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org; Manjunath M Bettegowda
        <manjumb@synopsys.com>; Prabu Thangamuthu <prabut@synopsys.com>; Tejas
        Joglekar <joglekar@synopsys.com>; Joao Pinto"
        <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] block: Add block level changes for inline encryption
Date: Wed, 6 Jun 2018 07:35:29 +0000
Message-ID: <BD7FB879CC136E419544C8E2AE7B9C3020C566@IN01WEMBXA.internal.synopsys.com>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
 <20180601081330.GA13067@infradead.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Friday 01 June 2018 09:13 AM, Christoph Hellwig wrote:=0A=
> On Mon, May 28, 2018 at 02:43:09PM +0100, Ladvine D Almeida wrote:=0A=
>> This patch introduces new variable under bio structure to=0A=
>> facilitate inline encryption. This variable is used to=0A=
>> associate I/O requests to crypto information.=0A=
> This seems to be missing a whole lot of context.  Where is the whole=0A=
> series showing what you are trying to do?=0A=
>=0A=
Christoph,=0A=
=0A=
The patches are generated in the below manner, with a thought of sending se=
parately to the MAINTAINERS responsible for each.=0A=
=0A=
For block level changes:=0A=
https://patchwork.kernel.org/patch/10432255/=0A=
=0A=
For dmcrypt changes for Full Disk Encryption support:=0A=
https://lkml.org/lkml/2018/5/28/1027=0A=
=0A=
UFS Host Controller driver changes, patch-series for Inline Encryption supp=
ort:=0A=
https://lkml.org/lkml/2018/5/28/1187 -- cover letter=0A=
https://lkml.org/lkml/2018/5/28/1153=0A=
https://lkml.org/lkml/2018/5/28/1196=0A=
https://lkml.org/lkml/2018/5/28/1158=0A=
https://lkml.org/lkml/2018/5/28/1173=0A=
https://lkml.org/lkml/2018/5/28/1178=0A=
=0A=
Best Regards,=0A=
=0A=
Ladvine=0A=
=0A=
=0A=
