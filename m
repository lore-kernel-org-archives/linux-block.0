Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: remove BLK_DEV_DAX config option
To: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20160729182314.6368-1-ross.zwisler@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
 Dave Hansen <dave.hansen@linux.intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <990cc01e-12c3-5967-dd28-4a54574828ee@kernel.dk>
Date: Fri, 29 Jul 2016 15:19:28 -0600
MIME-Version: 1.0
In-Reply-To: <20160729182314.6368-1-ross.zwisler@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 07/29/2016 12:23 PM, Ross Zwisler wrote:
> The functionality for block device DAX was already removed with this
> commit:
>
> commit acc93d30d7d4 ("Revert "block: enable dax for raw block devices"")
>
> However, we still had a config option hanging around that was always
> disabled because it depended on CONFIG_BROKEN.  This config option was
> introduced in this commit:
>
> commit 03cdadb04077 ("block: disable block device DAX by default")
>
> This change reverts that commit, removing the dead config option.

This doesn't apply to master, nor for-linus. I hand applied it.

-- 
Jens Axboe
