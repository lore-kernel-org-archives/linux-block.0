Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 03/11] fs: add support for an inode to carry stream
 related data
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
 <1497467134-6323-4-git-send-email-axboe@kernel.dk>
 <20170614202546.GA7022@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <19d75a47-19a3-c6e2-e1f9-cd61ef61ae34@kernel.dk>
Date: Wed, 14 Jun 2017 14:37:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170614202546.GA7022@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 02:25 PM, Christoph Hellwig wrote:
> On Wed, Jun 14, 2017 at 01:05:26PM -0600, Jens Axboe wrote:
>> No functional changes in this patch, just in preparation for
>> allowing applications to pass in hints about data life times
>> for writes.
>>
>> Pack the i_stream field into a 2-byte hole, so we don't grow
>> the size of the inode.
> 
> Can't we find space for 4 flags somewhere else?

Where? I can stuff them in i_flags? But apart from that, stealing
space in a hole seems the sanest.

-- 
Jens Axboe
