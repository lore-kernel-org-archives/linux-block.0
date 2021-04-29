Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4C3C433ED
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 14:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5860610A0
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 14:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbhD2OOV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 10:14:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238802AbhD2OOJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 10:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619705602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=erfYArL1SiuM6Jfi9enEN1R3Dodq+2ca9KSt+Kg0S4s=;
        b=SiigIJ/SxlPyWN3hLjmgfM4l9JQ7be/vZhMovjkC03bxTWNW4boCxMVxeHtKvueyQoSTZF
        1/Z7BEj5sXMeuI0ua4RmTa+bptF6hjbQeEKGx2ZVEAsI6E3eHzP+11EI0fZvQeUFfqeOKO
        mm0wRHylVKty/M36RtZRsAWkpfbVP18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-jHugu72FNGyPGx62RJGjLg-1; Thu, 29 Apr 2021 10:13:20 -0400
X-MC-Unique: jHugu72FNGyPGx62RJGjLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE98AA40C1;
        Thu, 29 Apr 2021 14:13:18 +0000 (UTC)
Received: from redhat (ovpn-118-247.phx2.redhat.com [10.3.118.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A443763BA7;
        Thu, 29 Apr 2021 14:13:14 +0000 (UTC)
Date:   Thu, 29 Apr 2021 10:13:12 -0400
From:   David Jeffery <djeffery@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V4 4/4] blk-mq: clearing flush request reference in
 tags->rqs[]
Message-ID: <20210429141312.GA43639@redhat>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
 <20210429023458.3044317-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429023458.3044317-5-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 29, 2021 at 10:34:58AM +0800, Ming Lei wrote:
> 
> Before we free request queue, clearing flush request reference in
> tags->rqs[], so that potential UAF can be avoided.
> 
> Based on one patch written by David Jeffery.
> 

With this fixing my issue with the previous patchset, looks good to me.

Reviewed-By: David Jeffery <djeffery@redhat.com>

