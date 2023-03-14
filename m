Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB53AC74A44
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 18:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCNS1j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 14:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCNS1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 14:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA938E86
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678818414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fTfsBvYbBxdRy/TFGETnYr2wutSLBUazSKwuZl5QCkE=;
        b=OUGEVZi1oWDpV3XIp7D3sVxdSRmD5BVqkGaeuPXW5CoXKgeXfx3n0R20njTqV848rD+aFC
        KldkQNu/3L7kQcMUgcGwdXqG95vAMeEG2G/x1YFUpV7QcnjPGHEK4lwEeEIkQzByBq/mEY
        1/LfYIJtqZgyxLtyft0ZHbOa8DU4vNU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-OSAmWMqFMO6H_2rey2MskA-1; Tue, 14 Mar 2023 14:26:49 -0400
X-MC-Unique: OSAmWMqFMO6H_2rey2MskA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BD4E280A328;
        Tue, 14 Mar 2023 18:26:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A90B1121318;
        Tue, 14 Mar 2023 18:26:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
References: <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com> <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com> <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com> <ZBCkDvveAIJENA0G@casper.infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3761464.1678818404.1@warthog.procyon.org.uk>
Date:   Tue, 14 Mar 2023 18:26:44 +0000
Message-ID: <3761465.1678818404@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Are you okay if we go with my current patch for the moment?

David

