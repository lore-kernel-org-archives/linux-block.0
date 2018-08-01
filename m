Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387517AbeHAJZm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Aug 2018 05:25:42 -0400
Date: Wed, 1 Aug 2018 09:41:20 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: zhong jiang <zhongjiang@huawei.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/bsg-lib: use PTR_ERR_OR_ZERO to simplify the flow
 path
Message-ID: <20180801074120.ydxvlw5wrjn7suvf@linux-x5ow.site>
References: <1533053594-35244-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1533053594-35244-1-git-send-email-zhongjiang@huawei.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
