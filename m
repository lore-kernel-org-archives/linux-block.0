Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] badblocks: fix overlapping check for clearing
To: Tomasz Majchrzak <tomasz.majchrzak@intel.com>, linux-block@vger.kernel.org
References: <1476267788-31480-1-git-send-email-tomasz.majchrzak@intel.com>
Cc: dan.j.williams@intel.com, neilb@suse.com, aleksey.obitotskiy@intel.com,
 pawel.baldysiak@intel.com, artur.paszkiewicz@intel.com,
 maksymilian.kunt@intel.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <beaa1a1c-be60-a3c8-b8e3-9e9ece4b8b26@kernel.dk>
Date: Wed, 12 Oct 2016 08:07:41 -0600
MIME-Version: 1.0
In-Reply-To: <1476267788-31480-1-git-send-email-tomasz.majchrzak@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/12/2016 04:23 AM, Tomasz Majchrzak wrote:
> Current bad block clear implementation assumes the range to clear
> overlaps with at least one bad block already stored. If given range to
> clear precedes first bad block in a list, the first entry is incorrectly
> updated.
>
> Check not only if stored block end is past clear block end but also if
> stored block start is before clear block end.

Queued up, thanks.

-- 
Jens Axboe
