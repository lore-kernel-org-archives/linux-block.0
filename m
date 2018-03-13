Return-Path: <scott.bauer@intel.com>
Date: Tue, 13 Mar 2018 09:44:17 -0600
From: Scott Bauer <scott.bauer@intel.com>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] block: sed-opal: ioctl for writing to shadow mbr
Message-ID: <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
 <b0b34fc0132312c09629c868d33b74fe5a19854e.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b0b34fc0132312c09629c868d33b74fe5a19854e.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 13, 2018 at 02:09:01PM +0100, Jonas Rabenstein wrote:
> Allow modification of the shadow mbr. If the shadow mbr is not marked as
> done, this data will be presented read only as the device content. Only
> after marking the shadow mbr as done and unlocking a locking range the
> actual content is accessible.
> 


> Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> +static int opal_write_shadow_mbr(struct opal_dev *dev,
> +				 struct opal_shadow_mbr *info)
> +{
> +	const struct opal_step mbr_steps[] = {
> +		{ opal_discovery0, },
> +		{ start_admin1LSP_opal_session, &info->key },
> +		{ write_shadow_mbr, info },
> +		{ end_opal_session, },
> +		{ NULL, }
> +	};
> +	int ret;
> +
> +	if (info->size == 0)
> +		return 0;

We need to bound this to some maximum. I assume we'll at some point come across a controller
with crappy firmware that wont check this against the MBR Table size and the user will either
brick their drive or overwrite their data.

We can get the size of the MBR Table it seems but I'm not sure how hard it is to pull that table yet.

TCG SAS 5.7.3.6:
The size of the MBR Table is retrievable from the "Table" table of the SP that incorporates the Locking Template.

As always the TCG spec is super helpful /s.

I will see how todo this and if it's worth it.


> diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
> index 0cb9890cdc04..c2669ebff681 100644
> --- a/include/uapi/linux/sed-opal.h
> +++ b/include/uapi/linux/sed-opal.h
> @@ -104,6 +104,13 @@ struct opal_mbr_data {
>  	__u8 __align[7];
>  };
>  
> +struct opal_shadow_mbr {
> +	struct opal_key key;
> +	const __u8 *data;

 Please use a u64 here for the data and cast it to a pointer
 in the driver. We do this so we do not have to maintain a compat
 layer for 32 bit userland.
