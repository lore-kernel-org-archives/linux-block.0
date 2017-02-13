Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35297 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbdBMN7y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 08:59:54 -0500
Received: by mail-wr0-f196.google.com with SMTP id o16so24312262wra.2
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2017 05:59:53 -0800 (PST)
Date: Mon, 13 Feb 2017 16:59:50 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
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
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCHv6 03/37] page-flags: relax page flag policy for few flags
Message-ID: <20170213135950.GB20394@node.shutemov.name>
References: <20170126115819.58875-1-kirill.shutemov@linux.intel.com>
 <20170126115819.58875-4-kirill.shutemov@linux.intel.com>
 <20170209040113.GR2267@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209040113.GR2267@bombadil.infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Feb 08, 2017 at 08:01:13PM -0800, Matthew Wilcox wrote:
> On Thu, Jan 26, 2017 at 02:57:45PM +0300, Kirill A. Shutemov wrote:
> > These flags are in use for filesystems with backing storage: PG_error,
> > PG_writeback and PG_readahead.
> 
> Oh ;-)  Then I amend my comment on patch 1 to be "patch 3 needs to go
> ahead of patch 1" ;-)

It doesn't really matter as long as both before patch 37 :P

-- 
 Kirill A. Shutemov
