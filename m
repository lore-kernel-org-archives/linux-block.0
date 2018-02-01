Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:48922 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbeBADXN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jan 2018 22:23:13 -0500
From: tang.junhui@zte.com.cn
To: mlyle@lyle.org
Cc: colyli@suse.de, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, tang.junhui@zte.com.cn
Subject: Re: [PATCH 2/2] bcache: fix high CPU occupancy during journal
Date: Thu, 1 Feb 2018 11:25:35 +0800
Message-Id: <1517455535-17027-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>


> Unfortunately, this doesn't build because of nonexistent call heap_empty
> (I assume some changes to util.h got left out).  I really need clean
> patches that build and are formatted properly.
> 
> Mike
Oh, I am so sorry for that. A new version patch on road.
I will be more careful for later patches.

Thanks.
Tang Junhui
