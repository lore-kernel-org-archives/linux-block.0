Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4720BC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Jul 2022 07:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiGYHHm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 03:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGYHHl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 03:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AF23DEC7
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 00:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658732860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsQdDGZeeiIc3TpqX0DNpOZeS/YIPNdKlIsl+877TGw=;
        b=Yir7jAlP831p5eBcTqiVUIqN8ijCAef/oTxYLJfS7Wm+o1rK532F1HNMBZPwcOYRW70xxk
        lqJPkB86vyhW+NmyrajwN6n8yxQNwD+zPRB08KN/nzl7bn7QAo0HO+bVGPAKpuF/SUUlVx
        WTxcm9PSB9Tdj6paHkou9U39syMO4ws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-2BQm5lGgPI-BoNA_sdYDJw-1; Mon, 25 Jul 2022 03:07:33 -0400
X-MC-Unique: 2BQm5lGgPI-BoNA_sdYDJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CE87811768;
        Mon, 25 Jul 2022 07:07:33 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE8C62166B26;
        Mon, 25 Jul 2022 07:07:30 +0000 (UTC)
Date:   Mon, 25 Jul 2022 15:07:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH 2/2] ublk_drv: add SET_PARA/GET_PARA control command
Message-ID: <Yt5BLGColdy1kh8W@T590>
References: <20220723150713.750369-1-ming.lei@redhat.com>
 <20220723150713.750369-3-ming.lei@redhat.com>
 <20220725064523.GB20796@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725064523.GB20796@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 25, 2022 at 08:45:23AM +0200, Christoph Hellwig wrote:
> Can you spell out PARAM?  PARA sounds rather strange.

OK.

Thanks, 
Ming

