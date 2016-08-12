Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33069 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbcHLXTt (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 12 Aug 2016 19:19:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so119678wme.0
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2016 16:19:48 -0700 (PDT)
Date: Sat, 13 Aug 2016 02:19:44 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Theodore Ts'o <tytso@mit.edu>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCHv2, 00/41] ext4: support of huge pages
Message-ID: <20160812231944.GA5260@node.shutemov.name>
References: <1471027104-115213-1-git-send-email-kirill.shutemov@linux.intel.com>
 <20160812203440.GD30280@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160812203440.GD30280@thunk.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Aug 12, 2016 at 04:34:40PM -0400, Theodore Ts'o wrote:
> On Fri, Aug 12, 2016 at 09:37:43PM +0300, Kirill A. Shutemov wrote:
> > Here's stabilized version of my patchset which intended to bring huge pages
> > to ext4.
> 
> So this patch is more about mm level changes than it is about the file
> system, and I didn't see any comments from the linux-mm peanut gallery
> (unless the linux-ext4 list got removed from the cc list, or some such).
> 
> I haven't had time to take a close look at the ext4 changes, and I'll
> try to carve out some time to do that

I would appreciate it.

> --- but has anyone from the mm
> side of the world taken a look at these patches?

Not yet. I had hard time obtaining review on similar-sized patchsets
before :-/

-- 
 Kirill A. Shutemov
