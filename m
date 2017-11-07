Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:47443 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758143AbdKGQgX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Nov 2017 11:36:23 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/3] nvme: fix eui_show() print format
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javigon.napster@gmail.com>
In-Reply-To: <20171107162828.GA26824@lst.de>
Date: Tue, 7 Nov 2017 17:36:18 +0100
Cc: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Joe Perches <joe@perches.com>
Message-Id: <7A69CDDA-7901-4A4C-BCE4-B5A83300202C@gmail.com>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com> <1509703370-20379-4-git-send-email-javier@cnexlabs.com> <20171103125516.GC25186@lst.de> <1509722197.15520.17.camel@perches.com> <2AC384A2-C792-45AF-AF11-89CBC128C527@lightnvm.io> <20171107162828.GA26824@lst.de>
To: Christoph Hellwig <hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 7 Nov 2017, at 17.28, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Sat, Nov 04, 2017 at 12:22:20PM +0100, Javier Gonz=C3=A1lez wrote:
>>> Perhaps this should just become
>>>=20
>>>    %8ph
>>>=20
>>> without D
>>=20
>> That would be ok with me.
>=20
> Can you resend a patch for that?
>=20

Sure. I=E2=80=99ll send it tomorrow together with the copy fix with the righ=
t commit message.=20

Javier=
