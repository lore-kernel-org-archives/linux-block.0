Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH next] Btrfs: fix comparison in __btrfs_map_block()
To: =?UTF-8?Q?Vincent_Stehl=c3=a9?= <vincent.stehle@intel.com>,
 linux-btrfs@vger.kernel.org
References: <1465155145-10812-14-git-send-email-mchristi@redhat.com>
 <1468595001-4270-1-git-send-email-vincent.stehle@intel.com>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
 Mike Christie <mchristi@redhat.com>, Jens Axboe <axboe@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <17530fad-226a-77e7-ff76-3fca3b1ffc97@kernel.dk>
Date: Mon, 18 Jul 2016 15:28:52 -0600
MIME-Version: 1.0
In-Reply-To: <1468595001-4270-1-git-send-email-vincent.stehle@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/15/2016 09:03 AM, Vincent Stehl� wrote:
> Add missing comparison to op in expression, which was forgotten when doing
> the REQ_OP transition.

Thanks, added to the 4.8 branch.

-- 
Jens Axboe
