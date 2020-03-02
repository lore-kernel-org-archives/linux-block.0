Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B21CC3F2D7
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 22:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E949A24677
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 22:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583186803;
	bh=DBWsXqGHLqbWM19myRI8pkA7NilUBhZVQTVIxy54ZFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lPPBKTwrLZ7jHyA3VD4EAQ0SExKBIZd4LgNe/ANYUCTQVMB/3JfLzaxqpx8VX3lX9
	 FmqI68JCTwRXshkyozsRzU567TVk17qQgEuChy4fl3NE9P91q4BcWUYHPpaW14uR6D
	 iMUo4vVv28jZQTK/43nog/IEOa0V5ZyTC0265Ktc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCBWGm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:06:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCBWGm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Mar 2020 17:06:42 -0500
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D3EA214DB;
        Mon,  2 Mar 2020 22:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583186801;
        bh=DBWsXqGHLqbWM19myRI8pkA7NilUBhZVQTVIxy54ZFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9FT8ZgoSRNU3Kf+Bd2/2T2H+ilAzfmGVaV+PWl0Rul9qndkjLKwFmXdOy9Tzbn4Y
         gPEPd9hNsmjbE7jiU36goDIBELBg75KAM5aipI2dhxlI3W5MiC281yQu1nCgZ3PYuV
         CbEnPoaWK/cITbXIV9yvUimH0zClTxvftYD1CPj0=
Date:   Mon, 2 Mar 2020 14:06:39 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "tristmd@gmail.com" <tristmd@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] blktrace: Protect q->blk_trace with RCU
Message-ID: <20200302220639.GA2393@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200302204057.GA128531@google.com>
 <BYAPR04MB574957E5116240523362B1DC86E70@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB574957E5116240523362B1DC86E70@BYAPR04MB5749.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 02, 2020 at 09:19:33PM +0000, Chaitanya Kulkarni wrote:
> By any chance will the following patch be able to get rid of
> the warning ?
> 
> index 4560878f0bac..889555910555 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1895,9 +1895,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct 
> device *dev,
>                  goto out_unlock_bdev;
>          }
> 
> -       ret = 0;
> -       if (bt == NULL)
> -               ret = blk_trace_setup_queue(q, bdev);
> +       ret = bt == NULL ? blk_trace_setup_queue(q, bdev) : 0;
> 
>          if (ret == 0) {
>                  if (attr == &dev_attr_act_mask)

That looks the same thing as what created the warning, just more
compact.

I think the right thing to do is update bt to the one allocated from a
successful blk_trace_setup_queue().
