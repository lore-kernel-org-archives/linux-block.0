Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF9BC77B72
	for <linux-block@archiver.kernel.org>; Mon, 17 Apr 2023 07:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjDQHTv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjDQHTt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 03:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D493E448D
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 00:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681715941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ywuq69NDoGYBzQBvoab/Vrezh1wLVkJwTzR8zqW+Rk=;
        b=e5kq8ekRwaQgMGluqP77glgPGAkE+Z5tsjDQ6hpsxPhmJg5aYt1pZ325sMaevwf4zjIyVf
        1+AC2s+upDNtldKbkYj0ZhoRdZ2c57g3Zdb7rCMPsWzVJjuOAxraM2pWkvX1/ITBXf7Vj/
        T2HwMoRMlcm7agR6eU9CRNY7Y0zM/eg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-GuH0lb_pPn6g73_mhRP5ZQ-1; Mon, 17 Apr 2023 03:18:59 -0400
X-MC-Unique: GuH0lb_pPn6g73_mhRP5ZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 570C68996E8;
        Mon, 17 Apr 2023 07:18:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1602140C6E6E;
        Mon, 17 Apr 2023 07:18:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <2d5fa5e3-dac5-6973-74e5-eeedf36a42b@google.com>
References: <2d5fa5e3-dac5-6973-74e5-eeedf36a42b@google.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next] shmem: minor fixes to splice-read implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1379546.1681715874.1@warthog.procyon.org.uk>
From:   David Howells <dhowells@redhat.com>
Date:   Mon, 17 Apr 2023 08:18:57 +0100
Message-ID: <1379675.1681715937@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hugh Dickins <hughd@google.com> wrote:

> +	if (unlikely(!len))
> +		return 0;

Should this be done in do_splice_to() instead?

Also, is it too late for Jens to fold this into the original patch since it's
not upstream yet?

Otherwise:

Reviewed-by: David Howells <dhowells@redhat.com>

