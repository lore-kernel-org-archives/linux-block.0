Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4761AC4332F
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 07:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiKVHRz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 02:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKVHRz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 02:17:55 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025EC25E89
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 23:17:53 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z20so17884044edc.13
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 23:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pK7+DIpf65Na+xkTauo/5yw1tjrhzCqldyom1FiwYk=;
        b=Bnmqwa+QSdR8J134qyGz23rjmr9bhFZ4aaAwUBnX4ztDg9bzEvgmK1yRxybEhrMjR+
         kCe8P4Y8BaV+dl6Uwe221D9Nva9Jn69AfW4COUU/YeUrVZ6Mh7UG9KB8wkoxr9XYIVLC
         2r+vN1QFWZ7gTLkmCw4P45hS9Llhb4LfR8eCQ7nPB2W/OXCR5ZYVXk45hHU00EK8baeS
         uFm0O+fkZ1iUx2QvOudbYNIWWv/xMPZGX8eHWuZ21n8nwQgcFvukq0YqF+p3YNt5sObu
         PjaQpX60x9MRkyVSu72AUo0ShHzl5m+fNHao5+lGirzi5sx9H6E6oCDcKgsELUljI4nS
         ntYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pK7+DIpf65Na+xkTauo/5yw1tjrhzCqldyom1FiwYk=;
        b=Uws5r5DEWVK3PgOY0i+my/RM4nBt76KgC2UhIluZ1TPzclHzPUKheinTIFmdbgpvsw
         mleeWz0eDW5q5IQl56tL4SWHc/+ExAAkSGyPlGpYPaOW7mV9XN3tpzBmSGvPDBX92QL0
         WPBRdxMAeX3zIO8bPviVjHBoXrYgbyIE9ER4U9GCKUPuvCD7OBa9LJV3HmHAGIHwHV4D
         BuQ6t+Q5u2b+Bj7Zp5CUHSYwsfuXRYYF0BJsWcWCrcbLcOgjoUQyy+Knb3Ck1ohQzqee
         7xZJWnmV/p6+as2ERMwP7OYiHM3ICe/IW9NBS0XLKxs/+I2r/0IeBnwdS+PRsXFVRxZJ
         luOQ==
X-Gm-Message-State: ANoB5pl3laC104HoPRZqMaA/gJL2xD0FWwRShoH3A4izpTB+8ogDpxy2
        zMMn5P9nZkNoh63nVhFjifVuFFWiZQJDfw==
X-Google-Smtp-Source: AA0mqf5ZjigOakUK+3q0yPZMb4Hv3RA/VzsT1hX9pIbxpnC02WL0dVK7/nDulUMFQPj1zoKXas5Oxw==
X-Received: by 2002:a05:6402:1f09:b0:462:6a0c:cfa with SMTP id b9-20020a0564021f0900b004626a0c0cfamr3028215edb.349.1669101471529;
        Mon, 21 Nov 2022 23:17:51 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906b30d00b007af0f0d2249sm5814786ejz.52.2022.11.21.23.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 23:17:51 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:17:47 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 6/6] ublk_drv: add mechanism for supporting unprivileged
 ublk device
Message-ID: <202211220917.c5VXrB5O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116060835.159945-7-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/ublk_drv-add-mechanism-for-supporting-unprivileged-ublk-device/20221116-141131
patch link:    https://lore.kernel.org/r/20221116060835.159945-7-ming.lei%40redhat.com
patch subject: [PATCH 6/6] ublk_drv: add mechanism for supporting unprivileged ublk device
config: x86_64-randconfig-m001-20221121
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/block/ublk_drv.c:2107 ublk_ctrl_uring_cmd_permission() error: uninitialized symbol 'mask'.

vim +/mask +2107 drivers/block/ublk_drv.c

a922b5da71a7776 Ming Lei 2022-11-16  2043  static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
a922b5da71a7776 Ming Lei 2022-11-16  2044  		struct io_uring_cmd *cmd)
a922b5da71a7776 Ming Lei 2022-11-16  2045  {
a922b5da71a7776 Ming Lei 2022-11-16  2046  	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
a922b5da71a7776 Ming Lei 2022-11-16  2047  	bool unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
a922b5da71a7776 Ming Lei 2022-11-16  2048  	void __user *argp = (void __user *)(unsigned long)header->addr;
a922b5da71a7776 Ming Lei 2022-11-16  2049  	char *dev_path = NULL;
a922b5da71a7776 Ming Lei 2022-11-16  2050  	int ret = 0;
a922b5da71a7776 Ming Lei 2022-11-16  2051  	int mask;
a922b5da71a7776 Ming Lei 2022-11-16  2052  
a922b5da71a7776 Ming Lei 2022-11-16  2053  	if (!unprivileged) {
a922b5da71a7776 Ming Lei 2022-11-16  2054  		if (!capable(CAP_SYS_ADMIN))
a922b5da71a7776 Ming Lei 2022-11-16  2055  			return -EPERM;
a922b5da71a7776 Ming Lei 2022-11-16  2056  		/*
a922b5da71a7776 Ming Lei 2022-11-16  2057  		 * The new added command of UBLK_CMD_GET_DEV_INFO2 includes
a922b5da71a7776 Ming Lei 2022-11-16  2058  		 * char_dev_path in payload too, since userspace may not
a922b5da71a7776 Ming Lei 2022-11-16  2059  		 * know if the specified device is created as unprivileged
a922b5da71a7776 Ming Lei 2022-11-16  2060  		 * mode.
a922b5da71a7776 Ming Lei 2022-11-16  2061  		 */
a922b5da71a7776 Ming Lei 2022-11-16  2062  		if (cmd->cmd_op != UBLK_CMD_GET_DEV_INFO2)
a922b5da71a7776 Ming Lei 2022-11-16  2063  			return 0;
a922b5da71a7776 Ming Lei 2022-11-16  2064  	}
a922b5da71a7776 Ming Lei 2022-11-16  2065  
a922b5da71a7776 Ming Lei 2022-11-16  2066  	/*
a922b5da71a7776 Ming Lei 2022-11-16  2067  	 * User has to provide the char device path for unprivileged ublk
a922b5da71a7776 Ming Lei 2022-11-16  2068  	 *
a922b5da71a7776 Ming Lei 2022-11-16  2069  	 * header->addr always points to the dev path buffer, and
a922b5da71a7776 Ming Lei 2022-11-16  2070  	 * header->dev_path_len records length of dev path buffer.
a922b5da71a7776 Ming Lei 2022-11-16  2071  	 */
a922b5da71a7776 Ming Lei 2022-11-16  2072  	if (!header->dev_path_len || header->dev_path_len > PATH_MAX)
a922b5da71a7776 Ming Lei 2022-11-16  2073  		return -EINVAL;
a922b5da71a7776 Ming Lei 2022-11-16  2074  
a922b5da71a7776 Ming Lei 2022-11-16  2075  	if (header->len < header->dev_path_len)
a922b5da71a7776 Ming Lei 2022-11-16  2076  		return -EINVAL;
a922b5da71a7776 Ming Lei 2022-11-16  2077  
a922b5da71a7776 Ming Lei 2022-11-16  2078  	dev_path = kmalloc(header->dev_path_len, GFP_KERNEL);
a922b5da71a7776 Ming Lei 2022-11-16  2079  	if (!dev_path)
a922b5da71a7776 Ming Lei 2022-11-16  2080  		return -ENOMEM;
a922b5da71a7776 Ming Lei 2022-11-16  2081  
a922b5da71a7776 Ming Lei 2022-11-16  2082  	ret = -EFAULT;
a922b5da71a7776 Ming Lei 2022-11-16  2083  	if (copy_from_user(dev_path, argp, header->dev_path_len))
a922b5da71a7776 Ming Lei 2022-11-16  2084  		goto exit;
a922b5da71a7776 Ming Lei 2022-11-16  2085  	dev_path[header->dev_path_len] = 0;
a922b5da71a7776 Ming Lei 2022-11-16  2086  
a922b5da71a7776 Ming Lei 2022-11-16  2087  	switch (cmd->cmd_op) {
a922b5da71a7776 Ming Lei 2022-11-16  2088  	case UBLK_CMD_GET_DEV_INFO:
a922b5da71a7776 Ming Lei 2022-11-16  2089  	case UBLK_CMD_GET_DEV_INFO2:
a922b5da71a7776 Ming Lei 2022-11-16  2090  	case UBLK_CMD_GET_QUEUE_AFFINITY:
a922b5da71a7776 Ming Lei 2022-11-16  2091  	case UBLK_CMD_GET_PARAMS:
a922b5da71a7776 Ming Lei 2022-11-16  2092  		mask = MAY_READ;
a922b5da71a7776 Ming Lei 2022-11-16  2093  		break;
a922b5da71a7776 Ming Lei 2022-11-16  2094  	case UBLK_CMD_START_DEV:
a922b5da71a7776 Ming Lei 2022-11-16  2095  	case UBLK_CMD_STOP_DEV:
a922b5da71a7776 Ming Lei 2022-11-16  2096  	case UBLK_CMD_ADD_DEV:
a922b5da71a7776 Ming Lei 2022-11-16  2097  	case UBLK_CMD_DEL_DEV:
a922b5da71a7776 Ming Lei 2022-11-16  2098  	case UBLK_CMD_SET_PARAMS:
a922b5da71a7776 Ming Lei 2022-11-16  2099  	case UBLK_CMD_START_USER_RECOVERY:
a922b5da71a7776 Ming Lei 2022-11-16  2100  	case UBLK_CMD_END_USER_RECOVERY:
a922b5da71a7776 Ming Lei 2022-11-16  2101  		mask = MAY_READ | MAY_WRITE;
a922b5da71a7776 Ming Lei 2022-11-16  2102  		break;
a922b5da71a7776 Ming Lei 2022-11-16  2103  	default:

mask not set on default path.

a922b5da71a7776 Ming Lei 2022-11-16  2104  		break;
a922b5da71a7776 Ming Lei 2022-11-16  2105  	}
a922b5da71a7776 Ming Lei 2022-11-16  2106  
a922b5da71a7776 Ming Lei 2022-11-16 @2107  	ret = ublk_char_dev_permission(ub, dev_path, mask);
a922b5da71a7776 Ming Lei 2022-11-16  2108  	if (!ret) {
a922b5da71a7776 Ming Lei 2022-11-16  2109  		header->len -= header->dev_path_len;
a922b5da71a7776 Ming Lei 2022-11-16  2110  		header->addr += header->dev_path_len;
a922b5da71a7776 Ming Lei 2022-11-16  2111  	}
a922b5da71a7776 Ming Lei 2022-11-16  2112  	pr_devel("%s: dev id %d cmd_op %x uid %d gid %d path %s ret %d\n",
a922b5da71a7776 Ming Lei 2022-11-16  2113  			__func__, ub->ub_number, cmd->cmd_op,
a922b5da71a7776 Ming Lei 2022-11-16  2114  			ub->dev_info.owner_uid, ub->dev_info.owner_gid,
a922b5da71a7776 Ming Lei 2022-11-16  2115  			dev_path, ret);
a922b5da71a7776 Ming Lei 2022-11-16  2116  exit:
a922b5da71a7776 Ming Lei 2022-11-16  2117  	kfree(dev_path);
a922b5da71a7776 Ming Lei 2022-11-16  2118  	return ret;
a922b5da71a7776 Ming Lei 2022-11-16  2119  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

