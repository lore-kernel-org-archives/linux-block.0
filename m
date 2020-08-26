Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9DCC433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 04:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EEB20825
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 04:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JP/y+vdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHZE3g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 00:29:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35642 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgHZE3e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 00:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598416173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=25qYfOACsmbAvoaQnmoTDd/ocsmeL+RtLd1N/yOMT6o=;
        b=JP/y+vdl5AEpK9jjgNWce89HrR3eMBD3x1dMZ7oLVZgspPhV7jHdmMruVDW3NIv+VqYjGd
        sXd2bM0xNDG2CWF8y/COlOSERtoNdAzHdOQEbxObaR/8B0EZtEEUQD5PRsnCXL8X28ufHV
        rxyw6xgUZmOsMPKzu/5V45MN3oiKauo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-azbTPEEWOT-tRC0vhUVV4w-1; Wed, 26 Aug 2020 00:29:29 -0400
X-MC-Unique: azbTPEEWOT-tRC0vhUVV4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DE058030CB;
        Wed, 26 Aug 2020 04:29:28 +0000 (UTC)
Received: from T590 (ovpn-13-178.pek2.redhat.com [10.72.13.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BC7A7C5F6;
        Wed, 26 Aug 2020 04:29:22 +0000 (UTC)
Date:   Wed, 26 Aug 2020 12:29:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] blk-mq: use BLK_MQ_NO_TAG for no tag
Message-ID: <20200826042918.GA116347@T590>
References: <20200826020651.9856-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826020651.9856-1-tian.xianting@h3c.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 26, 2020 at 10:06:51AM +0800, Xianting Tian wrote:
> Replace various magic -1 constants for tags with BLK_MQ_NO_TAG.
> And move the definition of BLK_MQ_NO_TAG from 'block/blk-mq-tag.h'
> to 'include/linux/blk-mq.h'

All three symbols are supposed for block core internal code only, so
looks you shouldn't move them to public header.


Thanks, 
Ming

