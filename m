Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43689FA373D
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 10:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiKAKtd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKAKtc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 06:49:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB5025C
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 03:49:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 041D868AA6; Tue,  1 Nov 2022 11:49:27 +0100 (CET)
Date:   Tue, 1 Nov 2022 11:49:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 7/7] block: store the holder kobject in bd_holder_disk
Message-ID: <20221101104927.GA13823@lst.de>
References: <20221030153120.1045101-1-hch@lst.de> <20221030153120.1045101-8-hch@lst.de> <fd409996-e5e1-d7af-b31d-87db943eaa25@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd409996-e5e1-d7af-b31d-87db943eaa25@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 31, 2022 at 09:52:04AM +0800, Yu Kuai wrote:
>>     	INIT_LIST_HEAD(&holder->list);
>> -	holder->bdev = bdev;
>>   	holder->refcnt = 1;
>> +	holder->holder_dir = kobject_get(bdev->bd_holder_dir);
>
> I wonder is this safe here, if kobject reference is 0 here and
> bd_holder_dir is about to be freed. Here in kobject_get, kref_get() will
> warn about uaf, and kobject_get will return a address that is about to
> be freed.

But how could the reference be 0 here?  The driver that calls
bd_link_disk_holder must have the block device open and thus hold a
reference to it.
