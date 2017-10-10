Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] writeback: merge try_to_writeback_inodes_sb_nr() into
 caller
To: Rakesh Pandit <rakesh@tuxera.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-block@vger.kernel.org
References: <20171009103440.GA29114@dhcp-216.srv.tuxera.com>
 <20171009120029.GL17917@quack2.suse.cz>
 <20171010094306.GA32628@dhcp-216.srv.tuxera.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2730ed85-a0a8-7da2-d91a-fe82fe215b75@kernel.dk>
Date: Tue, 10 Oct 2017 08:15:02 -0600
MIME-Version: 1.0
In-Reply-To: <20171010094306.GA32628@dhcp-216.srv.tuxera.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/10/2017 03:43 AM, Rakesh Pandit wrote:
> Hi Jens,
> 
> On Mon, Oct 09, 2017 at 02:00:29PM +0200, Jan Kara wrote:
>> On Mon 09-10-17 13:34:41, Rakesh Pandit wrote:
>>> Since commit 925a6efb8ff0c ("Btrfs: stop using
>>> try_to_writeback_inodes_sb_nr to flush delalloc") this function hasn't
>>> been used outside so stop exporting it.
>>>
>>> In addition we merge it into try_to_writeback_inodes_sb() which is the
>>> only caller.  Also change return type of try_to_writeback_inodes_sb to
>>> void as the only user ext4 doesn't care.
>>>
>>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>>
>> Looks good. You can add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>>
>> 								Honza
> 
> As there are many writeback related changes on your tree would you be
> okay queuing this up as well for-4.15 with above reviewed-by tag ?
> 
> This should apply fine on your tree for-4.15.
> 
> Let me know if that isn't okay.

That's fine, I'll queue it up.

-- 
Jens Axboe
