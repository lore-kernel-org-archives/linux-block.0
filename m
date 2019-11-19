Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4908C432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 03:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4D22231A
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 03:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtD5n5y9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfKSDRT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 22:17:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55999 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727706AbfKSDRS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 22:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574133438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jAyYA1EGDo2tPO9yeEPs5RYHS0Pu4uPIaA0sXDxh2i4=;
        b=FtD5n5y9xwio6sJBdNqWaytehWkUfgucfucPXIXeUFX1M2+NABuJT7NOEOpWxJCcKV+rU6
        Q0QuK890JPtkn0V5AAEcZ4h0IWY42LoL6o0mLc9B3zTh8AIdsp1+BnX+R+S+mEELU9t5uD
        kDBbOUQzULpPKFy6E5k6MTCS5xcQnW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-X6Q0MPssOsm3aAVBipaCiw-1; Mon, 18 Nov 2019 22:17:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB7C5800A02;
        Tue, 19 Nov 2019 03:17:12 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9750B1036C6D;
        Tue, 19 Nov 2019 03:17:05 +0000 (UTC)
Date:   Tue, 19 Nov 2019 11:17:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     lkml@sdf.org, tglx@linutronix.de, kbusch@kernel.org,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: The irq Affinity is changed after the patch(Fixes: b1a5a73e64e9
 ("genirq/affinity: Spread vectors on node according to nr_cpu ratio"))
Message-ID: <20191119031700.GE391@ming.t460p>
References: <d59f7f7a-975a-2032-aa61-7cbff7585d33@hisilicon.com>
 <20191119014204.GA391@ming.t460p>
 <a8a89884-8323-ff70-f35e-0fcf5d7afefc@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <a8a89884-8323-ff70-f35e-0fcf5d7afefc@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: X6Q0MPssOsm3aAVBipaCiw-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2019 at 11:05:55AM +0800, chenxiang (M) wrote:
> Hi Ming,
>=20
> =E5=9C=A8 2019/11/19 9:42, Ming Lei =E5=86=99=E9=81=93:
> > On Tue, Nov 19, 2019 at 09:25:30AM +0800, chenxiang (M) wrote:
> > > Hi,
> > >=20
> > > There are 128 cpus and 16 irqs for SAS controller in my system, and t=
here
> > > are 4 Nodes, every 32 cpus are for one node (cpu0-31 for node0, cpu32=
-63 for
> > > node1, cpu64-95 for node2, cpu96-127 for node3).
> > > We use function pci_alloc_irq_vectors_affinity() to set the affinity =
of
> > > irqs.
> > >=20
> > > I find that  before the patch (Fixes: b1a5a73e64e9 ("genirq/affinity:=
 Spread
> > > vectors on node according to nr_cpu ratio")), the relationship betwee=
n irqs
> > > and cpus is: irq0 bind to cpu0-7, irq1 bind to cpu8-15,
> > > irq2 bind to cpu16-23, irq3 bind to cpu24-31,irq4 bind to cpu32-39...=
 irq15
> > > bind to cpu120-127. But after the patch, the relationship is changed:=
 irq0
> > > bind to cpu32-39,
> > > irq1 bind to cpu40-47, ..., irq11 bind to cpu120-127, irq12 bind to c=
pu0-7,
> > > irq13 bind to cpu8-15, irq14 bind to cpu16-23, irq15 bind to cpu24-31=
.
> > >=20
> > > I notice that before calling the sort() in function alloc_nodes_vecto=
rs(),
> > > the id of array node_vectors[] is from 0,1,2,3. But after function so=
rt(),
> > > the index of array node_vectors[] is 1,2,3,0.
> > > But i think it sorts according to the numbers of cpus in those nodes,=
 so it
> > > should be the same as before calling sort() as the numbers of cpus in=
 every
> > > node are 32.
> > Maybe there are more non-present CPUs covered by node 0.
> >=20
> > Could you provide the following log?
> >=20
> > 1) lscpu
> >=20
> > 2) ./dump-io-irq-affinity $PCI_ID_SAS
> >=20
> > =09http://people.redhat.com/minlei/tests/tools/dump-io-irq-affinity
> >=20
> > You need to figure out the PCI ID(the 1st column of lspci output) of th=
e SAS
> > controller via lspci.
>=20
> Sorry, I can't access the link you provide, but i can provide those irqs'
> affinity in the attachment.
> I also write a small testcase, and find id is 1, 2, 3, 0 after calling
> sort() .

Runtime log from /proc/interrupts isn't useful for investigating
affinity allocation issue, please use the attached script for collecting
log.


Thanks,
Ming

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dump-io-irq-affinity
Content-Transfer-Encoding: quoted-printable

#!/bin/sh

get_disk_from_pcid()
{
=09PCID=3D$1

=09DISKS=3D`find /sys/block -name "*"`
=09for DISK in $DISKS; do
=09=09DISKP=3D`realpath $DISK/device`
=09=09echo $DISKP | grep $PCID > /dev/null
=09=09[ $? -eq 0 ] && echo `basename $DISK` && break
=09done
}

dump_irq_affinity()
{
=09PCID=3D$1
=09PCIP=3D`find /sys/devices -name *$PCID | grep pci`

=09[[ ! -d $PCIP/msi_irqs ]] && return

=09IRQS=3D`ls $PCIP/msi_irqs`

=09[ $? -ne 0 ] && return

=09DISK=3D`get_disk_from_pcid $PCID`
=09echo "PCI name is $PCID: $DISK"

=09for IRQ in $IRQS; do
=09    CPUS=3D`cat /proc/irq/$IRQ/smp_affinity_list`
=09    ECPUS=3D`cat /proc/irq/$IRQ/effective_affinity_list`
=09    echo -e "\tirq $IRQ, cpu list $CPUS, effective list $ECPUS"
=09done
}


if [ $# -ge 1 ]; then
=09PCIDS=3D$1
else
#=09PCID=3D`lspci | grep "Non-Volatile memory" | cut -c1-7`
=09PCIDS=3D`lspci | grep "Non-Volatile memory controller" | awk '{print $1}=
'`
fi

echo "kernel version: "
uname -a

for PCID in $PCIDS; do
=09dump_irq_affinity $PCID
done

--LZvS9be/3tNcYl/X--

