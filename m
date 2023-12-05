Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csJtwRRL"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08FEA7
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 17:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701738188; x=1733274188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rrSUkEEkMK4RtsHwwJOywZRKkiACbCwtIz2jJBU80pM=;
  b=csJtwRRLUdv2fqoY/ynrmvVtspmZeMDpT2o082qQAxBemlWLS4aE2nks
   yGfHqRx+mHTnMAKfhS2Jn2HmgXRL0JOt62yKHee6pr/PbPIfqnqTAdzg6
   iPkg66U3ZzWLrCbQv06PcRhmx9HnO/awJWb27zmjB57tj2r+6u1aFgme7
   c1w+YnOjbTim0WbH8JPn12jnvzqAp3jO+S1WnLKM5QELtRiLtlBu46UXn
   1O/eAUE/VxSCjrUyMlg7sSspfUhQxHVhVu3C0w3N09/+AG/FMgYvrDcyF
   5mUgb3FN82sThMK6QjjMLoaXOAZl9j966ilPxgqgtwjzBWnMEppJhG3BF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="373266981"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="373266981"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 17:03:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861572414"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="861572414"
Received: from abijaz-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.240])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 17:03:06 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 46D6110A437; Tue,  5 Dec 2023 04:03:03 +0300 (+03)
Date: Tue, 5 Dec 2023 04:03:03 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, agk@redhat.com, bmarzins@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	mpatocka@redhat.com, mpe@ellerman.id.au, snitzer@kernel.org
Subject: Re: [PATCH 1/2] mm, treewide: Introduce NR_PAGE_ORDERS
Message-ID: <20231205010303.tpt6wjicnvfopcmn@box.shutemov.name>
References: <20231120221735.k6iyr5t5wdlgpxui@box.shutemov.name>
 <20231121122712.31339-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wiqu14v=RdTYZwF60gpBb0gYdN++u-e-jnqkjEm0m6UdA@mail.gmail.com>
 <20231122123413.y54fmmk65qoxarzg@box.shutemov.name>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122123413.y54fmmk65qoxarzg@box.shutemov.name>

On Wed, Nov 22, 2023 at 03:34:13PM +0300, Kirill A. Shutemov wrote:
> On Tue, Nov 21, 2023 at 09:46:57AM -0800, Linus Torvalds wrote:
> > On Tue, 21 Nov 2023 at 04:27, Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > NR_PAGE_ORDERS defines the number of page orders supported by the page
> > > allocator, ranging from 0 to MAX_ORDER, MAX_ORDER + 1 in total.
> > >
> > > NR_PAGE_ORDERS assists in defining arrays of page orders and allows for
> > > more natural iteration over them.
> > 
> > These two patches look much better to me, but I think you missed one area.
> > 
> > Most of the Kconfig changes by commit 23baf831a32c ("mm, treewide:
> > redefine MAX_ORDER sanely") should also be basically reverted to use
> > this new NR_PAGE_ORDERS.
> 
> I am not convinced.
> 
> Some architectures make this option user-visible and, in my view, user
> cares more about the largest page size buddy allocator can provide than
> size of the array inside the allocator.
> 
> > IOW, I think the ARCH_FORCE_MAX_ORDER #defines etc should also be done
> > in "number of page orders". I suspect from a documentation standpoint
> > that also makes more sense in places, eg I think that right now your
> > patch says
> > 
> >                         amount of memory for normal system use. The maximum
> > -                       possible value is MAX_ORDER/2.  Setting this parameter
> > +                       possible value is MAX_PAGE_ORDER/2.  Setting this
> > 
> > and that's actually nonsensical, because it's NR_PAGE_ORDERS that was
> > at least historically the boundary (and historically the one that was
> > an even number that can be halved cleanly).
> 
> Maybe historically (I didn't check), but not now. It is all over the
> place. And it more even in MAX_PAGE_ORDER terms than in NR_PAGE_ORDERS:
> 
> ...

Ping?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
