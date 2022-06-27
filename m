Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23856C43334
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 07:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiF0Hqs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jun 2022 03:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiF0Hqr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 03:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1828460E7
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656316006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnmX60g0utcggJk3p7fmNX8l7/5odnPbkfZis0RysRw=;
        b=b6Mg7EnIl0pS+8ZWD/76iBd90Z9Ldndqm4Xuu1eNo7UA9ysrTRCMEXoyjd4nY2IdYwo64z
        Z9lDCO0ZYcX938aD+F/1VTzqK2OVUKZSTWrpB9lC/S9eE0SJQ4U60k7Z6wYm4qubOv5nKh
        HeKU6A0Yd0aPTkKIs2ylGyEll1Vzdok=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-FXrzlzSNOMCy_ioyPSMt_A-1; Mon, 27 Jun 2022 03:46:44 -0400
X-MC-Unique: FXrzlzSNOMCy_ioyPSMt_A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19A9C1C01B29;
        Mon, 27 Jun 2022 07:46:44 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91D1641615A;
        Mon, 27 Jun 2022 07:46:40 +0000 (UTC)
Date:   Mon, 27 Jun 2022 15:46:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH ubdsrv] tgt_null: Return number of sectors read/written
Message-ID: <YrlgW8qz5aEVfegR@T590>
References: <20220621224839.76007-1-krisman@collabora.com>
 <YrJgDO9JD/le5tKK@T590>
 <87k0983bw1.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0983bw1.fsf@collabora.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 22, 2022 at 12:23:42PM -0400, Gabriel Krisman Bertazi wrote:
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Tue, Jun 21, 2022 at 06:48:39PM -0400, Gabriel Krisman Bertazi wrote:
> >> Hi Ming,
> >> 
> >> I wrote this against your devel-v3 branch.  I'm wondering if you plan to
> >> send a new version of the kernel patch soon? From the latest
> >
> > Yeah, that is on my todo list:
> >
> > https://github.com/ming1/linux/commits/my_for-5.19-ubd-devel_v3
> >
> > there has lots cleanup & improvement.
> >
> >> discussions, I don't think there were major issues found on review. :)
> >
> > One problem is the driver name, and Christoph thought we have
> > 'arch/um/drivers/ubd*.c'. Not thought of one good candidate yet.
> 
> Hi Ming,
> 
> Thanks for the info, and sorry for not noticing the fix merged on Jun, 3rd
> on the master branch.  I will follow that branch when testing and submit
> fixes I find along the way.

That is great!

> 
> I guess you have considered a lot of names, but I'd suggest any of:
> 
>  * blkuser,
>  * ublk
>  * BUSE (as in Block FUSE, though there is another non-upstream
> project with that name),
>  * UBIO (as in UIO, but for Block IO)
>  * B2U (Block IO Backed by userspace) :-P
> 
> TBH, my favorite is ublk.

Me too, will change to it in v3 if no one objects.

Thanks,
Ming

