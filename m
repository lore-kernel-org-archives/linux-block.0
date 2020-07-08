Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFACDC433DF
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 13:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E43207C4
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 13:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgGHNXc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:23:32 -0400
Received: from verein.lst.de ([213.95.11.211]:35346 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgGHNXb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Jul 2020 09:23:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B2F6D68AFE; Wed,  8 Jul 2020 15:23:28 +0200 (CEST)
Date:   Wed, 8 Jul 2020 15:23:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] md: switch to ->check_events for media change
 notifications
Message-ID: <20200708132328.GA21223@lst.de>
References: <20200708122546.214579-1-hch@lst.de> <20200708122546.214579-2-hch@lst.de> <09cd4827-52ae-0e7c-c3d3-e9a6cd27ff2b@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09cd4827-52ae-0e7c-c3d3-e9a6cd27ff2b@cloud.ionos.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 08, 2020 at 03:17:31PM +0200, Guoqing Jiang wrote:
> On 7/8/20 2:25 PM, Christoph Hellwig wrote:
>> -static int md_media_changed(struct gendisk *disk)
>> -{
>> -	struct mddev *mddev = disk->private_data;
>> -
>> -	return mddev->changed;
>> -}
>
> Maybe we can remove "changed" from struct mddev since no one reads it
> after the change.

The new md_check_events method reads it.
