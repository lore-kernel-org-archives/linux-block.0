Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D326C4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 17:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJTR1d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJTR1V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 13:27:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196461E3EF6
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 10:27:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC2F8B826A0
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 17:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B083C433C1;
        Thu, 20 Oct 2022 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666286818;
        bh=qGrdvZ+avIT5ncewAhAAUh4JMIjmb8C6sPVDy6szDpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDUknAcyhZzWWlNmaFoNsnGGwHNTQdnWqHNSb2lVuXqFPsUCEep4KEPGBi/5vHjTq
         0UG5QuJrJPW2m/NwJNHfCvRxNLGa2RD4l73gdSHN8I6VLsHOgIXznuxhk2h7hwUjXy
         nogHUlJZuPv378o5MzCakmSdhkYF6YxO4PjsUwtxjeFFtU6votIkg+JVyTooNGuzSZ
         eGmpDLyXRVwLxGcD+g0OUXMjI3ixVp0vfgnFKDVuXFvniRajywva+rBAYrQeWP5K+L
         XghmZaKdm8SFTezIsBlrOMFyEVL1SzmJ0KcYx7ETAsSIv1GTGO/UyxQ5wD1+rfDK21
         AVKQd+dJsEuQA==
Date:   Thu, 20 Oct 2022 11:26:55 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] blk-mq: move the srcu_struct used for quiescing to
 the tagset
Message-ID: <Y1GE37ujxcfRn7Tm@kbusch-mbp.dhcp.thefacebook.com>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 20, 2022 at 12:56:03PM +0200, Christoph Hellwig wrote:
> All I/O submissions have fairly similar latencies, and a tagset-wide
> quiesce is a fairly common operation.  Becuase there are a lot less

s/Becuase/Because

> @@ -501,6 +502,8 @@ enum hctx_type {
>   * @tag_list_lock: Serializes tag_list accesses.
>   * @tag_list:	   List of the request queues that use this tag set. See also
>   *		   request_queue.tag_set_list.
> + * @srcu:	   Use as lock when type of the request queue is blocking
> + *		   (BLK_MQ_F_BLOCKING). Must be the last member

Since you're not dealing with flexible arrays anymore, I don't think
srcu strictly needs to be the last member.

The code looks great, though!

Reviewed-by: Keith Busch <kbusch@kernel.org>

>   */
>  struct blk_mq_tag_set {
>  	struct blk_mq_queue_map	map[HCTX_MAX_TYPES];
> @@ -521,6 +524,7 @@ struct blk_mq_tag_set {
>  
>  	struct mutex		tag_list_lock;
>  	struct list_head	tag_list;
> +	struct srcu_struct	srcu;
>  };
