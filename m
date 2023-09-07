Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A726EC874D
	for <linux-block@archiver.kernel.org>; Thu,  7 Sep 2023 18:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbjIGSjO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Sep 2023 14:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbjIGSjM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Sep 2023 14:39:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC7191;
        Thu,  7 Sep 2023 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X5fOGT6hnTJK573IuD04yd9SOfXqDxni4NBVfuWn3og=; b=URkMsGtMOgbMrLCeg5aGtFhgaQ
        HoJkeJMg/8gWZue+hLZeLEtaMqzN9ocM80wUv+Y0ygL/F3J/vu29d2mRkALYnqJutDlg2MX3bbUo5
        dah4NrZBIViKX+Ly/N55bo9koRN5Qnx8ehIEFqRJjUAVEf8yOru+8NI3VxszKjSbn8LuDopj1WhpQ
        JS9Iysm/xk2a38vON3CSp5AflVVHdANw7Jn699kvHEuDyhGQXs99dVzDLYMf59syhFVftJM2Pjiug
        IZisVZF66njVhUspIIQmR5U3NT48aNO2M93xMjvRLG3+hD8tDRiExDnSQ90Gk1VTAXElPavBsgUYs
        qA/KobBw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qeJtv-00CZ21-28;
        Thu, 07 Sep 2023 18:38:47 +0000
Date:   Thu, 7 Sep 2023 11:38:47 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, gost.dev@samsung.com,
        Hannes Reinecke <hare@suse.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Message-ID: <ZPoYtx2CfmYaG3UO@bombadil.infradead.org>
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164253epcas5p32862e8384bdd566881d2c155757cb056@epcas5p3.samsung.com>
 <20230906163844.18754-2-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906163844.18754-2-nj.shetty@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 06, 2023 at 10:08:26PM +0530, Nitesh Shetty wrote:
> Add device limits as sysfs entries,
> 	- copy_max_bytes (RW)
> 	- copy_max_hw_bytes (RO)
> 
> Above limits help to split the copy payload in block layer.
> copy_max_bytes: maximum total length of copy in single payload.
> copy_max_hw_bytes: Reflects the device supported maximum limit.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
