Return-Path: <jthumshirn@suse.de>
Subject: Re: [PATCH v3] dm: don't allow ioctls to targets that don't map to
 whole devices
To: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
References: <20170203163708.13943-1-hch@lst.de>
 <20170203163921.GA823@redhat.com> <20170203164129.GA4755@lst.de>
Cc: axboe@kernel.dk, agk@redhat.com, pbonzini@redhat.com,
 dm-devel@redhat.com, linux-block@vger.kernel.org
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <4435311b-80e1-8764-fa12-140203e9231f@suse.de>
Date: Fri, 3 Feb 2017 19:17:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170203164129.GA4755@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 02/03/2017 05:41 PM, Christoph Hellwig wrote:
> On Fri, Feb 03, 2017 at 11:39:22AM -0500, Mike Snitzer wrote:
>> I assume you meant for v3 to remove the newline? ;)
> I did.  And I swear I did edit the file, but I guess the ammend
> didn't work.  I guess it's time for the weekend..  I'll resend after
> I got some rest.

Forgotten git add? git commit --amend without git add is such a classic 
mistake on my side as well :-/


Anyways,

Reviewed-by: Johannes Thumshirn <jthumshirn@kernel.org>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
