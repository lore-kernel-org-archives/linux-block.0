Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out0-151.mail.aliyun.com ([140.205.0.151]:36875 "EHLO
        out0-151.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbcLADSs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2016 22:18:48 -0500
Reply-To: "Hillf Danton" <hillf.zj@alibaba-inc.com>
From: "Hillf Danton" <hillf.zj@alibaba-inc.com>
To: "'Kirill A. Shutemov'" <kirill.shutemov@linux.intel.com>
Cc: "'Theodore Ts'o'" <tytso@mit.edu>,
        "'Andreas Dilger'" <adilger.kernel@dilger.ca>,
        "'Jan Kara'" <jack@suse.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Alexander Viro'" <viro@zeniv.linux.org.uk>,
        "'Hugh Dickins'" <hughd@google.com>,
        "'Andrea Arcangeli'" <aarcange@redhat.com>,
        "'Dave Hansen'" <dave.hansen@intel.com>,
        "'Vlastimil Babka'" <vbabka@suse.cz>,
        "'Matthew Wilcox'" <willy@infradead.org>,
        "'Ross Zwisler'" <ross.zwisler@linux.intel.com>,
        <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-block@vger.kernel.org>,
        "'Naoya Horiguchi'" <n-horiguchi@ah.jp.nec.com>
References: <20161129112304.90056-1-kirill.shutemov@linux.intel.com> <20161129112304.90056-23-kirill.shutemov@linux.intel.com> <017501d24aee$d9a189c0$8ce49d40$@alibaba-inc.com> <20161130131534.3k35cigsn36d7ku6@black.fi.intel.com>
In-Reply-To: <20161130131534.3k35cigsn36d7ku6@black.fi.intel.com>
Subject: Re: [PATCHv5 22/36] mm, hugetlb: switch hugetlbfs to multi-order radix-tree entries
Date: Thu, 01 Dec 2016 11:10:52 +0800
Message-ID: <018c01d24b80$86b85490$9428fdb0$@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wednesday, November 30, 2016 9:16 PM Kirill A. Shutemov wrote:
> On Wed, Nov 30, 2016 at 05:48:05PM +0800, Hillf Danton wrote:
> > On Tuesday, November 29, 2016 7:23 PM Kirill A. Shutemov wrote:
> > > @@ -607,10 +605,10 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
> > >  		}
> > >
> > >  		/* Set numa allocation policy based on index */
> > > -		hugetlb_set_vma_policy(&pseudo_vma, inode, index);
> > > +		hugetlb_set_vma_policy(&pseudo_vma, inode, index >> huge_page_order(h));
> > >
> > >  		/* addr is the offset within the file (zero based) */
> > > -		addr = index * hpage_size;
> > > +		addr = index << PAGE_SHIFT & ~huge_page_mask(h);
> > >
> > >  		/* mutex taken here, fault path and hole punch */
> > >  		hash = hugetlb_fault_mutex_hash(h, mm, &pseudo_vma, mapping,
> >
> > Seems we can't use index in computing hash as long as it isn't in huge page size.
> 
> Look at changes in hugetlb_fault_mutex_hash(): we shift the index right by
> huge_page_order(), before calculating the hash. I don't see a problem
> here.
> 
You are right. I missed that critical point.

thanks
Hillf

