Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [PATCH V3 2/2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
To: Scott Bauer <scott.bauer@intel.com>, linux-nvme@lists.infradead.org
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
 <1486660801-5105-3-git-send-email-scott.bauer@intel.com>
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <e82756b9-df77-6033-b6ce-fbf9aac3b9a8@suse.de>
Date: Fri, 10 Feb 2017 08:45:38 +0100
MIME-Version: 1.0
In-Reply-To: <1486660801-5105-3-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, arnd@arndb.de, hch@infradead.org,
 linux-kernel@vger.kernel.org, axboe@fb.com, David.Laight@ACULAB.COM,
 linux-block@vger.kernel.org, jonathan.derrick@intel.com
Content-Type: text/plain; charset="windows-1252"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On 02/09/2017 06:20 PM, Scott Bauer wrote:
> When CONFIG_KASAN is enabled, compilation fails:
> =

> block/sed-opal.c: In function 'sed_ioctl':
> block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger th=
an 2048 bytes [-Werror=3Dframe-larger-than=3D]
> =

> Moved all the ioctl structures off the stack and dynamically activate
> using _IOC_SIZE()
> =

> Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
> =

> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Scott Bauer <scott.bauer@intel.com>
> ---
>  block/sed-opal.c | 134 +++++++++++++++++++++----------------------------=
------
>  1 file changed, 50 insertions(+), 84 deletions(-)
> =


[...]

> -		if (copy_from_user(&session, arg, sizeof(session)))
> -			return -EFAULT;
> -		return opal_erase_locking_range(dev, &session);
> +	ioctl_ptr =3D kzalloc(cmd_size, GFP_KERNEL);
> +	if (!ioctl_ptr)
> +		return -ENOMEM;
> +	if (copy_from_user(ioctl_ptr, arg, cmd_size)) {
> +		ret =3D -EFAULT;
> +		goto out;
>  	}

Can't we use memdup_user() instead of kzalloc() + copy_from_user()?



-- =

Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
