Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38583 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752048AbdBVCni (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2017 21:43:38 -0500
Subject: Re: [PATCHv4 0/4] OPAL patches, cont'd
To: Jon Derrick <jonathan.derrick@intel.com>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
CC: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        "Scott Bauer" <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <a75babc1-5a9d-2979-514a-5fea19370084@fb.com>
Date: Tue, 21 Feb 2017 19:42:55 -0700
MIME-Version: 1.0
In-Reply-To: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/21/2017 11:59 AM, Jon Derrick wrote:
> v3->v4:
> Passes in 'lock_held' into opal_lock_unlock() so we don't need to
> mutex_trylock(). I wasn't totally confident in that approach anyways.
> 
> v2->v3:
> Squashed 5/5 into 4/5
> Changed opal_step structs back to const
> Cleaned up opal_lock_unlock
> 
> v1->v2:
> Moved misplaced code from 5/5 to 4/5

Guys, where are we at with this? I'm shipping off some more fixes
for -rc1 soon, and I'd really like to get this wrapped up sooner
rather than later.

-- 
Jens Axboe
