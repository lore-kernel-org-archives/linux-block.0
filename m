Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <20160729182314.6368-1-ross.zwisler@linux.intel.com>
References: <20160729182314.6368-1-ross.zwisler@linux.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 29 Jul 2016 13:31:58 -0700
Message-ID: <CAPcyv4h+TFEkLm-6MJkM4Xdp+cjBR2LCyeAqcjv0SaLWYpuCXA@mail.gmail.com>
Subject: Re: [PATCH] block: remove BLK_DEV_DAX config option
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 29, 2016 at 11:23 AM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
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
>
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>
