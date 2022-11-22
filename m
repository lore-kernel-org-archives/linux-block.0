Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0174C433FE
	for <linux-block@archiver.kernel.org>; Tue, 22 Nov 2022 07:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiKVHsn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Nov 2022 02:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiKVHsl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2022 02:48:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA946464
        for <linux-block@vger.kernel.org>; Mon, 21 Nov 2022 23:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669103257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=afWoGFQqxG9wItxAr5svnboai4LOotEAg1GisWr4JKM=;
        b=aaTL1NQoeEEn6OVqVDlKqLJrJUgcLrvDgJVYNqZCkJsVZQxOAOC2g6Dcj5A9q7mp1VqXNm
        NNftE/D/YcuyDHzQXmGOE+GnT4+JTqrzmfzsZ3v1nhtTa4Gddzyj0EZFVITXuI5R4b0c/A
        /vMNaFxeZwHxJFhRaB5Svy4u8OH2bKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-m1jzLcFmOl2IXmj8479g9A-1; Tue, 22 Nov 2022 02:47:33 -0500
X-MC-Unique: m1jzLcFmOl2IXmj8479g9A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39B3185A59D;
        Tue, 22 Nov 2022 07:47:33 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E3334B400F;
        Tue, 22 Nov 2022 07:47:25 +0000 (UTC)
Date:   Tue, 22 Nov 2022 15:47:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 6/6] ublk_drv: add mechanism for supporting unprivileged
 ublk device
Message-ID: <Y3x+hmn+eU68QO0E@T590>
References: <20221116060835.159945-7-ming.lei@redhat.com>
 <202211220917.c5VXrB5O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211220917.c5VXrB5O-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 22, 2022 at 10:17:47AM +0300, Dan Carpenter wrote:
> Hi Ming,
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/ublk_drv-add-mechanism-for-supporting-unprivileged-ublk-device/20221116-141131
> patch link:    https://lore.kernel.org/r/20221116060835.159945-7-ming.lei%40redhat.com
> patch subject: [PATCH 6/6] ublk_drv: add mechanism for supporting unprivileged ublk device
> config: x86_64-randconfig-m001-20221121
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> 
> smatch warnings:
> drivers/block/ublk_drv.c:2107 ublk_ctrl_uring_cmd_permission() error: uninitialized symbol 'mask'.
> 
> vim +/mask +2107 drivers/block/ublk_drv.c
> 
> a922b5da71a7776 Ming Lei 2022-11-16  2043  static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
> a922b5da71a7776 Ming Lei 2022-11-16  2044  		struct io_uring_cmd *cmd)
> a922b5da71a7776 Ming Lei 2022-11-16  2045  {
> a922b5da71a7776 Ming Lei 2022-11-16  2046  	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
> a922b5da71a7776 Ming Lei 2022-11-16  2047  	bool unprivileged = ub->dev_info.flags & UBLK_F_UNPRIVILEGED_DEV;
> a922b5da71a7776 Ming Lei 2022-11-16  2048  	void __user *argp = (void __user *)(unsigned long)header->addr;
> a922b5da71a7776 Ming Lei 2022-11-16  2049  	char *dev_path = NULL;
> a922b5da71a7776 Ming Lei 2022-11-16  2050  	int ret = 0;
> a922b5da71a7776 Ming Lei 2022-11-16  2051  	int mask;
> a922b5da71a7776 Ming Lei 2022-11-16  2052  
> a922b5da71a7776 Ming Lei 2022-11-16  2053  	if (!unprivileged) {
> a922b5da71a7776 Ming Lei 2022-11-16  2054  		if (!capable(CAP_SYS_ADMIN))
> a922b5da71a7776 Ming Lei 2022-11-16  2055  			return -EPERM;
> a922b5da71a7776 Ming Lei 2022-11-16  2056  		/*
> a922b5da71a7776 Ming Lei 2022-11-16  2057  		 * The new added command of UBLK_CMD_GET_DEV_INFO2 includes
> a922b5da71a7776 Ming Lei 2022-11-16  2058  		 * char_dev_path in payload too, since userspace may not
> a922b5da71a7776 Ming Lei 2022-11-16  2059  		 * know if the specified device is created as unprivileged
> a922b5da71a7776 Ming Lei 2022-11-16  2060  		 * mode.
> a922b5da71a7776 Ming Lei 2022-11-16  2061  		 */
> a922b5da71a7776 Ming Lei 2022-11-16  2062  		if (cmd->cmd_op != UBLK_CMD_GET_DEV_INFO2)
> a922b5da71a7776 Ming Lei 2022-11-16  2063  			return 0;
> a922b5da71a7776 Ming Lei 2022-11-16  2064  	}
> a922b5da71a7776 Ming Lei 2022-11-16  2065  
> a922b5da71a7776 Ming Lei 2022-11-16  2066  	/*
> a922b5da71a7776 Ming Lei 2022-11-16  2067  	 * User has to provide the char device path for unprivileged ublk
> a922b5da71a7776 Ming Lei 2022-11-16  2068  	 *
> a922b5da71a7776 Ming Lei 2022-11-16  2069  	 * header->addr always points to the dev path buffer, and
> a922b5da71a7776 Ming Lei 2022-11-16  2070  	 * header->dev_path_len records length of dev path buffer.
> a922b5da71a7776 Ming Lei 2022-11-16  2071  	 */
> a922b5da71a7776 Ming Lei 2022-11-16  2072  	if (!header->dev_path_len || header->dev_path_len > PATH_MAX)
> a922b5da71a7776 Ming Lei 2022-11-16  2073  		return -EINVAL;
> a922b5da71a7776 Ming Lei 2022-11-16  2074  
> a922b5da71a7776 Ming Lei 2022-11-16  2075  	if (header->len < header->dev_path_len)
> a922b5da71a7776 Ming Lei 2022-11-16  2076  		return -EINVAL;
> a922b5da71a7776 Ming Lei 2022-11-16  2077  
> a922b5da71a7776 Ming Lei 2022-11-16  2078  	dev_path = kmalloc(header->dev_path_len, GFP_KERNEL);
> a922b5da71a7776 Ming Lei 2022-11-16  2079  	if (!dev_path)
> a922b5da71a7776 Ming Lei 2022-11-16  2080  		return -ENOMEM;
> a922b5da71a7776 Ming Lei 2022-11-16  2081  
> a922b5da71a7776 Ming Lei 2022-11-16  2082  	ret = -EFAULT;
> a922b5da71a7776 Ming Lei 2022-11-16  2083  	if (copy_from_user(dev_path, argp, header->dev_path_len))
> a922b5da71a7776 Ming Lei 2022-11-16  2084  		goto exit;
> a922b5da71a7776 Ming Lei 2022-11-16  2085  	dev_path[header->dev_path_len] = 0;
> a922b5da71a7776 Ming Lei 2022-11-16  2086  
> a922b5da71a7776 Ming Lei 2022-11-16  2087  	switch (cmd->cmd_op) {
> a922b5da71a7776 Ming Lei 2022-11-16  2088  	case UBLK_CMD_GET_DEV_INFO:
> a922b5da71a7776 Ming Lei 2022-11-16  2089  	case UBLK_CMD_GET_DEV_INFO2:
> a922b5da71a7776 Ming Lei 2022-11-16  2090  	case UBLK_CMD_GET_QUEUE_AFFINITY:
> a922b5da71a7776 Ming Lei 2022-11-16  2091  	case UBLK_CMD_GET_PARAMS:
> a922b5da71a7776 Ming Lei 2022-11-16  2092  		mask = MAY_READ;
> a922b5da71a7776 Ming Lei 2022-11-16  2093  		break;
> a922b5da71a7776 Ming Lei 2022-11-16  2094  	case UBLK_CMD_START_DEV:
> a922b5da71a7776 Ming Lei 2022-11-16  2095  	case UBLK_CMD_STOP_DEV:
> a922b5da71a7776 Ming Lei 2022-11-16  2096  	case UBLK_CMD_ADD_DEV:
> a922b5da71a7776 Ming Lei 2022-11-16  2097  	case UBLK_CMD_DEL_DEV:
> a922b5da71a7776 Ming Lei 2022-11-16  2098  	case UBLK_CMD_SET_PARAMS:
> a922b5da71a7776 Ming Lei 2022-11-16  2099  	case UBLK_CMD_START_USER_RECOVERY:
> a922b5da71a7776 Ming Lei 2022-11-16  2100  	case UBLK_CMD_END_USER_RECOVERY:
> a922b5da71a7776 Ming Lei 2022-11-16  2101  		mask = MAY_READ | MAY_WRITE;
> a922b5da71a7776 Ming Lei 2022-11-16  2102  		break;
> a922b5da71a7776 Ming Lei 2022-11-16  2103  	default:
> 
> mask not set on default path.

Good catch, and it is really one bug, will fix it in V2.


Thanks,
Ming

