Return-Path: <SRS0=rrL6=BA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4CDC433E0
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 17:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFD92068F
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 17:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kvcg0h+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgGURct (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:32:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31642 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728256AbgGURct (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jul 2020 13:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595352768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A4vq3hzF5EnfbrZUDBvH85BpDrVUYICRg+naxatpopQ=;
        b=Kvcg0h+WtI1ZIV2hjAzx93QxwHQpDonNwH1b4Cv7XXF5u/93G7wS7SDW+T4uh8VPWB8of6
        pVxxMIZ4GckHOA+rNsPVtkIXhAaec0Tp87EC2y3H1To07993qjhORi+2et4Ck+DOD23nx2
        5wUlDHdozIyEkvL8UwQZrf1Zv3DCCms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-ad_qQ1bDNm6XsHUkgmB9LQ-1; Tue, 21 Jul 2020 13:32:45 -0400
X-MC-Unique: ad_qQ1bDNm6XsHUkgmB9LQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D202D189CEE2;
        Tue, 21 Jul 2020 17:32:44 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 530BA72683;
        Tue, 21 Jul 2020 17:32:41 +0000 (UTC)
Date:   Tue, 21 Jul 2020 13:32:40 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Damien.LeMoal@wdc.com, dm-devel@redhat.com
Subject: Re: [PATCH 1/3] block: inherit the zoned characteristics in
 blk_stack_limits
Message-ID: <20200721173240.GA21963@redhat.com>
References: <20200720061251.652457-1-hch@lst.de>
 <20200720061251.652457-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720061251.652457-2-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 20 2020 at  2:12am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Lift the code from device mapper into blk_stack_limits to inherity
> the stacking limitations.  This ensures we do the right thing for
> all stacked zoned block devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

