Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEAAC64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 05:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7000E221FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 05:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgLBFQL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 00:16:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgLBFQL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 00:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606886085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+4SisJSPmxjLfxHyr+ta1P4rvG3p84PcSep94LwDoM=;
        b=Aw/g4KDO94TYsPB5u3TP8pS32TvsDLXNbKojKnbtPh/rjaRWmK2ryonpHON0ipPZcqMwga
        duVecuZmZl48SpUcyPosxmOHe74WRpXe0KqCsJX6AlTC3mNaKlusLI93lsT7GBDfj/IBCh
        Dgg6dZXUJgF2QheO/Z4CAstm/edD/6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-Dwvs339BPqeQgRgrXc1VfA-1; Wed, 02 Dec 2020 00:14:43 -0500
X-MC-Unique: Dwvs339BPqeQgRgrXc1VfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36D088042A6;
        Wed,  2 Dec 2020 05:14:42 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15AE15C1B4;
        Wed,  2 Dec 2020 05:14:38 +0000 (UTC)
Date:   Wed, 2 Dec 2020 00:14:38 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        linux-block@vger.kernel.org
Subject: Re: dm: use gcd() to fix chunk_sectors limit stacking
Message-ID: <20201202051438.GB20535@redhat.com>
References: <20201201160709.31748-1-snitzer@redhat.com>
 <20201202033855.60882-1-jefflexu@linux.alibaba.com>
 <20201202033855.60882-2-jefflexu@linux.alibaba.com>
 <feb19a02-5ece-505f-e905-86dc84cdb204@linux.alibaba.com>
 <20201202050343.GA20535@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202050343.GA20535@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 02 2020 at 12:03am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> What you've done here is fairly chaotic/disruptive:
> 1) you emailed a patch out that isn't needed or ideal, I dealt already
>    staged a DM fix in linux-next for 5.10-rcX, see:
>    https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.10-rcX&id=f28de262ddf09b635095bdeaf0e07ff507b3c41b
> 2) you replied to your patch and started referencing snippets of this
>    other patch's header (now staged for 5.10-rcX via Jens' block tree):
>    https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.10&id=7e7986f9d3ba69a7375a41080a1f8c8012cb0923
>    - why not reply to _that_ patch in response something stated in it?

I now see you did reply to the original v2 patch:
https://www.redhat.com/archives/dm-devel/2020-December/msg00006.html

but you changed the Subject to have a "dm" prefix for some reason.
Strange but OK.. though it got really weird when you cut-and-paste your
other DM patch in reply at the bottom of your email.  If you find
yourself cross referencing emails and cutting and pasting like that, you
probably shouldn't.  Makes it chaotic for others to follow along.

Thanks,
Mike

