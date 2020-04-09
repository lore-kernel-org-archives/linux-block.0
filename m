Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C3BC2BA2B
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 01:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81277208E4
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 01:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtrovxK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDIBoX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 21:44:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726523AbgDIBoW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Apr 2020 21:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586396662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b2mtGi6r3BCSmkwLZaqpFPxWzlxVwSz47AyFQhgeBuQ=;
        b=VtrovxK9+cVDxE2MN9fbQDQK2V2NC2jU/fZIjflRbmbsdqoGxOfiwirANw1xVQqWiM4+GD
        FrP1JX47nfWgycTJ236pBnphcwiyKDCoMWM8mNG82jy14Lmh468qAcPwJZAjEFN5ppwtRB
        t7Zb0FDged5LTOJXuTr+RAzxdYBvxBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-17zbROZEMUmtlVE77rpzDg-1; Wed, 08 Apr 2020 21:44:20 -0400
X-MC-Unique: 17zbROZEMUmtlVE77rpzDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 024B78017F5;
        Thu,  9 Apr 2020 01:44:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F11C19DD73;
        Thu,  9 Apr 2020 01:44:11 +0000 (UTC)
Date:   Thu, 9 Apr 2020 09:44:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@vger.kernel.org,
        cgroups@vger.kernel.org, newella@fb.com, josef@toxicpanda.com
Subject: Re: [PATCH 2/5] block: add request->io_data_len
Message-ID: <20200409014406.GA370295@localhost.localdomain>
References: <20200408201450.3959560-1-tj@kernel.org>
 <20200408201450.3959560-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408201450.3959560-3-tj@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tejun,

On Wed, Apr 08, 2020 at 04:14:47PM -0400, Tejun Heo wrote:
> Currently, at the time of completeion, there's no way of knowing how big a
> request was. blk-iocost will need this information to account for IO size when
> calculating expected latencies.
> 
> This patch adds rq->io_data_len which remembers blk_rq_bytes() at the time the
> request gets issued. The field is enabled iff CONFIG_BLK_IO_DATA_LEN is set and
> doesn't increase the size of the struct even when enabled.

Almost all __blk_mq_end_request() follow blk_update_request(), so the
completed bytes can be passed to __blk_mq_end_request(), then we can
avoid to introduce this field.

Also there is just 20 callers of __blk_mq_end_request(), looks this kind
of change shouldn't be too big.


Thanks, 
Ming

