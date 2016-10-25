Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:38574 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755296AbcJYW3w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2016 18:29:52 -0400
Received: by mail-lf0-f53.google.com with SMTP id d20so21624785lfj.5
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2016 15:29:51 -0700 (PDT)
Date: Tue, 25 Oct 2016 15:54:31 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCHv4 18/43] block: define BIO_MAX_PAGES to HPAGE_PMD_NR if
 huge page cache enabled
Message-ID: <20161025125431.GA22787@node.shutemov.name>
References: <20161025001342.76126-1-kirill.shutemov@linux.intel.com>
 <20161025001342.76126-19-kirill.shutemov@linux.intel.com>
 <20161025072122.GA21708@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161025072122.GA21708@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Oct 25, 2016 at 12:21:22AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 25, 2016 at 03:13:17AM +0300, Kirill A. Shutemov wrote:
> > We are going to do IO a huge page a time. So we need BIO_MAX_PAGES to be
> > at least HPAGE_PMD_NR. For x86-64, it's 512 pages.
> 
> NAK.  The maximum bio size should not depend on an obscure vm config,
> please send a standalone patch increasing the size to the block list,
> with a much long explanation.  Also you can't simply increase the size
> of the largers pool, we'll probably need more pools instead, or maybe
> even implement a similar chaining scheme as we do for struct
> scatterlist.

The size of required pool depends on architecture: different architectures
has different (huge page size)/(base page size).

Would it be okay if I add one more pool with size equal to HPAGE_PMD_NR,
if it's bigger than than BIO_MAX_PAGES and huge pages are enabled?

-- 
 Kirill A. Shutemov
