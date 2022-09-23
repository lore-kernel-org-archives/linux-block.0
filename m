Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D71C07E9D
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 22:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiIWW64 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 18:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiIWW6y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 18:58:54 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387D147A06
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 15:58:51 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r20so955199qtn.12
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 15:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FNVLh7QhTGQ0fcTY+ctZvZZG3IwOkyYDgRdATbQqFOE=;
        b=K6ThUhwaPxzE2uNJlUneDV+lEcb3sOSkMme+uJcOlA6PYnkzlx9eWnQI1++F4JHPTq
         6r5PK01FmTenaqwabhqB54wtpEtSh4q/f93LAarupwwOtTOjD+IgB/VnY7DUeuIhnkQC
         ueJpGrhUyrDSBys3KiQqSXiiBkciEmtt9rHzEbu8riWDZ48ZSyiWrSiPky8YDf3TxmTw
         JUiu1YmBDldxsDnWcSHllSPx0BxlwyOXe/lppV6D0S4dxlwZK9P4DpsQeTWyB8t6HwzK
         z3SSHJoW/95nBFxiW6hEVkAM1qDx4k+3uHGKOmgxxq5NvqNGbvm3e45Zg2lFjxXsyWRU
         k//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FNVLh7QhTGQ0fcTY+ctZvZZG3IwOkyYDgRdATbQqFOE=;
        b=zI71+aoP9LBdCKLs2lIG3yt8lmF7w9zz+h650iY7MQ+t1amYuRhVX8WCF/WraBiazp
         sqhRBUzs4W/ccJx1INXN6VtMpuhqXfYQ7eJRW7UlqwghLkw+FDHEmbEeaak4beQWk5Vw
         LbgxVjiFQ9iDOfVWrKNjhwrpEy0BWPx++fyJJGs7rFcSeT2zP89/qKBtMUYkZaC7YjOD
         QxsGkwKNRuOS3g3uh63UcwSodtiE4q/AbTXSTvhYY23USo8tXWfQvPsVEvMBxp1Q3q5r
         esSNRuIF+niWmTStOD41e1vsCyezBPPcYLcW2JLh5D2luxcoLz4OXb4yaM+Uhuwn96Hm
         J8wg==
X-Gm-Message-State: ACrzQf3RW//KMMaXUwv0rMwn4CXVoCCmaRziTksZRVx9XjjAz/UeregF
        eAbTEl73iUGmMaQN+B7tIme1mzbDvnb2xQ==
X-Google-Smtp-Source: AMsMyM47dsm4TxegiRkZUeLCH+5O+Wr8H54uLORgq4Q+/7wXo2aoGW0gmLRhcDSR3jPPk1osSOqTXA==
X-Received: by 2002:ac8:5a8b:0:b0:35b:f5c0:d5c9 with SMTP id c11-20020ac85a8b000000b0035bf5c0d5c9mr9233331qtc.14.1663973931136;
        Fri, 23 Sep 2022 15:58:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s5-20020a05620a254500b006b98315c6fbsm7255492qko.1.2022.09.23.15.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 15:58:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1obrdB-00316G-At;
        Fri, 23 Sep 2022 19:58:49 -0300
Date:   Fri, 23 Sep 2022 19:58:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <Yy46KbD/PvhaHA6X@ziepe.ca>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com>
 <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
 <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
 <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 23, 2022 at 02:11:03PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2022-09-23 13:53, Jason Gunthorpe wrote:
> > On Fri, Sep 23, 2022 at 01:08:31PM -0600, Logan Gunthorpe wrote:
> > I'm encouraging Dan to work on better infrastructure in pgmap core
> > because every pgmap implementation has this issue currently.
> > 
> > For that reason it is probably not so relavent to this series.
> > 
> > Perhaps just clarify in the commit message that the FOLL_LONGTERM
> > restriction is to copy DAX until the pgmap page refcounts are fixed.
> 
> Ok, I'll add that note.
> 
> Per the fix for the try_grab_page(), to me it doesn't fit well in 
> try_grab_page() without doing a bunch of cleanup to change the
> error handling, and the same would have to be added to try_grab_folio().
> So I think it's better to leave it where it was, but move it below the 
> respective grab calls. Does the incremental patch below look correct?

Oh? I was thinking of just a very simple thing:

--- a/mm/gup.c
+++ b/mm/gup.c
@@ -225,6 +225,11 @@ bool __must_check try_grab_page(struct page *page, unsigned int flags)
                node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
        }
 
+       if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page))) {
+               gup_put_folio(page_folio(page), 1, flags);
+              return false;
+       }
+
        return true;
 }


> I am confused about what happens if neither FOLL_PIN or FOLL_GET 
> are set (which the documentation for try_grab_x() says is possible, but
> other documentation suggests that FOLL_GET is automatically set). 
> In which case it'd be impossible to do the check if we can't 
> access the page.

try_grab_page is operating under the PTL so it can probably touch the
page OK (though perhaps we don't need to even check anything)

try_grab_folio cannot be called without PIN/GET, so like this perhaps:

@@ -123,11 +123,14 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
  */
 struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
 {
+       struct folio *folio;
+
+       if (WARN_ON((flags & (FOLL_GET | FOLL_PIN)) == 0))
+               return NULL;
+
        if (flags & FOLL_GET)
-               return try_get_folio(page, refs);
+               folio = try_get_folio(page, refs);
        else if (flags & FOLL_PIN) {
-               struct folio *folio;
-
                /*
                 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
                 * right zone, so fail and let the caller fall back to the slow
@@ -160,11 +163,14 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
                                        refs * (GUP_PIN_COUNTING_BIAS - 1));
                node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 
-               return folio;
        }
 
-       WARN_ON_ONCE(1);
-       return NULL;
+       if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page))) {
+               gup_put_folio(page, 1, flags);
+               return NULL;
+       }
+
+       return folio;
 }

Jason

