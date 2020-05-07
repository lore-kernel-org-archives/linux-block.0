Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DC7C38A2A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D638A2084D
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 15:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgEGPp6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 11:45:58 -0400
Received: from verein.lst.de ([213.95.11.211]:47463 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgEGPp5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 May 2020 11:45:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F2D2D68B05; Thu,  7 May 2020 17:45:54 +0200 (CEST)
Date:   Thu, 7 May 2020 17:45:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: remove ioctl_by_bdev from DASD driver
Message-ID: <20200507154554.GA32006@lst.de>
References: <20200430111754.98508-2-sth@linux.ibm.com> <20200430131351.GA24813@lst.de> <4ab11558-9f2b-02ee-d191-c9a5cc38de0f@linux.ibm.com> <70f541fe-a678-8952-0753-32707d21e337@linux.ibm.com> <20200505124423.GA26313@lst.de> <a6c99eba-44f2-2944-a135-50ed75ef2c55@linux.ibm.com> <20200506045258.GB9846@lst.de> <10918cd1-a4a9-7872-9672-efcd28ef0751@linux.ibm.com> <20200507152906.GA31257@lst.de> <35ee027b-7892-23ab-c31d-7c17750da8f4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ee027b-7892-23ab-c31d-7c17750da8f4@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 05:43:40PM +0200, Stefan Haberland wrote:
> Not checked till now. I just was thinking about the basicapproach.
> 
> I could either check the block_device_operations like you suggested
> or I could verify that the gendisk pointer is already in our devmap
> and therefor belongs to the DASD driver.

The ops pointer check is simpler and cheaper, so I'd suggest that.
