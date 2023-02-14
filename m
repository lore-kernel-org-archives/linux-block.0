Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBE3C64ED8
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 18:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjBNSEz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 13:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjBNSEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 13:04:43 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B422D2B2A4
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 10:04:32 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id g18so18482424qtb.6
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 10:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+RfWT82grRH2yp1+kvd7+qFvAWPLOfM6Uu0gZ6cTAM=;
        b=Ln45vBZO59pu7SCdRQDTnrH5JI49m22gg9Iw5nS8G1OytCBUQAa/PPJ6CJSRLIKP3+
         Ete2z9K+Wm3eHwhoGtsAFCh9phgnyG6yYdbPTck3fzzialpi0qtypazpwULGSrPF+WM/
         zsYEB/dDXQAXtsn8h+2p2i2kC+MIVbcsaa3HMsG9WOs5iWLLHN7D3NiVXSw/ejzP17TE
         u64Zo1uSlebWrDFdcT3bHKs3eQY5Q3UffPxwjLrAWeCqBsEDdwrS9lP+d9v5iBe7yjsJ
         jANs/yFtaz2RhvqlutN7zSqbZLgf+xWR6Yp7KKok7CJkJypVa2gQtZG1fEX4B7zl8MJ1
         x2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+RfWT82grRH2yp1+kvd7+qFvAWPLOfM6Uu0gZ6cTAM=;
        b=1PyyUa0pryynhcKkRpB1yb3WxGvIUFKb69dQ+r6W2xUrX8gt0OEpBvzsleZyT31O03
         Q0taXywS67ooqxrmOp4C8Q1ao4EyKnN5DfvITsompX8eDF3gKrbHlOfR84KFRwqCFpHH
         e5FelmeBgFmfui6VcYhvuFO6uexMeyehVw6yHuqXtnrfw7PlLe8rscPjoGRS9G/3aHNE
         cxnkn5xUZbBZuntYB6SZdw+AJPFDwxHY6XggFEnwmYAwBntDESFfviidAkNo/ppfbfl+
         foN+s7FJ2w+zKyOhfFZTd8waIoRctRnlSyS4WD9Kj3kxWjy3Dk2mn7S+ESotO6IH2P02
         7MAQ==
X-Gm-Message-State: AO0yUKVIcAJ7W5gherUEoMOZUsLabC/ZwJtgvPdLigUKH6KNaRqc/NDt
        xHgzU2tqyU94DLzCj29BeXXuCQ==
X-Google-Smtp-Source: AK7set+HUg0X5HtHNByMB4FKO6BoBVyKHOm7rQNL5MfU8paF1RWmVoOYq5KgxBs19P0Uaq1exxK3Dg==
X-Received: by 2002:ac8:5dd2:0:b0:3b6:9817:18e4 with SMTP id e18-20020ac85dd2000000b003b6981718e4mr5283147qtx.49.1676397871740;
        Tue, 14 Feb 2023 10:04:31 -0800 (PST)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id e5-20020a05620a014500b006fcb77f3bd6sm12300242qkn.98.2023.02.14.10.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 10:04:31 -0800 (PST)
Date:   Tue, 14 Feb 2023 13:04:28 -0500
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v14 06/17] coda: Implement splice-read
Message-ID: <20230214180428.asqulrek773hae23@cs.cmu.edu>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-unionfs@vger.kernel.org
References: <20230214171330.2722188-1-dhowells@redhat.com>
 <20230214171330.2722188-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214171330.2722188-7-dhowells@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 14, 2023 at 05:13:19PM +0000, David Howells wrote:
> Implement splice-read for coda by passing the request down a layer rather
> than going through generic_file_splice_read() which is going to be changed
> to assume that ->read_folio() is present on buffered files.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Jan Harkes <jaharkes@cs.cmu.edu>
> cc: coda@cs.cmu.edu
> cc: codalist@coda.cs.cmu.edu
> cc: linux-unionfs@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>

