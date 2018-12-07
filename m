Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A23AC04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A71220659
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A71220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLGCKy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:10:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGCKy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Dec 2018 21:10:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 673003078AC2;
        Fri,  7 Dec 2018 02:10:54 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2792C600C3;
        Fri,  7 Dec 2018 02:10:54 +0000 (UTC)
Date:   Thu, 6 Dec 2018 21:10:53 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: block: fix direct dispatch issue failure for clones
Message-ID: <20181207021053.GA17585@redhat.com>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
 <0d754fbb-9034-e375-a71d-9262ce8300ea@oracle.com>
 <e2c1c79e-89e5-4a09-d276-b1af5230f625@kernel.dk>
 <671bf8cd-672d-55ed-ad1e-1deb0b17f701@oracle.com>
 <36822da2-ecde-ad71-7b49-f98e845b4fc2@kernel.dk>
 <20181207015830.GC17427@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207015830.GC17427@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 07 Dec 2018 02:10:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06 2018 at  8:58pm -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> DM is forced to worry about all these details, as covered some in
> the header for commit 396eaf21ee17c476e8f66249fb1f4a39003d0ab4, it is
> trying to have its cake and eat it too.

Gah, obviously meant: DM is _NOT_ trying to have its cake and eat it too.

> It just wants IO scheduling to work for request-based DM devices.
