Return-Path: <SRS0=7rSP=3F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C074C33CB1
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 15:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFDA207E0
	for <linux-block@archiver.kernel.org>; Thu, 16 Jan 2020 15:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nbdxFRjv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="XGMTtUz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgAPPRw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:17:52 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35050 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbgAPPRw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 10:17:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7824B8EE2C4;
        Thu, 16 Jan 2020 07:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579187871;
        bh=OISQx2PW1q+/gsGW6o7iHfBjNkXVBynUqLOr+85V55Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nbdxFRjvwJJ+x0qDG1Wu/Qov2VHFziN8i2uBFgYGOKE58GMCZej0KghDvt1bbio/v
         IYK4KIFBXN0ZnDkO78AQwMFpu39vd2AbjVHb+0DnudHuYCgcwpj5w5Cjv+OhGtrV0q
         KDxbu92rIGTuy+hbf6mYR7QkgSA9itR1//45zSas=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G0OXWeL0UQYp; Thu, 16 Jan 2020 07:17:49 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C85F38EE180;
        Thu, 16 Jan 2020 07:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579187867;
        bh=OISQx2PW1q+/gsGW6o7iHfBjNkXVBynUqLOr+85V55Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XGMTtUz9mt9X1uMs38LL5f0MCPYzqEnE5THczlqJkAsPftBZJ2TzmIVxhoRypDsPg
         S+81U0tnBRImp1sQyEWZIKBtrtIxervtUtOKNCO2IFNHG2Hz+NIwiCRYYH43mhrjB5
         79nCgihlfCV2CRryj+OLxggjUnBEbgpdIFvCwwhc=
Message-ID: <1579187864.3551.10.camel@HansenPartnership.com>
Subject: Re: [Question] abort shared tags for SCSI drivers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ming Lei <ming.lei@redhat.com>, Yufen Yu <yuyufen@huawei.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        john.garry@huawei.com, "axboe@kernel.dk" <axboe@kernel.dk>,
        hare@suse.de, Bart Van Assche <bvanassche@acm.org>
Date:   Thu, 16 Jan 2020 07:17:44 -0800
In-Reply-To: <20200116090347.GA7438@ming.t460p>
References: <bd959b9f-78dd-e0e7-0421-8d7e3cd2f41b@huawei.com>
         <20200116090347.GA7438@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2020-01-16 at 17:03 +0800, Ming Lei wrote:
> On Thu, Jan 16, 2020 at 12:06:02PM +0800, Yufen Yu wrote:
> > Hi, all
> > 
> > Shared tags is introduced to maintains a notion of fairness between
> > active users. This may be good for nvme with multiple namespace to
> > avoid starving some users. Right?
> 
> Actually nvme namespace is LUN of scsi world.
> 
> Shared tags isn't for maintaining fairness, it is just natural sw
> implementation of scsi host's tags, since every scsi host shares
> tags among all LUNs. If the SCSI host supports real MQ, the tags
> is hw-queue wide, otherwise it is host wide.

From the standards point of view, this statement is incorrect, it's the
ITLQ that identifies the Nexus, so the same tag *may* be in use for
different commands on different LUNS according to standards.

However, some device drivers choose to use ITQ as the identifier
because it fits with the ITLQ standard and they can use Q as a per
target mailbox identifier.

I don't think this affects the analysis, but I just didn't want people
to think it was always true.  We have some older drivers that will
allocate the same tag for different LUNS and this was incredibly
prevalent in the SPI world where the tag was only  bits.

James

