Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15348C64EC4
	for <linux-block@archiver.kernel.org>; Wed,  8 Mar 2023 07:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCHHp0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCHHpZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 02:45:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475B99C07
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 23:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678261478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LoVcvJyVYNZQgjrYfBlIMLAPlM+tY6ZIFyFH/nFof5A=;
        b=XrYAIuA9izJKjuwKrRRAUsUdWPCFSZG9p3+SebK/fSedZ4w8YWuTz7da7BzNnmviQxfFT4
        oHY5Lst92Zw0c2/qHX2bHQz3jAP7Jg5RucRm+Yngcl1xnVckX3Q8b+muuVezYIuGwTqubJ
        7CCkZTNOaIfvkDQojTOWmHzUKsb9+C4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-AHxDAfxrM9y0kA_Mp-N38w-1; Wed, 08 Mar 2023 02:44:37 -0500
X-MC-Unique: AHxDAfxrM9y0kA_Mp-N38w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65D3B3C0ED59;
        Wed,  8 Mar 2023 07:44:35 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11AD1C15BA0;
        Wed,  8 Mar 2023 07:44:31 +0000 (UTC)
Date:   Wed, 8 Mar 2023 15:44:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, ming.lei@redhat.com
Subject: Re: [PATCH V2 06/17] block: ublk_drv: mark device as LIVE before
 adding disk
Message-ID: <ZAg82vq4bDC64YH/@ovpn-8-16.pek2.redhat.com>
References: <20230307141520.793891-1-ming.lei@redhat.com>
 <20230307141520.793891-7-ming.lei@redhat.com>
 <3e5c7542-e4ad-202f-6dbb-fdea37bd62d7@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5c7542-e4ad-202f-6dbb-fdea37bd62d7@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 08, 2023 at 11:48:15AM +0800, Ziyang Zhang wrote:
> On 2023/3/7 22:15, Ming Lei wrote:
> > IO can be started before add_disk() returns, such as reading parititon table,
> > then the monitor work should work for making forward progress.
> > 
> > So mark device as LIVE before adding disk, meantime change to
> > DEAD if add_disk() fails.
> > 
> > Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> 
> Hi Ming,
> 
> Without this patch, if we fail to read partition table(Could this
> happen?)and EIO is returned, then START_DEV may hang forever, right?
> I may have encountered such error before and I think this bug is introduced
> by:
> bbae8d1f526b(ublk_drv: consider recovery feature in aborting mechanism)
> which change the behavior of monitor_work. So shall we add a fixes tag, such
> as:
> Fixes: bbae8d1f526b("ublk_drv: consider recovery feature in aborting mechanism")

Even without the above commit, monitor work still may not be started
because of ub->dev_info.state == UBLK_S_DEV_DEAD.

thanks, 
Ming

