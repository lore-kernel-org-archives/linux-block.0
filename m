Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19700C07E95
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 10:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED3B60FF0
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 10:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhGGKtn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231345AbhGGKtm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Jul 2021 06:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625654822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7edPdrNHVPqSqyOroMx7vyShL9GDo0V28Fe/j1ECYZ0=;
        b=XxXmty9Q/AZ4NnlTplpX9x3wkmu+qj9dfjt9tn4RX3CF0dfUOcDOb8AmPDD3QqSUvDvjzF
        N/msn+l/7bQhCNaV1blrOhdNs6zS0mfLFsPhT48sf0pAtD+L3damg3Y2KXy8dDXwlRsGTD
        YbSfFqqqk2ng0seIDJ+hTniunXJ3x1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-Un2q_0ZHNdClOuGrQQ3S0A-1; Wed, 07 Jul 2021 06:47:01 -0400
X-MC-Unique: Un2q_0ZHNdClOuGrQQ3S0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 096A310C1ADC;
        Wed,  7 Jul 2021 10:47:00 +0000 (UTC)
Received: from T590 (ovpn-12-84.pek2.redhat.com [10.72.12.84])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29BFD51C48;
        Wed,  7 Jul 2021 10:46:53 +0000 (UTC)
Date:   Wed, 7 Jul 2021 18:46:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: fix the problem of io_ticks becoming smaller
Message-ID: <YOWGGsaKqmLnIiVt@T590>
References: <1625521646-1069-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625521646-1069-1-git-send-email-brookxu.cn@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 06, 2021 at 05:47:26AM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> On the IO submission path, blk_account_io_start() may interrupt
> the system interruption. When the interruption returns, the value
> of part->stamp may have been updated by other cores, so the time
> value collected before the interruption may be less than part->
> stamp. So when this happens, we should do nothing to make io_ticks
> more accurate? For kernels less than 5.0, this may cause io_ticks
> to become smaller, which in turn may cause abnormal ioutil values.

Just be curious, is there any user visible difference with this change?

It can only be one issue if the stamp update crosses two jiffies, but
this event should be very unlikely, right?

Thanks, 
Ming

