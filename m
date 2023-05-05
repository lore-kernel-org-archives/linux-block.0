Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7355DC7EE22
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 15:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjEEPnf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 11:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjEEPne (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 11:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E4815EC2
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683301367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DmSP1tzyBY9KMlL+hSaKNKPvuINRh0pulHLECnqRpeo=;
        b=bqi8u2sp1rXgwI5XP8xuN4tjDMbyItH/DuN1clU7ARno/w0+mbxdZmvCFIMijBj5iyrsFH
        uXVRzsUU/edTS8KEQXcDTdHOAV3ljEhrq0P/xjcJB5GDSsN8OZqw10vMYTzbW9hbE3QzcA
        o6o5cEroLgk3fCtgw15W5el6ZmDEFxU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-sbWqrACvM9CMsBLQjMgzTg-1; Fri, 05 May 2023 11:42:44 -0400
X-MC-Unique: sbWqrACvM9CMsBLQjMgzTg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 083B51C07540;
        Fri,  5 May 2023 15:42:44 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5455A492B01;
        Fri,  5 May 2023 15:42:40 +0000 (UTC)
Date:   Fri, 5 May 2023 23:42:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org
Subject: Re: [PATCH V2 blktests 2/2] tests: Add ublk tests
Message-ID: <ZFUj7PS/kruy7xMs@ovpn-8-16.pek2.redhat.com>
References: <20230505032808.356768-1-ZiyangZhang@linux.alibaba.com>
 <20230505032808.356768-3-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505032808.356768-3-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 05, 2023 at 11:28:08AM +0800, Ziyang Zhang wrote:
> It is very important to test ublk crash handling since the userspace
> part is not reliable. Especially we should test removing device, killing
> ublk daemons and user recovery feature.
> 
> Add five new tests for ublk to cover these cases.
> 
> Signed-off-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

BTW, the following ublk driver patch is required on v6.3+ for passing
'./check ublk/':

https://lore.kernel.org/linux-block/20230505153142.1258336-1-ming.lei@redhat.com/T/#u


Thanks,
Ming

