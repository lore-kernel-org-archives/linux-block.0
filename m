Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC91C433E0
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 14:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1BF22CB2
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 14:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOIrPE3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgHDOgo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:36:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24000 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729067AbgHDOgd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Aug 2020 10:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596551792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oXVOiX6y4befVPxj9oYCNVD/rne++cXzQZdxNiMKAjY=;
        b=TOIrPE3BynPK4Gp/MVBVWkgi7+YpXO1K9LuZj7hCiDsduCcGcoaAlrwhXkGLxnjkclN4P0
        yH6oEOcLLaiFaLoLzsCxXQvHMa/II0eTrBFiURz/a63RBm2AYL2W1gIXapU4ysvG/m43mb
        KHgFH8QXO363fgC2VkgBfWxHupDBWDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-w9jIuSQGOaSg1aYgQXtWDA-1; Tue, 04 Aug 2020 10:36:30 -0400
X-MC-Unique: w9jIuSQGOaSg1aYgQXtWDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F1338015F4;
        Tue,  4 Aug 2020 14:36:29 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1825C7179F;
        Tue,  4 Aug 2020 14:36:25 +0000 (UTC)
Date:   Tue, 4 Aug 2020 10:36:25 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: dm: don't call report zones for more than the user requested
Message-ID: <20200804143625.GA14672@redhat.com>
References: <20200804092501.7938-1-johannes.thumshirn@wdc.com>
 <CY4PR04MB3751EB538B7F29FBDBB4EBA4E74A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <SN4PR0401MB3598A9D49399D70697DCEC789B4A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598A9D49399D70697DCEC789B4A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 04 2020 at  7:26am -0400,
Johannes Thumshirn <Johannes.Thumshirn@wdc.com> wrote:

> On 04/08/2020 12:17, Damien Le Moal wrote:
> > 
> > Looks good. I think this needs a Cc: stable.
> 
> Indeed, Mike can you add these two when applying or do you want me to resend?
> 
> Fixes: d41003513e61 ("block: rework zone reporting")
> Cc: stable@vger.kernel.org # v5.5+

I can apply those tags, thanks.

