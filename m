Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ipo2.cc.utah.edu ([155.97.144.12]:16505 "EHLO ipo2.cc.utah.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752806AbdBVDPH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2017 22:15:07 -0500
Subject: Re: [PATCHv4 0/4] OPAL patches, cont'd
To: Jens Axboe <axboe@fb.com>, Jon Derrick <jonathan.derrick@intel.com>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
 <a75babc1-5a9d-2979-514a-5fea19370084@fb.com>
Cc: linux-block@vger.kernel.org,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Scott Bauer <scott.bauer@intel.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
From: Scott Bauer <sbauer@eng.utah.edu>
Message-ID: <ab5119d2-467f-f08d-c1ad-c91d9ed97d58@eng.utah.edu>
Date: Tue, 21 Feb 2017 20:14:51 -0700
MIME-Version: 1.0
In-Reply-To: <a75babc1-5a9d-2979-514a-5fea19370084@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 02/21/2017 07:42 PM, Jens Axboe wrote:
> On 02/21/2017 11:59 AM, Jon Derrick wrote:
>> v3->v4:
>> Passes in 'lock_held' into opal_lock_unlock() so we don't need to
>> mutex_trylock(). I wasn't totally confident in that approach anyways.
>>
>> v2->v3:
>> Squashed 5/5 into 4/5
>> Changed opal_step structs back to const
>> Cleaned up opal_lock_unlock
>>
>> v1->v2:
>> Moved misplaced code from 5/5 to 4/5
> 
> Guys, where are we at with this? I'm shipping off some more fixes
> for -rc1 soon, and I'd really like to get this wrapped up sooner
> rather than later.
> 

We just need Christoph to look at patch 4/4. Once he reviews it it the series
is good to go. Once this goes in I have one patch I previously sent and one from 
Christoph I took over. After that the opal code should be quiet for the rest of the
release candidates. We've ironed out all the kinks and clean ups it seems. 
