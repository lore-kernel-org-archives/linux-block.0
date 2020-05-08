Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2D3C35280
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 00:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB5E20643
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 00:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuH3r9Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEHASi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 20:18:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45093 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726509AbgEHASh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 20:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588897116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Mv1XBj4iTmPAp3vlxssIRDn/UsUqLQOKL0IgsAhs8U=;
        b=iuH3r9VjsyLmvTaUMHZ+oZlZgl4RuBJhelO4VjWsDOuXV1fDDigqqlodQx5gxYcy66OVyg
        9+xV4Kig3ZM6EdEA9sXBDuYfegEruRLdYOod2CxebrF6Zn4RhTIs6QNG/LqSMhxm2qp4mT
        z2i7bHDkTTeURiv4FXA8i8Tlz2EewXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-DCmbjbp0MJ-DlwxCIoPCjA-1; Thu, 07 May 2020 20:18:34 -0400
X-MC-Unique: DCmbjbp0MJ-DlwxCIoPCjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AA83100A614;
        Fri,  8 May 2020 00:18:33 +0000 (UTC)
Received: from agk-dp.fab.redhat.com (agk-dp.fab.redhat.com [10.33.15.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF7325D9C5;
        Fri,  8 May 2020 00:18:27 +0000 (UTC)
Received: from agk by agk-dp.fab.redhat.com with local (Exim 4.69)
        (envelope-from <agk@redhat.com>)
        id 1jWqif-0006ez-R6; Fri, 08 May 2020 01:18:26 +0100
Date:   Fri, 8 May 2020 01:18:25 +0100
From:   Alasdair G Kergon <agk@redhat.com>
To:     Kjetil Orbekk <kj@orbekk.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, harshads@google.com,
        Khazhismel Kumykov <khazhy@google.com>
Subject: Re: [PATCH] dm: track io errors per mapped device
Message-ID: <20200508001825.GC22266@agk-dp.fab.redhat.com>
Mail-Followup-To: Kjetil Orbekk <kj@orbekk.com>,
        Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        harshads@google.com, Khazhismel Kumykov <khazhy@google.com>
References: <20200507230532.5733-1-kj@orbekk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507230532.5733-1-kj@orbekk.com>
Organization: Red Hat UK Ltd. Registered in England and Wales, number
        03798903. Registered Office: Peninsular House, 30-36 Monument
        Street, 4th Floor, London, England, EC3R 8NB.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 07:05:33PM -0400, Kjetil Orbekk wrote:
> This will track ioerr_cnt on all dm targets and expose it as
> <device>/dm/ioerr_cnt.

How do you propose to use this?
What are you trying to measure and why?
- How exact must the number be to meet your requirements?

Or to put it another way, do you need to know the exact number you are
exposing, or do you derive something else from this which could also be
derived from an alternative number?

In particular, given the way we split and clone and stack devices (so
there may be an element of multiplication), and reload tables (so
existing values might become irrelevant), did you consider alternative
semantics before selecting this approach?
(Or to put it another way, is there a need to reset it or track
the value since the last resume?)

(Documentation is also needed - which ought to explain the semantics
and how the observed values interact with the use of device-mapper
features.)

Alasdair

