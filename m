Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdBIUfj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2017 15:35:39 -0500
Date: Thu, 9 Feb 2017 12:19:09 -0800
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <20170209201909.GU2267@bombadil.infradead.org>
References: <20170126115819.58875-1-kirill.shutemov@linux.intel.com>
 <20170126115819.58875-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170126115819.58875-7-kirill.shutemov@linux.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jan 26, 2017 at 02:57:48PM +0300, Kirill A. Shutemov wrote:
> For filesystems that wants to be write-notified (has mkwrite), we will
> encount write-protection faults for huge PMDs in shared mappings.
> 
> The easiest way to handle them is to clear the PMD and let it refault as
> wriable.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
