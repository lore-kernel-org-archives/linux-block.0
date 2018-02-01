Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752731AbeBANW3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Feb 2018 08:22:29 -0500
Date: Thu, 1 Feb 2018 08:22:26 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Killing reliance on struct page->mapping
Message-ID: <20180201132225.GA2864@redhat.com>
References: <20180130004347.GD4526@redhat.com>
 <20180131165646.GI29051@ZenIV.linux.org.uk>
 <20180131174245.GE2912@redhat.com>
 <20180201122752.xrlzy4lmjkvauge4@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180201122752.xrlzy4lmjkvauge4@node.shutemov.name>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Feb 01, 2018 at 03:27:52PM +0300, Kirill A. Shutemov wrote:
> On Wed, Jan 31, 2018 at 12:42:45PM -0500, Jerome Glisse wrote:
> > The overall idea i have is that in any place in the kernel (except memory reclaim
> > but that's ok) we can either get mapping or buffer_head information without relying
> > on struct page and if we have either one and a struct page then we can find the
> > other one.
> 
> Why is it okay for reclaim?
> 
> And what about physical memory scanners that doesn't have any side information
> about the page they step onto?

Reclaim is only interested in unmapping and reclaiming, KSM already provide
special function for unmapping (rmap walk) so it is just about extending that
for file back page.

For physical memory scanners it depends on what their individual objectives are.
I have not reviewed them but had the feeling that i could add special KSM helpers
to achieve aims of each one of them.

The mapping information is not lost, it would just not be easily accessible
for those write protected pages.

Cheers,
J�r�me
