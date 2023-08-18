Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0ACC001DE
	for <linux-block@archiver.kernel.org>; Fri, 18 Aug 2023 11:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376525AbjHRLni (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Aug 2023 07:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376527AbjHRLn1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2023 07:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7162112
        for <linux-block@vger.kernel.org>; Fri, 18 Aug 2023 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692358959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nIJDtceJEvPvpHYLAnup+4KqtuQicSCLwPh42Fs8LnI=;
        b=OkyeevQvQAiPKznAJBhce+Wjn+8sBWAPiC/zpcDC0fXdsRDPEnTI2rTCKN64AXcYE4OEva
        GDUFMcM9ElM2RtFk2rB0Yh2oEa6Q3H+WBfEPTaKXO4g0FBiyaUGDM+pkHGUZ69nlYV7ybp
        Yws6rf0mP1epQm5igSigiwF2T2BMUfE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-Js43KPOeMVmCnPjUHe8Lfw-1; Fri, 18 Aug 2023 07:42:36 -0400
X-MC-Unique: Js43KPOeMVmCnPjUHe8Lfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 691DE1C0755C;
        Fri, 18 Aug 2023 11:42:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA67C1121314;
        Fri, 18 Aug 2023 11:42:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
References: <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com> <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com> <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com> <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com> <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com> <665724.1692218114@warthog.procyon.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1748359.1692358952.1@warthog.procyon.org.uk>
Date:   Fri, 18 Aug 2023 12:42:32 +0100
Message-ID: <1748360.1692358952@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Well, that part is trivially fixable, and we should do that anyway for
> other reasons.
> ..
>  enum iter_type {
>  	/* iter types */
> -	ITER_IOVEC,
> -	ITER_KVEC,
> -	ITER_BVEC,
> -	ITER_XARRAY,
> -	ITER_DISCARD,
> -	ITER_UBUF,
> +	ITER_IOVEC = 1,
> +	ITER_UBUF = 2,
> +	ITER_KVEC = 4,
> +	ITER_BVEC = 8,
> +	ITER_XARRAY = 16,
> +	ITER_DISCARD = 32,
>  };

It used to be this way, but Al switched it:

	8cd54c1c848031a87820e58d772166ffdf8c08c0
	iov_iter: separate direction from flavour

David

