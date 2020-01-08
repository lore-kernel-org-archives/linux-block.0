Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B56C282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 21:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882D2206DA
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 21:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy5sFBxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgAHV2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:28:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47649 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbgAHV2E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Jan 2020 16:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578518883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDndyIMuf+SGBEdpoWnLHWGwmjrUEAzXRO3SpvATPL0=;
        b=Qy5sFBxJSoomrN9mYwqw86V/Pnuw6FW3hPZtPaJ5GPMVKa5/Ladw0TVjkkz7M9hq9Z0A35
        +IKCzgO7+0CrxBoxdrdBOl/kyXsDxr+3eJVqj1xKVAqYu+BTM2ovZG9T67+9/cpav6n+FN
        EsvA8D19bWzvvpWWbPlwEHa5cRC5gds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-dStVFU0HPOeWpx54NiZpYw-1; Wed, 08 Jan 2020 16:28:02 -0500
X-MC-Unique: dStVFU0HPOeWpx54NiZpYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32852800D48;
        Wed,  8 Jan 2020 21:28:00 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F3607C3AD;
        Wed,  8 Jan 2020 21:27:56 +0000 (UTC)
Message-ID: <a267a03595c613a4c44d379706d8f1a5d6e30035.camel@redhat.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <jejb@linux.ibm.com>, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com, mst@redhat.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, ssomesh@amazon.com,
        Balbir Singh <sblbir@amazon.com>, hch@lst.de
Date:   Wed, 08 Jan 2020 16:27:55 -0500
In-Reply-To: <yq1ftgq1wlt.fsf@oracle.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-6-sblbir@amazon.com> <yq1blrg2agh.fsf@oracle.com>
         <1578369479.3251.31.camel@linux.ibm.com> <yq1y2uj283m.fsf@oracle.com>
         <1eb9d796f81fffbb0bfe90bff8460bcda34cb04d.camel@redhat.com>
         <yq1ftgq1wlt.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2020-01-07 at 21:59 -0500, Martin K. Petersen wrote:
> Ewan,
> 
> > Yes, there are some storage arrays that refuse a READ CAPACITY
> > command in certain ALUA states so you can't get the new capacity
> > anyway.
> 
> Yep. And some devices will temporarily return a capacity of
> 0xFFFFFFFF... If we were to trigger a filesystem resize, the results
> would be disastrous.
> 
> > It might be nice to improve this, though, there are some cases now
> > where we set the capacity to zero when we revalidate and can't get the
> > value.
> 
> If you have a test case, let's fix it.
> 

This happens with NVMe fabric devices, I thought.  I'll check.


