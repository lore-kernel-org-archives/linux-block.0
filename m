Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752716AbeAaRsm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jan 2018 12:48:42 -0500
Date: Wed, 31 Jan 2018 12:48:40 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Killing reliance on struct page->mapping
Message-ID: <20180131174840.GF2912@redhat.com>
References: <20180130004347.GD4526@redhat.com>
 <111f49c1-02d1-3355-e403-a8f91c0191e2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <111f49c1-02d1-3355-e403-a8f91c0191e2@huawei.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 31, 2018 at 07:09:48PM +0200, Igor Stoppa wrote:
> On 30/01/18 02:43, Jerome Glisse wrote:
> 
> [...]
> 
> > Maybe we can kill page->mapping altogether as a result of this. However this is
> > not my motivation at this time.
> 
> We had a discussion some time ago
> 
> http://www.openwall.com/lists/kernel-hardening/2017/07/07/7
> 
> where you advised to use it for tracking pmalloc pages vs area, which
> generated this patch:
> 
> http://www.openwall.com/lists/kernel-hardening/2018/01/24/7
> 
> Could you please comment what wold happen to the shortcut from struct
> page to vm_struct that this patch is now introducing?

Sadly struct page fields means different thing depending on the context
in which the page is use. This is confusing i know. So when i say kill
page->mapping i am not saying shrink the struct page and remove that
field, i am saying maybe we can kill current user of page->mapping
for regular process page (ie page that are in some mmap() area of a
process).

Other use of that field in different context like yours are not affected
by this change and can ignore it alltogether.

Hope this clarify it :)

Cheers,
J�r�me
