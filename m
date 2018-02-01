Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Thu, 1 Feb 2018 15:27:52 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jerome Glisse <jglisse@redhat.com>
Message-ID: <20180201122752.xrlzy4lmjkvauge4@node.shutemov.name>
References: <20180130004347.GD4526@redhat.com>
	<20180131165646.GI29051@ZenIV.linux.org.uk>
	<20180131174245.GE2912@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20180131174245.GE2912@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Killing reliance on struct page->mapping
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf-pc/>
List-Post: <mailto:lsf-pc@lists.linux-foundation.org>
List-Help: <mailto:lsf-pc-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: lsf-pc-bounces@lists.linux-foundation.org
Errors-To: lsf-pc-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 31, 2018 at 12:42:45PM -0500, Jerome Glisse wrote:
> The overall idea i have is that in any place in the kernel (except memory reclaim
> but that's ok) we can either get mapping or buffer_head information without relying
> on struct page and if we have either one and a struct page then we can find the
> other one.

Why is it okay for reclaim?

And what about physical memory scanners that doesn't have any side information
about the page they step onto?

-- 
 Kirill A. Shutemov
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
