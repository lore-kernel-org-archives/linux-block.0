Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F9DC38142
	for <linux-block@archiver.kernel.org>; Mon, 23 Jan 2023 11:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjAWLv4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Jan 2023 06:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjAWLvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2023 06:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193C323671
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2023 03:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674474671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JJckYyBTZyBY7j44qzn90Ae9aMKGleBaEKh6HgH8NU=;
        b=i8iwjb0ROuucgZx8JOyJBavOGeQNfp67jASinLoc1bOz+84f5kWFmTQLFVN/IMljG81JxE
        ZEKkbq7fRE5RdBz7JNH8exIRQu7U5d7pNA2K91h+1Wr+Gs8UZ2Z+FRG8wXfRa2mnaWNomZ
        4womFoiX78uio53klqxFyBPrmJSNzoE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-GDKYFcVMOFmDY9Dof81bTQ-1; Mon, 23 Jan 2023 06:51:06 -0500
X-MC-Unique: GDKYFcVMOFmDY9Dof81bTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B25A281DE64;
        Mon, 23 Jan 2023 11:51:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B00121121330;
        Mon, 23 Jan 2023 11:51:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
References: <246ba813-698b-8696-7f4d-400034a3380b@redhat.com> <20230120175556.3556978-1-dhowells@redhat.com> <20230120175556.3556978-3-dhowells@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list from an iterator
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3814748.1674474663.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 23 Jan 2023 11:51:03 +0000
Message-ID: <3814749.1674474663@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

David Hildenbrand <david@redhat.com> wrote:

> How does this work align with the goal of no longer using FOLL_GET for
> O_DIRECT? We should get rid of any FOLL_GET usage for accessing page con=
tent.

Would that run the risk of changes being made by the child being visible t=
o
the a DIO write if the parent changes the buffer first?


	PARENT			CHILD
	=3D=3D=3D=3D=3D=3D			=3D=3D=3D=3D=3D
	start-DIO-write
	fork() =3D pid		fork() =3D 0
	alter-buffer
	CoW happens
	page copied		original page retained
				alter-buffer
		<DMA-happens>

David

