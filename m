Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Wed, 31 Jan 2018 17:55:58 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jerome Glisse <jglisse@redhat.com>
Message-ID: <20180131175558.GA30522@ZenIV.linux.org.uk>
References: <20180130004347.GD4526@redhat.com>
	<20180131165646.GI29051@ZenIV.linux.org.uk>
	<20180131174245.GE2912@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20180131174245.GE2912@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
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

> For block devices the idea is to use struct page and buffer_head (first one of
> a page) as a key to find mapping (struct address_space) back.

Details, please...
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
