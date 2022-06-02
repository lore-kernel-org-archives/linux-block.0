Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0B2C43334
	for <linux-block@archiver.kernel.org>; Thu,  2 Jun 2022 12:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiFBMMe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiFBMMe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 08:12:34 -0400
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E373628D68D
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 05:12:31 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd7616.dip0.t-ipconnect.de [93.221.118.22])
        by mail.itouring.de (Postfix) with ESMTPSA id 5C7F9125BCF;
        Thu,  2 Jun 2022 14:12:30 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 0A1F5F01600;
        Thu,  2 Jun 2022 14:12:30 +0200 (CEST)
Subject: Re: Q: fsync on a blockdev fd worked in 5.15, but no longer does.
 Should it?
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block <linux-block@vger.kernel.org>
References: <cca51ad8-052c-769d-62cc-99a3e3efe4f0@applied-asynchrony.com>
 <YphR19tJNqFuB/xh@infradead.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <f4f29cf8-eb99-0276-caaa-d6af5083925a@applied-asynchrony.com>
Date:   Thu, 2 Jun 2022 14:12:29 +0200
MIME-Version: 1.0
In-Reply-To: <YphR19tJNqFuB/xh@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022-06-02 07:59, Christoph Hellwig wrote:
> On Wed, Jun 01, 2022 at 10:19:40PM +0200, Holger Hoffstätte wrote:
>> Obviously if anybody (Jens, Christoph..?) has an idea what changed this
>> behaviour and thinks it's a bug I'm more than happy to test a fix,
>> however for now I'd be happy to understand what's going on.
> 
> I just tested fsync on SCSI disk and NVMe SSDs and they make it down
> perfectly fine to the driver and device as Synchronize Cache / Flush
> commands, including the block device node for a partition.
> 
> Everything else would be really horrible for data integrity anyway..

Thanks for confirming. Unfortunately that still doesn't explain
why dirty buffers now keep accumulating, but whatever.
In the meantime I found a much less intrusive solution (hd-idle) that
just monitors /proc/diskstats for selected devices instead of trying
to replace periodic writeback wholesale.

cheers
Holger
