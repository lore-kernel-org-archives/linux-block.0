Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBB4C282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 21:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6186C2070E
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 21:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VD2PFeMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgAHVcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:32:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbgAHVcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 16:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578519158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2Tl300doSUHOEtlULkq/YaFUqcc7K1ac46TaKPX0Ws=;
        b=VD2PFeMzi+w7VoJQRBen934e4GIt6ltUhFWbF7oMzLF88KuIxsMyR9MapjHTMVNrfRzosS
        lC0zzV+60L2LaEi8BNMeNJ2iHldFUtJOZzH3/7xR+AgWRp9GZQgluX1CAIFgTN4UUdCNdh
        a8I7IIZ/Xgrua1YsZ3F65ek/NKk/3sU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-4JXflz8VOOWLa-f3AACnGQ-1; Wed, 08 Jan 2020 16:32:37 -0500
X-MC-Unique: 4JXflz8VOOWLa-f3AACnGQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C190800D48;
        Wed,  8 Jan 2020 21:32:32 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E33A586C54;
        Wed,  8 Jan 2020 21:32:28 +0000 (UTC)
Message-ID: <8339b890eec74c423fa2260a90fcc2154cf05b53.camel@redhat.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Singh, Balbir" <sblbir@amazon.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>,
        "hch@lst.de" <hch@lst.de>
Date:   Wed, 08 Jan 2020 16:32:28 -0500
In-Reply-To: <yq1blre1vwr.fsf@oracle.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-6-sblbir@amazon.com> <yq1blrg2agh.fsf@oracle.com>
         <bc0575f1bb565f3955a411032f97163b2a5bd832.camel@amazon.com>
         <yq1blre1vwr.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2020-01-07 at 22:15 -0500, Martin K. Petersen wrote:
> Balbir,
> 
> > > We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
> > > capacity changes. However, this event does not automatically cause
> > > revalidation.
> > 
> > The proposed idea is to not reinforce revalidation, unless explictly
> > specified (in the thread before Bob Liu had suggestions). The goal is
> > to notify user space of changes via RESIZE. SCSI sd can opt out of
> > this IOW, I can remove this if you feel
> > SDEV_EVT_CAPACITY_CHANGE_REPORTED is sufficient for current use cases.

Remember that this event is generated because of a Unit Attention from
the device.  We are only passing on this indication to udev.  It basically
allows automation without having to scrape the log file.  We don't proactively
look. e.g. in the case of SCSI unless you have commands being sent to the
device to return the UA status you won't hear about it.

> 
> I have no particular objection to the code change. I was just observing
> that in the context of sd.c, RESIZE=1 is more of a "your request to
> resize was successful" notification due to the requirement of an
> explicit userland action in case a device reports a capacity change.
> 


