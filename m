Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98F3C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D2E217D8
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeLRHrv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:47:51 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:47006 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLRHrv (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Tue, 18 Dec 2018 02:47:51 -0500
Received: from [10.160.4.48] (nat.nue.novell.com [195.135.221.2])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 18 Dec 2018 08:47:49 +0100
Subject: Re: remove the "clustering" flag V2
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20181213151710.30036-1-hch@lst.de> <20181218070826.GA1787@lst.de>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <e781422e-f340-8d2c-ba4e-fd6c7af614ca@suse.com>
Date:   Tue, 18 Dec 2018 08:47:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181218070826.GA1787@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 8:08 AM, Christoph Hellwig wrote:
> Martin and others:
> 
> can we get this reviewed and merge before the end of the merge window?
> That gets the clustering put of the way for the multipage-biovec work
> from Ming which we want to land in the block tree early in the next
> merge window.
> 
Have we reviewed the crash in iscsi target?
It might be something completely different, but the fact still stands 
that the bug is exposed after removing the clustering flag...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
