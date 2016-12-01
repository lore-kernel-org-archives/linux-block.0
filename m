Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Date: Wed, 30 Nov 2016 19:50:07 -0500
From: Keith Busch <keith.busch@intel.com>
To: Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCH v2 2/4] block: Add Sed-opal library
Message-ID: <20161201005006.GE21081@localhost.localdomain>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
MIME-Version: 1.0
In-Reply-To: <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, sagi@grimberg.me, Rafael.Antognolli@intel.com,
 linux-nvme@lists.infradead.org, axboe@fb.com, linux-block@vger.kernel.org,
 jonathan.derrick@intel.com, j.naumann@fu-berlin.de
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 29, 2016 at 02:52:00PM -0700, Scott Bauer wrote:
> +struct opal_dev {
> +	dev_t majmin;
> +	sed_sec_submit *submit_fn;
> +	void *submit_data;
> +	struct opal_lock_unlock lkul;
> +	const opal_step *funcs;
> +	void **func_data;
> +	bool resume_from_suspend;
> +	struct opal_suspend_unlk *resume_data;
> +	size_t num_func_data;
> +	atomic_t in_use;
> +	sector_t start;
> +	sector_t length;
> +	u8 lr;
> +	u8 key_type;
> +	u8 key_name[OPAL_KEY_MAX];
> +	size_t key_name_len;
> +	u8 key[OPAL_KEY_MAX];
> +	size_t key_len;
> +	u16 comID;
> +	u32 HSN;
> +	u32 TSN;
> +	u64 align;
> +	u64 lowest_lba;
> +	struct list_head node;
> +	char disk_name[DISK_NAME_LEN];
> +	int state;
> +
> +	struct opal_cmd cmd;
> +	struct parsed_resp parsed;
> +
> +	size_t prev_d_len;
> +	void *prev_data;
> +
> +	opal_step error_cb;
> +	void *error_cb_data;
> +};

I think this structure could use some kernel-doc comments explaining what
all these fields are for. Some of them don't appear to be used anywhere
in the code, but it'd help to know what the fields are supposed to be for.

I think we should get rid of the "majmin" stuff and directly use
block_device. Then if we add the security send/receive operations to the
block_device_operations, that will simplify chaining the security request
to the driver without needing to thread the driver's requested callback
and data the way you have to here since all the necessary information
is encapsulated in the block_device.

We shouldn't need to be allocating an 'opal_dev' for every range. The
range-specific parts should be in a different structure that the opal_dev
can have a list of. That will simpify the unlock from suspend a bit.

> +/*
> + * N = number of format specifiers (1-999) to be replicated
> + * c = u8
> + * u = u64
> + * s = bytestring, length
> + *
> + * ret = test_and_add_token_va(cmd, "c",
> + *			       u8_val1);
> + *
> + * ret = test_and_add_token_va(cmd, "2c2u",
> + *			       u8_val1, u8_val2, u64_val1, u64_val2);
> + *
> + * ret = test_and_add_token_va(cmd, "3s",
> + *			       bytestring1, length1,
> + *			       bytestring2, length2,
> + *			       bytestring3, length3);
> + */
> +static int test_and_add_token_va(struct opal_cmd *cmd,
> +				 const char *fmt, ...)

This custom formated string parser looks too complicated to me. I'll try
propose something simpler once I fully understand all the parts to this.

> +#define CMD_TO_FN_INDX(cmd) \
> +	(cmd) - IOC_SED_SAVE
> +
> +int (*sed_fn[])(struct block_device *bdev, struct sed_key *key,
> +		  void *sbmt_data, sed_sec_submit *submit_fn) =
> +{
> +	sed_save,
> +	sed_lock_unlock,
> +	sed_take_ownership,
> +	sed_activate_lsp,
> +	sed_set_pw,
> +	sed_activate_user,
> +	sed_reverttper,
> +	sed_setup_locking_range,
> +	sed_adduser_to_lr,
> +	sed_do_mbr,
> +	sed_erase_lr,
> +	sed_secure_erase_lr
> +};
> +
> +/* The sbmt_ctrl_data is a opaque pointer to some structure which will be used
> + * by the submit_fn to properly submit the opal command to the controller.
> + * The submit_fn must be a blocking call.
> + */
> +int blkdev_sed_ioctl(struct block_device *bdev, fmode_t fmode, unsigned int cmd,
> +		     unsigned long arg, void *sbmt_ctrl_data,
> +		     sed_sec_submit *submit_fn)
> +{
> +	struct sed_key key;
> +
> +	 /* Caller should do this but since we're going to use cmd as an index
> +	 * lets 'trust but verify'.
> +	 */
> +	if (!is_sed_ioctl(cmd))
> +		return -EINVAL;
> +	if (copy_from_user(&key, (void __user *)arg, sizeof(key)))
> +		return -EFAULT;
> +	return sed_fn[CMD_TO_FN_INDX(cmd)](bdev, &key, sbmt_ctrl_data, submit_fn);

I can appreciate how compact this is, but this is a little harder to
read IMO, and it works only because you were so careful in setting up
the array. I think expanding the ioctl into a switch will be easier to
follow, and has a more tolerent coding convention for future additions.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
