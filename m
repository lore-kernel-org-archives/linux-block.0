Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B1C432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 06:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213F12230B
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 06:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuvypqzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbfKSG4Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:56:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52745 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725536AbfKSG4Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Nov 2019 01:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574146582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JiJNU7d8EXtHVxPNjP09e186Srj5FkgJRqMKxLss4OU=;
        b=iuvypqzYEGe4E/IQQC7BxMBvSIYeTseCu1BDd5oolCPFeIhsUo8uVhAfRdrzY3FCV2PAYF
        +Lgb2sMQxbotguo8gL0DBEuGcK9YasETJCT6ifeTEe1EvBT4LJsn5akHW2kQ5XUBz/jg4R
        fYKUeR+c15SGMrHurEIMXiNRAMa3RXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-i0htFVo4PKaHXrQU069Rqg-1; Tue, 19 Nov 2019 01:56:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B05F7DB61;
        Tue, 19 Nov 2019 06:56:19 +0000 (UTC)
Received: from ming.t460p (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F45A5E251;
        Tue, 19 Nov 2019 06:56:11 +0000 (UTC)
Date:   Tue, 19 Nov 2019 14:56:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     lkml@sdf.org, tglx@linutronix.de, kbusch@kernel.org,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: The irq Affinity is changed after the patch(Fixes: b1a5a73e64e9
 ("genirq/affinity: Spread vectors on node according to nr_cpu ratio"))
Message-ID: <20191119065607.GC18214@ming.t460p>
References: <d59f7f7a-975a-2032-aa61-7cbff7585d33@hisilicon.com>
 <20191119014204.GA391@ming.t460p>
 <a8a89884-8323-ff70-f35e-0fcf5d7afefc@hisilicon.com>
 <20191119031700.GE391@ming.t460p>
 <75a630b2-029b-0a3e-79a9-d11143a033ad@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <75a630b2-029b-0a3e-79a9-d11143a033ad@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: i0htFVo4PKaHXrQU069Rqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 19, 2019 at 11:32:48AM +0800, chenxiang (M) wrote:
>=20
>=20
> =E5=9C=A8 2019/11/19 11:17, Ming Lei =E5=86=99=E9=81=93:
> > On Tue, Nov 19, 2019 at 11:05:55AM +0800, chenxiang (M) wrote:
> > > Hi Ming,
> > >=20
> > > =E5=9C=A8 2019/11/19 9:42, Ming Lei =E5=86=99=E9=81=93:
> > > > On Tue, Nov 19, 2019 at 09:25:30AM +0800, chenxiang (M) wrote:
> > > > > Hi,
> > > > >=20
> > > > > There are 128 cpus and 16 irqs for SAS controller in my system, a=
nd there
> > > > > are 4 Nodes, every 32 cpus are for one node (cpu0-31 for node0, c=
pu32-63 for
> > > > > node1, cpu64-95 for node2, cpu96-127 for node3).
> > > > > We use function pci_alloc_irq_vectors_affinity() to set the affin=
ity of
> > > > > irqs.
> > > > >=20
> > > > > I find that  before the patch (Fixes: b1a5a73e64e9 ("genirq/affin=
ity: Spread
> > > > > vectors on node according to nr_cpu ratio")), the relationship be=
tween irqs
> > > > > and cpus is: irq0 bind to cpu0-7, irq1 bind to cpu8-15,
> > > > > irq2 bind to cpu16-23, irq3 bind to cpu24-31,irq4 bind to cpu32-3=
9... irq15
> > > > > bind to cpu120-127. But after the patch, the relationship is chan=
ged: irq0
> > > > > bind to cpu32-39,
> > > > > irq1 bind to cpu40-47, ..., irq11 bind to cpu120-127, irq12 bind =
to cpu0-7,
> > > > > irq13 bind to cpu8-15, irq14 bind to cpu16-23, irq15 bind to cpu2=
4-31.
> > > > >=20
> > > > > I notice that before calling the sort() in function alloc_nodes_v=
ectors(),
> > > > > the id of array node_vectors[] is from 0,1,2,3. But after functio=
n sort(),
> > > > > the index of array node_vectors[] is 1,2,3,0.
> > > > > But i think it sorts according to the numbers of cpus in those no=
des, so it
> > > > > should be the same as before calling sort() as the numbers of cpu=
s in every
> > > > > node are 32.
> > > > Maybe there are more non-present CPUs covered by node 0.
> > > >=20
> > > > Could you provide the following log?
> > > >=20
> > > > 1) lscpu
> > > >=20
> > > > 2) ./dump-io-irq-affinity $PCI_ID_SAS
> > > >=20
> > > > =09http://people.redhat.com/minlei/tests/tools/dump-io-irq-affinity
> > > >=20
> > > > You need to figure out the PCI ID(the 1st column of lspci output) o=
f the SAS
> > > > controller via lspci.
> > > Sorry, I can't access the link you provide, but i can provide those i=
rqs'
> > > affinity in the attachment.
> > > I also write a small testcase, and find id is 1, 2, 3, 0 after callin=
g
> > > sort() .
> > Runtime log from /proc/interrupts isn't useful for investigating
> > affinity allocation issue, please use the attached script for collectin=
g
> > log.
>=20
> Note: there are 32 irqs for SAS controller, irq0-15 are other interrupts
> (such as phy up/down/channel....), only irq 16-31 are cq interrupts which=
 is
> processed by function pci_alloc_irq_vectors_affinity().
> The log is as follows:
>=20
> Euler:~ # ./dump-io-irq-affinity 74:02.0
> kernel version:
> Linux Euler 5.4.0-rc2-14683-g74684b1-dirty #224 SMP PREEMPT Mon Nov 18
> 18:54:27 CST 2019 aarch64 aarch64 aarch64 GNU/Linux
> PCI name is 74:02.0: sdd
> cat: /proc/irq/65/smp_affinity_list: No such file or directory
> cat: /proc/irq/65/effective_affinity_list: No such file or directory
>     irq 65, cpu list , effective list
>     irq 66, cpu list 0-31, effective list 0
>     irq 67, cpu list 0-31, effective list 0
> cat: /proc/irq/68/smp_affinity_list: No such file or directory
> cat: /proc/irq/68/effective_affinity_list: No such file or directory
>     irq 68, cpu list , effective list
> cat: /proc/irq/69/smp_affinity_list: No such file or directory
> cat: /proc/irq/69/effective_affinity_list: No such file or directory
>     irq 69, cpu list , effective list
> cat: /proc/irq/70/smp_affinity_list: No such file or directory
> cat: /proc/irq/70/effective_affinity_list: No such file or directory
>     irq 70, cpu list , effective list
> cat: /proc/irq/71/smp_affinity_list: No such file or directory
> cat: /proc/irq/71/effective_affinity_list: No such file or directory
>     irq 71, cpu list , effective list
> cat: /proc/irq/72/smp_affinity_list: No such file or directory
> cat: /proc/irq/72/effective_affinity_list: No such file or directory
>     irq 72, cpu list , effective list
> cat: /proc/irq/73/smp_affinity_list: No such file or directory
> cat: /proc/irq/73/effective_affinity_list: No such file or directory
>     irq 73, cpu list , effective list
> cat: /proc/irq/74/smp_affinity_list: No such file or directory
> cat: /proc/irq/74/effective_affinity_list: No such file or directory
>     irq 74, cpu list , effective list
> cat: /proc/irq/75/smp_affinity_list: No such file or directory
> cat: /proc/irq/75/effective_affinity_list: No such file or directory
>     irq 75, cpu list , effective list
>     irq 76, cpu list 0-31, effective list 0
> cat: /proc/irq/77/smp_affinity_list: No such file or directory
> cat: /proc/irq/77/effective_affinity_list: No such file or directory
>     irq 77, cpu list , effective list
> cat: /proc/irq/78/smp_affinity_list: No such file or directory
> cat: /proc/irq/78/effective_affinity_list: No such file or directory
>     irq 78, cpu list , effective list
> cat: /proc/irq/79/smp_affinity_list: No such file or directory
> cat: /proc/irq/79/effective_affinity_list: No such file or directory
>     irq 79, cpu list , effective list
> cat: /proc/irq/80/smp_affinity_list: No such file or directory
> cat: /proc/irq/80/effective_affinity_list: No such file or directory
>     irq 80, cpu list , effective list
>     irq 81, cpu list 32-39, effective list 32
>     irq 82, cpu list 40-47, effective list 40
>     irq 83, cpu list 48-55, effective list 48
>     irq 84, cpu list 56-63, effective list 56
>     irq 85, cpu list 64-71, effective list 64
>     irq 86, cpu list 72-79, effective list 72
>     irq 87, cpu list 80-87, effective list 80
>     irq 88, cpu list 88-95, effective list 88
>     irq 89, cpu list 96-103, effective list 96
>     irq 90, cpu list 104-111, effective list 104
>     irq 91, cpu list 112-119, effective list 112
>     irq 92, cpu list 120-127, effective list 120
>     irq 93, cpu list 0-7, effective list 0
>     irq 94, cpu list 8-15, effective list 8
>     irq 95, cpu list 16-23, effective list 16
>     irq 96, cpu list 24-31, effective list 24

OK, nothing is wrong.

That is the implementation of sort().

If you provide the following array to sort():

=09struct elem {
=09        unsigned id;
=09        unsigned val;
=09};
=09struct elem A[4] =3D {{0, 4}, {1, 4}, {2, 4}, {3, 4}};

And the output will becomes:

=09A =3D {{1, 4}, {2, 4}, {3, 4}, {0, 4}};

It can't be problem for users of pci_alloc_irq_vectors_affinity() cause
all nodes are symmetric, can it?


Thanks,
Ming

