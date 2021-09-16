Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0491C433F5
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 08:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B7160F93
	for <linux-block@archiver.kernel.org>; Thu, 16 Sep 2021 08:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhIPIYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234928AbhIPIYQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 04:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631780575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QWt3ip4CBk0I1AL9OVGf26EzSToILsSmwhya6rje3aI=;
        b=U0kuVAxBD6giqI0kxDnorPZzFfvQVOSQBn2sXlu/PuuLW0qEZjSgfiobdZxpcbg6iypd09
        iEhqxJ0U9/Y0ucWJBskHpFjKnbgKLFR7NIax0yi4QRwSBdj7FODMobu7CKdPUck9cg8Djx
        FEAmqOa/T4IslsLxjlwkGip161RgBzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-j50vqmdTPD6_xx3ZVhctiA-1; Thu, 16 Sep 2021 04:22:54 -0400
X-MC-Unique: j50vqmdTPD6_xx3ZVhctiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B40950759;
        Thu, 16 Sep 2021 08:22:53 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42E22838DB;
        Thu, 16 Sep 2021 08:22:32 +0000 (UTC)
Date:   Thu, 16 Sep 2021 16:22:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     pkalever@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, josef@toxicpanda.com, axboe@kernel.dk,
        idryomov@redhat.com, xiubli@redhat.com,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Subject: Re: [PATCH v1 1/2] block: cleanup: define default command timeout
 and use it
Message-ID: <YUL+1PE1z5aM0eTM@T590>
References: <20210806142914.70556-1-pkalever@redhat.com>
 <20210806142914.70556-2-pkalever@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806142914.70556-2-pkalever@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 06, 2021 at 07:59:13PM +0530, pkalever@redhat.com wrote:
> From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> 
> defined BLK_DEFAULT_CMD_TIMEOUT and reuse it everywhere else.
> 
> Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

