Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491F1CA9EB0
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 00:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1531B21D7C
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 00:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfKDAPZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Nov 2019 19:15:25 -0500
Received: from bout01.mta.xmission.com ([166.70.11.15]:34203 "EHLO
        bout01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfKDAPZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Nov 2019 19:15:25 -0500
Received: from mx01.mta.xmission.com ([166.70.13.211])
        by bout01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iRQ1j-0007BI-5Y; Sun, 03 Nov 2019 17:15:23 -0700
Received: from plesk14-shared.xmission.com ([166.70.198.161] helo=plesk14.xmission.com)
        by mx01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <sbauer@plzdonthack.me>)
        id 1iRQ1i-0002CT-Gf; Sun, 03 Nov 2019 17:15:23 -0700
Received: from hacktheplanet (c-68-50-34-150.hsd1.in.comcast.net [68.50.34.150])
        by plesk14.xmission.com (Postfix) with ESMTPSA id AED5D217436;
        Mon,  4 Nov 2019 00:15:21 +0000 (UTC)
Date:   Sun, 3 Nov 2019 19:15:19 -0500
From:   Scott Bauer <sbauer@plzdonthack.me>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>,
        Jens Axboe <axboe@kernel.dk>
Message-ID: <20191104001519.GB12665@hacktheplanet>
References: <20191031161322.16624-1-revanth.rajashekar@intel.com>
 <20191031161322.16624-3-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031161322.16624-3-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-XM-SPF: eid=1iRQ1i-0002CT-Gf;;;mid=<20191104001519.GB12665@hacktheplanet>;;;hst=mx01.mta.xmission.com;;;ip=166.70.198.161;;;frm=sbauer@plzdonthack.me;;;spf=none
X-SA-Exim-Connect-IP: 166.70.198.161
X-SA-Exim-Mail-From: sbauer@plzdonthack.me
Subject: Re: [PATCH v3 2/3] block: sed-opal: Add support to read/write opal
 tables generically
X-SA-Exim-Version: 4.2.1 (built Mon, 03 Jun 2019 09:49:16 -0600)
X-SA-Exim-Scanned: Yes (on mx01.mta.xmission.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 31, 2019 at 10:13:21AM -0600, Revanth Rajashekar wrote:
> This feature gives the user RW access to any opal table with admin1
> authority. The flags described in the new structure determines if the user
> wants to read/write the data. Flags are checked for valid values in
> order to allow future features to be added to the ioctl.
> 
> The user can provide the desired table's UID. Also, the ioctl provides a
> size and offset field and internally will loop data accesses to return
> the full data block. Read overrun is prevented by the initiator's
> sec_send_recv() backend. The ioctl provides a private field with the
> intention to accommodate any future expansions to the ioctl.
> 
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
Looks fine
Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>



> +static int read_table_data(struct opal_dev *dev, void *data)
> +{
> +	struct opal_read_write_table *read_tbl = data;
> +	int err;
> +	size_t off = 0, max_read_size = OPAL_MAX_READ_TABLE;
> +	u64 table_len, len;
> +	u64 offset = read_tbl->offset, read_size = read_tbl->size - 1;
> +	u8 __user *dst;

> +
> +		/* len+1: This includes the NULL terminator at the end*/
> +		if (dev->prev_d_len > len + 1) {
> +			err = -EOVERFLOW;
> +			break;
> +		}
> +
> +		dst = (u8 __user *)(uintptr_t)read_tbl->data;
> +		if (copy_to_user(dst + off, dev->prev_data, dev->prev_d_len)) {
> +			pr_debug("Error copying data to userspace\n");
> +			err = -EFAULT;
> +			break;
> +		}
> +		dev->prev_data = NULL;

If you end up needing to spin a v4 can you please add a comment here reminding me that prev_data in this scenario is not kmalloc'd memory but an offset into the response buffer. I had to go track down why you were not kfree()ing this. I know in a year I'll have forgotten it and will review it again.



> +static int opal_generic_read_write_table(struct opal_dev *dev,
> +					 struct opal_read_write_table *rw_tbl)
> +{
> +	int ret, bit_set;
> +
> +	mutex_lock(&dev->dev_lock);
> +	setup_opal_dev(dev);
> +
> +	bit_set = fls64(rw_tbl->flags) - 1;
Maybe I am missing something obvious but why don't we just use flags as a number? Like instead of bit packing flags we just use it as a number like number 0 is read_table, 1 is write_table, 2 is delete_table, 3 is clear_table etc etc. I don't understand the neccessity for fls-ing some bit field when a number would suffice.

I don't want another revision --it's fine-- I'm just wondering why this method was chosen. 

