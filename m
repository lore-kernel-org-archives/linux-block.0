Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F40C74A5B
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 11:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCUL0t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Mar 2023 07:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCUL0s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2023 07:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2C8D315
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2023 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679397952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wuq4P8qf3VmJv2BNFBbXGZ+QCHmun5PoFCB20jybe08=;
        b=IbDIdVTruqL1VVph+oMycarO22uIdgnizkQl/2CJSeNqSJYVisCc+CCoUYohh6/eOx1Hlx
        2OviXDZ+LZ/OiyrBacC9UTvHikL2yN8UVIRGpcPRCFlSDpyySBFPkOjW87yJjbdzUW+/uH
        VeJZW1+8zMalqXNOwLyRsimwJcDqzmA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-X9RCVi1IOqyxzJJ0JjUNNQ-1; Tue, 21 Mar 2023 07:25:46 -0400
X-MC-Unique: X9RCVi1IOqyxzJJ0JjUNNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B911800B23;
        Tue, 21 Mar 2023 11:25:45 +0000 (UTC)
Received: from localhost (unknown [10.39.193.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 996146B590;
        Tue, 21 Mar 2023 11:25:44 +0000 (UTC)
Date:   Tue, 21 Mar 2023 07:25:42 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Andreas Hindborg <nmi@metaspace.dk>, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <20230321112542.GB1073811@fedora>
References: <Y/EbEGV2Ege51RQZ@fedora>
 <Y/aijeTJ2HuITMc1@T590>
 <Y/fKC7/cTM2mpz3H@fedora>
 <ZAAWj8Bs8JujXsbX@T590>
 <20230302150925.GD2485531@fedora>
 <ZBPaHBHrRPCPN4Ge@ovpn-8-18.pek2.redhat.com>
 <20230317144128.GB237262@fedora>
 <ZBUGJf67Yx9xMhmk@ovpn-8-18.pek2.redhat.com>
 <20230320123417.GC1011461@fedora>
 <ZBh7+OjBpY8FeM3z@ovpn-8-29.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B44yYZKcDKS1EVWy"
Content-Disposition: inline
In-Reply-To: <ZBh7+OjBpY8FeM3z@ovpn-8-29.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--B44yYZKcDKS1EVWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 11:30:00PM +0800, Ming Lei wrote:
> On Mon, Mar 20, 2023 at 08:34:17AM -0400, Stefan Hajnoczi wrote:
> > On Sat, Mar 18, 2023 at 08:30:29AM +0800, Ming Lei wrote:
> > > On Fri, Mar 17, 2023 at 10:41:28AM -0400, Stefan Hajnoczi wrote:
> > > > On Fri, Mar 17, 2023 at 11:10:20AM +0800, Ming Lei wrote:
> > > > > On Thu, Mar 02, 2023 at 10:09:25AM -0500, Stefan Hajnoczi wrote:
> > > > > > On Thu, Mar 02, 2023 at 11:22:55AM +0800, Ming Lei wrote:
> > > > > > > On Thu, Feb 23, 2023 at 03:18:19PM -0500, Stefan Hajnoczi wro=
te:
> > > > > > > > On Thu, Feb 23, 2023 at 07:17:33AM +0800, Ming Lei wrote:
> > > > > > > > > On Sat, Feb 18, 2023 at 01:38:08PM -0500, Stefan Hajnoczi=
 wrote:
> > > > > > > > > > On Sat, Feb 18, 2023 at 07:22:49PM +0800, Ming Lei wrot=
e:
> > > > > > > > > > > On Fri, Feb 17, 2023 at 11:39:58AM -0500, Stefan Hajn=
oczi wrote:
> > > > > > > > > > > > On Fri, Feb 17, 2023 at 10:20:45AM +0800, Ming Lei =
wrote:
> > > > > > > > > > > > > On Thu, Feb 16, 2023 at 12:21:32PM +0100, Andreas=
 Hindborg wrote:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Ming Lei <ming.lei@redhat.com> writes:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > On Thu, Feb 16, 2023 at 10:44:02AM +0100, And=
reas Hindborg wrote:
> > > > > > > > > > > > > > >>=20
> > > > > > > > > > > > > > >> Hi Ming,
> > > > > > > > > > > > > > >>=20
> > > > > > > > > > > > > > >> Ming Lei <ming.lei@redhat.com> writes:
> > > > > > > > > > > > > > >>=20
> > > > > > > > > > > > > > >> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, =
Stefan Hajnoczi wrote:
> > > > > > > > > > > > > > >> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800,=
 Ming Lei wrote:
> > > > > > > > > > > > > > >> >> > On Wed, Feb 08, 2023 at 07:17:10AM -050=
0, Stefan Hajnoczi wrote:
> > > > > > > > > > > > > > >> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0=
800, Ming Lei wrote:
> > > > > > > > > > > > > > >> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM =
-0500, Stefan Hajnoczi wrote:
> > > > > > > > > > > > > > >> >> > > > > On Mon, Feb 06, 2023 at 11:00:27P=
M +0800, Ming Lei wrote:
> > > > > > > > > > > > > > >> >> > > > > > Hello,
> > > > > > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > > > > > >> >> > > > > > So far UBLK is only used for im=
plementing virtual block device from
> > > > > > > > > > > > > > >> >> > > > > > userspace, such as loop, nbd, q=
cow2, ...[1].
> > > > > > > > > > > > > > >> >> > > > >=20
> > > > > > > > > > > > > > >> >> > > > > I won't be at LSF/MM so here are =
my thoughts:
> > > > > > > > > > > > > > >> >> > > >=20
> > > > > > > > > > > > > > >> >> > > > Thanks for the thoughts, :-)
> > > > > > > > > > > > > > >> >> > > >=20
> > > > > > > > > > > > > > >> >> > > > >=20
> > > > > > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > > > > > >> >> > > > > > It could be useful for UBLK to =
cover real storage hardware too:
> > > > > > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > > > > > >> >> > > > > > - for fast prototype or perform=
ance evaluation
> > > > > > > > > > > > > > >> >> > > > > >=20
> > > > > > > > > > > > > > >> >> > > > > > - some network storages are att=
ached to host, such as iscsi and nvme-tcp,
> > > > > > > > > > > > > > >> >> > > > > > the current UBLK interface does=
n't support such devices, since it needs
> > > > > > > > > > > > > > >> >> > > > > > all LUNs/Namespaces to share ho=
st resources(such as tag)
> > > > > > > > > > > > > > >> >> > > > >=20
> > > > > > > > > > > > > > >> >> > > > > Can you explain this in more deta=
il? It seems like an iSCSI or
> > > > > > > > > > > > > > >> >> > > > > NVMe-over-TCP initiator could be =
implemented as a ublk server today.
> > > > > > > > > > > > > > >> >> > > > > What am I missing?
> > > > > > > > > > > > > > >> >> > > >=20
> > > > > > > > > > > > > > >> >> > > > The current ublk can't do that yet,=
 because the interface doesn't
> > > > > > > > > > > > > > >> >> > > > support multiple ublk disks sharing=
 single host, which is exactly
> > > > > > > > > > > > > > >> >> > > > the case of scsi and nvme.
> > > > > > > > > > > > > > >> >> > >=20
> > > > > > > > > > > > > > >> >> > > Can you give an example that shows ex=
actly where a problem is hit?
> > > > > > > > > > > > > > >> >> > >=20
> > > > > > > > > > > > > > >> >> > > I took a quick look at the ublk sourc=
e code and didn't spot a place
> > > > > > > > > > > > > > >> >> > > where it prevents a single ublk serve=
r process from handling multiple
> > > > > > > > > > > > > > >> >> > > devices.
> > > > > > > > > > > > > > >> >> > >=20
> > > > > > > > > > > > > > >> >> > > Regarding "host resources(such as tag=
)", can the ublk server deal with
> > > > > > > > > > > > > > >> >> > > that in userspace? The Linux block la=
yer doesn't have the concept of a
> > > > > > > > > > > > > > >> >> > > "host", that would come in at the SCS=
I/NVMe level that's implemented in
> > > > > > > > > > > > > > >> >> > > userspace.
> > > > > > > > > > > > > > >> >> > >=20
> > > > > > > > > > > > > > >> >> > > I don't understand yet...
> > > > > > > > > > > > > > >> >> >=20
> > > > > > > > > > > > > > >> >> > blk_mq_tag_set is embedded into driver =
host structure, and referred by queue
> > > > > > > > > > > > > > >> >> > via q->tag_set, both scsi and nvme allo=
cates tag in host/queue wide,
> > > > > > > > > > > > > > >> >> > that said all LUNs/NSs share host/queue=
 tags, current every ublk
> > > > > > > > > > > > > > >> >> > device is independent, and can't shard =
tags.
> > > > > > > > > > > > > > >> >>=20
> > > > > > > > > > > > > > >> >> Does this actually prevent ublk servers w=
ith multiple ublk devices or is
> > > > > > > > > > > > > > >> >> it just sub-optimal?
> > > > > > > > > > > > > > >> >
> > > > > > > > > > > > > > >> > It is former, ublk can't support multiple =
devices which share single host
> > > > > > > > > > > > > > >> > because duplicated tag can be seen in host=
 side, then io is failed.
> > > > > > > > > > > > > > >> >
> > > > > > > > > > > > > > >>=20
> > > > > > > > > > > > > > >> I have trouble following this discussion. Wh=
y can we not handle multiple
> > > > > > > > > > > > > > >> block devices in a single ublk user space pr=
ocess?
> > > > > > > > > > > > > > >>=20
> > > > > > > > > > > > > > >> From this conversation it seems that the lim=
iting factor is allocation
> > > > > > > > > > > > > > >> of the tag set of the virtual device in the =
kernel? But as far as I can
> > > > > > > > > > > > > > >> tell, the tag sets are allocated per virtual=
 block device in
> > > > > > > > > > > > > > >> `ublk_ctrl_add_dev()`?
> > > > > > > > > > > > > > >>=20
> > > > > > > > > > > > > > >> It seems to me that a single ublk user space=
 process shuld be able to
> > > > > > > > > > > > > > >> connect to multiple storage devices (for ins=
tance nvme-of) and then
> > > > > > > > > > > > > > >> create a ublk device for each namespace, all=
 from a single ublk process.
> > > > > > > > > > > > > > >>=20
> > > > > > > > > > > > > > >> Could you elaborate on why this is not possi=
ble?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > If the multiple storages devices are independ=
ent, the current ublk can
> > > > > > > > > > > > > > > handle them just fine.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > But if these storage devices(such as luns in =
iscsi, or NSs in nvme-tcp)
> > > > > > > > > > > > > > > share single host, and use host-wide tagset, =
the current interface can't
> > > > > > > > > > > > > > > work as expected, because tags is shared amon=
g all these devices. The
> > > > > > > > > > > > > > > current ublk interface needs to be extended f=
or covering this case.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Thanks for clarifying, that is very helpful.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Follow up question: What would the implications=
 be if one tried to
> > > > > > > > > > > > > > expose (through ublk) each nvme namespace of an=
 nvme-of controller with
> > > > > > > > > > > > > > an independent tag set?
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > https://lore.kernel.org/linux-block/877cwhrgul.fs=
f@metaspace.dk/T/#m57158db9f0108e529d8d62d1d56652c52e9e3e67
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > > What are the benefits of sharing a tagset across
> > > > > > > > > > > > > > all namespaces of a controller?
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > The userspace implementation can be simplified a =
lot since generic
> > > > > > > > > > > > > shared tag allocation isn't needed, meantime with=
 good performance
> > > > > > > > > > > > > (shared tags allocation in SMP is one hard proble=
m)
> > > > > > > > > > > >=20
> > > > > > > > > > > > In NVMe, tags are per Submission Queue. AFAIK there=
's no such thing as
> > > > > > > > > > > > shared tags across multiple SQs in NVMe. So userspa=
ce doesn't need an
> > > > > > > > > > >=20
> > > > > > > > > > > In reality the max supported nr_queues of nvme is oft=
en much less than
> > > > > > > > > > > nr_cpu_ids, for example, lots of nvme-pci devices jus=
t support at most
> > > > > > > > > > > 32 queues, I remembered that Azure nvme supports less=
(just 8 queues).
> > > > > > > > > > > That is because queue isn't free in both software and=
 hardware, which
> > > > > > > > > > > implementation is often tradeoff between performance =
and cost.
> > > > > > > > > >=20
> > > > > > > > > > I didn't say that the ublk server should have nr_cpu_id=
s threads. I
> > > > > > > > > > thought the idea was the ublk server creates as many th=
reads as it needs
> > > > > > > > > > (e.g. max 8 if the Azure NVMe device only has 8 queues).
> > > > > > > > > >=20
> > > > > > > > > > Do you expect ublk servers to have nr_cpu_ids threads i=
n all/most cases?
> > > > > > > > >=20
> > > > > > > > > No.
> > > > > > > > >=20
> > > > > > > > > In ublksrv project, each pthread maps to one unique hardw=
are queue, so total
> > > > > > > > > number of pthread is equal to nr_hw_queues.
> > > > > > > >=20
> > > > > > > > Good, I think we agree on that part.
> > > > > > > >=20
> > > > > > > > Here is a summary of the ublk server model I've been descri=
bing:
> > > > > > > > 1. Each pthread has a separate io_uring context.
> > > > > > > > 2. Each pthread has its own hardware submission queue (NVMe=
 SQ, SCSI
> > > > > > > >    command queue, etc).
> > > > > > > > 3. Each pthread has a distinct subrange of the tag space if=
 the tag
> > > > > > > >    space is shared across hardware submission queues.
> > > > > > > > 4. Each pthread allocates tags from its subrange without co=
ordinating
> > > > > > > >    with other threads. This is cheap and simple.
> > > > > > >=20
> > > > > > > That is also not doable.
> > > > > > >=20
> > > > > > > The tag space can be pretty small, such as, usb-storage queue=
 depth
> > > > > > > is just 1, and usb card reader can support multi lun too.
> > > > > >=20
> > > > > > If the tag space is very limited, just create one pthread.
> > > > >=20
> > > > > What I meant is that sub-range isn't doable.
> > > > >=20
> > > > > And pthread is aligned with queue, that is nothing to do with nr_=
tags.
> > > > >=20
> > > > > >=20
> > > > > > > That is just one extreme example, but there can be more low q=
ueue depth
> > > > > > > scsi devices(sata : 32, ...), typical nvme/pci queue depth is=
 1023, but
> > > > > > > there could be some implementation with less.
> > > > > >=20
> > > > > > NVMe PCI has per-sq tags so subranges aren't needed. Each pthre=
ad has
> > > > > > its own independent tag space. That means NVMe devices with low=
 queue
> > > > > > depths work fine in the model I described.
> > > > >=20
> > > > > NVMe PCI isn't special, and it is covered by current ublk abstrac=
t, so one way
> > > > > or another, we should not support both sub-range or non-sub-range=
 for
> > > > > avoiding unnecessary complexity.
> > > > >=20
> > > > > "Each pthread has its own independent tag space" may mean two thi=
ngs
> > > > >=20
> > > > > 1) each LUN/NS is implemented in standalone process space:
> > > > > - so every queue of each LUN has its own space, but all the queue=
s with
> > > > > same ID share the whole queue tag space
> > > > > - that matches with current ublksrv
> > > > > - also easier to implement
> > > > >=20
> > > > > 2) all LUNs/NSs are implemented in single process space
> > > > > - so each pthread handles one queue for all NSs/LUNs
> > > > >=20
> > > > > Yeah, if you mean 2), the tag allocation is cheap, but the existe=
d ublk
> > > > > char device has to handle multiple LUNs/NSs(disks), which still n=
eed
> > > > > (big) ublk interface change. Also this way can't scale for single=
 queue
> > > > > devices.
> > > >=20
> > > > The model I described is neither 1) or 2). It's similar to 2) but I=
'm
> > > > not sure why you say the ublk interface needs to be changed. I'm af=
raid
> > > > I haven't explained it well, sorry. I'll try to describe it again w=
ith
> > > > an NVMe PCI adapter being handled by userspace.
> > > >=20
> > > > There is a single ublk server process with an NVMe PCI device opened
> > > > using VFIO.
> > > >=20
> > > > There are N pthreads and each pthread has 1 io_uring context and 1 =
NVMe
> > > > PCI SQ/CQ pair. The size of the SQ and CQ rings is QD.
> > > >=20
> > > > The NVMe PCI device has M Namespaces. The ublk server creates M
> > > > ublk_devices. Each ublk_device has N ublk_queues with queue_depth Q=
D.
> > > >=20
> > > > The Linux block layer sees M block devices with N nr_hw_queues and =
QD
> > > > queue_depth. The actual NVMe PCI device resources are less than wha=
t the
> > > > Linux block layer sees because the each SQ/CQ pair is used for M
> > > > ublk_devices. In other words, Linux thinks there can be M * N * QD
> > > > requests in flight but in reality the NVMe PCI adapter only support=
s N *
> > > > QD requests.
> > >=20
> > > Yeah, but it is really bad.
> > >=20
> > > Now QD is the host hard queue depth, which can be very big, and could=
 be
> > > more than thousands.
> > >=20
> > > ublk driver doesn't understand this kind of sharing(tag, io command b=
uffer, io
> > > buffers), M * M * QD requests are submitted to ublk server, and CPUs/=
memory
> > > are wasted a lot.
> > >=20
> > > Every device has to allocate command buffers for holding QD io comman=
ds, and
> > > command buffer is supposed to be per-host, instead of per-disk. Same =
with io
> > > buffer pre-allocation in userspace side.
> >=20
> > I agree with you in cases with lots of LUNs (large M), block layer and
> > ublk driver per-request memory is allocated that cannot be used
> > simultaneously.
> >=20
> > > Userspace has to re-tag the requests for avoiding duplicated tag, and
> > > requests have to be throttled in ublk server side. If you implement t=
ag allocation
> > > in userspace side, it is still one typical shared data issue in SMP, =
M pthreads
> > > contends on single tags from multiple CPUs.
> >=20
> > Here I still disagree. There is no SMP contention with NVMe because tags
> > are per SQ. For SCSI the tag namespace is shared but each pthread can
> > trivially work with a sub-range to avoid SMP contention. If the tag
> > namespace is too small for sub-ranges, then there should be fewer
> > pthreads.
> >=20
> > > >=20
> > > > Now I'll describe how userspace can take care of the mismatch betwe=
en
> > > > the Linux block layer and the NVMe PCI device without doing much wo=
rk:
> > > >=20
> > > > Each pthread sets up QD UBLK_IO_COMMIT_AND_FETCH_REQ io_uring_cmds =
for
> > > > each of the M Namespaces.
> > > >=20
> > > > When userspace receives a request from ublk, it cannot simply copy =
the
> > > > struct ublksrv_io_cmd->tag field into the NVMe SQE Command Identifi=
er
> > > > (CID) field. There would be collisions between the tags used across=
 the
> > > > M ublk_queues that the pthread services.
> > > >=20
> > > > Userspace selects a free tag (e.g. from a bitmap with QD elements) =
and
> > > > uses that as the NVMe Command Identifier. This is trivial because e=
ach
> > > > pthread has its own bitmap and NVMe Command Identifiers are per-SQ.
> > >=20
> > > I believe I have explained, in reality, NVME SQ/CQ pair can be less(
> > > or much less) than nr_cpu_ids, so the per-queue-tags can be allocated=
 & freed
> > > among CPUs of (nr_cpu_ids / nr_hw_queues).
> > >=20
> > > Not mention userspace is capable of overriding the pthread cpu affini=
ty,
> > > so it isn't trivial & cheap, M pthreads could be run from
> > > more than (nr_cpu_ids / nr_hw_queues) CPUs and contend on the single =
hw queue tags.
> >=20
> > I don't understand your nr_cpu_ids concerns. In the model I have
> > described, the number of pthreads is min(nr_cpu_ids, max_sq_cq_pairs)
> > and the SQ/CQ pairs are per pthread. There is no sharing of SQ/CQ pairs
> > across pthreads.
> >=20
> > On a limited NVMe controller nr_cpu_ids=3D128 and max_sq_cq_pairs=3D8, =
so
> > there are only 8 pthreads. Each pthread has its own io_uring context
> > through which it handles M ublk_queues. Even if a pthread runs from more
> > than 1 CPU, its SQ Command Identifiers (tags) are only used by that
> > pthread and there is no SMP contention.
> >=20
> > Can you explain where you see SMP contention for NVMe SQ Command
> > Identifiers?
>=20
> ublk server queue pthread is aligned with hw queue in ublk driver, and it=
s affinity is
> retrieved from ublk blk-mq's hw queue's affinity.
>=20
> So if nr_hw_queues is 8, nr_cpu_ids is 128, there will be 16 cpus mapped
> to each hw queue. For example, hw queue 0's cpu affinity is cpu 0 ~ 15,
> and affinity of pthread for handling hw queue 0 is cpu 0 ~ 15 too.
>=20
> Now if we have M ublk devices, pthead 0(hw queue 0) of these M devices
> share same hw queue tags. M pthreads could be scheduled among cpu0~15,
> and tag is allocated from M pthreads among cpu0~15, contention?
>=20
> That is why I mentioned, if all devices are implemented in same process, =
and
> each pthread is handling host hardware queue for all M devices, the conte=
ntion
> can be avoided. However, ublk server still needs lots of change.

I see. In the model I described each pthread services all M devices so
the contention is avoided.

Stefan

--B44yYZKcDKS1EVWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQZlDYACgkQnKSrs4Gr
c8iRpQgAyino1RML6Bg/4XswpaNcXwiDCso6CfXICz2F9oe5FbGP/eLW+qErBOOh
0n5o657pGkM5G07VxOKEQ9MrblAA8OkO5qN7O6fPgJ3ULY60e3ZTKP6bmj2lSr4F
sdbo8CnCXmkWJIOdzjsPPK2xdaok2NsXzhtTQUmZqnJG5Xa7PPoulGYJ7wHovIt0
0Kgv2AxpB5JHVA2oNU7VFx33Wp9YqOSnd6xZuR6PCdS1+iiL56iOsg+iPM5AfFDd
6n/hFAFiH5BfVmC92zoRolkzN4pSKKoOlmHJ+5H57htp2lr7Q9Kh5o0unEfFP6Xg
xbxEPkpJQWGhi7I1eVfnjJb4NLoJDw==
=s3Qp
-----END PGP SIGNATURE-----

--B44yYZKcDKS1EVWy--

