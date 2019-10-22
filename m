Return-Path: <SRS0=K2Ob=YP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A236CA9EAF
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 00:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5CB2084C
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 00:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uk9oK4tZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfJVAQb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:16:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53891 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730065AbfJVAQb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 20:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571703389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQeforminH7Yw0nowNQJcAds3LrJioeMDpY//h1GWng=;
        b=Uk9oK4tZQCt1Wb2XOxUnmsuX/g/qsc2dmSoDePuOEoVTZU5DyCc+QQsJflyHEHmG3ycNwY
        LAC400Ut8wRhN3WBOAiYoD+4pqYrjdOBiT1SUC0ZMwfaGCVEVMa/uSXyX5WRB74vGY/Ehg
        porDE3mFjUGM9SlmAGGWpcjDVjRzWvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-GR8QRKuMNSeOaHpu770YmA-1; Mon, 21 Oct 2019 20:16:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C02F100550E;
        Tue, 22 Oct 2019 00:16:26 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DBFDE19C6A;
        Tue, 22 Oct 2019 00:16:19 +0000 (UTC)
Date:   Tue, 22 Oct 2019 08:16:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
Message-ID: <20191022001613.GA32193@ming.t460p>
References: <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
 <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
 <20191021093448.GA22635@ming.t460p>
 <9e6e86a5-7247-4648-9df9-61f81d2df413@huawei.com>
 <20191021102401.GB22635@ming.t460p>
 <c98c0cd5-950d-5404-eeaf-4e4ed6c86acc@huawei.com>
 <20191021125327.GA25864@ming.t460p>
 <d4c8e435-b243-4734-6383-3618ad303842@huawei.com>
MIME-Version: 1.0
In-Reply-To: <d4c8e435-b243-4734-6383-3618ad303842@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: GR8QRKuMNSeOaHpu770YmA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 21, 2019 at 03:02:56PM +0100, John Garry wrote:
> On 21/10/2019 13:53, Ming Lei wrote:
> > On Mon, Oct 21, 2019 at 12:49:53PM +0100, John Garry wrote:
> > > > > >=20
> > > > >=20
> > > > > Yes, we share tags among all queues, but we generate the tag - kn=
own as IPTT
> > > > > - in the LLDD now, as we can no longer use the request tag (as it=
 is not
> > > > > unique per all queues):
> > > > >=20
> > > > > https://github.com/hisilicon/kernel-dev/commit/087b95af374be69655=
83c1673032fb33bc8127e8#diff-f5d8fff19bc539a7387af5230d4e5771R188
> > > > >=20
> > > > > As I said, the branch is messy and I did have to fix 087b95af374.
> > > >=20
> > > > Firstly this way may waste lots of memory, especially the queue dep=
th is
> > > > big, such as, hisilicon V3's queue depth is 4096.
> > > >=20
> > > > Secondly, you have to deal with queue busy efficiently and correctl=
y,
> > > > for example, your real hw tags(IPTT) can be used up easily, and how
> > > > will you handle these dispatched request?
> > >=20
> > > I have not seen scenario of exhausted IPTT. And IPTT count is same as=
 SCSI
> > > host.can_queue, so SCSI midlayer should ensure that this does not occ=
ur.
> >=20
>=20
> Hi Ming,
>=20
> > That check isn't correct, and each hw queue should have allowed
> > .can_queue in-flight requests.
>=20
> There always seems to be some confusion or disagreement on this topic.
>=20
> I work according to the comment in scsi_host.h:
>=20
> "Note: it is assumed that each hardware queue has a queue depth of
>  can_queue. In other words, the total queue depth per host
>  is nr_hw_queues * can_queue."
>=20
> So I set Scsi_host.can_queue =3D HISI_SAS_MAX_COMMANDS (=3D4096)

I believe all current drivers set .can_queue as single hw queue's depth.
If you set .can_queue as HISI_SAS_MAX_COMMANDS which is HBA's queue
depth, the hisilicon sas driver will HISI_SAS_MAX_COMMANDS * nr_hw_queues
in-flight requests.

>=20
> >=20
> > >=20
> > > >=20
> > > > Finally, you have to evaluate the performance effect, this is highl=
y
> > > > related with how to deal with out-of-IPTT.
> > >=20
> > > Some figures from our previous testing:
> > >=20
> > > Managed interrupt without exposing multiple queues: 3M IOPs
> > > Managed interrupt with exposing multiple queues: 2.6M IOPs
> >=20
> > Then you see the performance regression.
>=20
> Let's discuss this when I send the patches, so we don't get sidetracked o=
n
> this blk-mq improvement topic.

OK, what I meant is to use correct driver to test the patches, otherwise
it might be hard to investigate.


Thanks,
Ming

