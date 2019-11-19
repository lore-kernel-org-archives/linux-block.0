Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618A5C432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 01:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7CD222ED
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 01:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGTs94eH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfKSBmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:42:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23517 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726761AbfKSBmW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 20:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574127741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7r3EuGqlV6Li6XVVC8wvTxbwUoxK99q8WwchQzbU5M=;
        b=YGTs94eHAuh6hbIzUNffMgc9W+JSlu3L6VIqdxxjgv09xfvLbFAncBPtduuaIhhzQH7Boc
        zVUdUdEcxqiBQkwuAX5ro4/M0MX6JRLJYkyS9ckL9DbguBRh0dWwiBffluR3+cHL8zmSoG
        Ef34rG8tE4S5oCOSB1cSkTr6NDur2z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-SIgbOjGuNEimuLHgPRAPPw-1; Mon, 18 Nov 2019 20:42:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54DA1100550E;
        Tue, 19 Nov 2019 01:42:17 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C492C60317;
        Tue, 19 Nov 2019 01:42:08 +0000 (UTC)
Date:   Tue, 19 Nov 2019 09:42:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     lkml@sdf.org, tglx@linutronix.de, kbusch@kernel.org,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: The irq Affinity is changed after the patch(Fixes: b1a5a73e64e9
 ("genirq/affinity: Spread vectors on node according to nr_cpu ratio"))
Message-ID: <20191119014204.GA391@ming.t460p>
References: <d59f7f7a-975a-2032-aa61-7cbff7585d33@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <d59f7f7a-975a-2032-aa61-7cbff7585d33@hisilicon.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: SIgbOjGuNEimuLHgPRAPPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 19, 2019 at 09:25:30AM +0800, chenxiang (M) wrote:
> Hi,
>=20
> There are 128 cpus and 16 irqs for SAS controller in my system, and there
> are 4 Nodes, every 32 cpus are for one node (cpu0-31 for node0, cpu32-63 =
for
> node1, cpu64-95 for node2, cpu96-127 for node3).
> We use function pci_alloc_irq_vectors_affinity() to set the affinity of
> irqs.
>=20
> I find that  before the patch (Fixes: b1a5a73e64e9 ("genirq/affinity: Spr=
ead
> vectors on node according to nr_cpu ratio")), the relationship between ir=
qs
> and cpus is: irq0 bind to cpu0-7, irq1 bind to cpu8-15,
> irq2 bind to cpu16-23, irq3 bind to cpu24-31,irq4 bind to cpu32-39... irq=
15
> bind to cpu120-127. But after the patch, the relationship is changed: irq=
0
> bind to cpu32-39,
> irq1 bind to cpu40-47, ..., irq11 bind to cpu120-127, irq12 bind to cpu0-=
7,
> irq13 bind to cpu8-15, irq14 bind to cpu16-23, irq15 bind to cpu24-31.
>=20
> I notice that before calling the sort() in function alloc_nodes_vectors()=
,
> the id of array node_vectors[] is from 0,1,2,3. But after function sort()=
,
> the index of array node_vectors[] is 1,2,3,0.
> But i think it sorts according to the numbers of cpus in those nodes, so =
it
> should be the same as before calling sort() as the numbers of cpus in eve=
ry
> node are 32.

Maybe there are more non-present CPUs covered by node 0.

Could you provide the following log?

1) lscpu

2) ./dump-io-irq-affinity $PCI_ID_SAS

=09http://people.redhat.com/minlei/tests/tools/dump-io-irq-affinity

You need to figure out the PCI ID(the 1st column of lspci output) of the SA=
S
controller via lspci.

Thanks,
Ming

