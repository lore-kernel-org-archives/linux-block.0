Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6020DC433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Mar 2022 00:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbiCUAXm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Mar 2022 20:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiCUAXm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Mar 2022 20:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44C62D95C3
        for <linux-block@vger.kernel.org>; Sun, 20 Mar 2022 17:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647822137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TwNDEBQSXgyzJrzHPsAGTVA2nojzVDJdIzMqJvcnmzs=;
        b=NnKXEYRQplog5ImwXmgs7K7J9fqx7pJBUjczr4zZRCVx8JYbiGLBFix1walR4t5HynrW3R
        OcA2sHh6FxUQ7TsZksWjv1Mk4N/R2CnXovpbRYXJvoLrrmu3DA6Zkk9YdLowivkv5sVwXi
        DuoL226ntWElapWVrwZNS/qNNbyObLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-Sbp7BK2LN3q9N2Ru0XK1WA-1; Sun, 20 Mar 2022 20:22:13 -0400
X-MC-Unique: Sbp7BK2LN3q9N2Ru0XK1WA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87837185A79C;
        Mon, 21 Mar 2022 00:22:13 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 670DF2026D60;
        Mon, 21 Mar 2022 00:22:00 +0000 (UTC)
Date:   Mon, 21 Mar 2022 08:21:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Eric Wheeler <linux-block@lists.ewheeler.net>
Cc:     linux-block@vger.kernel.org
Subject: Re: loop: it looks like REQ_OP_FLUSH could return before IO
 completion.
Message-ID: <YjfFHvTCENCC29WS@T590>
References: <af3e552a-6c77-b295-19e1-d7a1e39b31f3@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3e552a-6c77-b295-19e1-d7a1e39b31f3@ewheeler.net>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 19, 2022 at 10:14:29AM -0700, Eric Wheeler wrote:
> Hello all,
> 
> In loop.c do_req_filebacked() for REQ_OP_FLUSH, lo_req_flush() is called: 
> it does not appear that lo_req_flush() does anything to make sure 
> ki_complete has been called for pending work, it just calls vfs_fsync().
> 
> Is this a consistency problem?

No. What FLUSH command provides is just flushing cache in device side to
storage medium, so it is nothing to do with pending request.


Thanks, 
Ming

