Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0C4C48BE8
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 07:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4806061055
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 07:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFPHrN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 03:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231698AbhFPHrM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 03:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623829507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ul2QvNVOtAmda/VaZI1Ngg8b/Jgaxnc3kE9O/BAv/Nw=;
        b=iEyFdLHXPE55IO4/W7XyTwN8u5b8Dh3fRzyLgu6TDK3Sm1IpAbxEWCoc2OlemBLRY0kf4L
        WI0g5Ss3Iyxp10hFLM2OvnTKUWgxQ8tqAYeQ3McxFNcuqvEMjJzKCa0p5eK9wcl004kAMy
        4nQ0pPdqIGUwcb49ySPF+hpvqXkhVTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-RYCR_a2RORWNOb5voVSYQQ-1; Wed, 16 Jun 2021 03:45:03 -0400
X-MC-Unique: RYCR_a2RORWNOb5voVSYQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 393941084F42;
        Wed, 16 Jun 2021 07:45:02 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 173E35D9DE;
        Wed, 16 Jun 2021 07:44:54 +0000 (UTC)
Date:   Wed, 16 Jun 2021 09:44:52 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Ingo Franzki <ifranzki@linux.ibm.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juergen Christ <jchrist@linux.ibm.com>
Subject: Re: loop_set_block_size: loop0 () has still dirty pages (nrpages=2)
Message-ID: <20210616074452.viprot2qh3y7anct@ws.net.home>
References: <8bed44f2-273c-856e-0018-69f127ea4258@linux.ibm.com>
 <YMIliuPi2tTLUJxv@T590>
 <cf3c803f-350e-c365-afac-0a07a9b6cee2@linux.ibm.com>
 <20210615084259.yj5pmyjonfqcg7lg@ws.net.home>
 <72939177-a284-b5b6-e75e-2de9ab989bb4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72939177-a284-b5b6-e75e-2de9ab989bb4@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 16, 2021 at 09:22:17AM +0200, Ingo Franzki wrote:
> On 15.06.2021 10:42, Karel Zak wrote:
> > On Mon, Jun 14, 2021 at 09:35:30AM +0200, Ingo Franzki wrote:
> >> However, shouldn't then the losetup userspace utility implement some kind of retry logic in case of -EAGAIN ?
> >> I don't see that in the source of losetup.c nor in loopdev.c in the util-linux package. There is a retry loop in create_loop() in losetup.c retrying loopcxt_setup_device() in case of EBUSY, but not in case of EAGAIN.
> >>
> >> And losetup also hides the original error code and just returns EXIT_FAILURE in case of a failure. So no real good chance for the script that uses losetup to catch that error situation and perform a retry itself.
> >>
> >> Adding Karel Zak (the maintainer of util-linux).
> >>
> >> @Karel Zak: How about adding EAGAIN to the condition for performing a retry? 
> >>
> >> Something like this:
> >>
> >> -		if (errno == EBUSY && !hasdev && ntries < 64) {
> >> +		if ((errno == EBUSY || errno == EAGAIN) && !hasdev && ntries < 64) {
> >> 			xusleep(200000);
> >> 			ntries++;
> >> 			continue;
> >> 		}
> >  
> > EAGAIN sounds like the best reason to try it again :-) 
> > 
> > Committed, it will be also available in v2.37.1.
> 
> Thanks a lot for the quick resolution!
> 
> Do you by any chance know if Fedora 34 will be updated with v2.37.1? 

I'd like to keep f34 based on v2.36.2, but I can backport the patch to f34.

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

