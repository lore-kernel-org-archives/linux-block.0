Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE77EC678D4
	for <linux-block@archiver.kernel.org>; Thu,  2 Mar 2023 07:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCBHtf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 02:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBHte (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 02:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948E8149A6
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 23:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677743341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cQ4sHF5KJ3cktE2RXo4MAmwO8cN1mxryLaTqRFOyl/s=;
        b=XzT9/VjLLd5gEZVS9hMurzHM23uy5229tIvoUD1bBgmM3acKkZW+13Qx5gBqaThcUDb+6u
        BH74Wu6Ca/QTEGuKrS+33JFLMaAo7O3rwsI2K8CZAHFgae6rokvV474xJ2bbC8Ky1kyvcm
        BJgG9Sz87TYSGAIeMeE3Og7URRUdNCE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-w8MRV87GP_CvKTJr2Kt-wg-1; Thu, 02 Mar 2023 02:48:58 -0500
X-MC-Unique: w8MRV87GP_CvKTJr2Kt-wg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 015571C08973;
        Thu,  2 Mar 2023 07:48:58 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDF27492C14;
        Thu,  2 Mar 2023 07:48:54 +0000 (UTC)
Date:   Thu, 2 Mar 2023 15:48:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH blktests v4 0/2] blktests: add mini ublk source and
 blktests/033
Message-ID: <ZABU4bQ16MHwkNyZ@T590>
References: <20230224124502.1720278-1-ming.lei@redhat.com>
 <fafd397d-0590-b6ce-121a-365877596ee1@nvidia.com>
 <20230302074446.73egqk5bseexvqg3@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302074446.73egqk5bseexvqg3@shindev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 02, 2023 at 07:44:46AM +0000, Shinichiro Kawasaki wrote:
> On Mar 02, 2023 / 05:00, Chaitanya Kulkarni wrote:
> > On 2/24/2023 4:45 AM, Ming Lei wrote:
> > > Hello,
> > > 
> > > The 1st patch adds one mini ublk program, which only supports null &
> > > loop targets.
> > > 
> > > The 2nd patch add blktests/033 for covering gendisk leak issue.
> > >
> > 
> > Looks good to me, feel free to merge it.
> > 
> > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> Thanks Chaitanya.
> 
> Ming, I've merged the patches. Thanks!

Great! Thanks all of you!

Thanks,
Ming

