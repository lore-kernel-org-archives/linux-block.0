Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A58C7EE29
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 04:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjETEOa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 May 2023 00:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjETEOU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 00:14:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26010FD;
        Fri, 19 May 2023 21:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/5FaSPM/GVMx5F7idoJAX61IM/zLeWpOU/uyAlqZ2Ug=; b=Zy1+g2IIDexLtdfgFTbFfl0WC5
        qLB7aBpPUxPOvwVpfHOOuH0vDIGAtcAdrUEuR8wt0F7YK3rgDAEv/n/a2VklirOi2nIs3JPuz3NHI
        xM7K9iGPPb5wJyx2ZL4CEyQoJ9mFYgKfvERlVURkI6MDLClGHK+CblSWx7E4KNzCDQch+X5Rv8waD
        Bry8oa2xINp7fibHYfPo9xX8Uk8Nk44AEeCClR1ZhuOv3LPEsXnOpkIZEkp+q9VJH/cTCpZokb3BM
        0PT7iC2Y1ai3m/uUlHGliFSRZBc5b08pLsMKrwA1u2aRvj9isRmiwn23E5gTkW6QjcpvTyq1W5m1Q
        5B+EIC2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q0Dyi-000dkN-37;
        Sat, 20 May 2023 04:14:00 +0000
Date:   Fri, 19 May 2023 21:14:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v21 26/30] splice: Convert trace/seq to use
 copy_splice_read()
Message-ID: <ZGhJCBdCpnqTsAGa@infradead.org>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-27-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-27-dhowells@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

s/splice/trace/ ?

