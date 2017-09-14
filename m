Return-Path: <jthumshirn@suse.de>
Date: Thu, 14 Sep 2017 10:17:57 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Philipp Guendisch <philipp.guendisch@fau.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, damien.lemoal@wdc.com, axboe@kernel.dk,
	viro@zeniv.linux.org.uk, bart.vanassche@sandisk.com,
	martin.petersen@oracle.com, hare@suse.de, osandov@fb.com,
	dan.j.williams@intel.com, ming.lei@redhat.com,
	linux-kernel@i4.cs.fau.de, Mate Horvath <horvatmate@gmail.com>
Subject: Re: [PATCH] Support for secure erase functionality
Message-ID: <20170914081757.c64qa6pp2zi5hmda@linux-x5ow.site>
References: <1505317073-22567-1-git-send-email-philipp.guendisch@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1505317073-22567-1-git-send-email-philipp.guendisch@fau.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 13, 2017 at 05:37:53PM +0200, Philipp Guendisch wrote:
> This patch adds a software based secure erase option to improve data
> confidentiality. The CONFIG_BLK_DEV_SECURE_ERASE option enables a mount
> flag called 'sw_secure_erase'. When you mount a volume with this flag,
> every discard call is prepended by an explicit write command to overwrite
> the data before it is discarded. A volume without a discard compatibility
> can be used as well but the discard calls will be enabled for this device
> and suppressed after the write call is made.

How can this work with CoW filesystems?

> 
> Built against torvalds/linux

This should go below the '---' so git am doesn't write it into the changelog.


[...]

> +	if (strcmp(fs_type->name, "ext4") != 0 &&
> +	    strcmp(fs_type->name, "btrfs") != 0 &&
> +	    strcmp(fs_type->name, "gfs2") != 0 &&
> +	    strcmp(fs_type->name, "gfs2meta") != 0 &&
> +	    strcmp(fs_type->name, "xfs") != 0 &&
> +	    strcmp(fs_type->name, "jfs") != 0) {
> +		pr_warn("fs: The mounted %s filesystem on drive %s does not generate discards, secure erase won't work",
> +				fs_type->name, dev_name);
> +	}
> +skip:
> +#endif

Which filesystems commonly used in production are left afterwards?

I'm sorry, but while I get that this sounds like a nice feature for a paper or
reasearch project, I don't see why it should be used on production systems at
all.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
