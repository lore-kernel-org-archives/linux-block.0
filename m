Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58701C4332F
	for <linux-block@archiver.kernel.org>; Thu, 15 Dec 2022 00:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLOAg2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Dec 2022 19:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOAg1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 19:36:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4121EA4
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 16:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671064540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ApzFcJJbD4r/IvshGoU+D+Il451lx5rrWMi/5Db3CRM=;
        b=LV9SP9pzV1VRIWn2AeZAl8Lh2Ivd63G1G1jxMB3eRzw54z9CNEUCV59fLBMWD7YWcwnqDi
        P3pnpzny9kuk8cNzpi0XvV7KV1w6kZ+I5KZO/eXsVU1yNeq3syNyM3BP/aD4XkxCCi07DA
        abXiN+wwH5ZzLDtnfJm1Relf8naKjMA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-PA4VnT3AOoGoX7JtyBAimw-1; Wed, 14 Dec 2022 19:35:37 -0500
X-MC-Unique: PA4VnT3AOoGoX7JtyBAimw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACF58811E6E;
        Thu, 15 Dec 2022 00:35:36 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D92282166B26;
        Thu, 15 Dec 2022 00:35:33 +0000 (UTC)
Date:   Thu, 15 Dec 2022 08:35:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V3 0/6] ublk_drv: add mechanism for supporting
 unprivileged ublk device
Message-ID: <Y5pr0I0P1MDA38Wd@T590>
References: <20221207123305.937678-1-ming.lei@redhat.com>
 <Y5anOZyJBCes1XEo@T590>
 <d3f761ce-4670-9665-3db0-86c2cd528811@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3f761ce-4670-9665-3db0-86c2cd528811@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 14, 2022 at 10:54:33AM -0700, Jens Axboe wrote:
> On 12/11/22 8:59 PM, Ming Lei wrote:
> > On Wed, Dec 07, 2022 at 08:32:59PM +0800, Ming Lei wrote:
> >> Hello,
> >>
> >> Stefan Hajnoczi suggested un-privileged ublk device[1] for container
> >> use case.
> >>
> >> So far only administrator can create/control ublk device which is too
> >> strict and increase system administrator burden, and this patchset
> >> implements un-privileged ublk device:
> >>
> >> - any user can create ublk device, which can only be controlled &
> >>   accessed by the owner of the device or administrator
> >>
> >> For using such mechanism, system administrator needs to deploy two
> >> simple udev rules[2] after running 'make install' in ublksrv.
> >>
> >> Userspace(ublksrv):
> >>
> >> 	https://github.com/ming1/ubdsrv/tree/unprivileged-ublk
> >>     
> >> 'ublk add -t $TYPE --un_privileged' is for creating one un-privileged
> >> ublk device if the user is un-privileged.
> >>
> >>
> >> [1] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
> >> [2] https://github.com/ming1/ubdsrv/blob/unprivileged-ublk/README.rst#un-privileged-mode
> >>
> >> V3:
> >> 	- don't warn on invalid user input for setting devt parameter, as
> >> 	  suggested by Ziyang, patch 4/6
> >> 	- fix one memory corruption issue, patch 6/6
> > 
> > Hello Guys,
> > 
> > Ping...
> 
> I think timing was just a tad late on this. OK if we defer for 6.3, or are
> there strong arguments for 6.2?

I am OK with deferring for 6.3.

Thanks,
Ming

