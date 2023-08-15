Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F84C001B0
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 12:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbjHOMuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Aug 2023 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237336AbjHOMtx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 08:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C06BE63
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692103758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+l55HTddVYwEg/eLFK4VwzVELui+1PXrZDBowROvDQ=;
        b=Qo3mNAcvCxfA62BZ6/VMbxJAP8w72Q2/VSaHaLENK25acryPAtmNLUYwF1oT68ha4yBDgC
        dSilFUl8qTVuZDrzMCD5vk4Ldav6wfDeyL+ZlBz8oicgvlNBgUlFiwG0auCJPbzc6u+EmI
        gw+7qVY2Bc3hdlfvzXX1hNf4CQofd5Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-ll15gl-GO-y5SNsQYGgXKQ-1; Tue, 15 Aug 2023 08:49:11 -0400
X-MC-Unique: ll15gl-GO-y5SNsQYGgXKQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D42F1C07588;
        Tue, 15 Aug 2023 12:49:10 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.9.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19F70C15BAD;
        Tue, 15 Aug 2023 12:49:09 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, axboe@kernel.dk, linux-block@vger.kernel.org,
        jiri@resnulli.us, netdev@vger.kernel.org, dev@openvswitch.org,
        philipp.reisner@linbit.com, jmaloy@redhat.com,
        christoph.boehmwalder@linbit.com, edumazet@google.com,
        tipc-discussion@lists.sourceforge.net,
        Jiri Pirko <jiri@nvidia.com>, ying.xue@windriver.com,
        johannes@sipsolutions.net, pabeni@redhat.com,
        drbd-dev@lists.linbit.com, lars.ellenberg@linbit.com,
        jacob.e.keller@intel.com
Subject: Re: [ovs-dev] [PATCH net-next v3 03/10] genetlink: remove userhdr
 from struct genl_info
References: <20230814214723.2924989-1-kuba@kernel.org>
        <20230814214723.2924989-4-kuba@kernel.org>
Date:   Tue, 15 Aug 2023 08:49:08 -0400
In-Reply-To: <20230814214723.2924989-4-kuba@kernel.org> (Jakub Kicinski's
        message of "Mon, 14 Aug 2023 14:47:16 -0700")
Message-ID: <f7twmxwxygr.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> Only three families use info->userhdr today and going forward
> we discourage using fixed headers in new families.
> So having the pointer to user header in struct genl_info
> is an overkill. Compute the header pointer at runtime.
>
> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Seems the OVS side didn't change from v2 so still:

Reviewed-by: Aaron Conole <aconole@redhat.com>

