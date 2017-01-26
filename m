Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35104 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbdAZP5e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 10:57:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id d140so51511605wmd.2
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 07:57:12 -0800 (PST)
Date: Thu, 26 Jan 2017 18:57:09 +0300
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
Subject: Re: [PATCHv6 06/37] thp: handle write-protection faults for file THP
Message-ID: <20170126155709.GA11239@node.shutemov.name>
References: <20170126115819.58875-1-kirill.shutemov@linux.intel.com>
 <20170126115819.58875-7-kirill.shutemov@linux.intel.com>
 <20170126154439.GB20495@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170126154439.GB20495@bombadil.infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 26, 2017 at 07:44:39AM -0800, Matthew Wilcox wrote:
> On Thu, Jan 26, 2017 at 02:57:48PM +0300, Kirill A. Shutemov wrote:
> > For filesystems that wants to be write-notified (has mkwrite), we will
> > encount write-protection faults for huge PMDs in shared mappings.
> > 
> > The easiest way to handle them is to clear the PMD and let it refault as
> > wriable.
> 
> ... of course, the filesystem could implement ->pmd_fault, and then it
> wouldn't hit this case ...

I would rather get rid of ->pmd_fault/->huge_fault :)

->fault should be flexible enough to provide for all of them...

-- 
 Kirill A. Shutemov
