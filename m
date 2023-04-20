Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05679C77B72
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 08:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjDTIY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 04:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbjDTIYw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 04:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B8149DE
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 01:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681979031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9DO4ChOlq8sLV15YmmApLWgQEHlT5/IqsGo7T7qnLo=;
        b=EVjnk4dGwXwxzviww+ODaxR0idvGhQCK1BpAucaDxgLXnx6zR0iAEmZVQzwwCZq/zJ93cE
        VjRXJxLL00ED+I6NE7Afwo2z+6d57FM50an5/ea7NZcwASCMPPIeWV0DBMnsTYNzv2yn7/
        D8d03KVM2v8GMW53Pgf+3fcyJQyJWTM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-qGwE5T5DPDedcCc98QV_vQ-1; Thu, 20 Apr 2023 04:23:50 -0400
X-MC-Unique: qGwE5T5DPDedcCc98QV_vQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E720D185A78B;
        Thu, 20 Apr 2023 08:23:49 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9802F492B10;
        Thu, 20 Apr 2023 08:23:46 +0000 (UTC)
Date:   Thu, 20 Apr 2023 16:23:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Xiao Ni <xni@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] general protection fault at
 kyber_bio_merge+0x123/0x300
Message-ID: <ZED2jPfRY7irGW6X@ovpn-8-16.pek2.redhat.com>
References: <CAHj4cs9-PhuUM0ztSnCuryKkOa+tX-RGP+M=zX-UoCE5f9E6FA@mail.gmail.com>
 <a0a0d448-76f1-3e02-145c-cfdcff07cebf@nvidia.com>
 <CAHj4cs_iamYa5XbyoBeDCNMHBfLqqnRd0o3_+F__gRbPs+bEDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs_iamYa5XbyoBeDCNMHBfLqqnRd0o3_+F__gRbPs+bEDA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 20, 2023 at 04:04:07PM +0800, Yi Zhang wrote:
> Hi Chaitanya
> 
> Sorry for the late response, as it take me some time to bisect this
> issue, seems it was introduced with the below commit:
> 
> 23f3e3272e7a4d9fb870485cd6df1e4f9539282c
> Author: Xiao Ni <xni@redhat.com>
> Date:   Thu Feb 9 11:19:30 2023 +0800
> 
>     block: Merge bio before checking ->cached_rq
> 

Yeah, sched bio merge still needs queue reference to be grabbed, but plug
merge needn't it.

The simple fix is to revert the above commit.


Thanks,
Ming

