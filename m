Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70938C6379D
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3D720B80
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yx2a5odZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgKZI3J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:29:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727130AbgKZI3J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606379347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3rXQzmEocIXb9J6qVfLPhdebmYZHUsNEtxEoa/mad+8=;
        b=Yx2a5odZpB7c4brocsH0QNhIYKulMiS78e3T444PEX5A1dn/ELxNoHYxzP+NBONRoVdF+k
        hgfUWPFXkDuFCdKtH/Jpbohp70ESPGcplvQ1Tv4n6OEakW1mpjnWls33i0jcqTRJtSzQKQ
        K4XgBnS5J6Ar5F6yWiOg2nlGJdvs314=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-gV7_s-NHP3urQRXK5900yQ-1; Thu, 26 Nov 2020 03:29:03 -0500
X-MC-Unique: gV7_s-NHP3urQRXK5900yQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56C2181CBE1;
        Thu, 26 Nov 2020 08:29:01 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-83.ams2.redhat.com [10.36.113.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 106CF5C1B4;
        Thu, 26 Nov 2020 08:28:53 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Greg Kurz <groug@kaod.org>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v4 0/2] powerpc/pseries: fix MSI/X IRQ affinity on pseries
Date:   Thu, 26 Nov 2020 09:28:50 +0100
Message-Id: <20201126082852.1178497-1-lvivier@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With virtio, in multiqueue case, each queue IRQ is normally=0D
bound to a different CPU using the affinity mask.=0D
=0D
This works fine on x86_64 but totally ignored on pseries.=0D
=0D
This is not obvious at first look because irqbalance is doing=0D
some balancing to improve that.=0D
=0D
It appears that the "managed" flag set in the MSI entry=0D
is never copied to the system IRQ entry.=0D
=0D
This series passes the affinity mask from rtas_setup_msi_irqs()=0D
to irq_domain_alloc_descs() by adding an affinity parameter to=0D
irq_create_mapping().=0D
=0D
The first patch adds the parameter (no functional change), the=0D
second patch passes the actual affinity mask to irq_create_mapping()=0D
in rtas_setup_msi_irqs().=0D
=0D
For instance, with 32 CPUs VM and 32 queues virtio-scsi interface:=0D
=0D
... -smp 32 -device virtio-scsi-pci,id=3Dvirtio_scsi_pci0,num_queues=3D32=0D
=0D
for IRQ in $(grep virtio2-request /proc/interrupts |cut -d: -f1); do=0D
    for file in /proc/irq/$IRQ/ ; do=0D
        echo -n "IRQ: $(basename $file) CPU: " ; cat $file/smp_affinity_lis=
t=0D
    done=0D
done=0D
=0D
Without the patch (and without irqbalanced)=0D
=0D
IRQ: 268 CPU: 0-31=0D
IRQ: 269 CPU: 0-31=0D
IRQ: 270 CPU: 0-31=0D
IRQ: 271 CPU: 0-31=0D
IRQ: 272 CPU: 0-31=0D
IRQ: 273 CPU: 0-31=0D
IRQ: 274 CPU: 0-31=0D
IRQ: 275 CPU: 0-31=0D
IRQ: 276 CPU: 0-31=0D
IRQ: 277 CPU: 0-31=0D
IRQ: 278 CPU: 0-31=0D
IRQ: 279 CPU: 0-31=0D
IRQ: 280 CPU: 0-31=0D
IRQ: 281 CPU: 0-31=0D
IRQ: 282 CPU: 0-31=0D
IRQ: 283 CPU: 0-31=0D
IRQ: 284 CPU: 0-31=0D
IRQ: 285 CPU: 0-31=0D
IRQ: 286 CPU: 0-31=0D
IRQ: 287 CPU: 0-31=0D
IRQ: 288 CPU: 0-31=0D
IRQ: 289 CPU: 0-31=0D
IRQ: 290 CPU: 0-31=0D
IRQ: 291 CPU: 0-31=0D
IRQ: 292 CPU: 0-31=0D
IRQ: 293 CPU: 0-31=0D
IRQ: 294 CPU: 0-31=0D
IRQ: 295 CPU: 0-31=0D
IRQ: 296 CPU: 0-31=0D
IRQ: 297 CPU: 0-31=0D
IRQ: 298 CPU: 0-31=0D
IRQ: 299 CPU: 0-31=0D
=0D
With the patch:=0D
=0D
IRQ: 265 CPU: 0=0D
IRQ: 266 CPU: 1=0D
IRQ: 267 CPU: 2=0D
IRQ: 268 CPU: 3=0D
IRQ: 269 CPU: 4=0D
IRQ: 270 CPU: 5=0D
IRQ: 271 CPU: 6=0D
IRQ: 272 CPU: 7=0D
IRQ: 273 CPU: 8=0D
IRQ: 274 CPU: 9=0D
IRQ: 275 CPU: 10=0D
IRQ: 276 CPU: 11=0D
IRQ: 277 CPU: 12=0D
IRQ: 278 CPU: 13=0D
IRQ: 279 CPU: 14=0D
IRQ: 280 CPU: 15=0D
IRQ: 281 CPU: 16=0D
IRQ: 282 CPU: 17=0D
IRQ: 283 CPU: 18=0D
IRQ: 284 CPU: 19=0D
IRQ: 285 CPU: 20=0D
IRQ: 286 CPU: 21=0D
IRQ: 287 CPU: 22=0D
IRQ: 288 CPU: 23=0D
IRQ: 289 CPU: 24=0D
IRQ: 290 CPU: 25=0D
IRQ: 291 CPU: 26=0D
IRQ: 292 CPU: 27=0D
IRQ: 293 CPU: 28=0D
IRQ: 294 CPU: 29=0D
IRQ: 295 CPU: 30=0D
IRQ: 299 CPU: 31=0D
=0D
This matches what we have on an x86_64 system.=0D
=0D
v4: udate changelog of PATCH 2, add Michael's Acked-by=0D
v3: update changelog of PATCH 1 with comments from Thomas Gleixner and=0D
    Marc Zyngier.=0D
v2: add a wrapper around original irq_create_mapping() with the=0D
    affinity parameter. Update comments=0D
=0D
Laurent Vivier (2):=0D
  genirq/irqdomain: Add an irq_create_mapping_affinity() function=0D
  powerpc/pseries: Pass MSI affinity to irq_create_mapping()=0D
=0D
 arch/powerpc/platforms/pseries/msi.c |  3 ++-=0D
 include/linux/irqdomain.h            | 12 ++++++++++--=0D
 kernel/irq/irqdomain.c               | 13 ++++++++-----=0D
 3 files changed, 20 insertions(+), 8 deletions(-)=0D
=0D
-- =0D
2.28.0=0D
=0D

