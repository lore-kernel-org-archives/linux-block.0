Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC52C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 01:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKBBXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 21:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKBBXH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 21:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB1FAEA
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 18:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667352138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FxaRqeZn4Qi9uY35VcV/xGow7yoeXyMbR1sH80AKkuw=;
        b=b4v2dQ1XrezFpw0xGV+QLfJPXIlB5EK6m7yxfd6D0BVbRlVnWrwZaXWWnDeDfJsSKYJT6o
        TDNjHZdDLPO1Espo8sSqW4elmpsUVQOrz5D5vwMIJ5g9pFZAteQIW/tFeSKoKCv3UbEZnb
        Jlv9X25JosKlnIpIk2McokE3DN59/4k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-uOAB9c1lPISkIQG1GCZKOg-1; Tue, 01 Nov 2022 21:22:16 -0400
X-MC-Unique: uOAB9c1lPISkIQG1GCZKOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 805B53C025C8;
        Wed,  2 Nov 2022 01:22:16 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CAB5141511F;
        Wed,  2 Nov 2022 01:22:09 +0000 (UTC)
Date:   Wed, 2 Nov 2022 09:22:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 06/10] block: Fix the number of segment calculations
Message-ID: <Y2HGOj/OCKoZr7ej@T590>
References: <20221019222324.362705-1-bvanassche@acm.org>
 <20221019222324.362705-7-bvanassche@acm.org>
 <934d8e30-8629-d598-0214-987580c349b8@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <934d8e30-8629-d598-0214-987580c349b8@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On Tue, Nov 01, 2022 at 10:23:32AM -0700, Bart Van Assche wrote:
> On 10/19/22 15:23, Bart Van Assche wrote:
> > Since multi-page bvecs are supported there can be multiple segments per
> > bvec (see also bvec_split_segs()). Hence this patch that calculates the
> > number of segments per bvec instead of assuming that there is only one
> > segment per bvec.
> 
> (replying to my own email)
> 
> Hi Ming,
> 
> Do you agree that this patch fixes a bug introduced by the multi-page bvec
> code and also that it is required even if the segment size is larger than
> the page size?

No, multi-age bvec is only applied on normal IO bvec, and it isn't used
in bio_add_pc_page(), so there isn't such issue in blk_rq_append_bio(),
that is why we needn't to split passthrough bio.

thanks, 
Ming

