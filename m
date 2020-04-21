Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CABC54FD0
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 10:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CD620672
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 10:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDUKxn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:53:43 -0400
Received: from verein.lst.de ([213.95.11.211]:45971 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgDUKxn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 06:53:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90E8668C7B; Tue, 21 Apr 2020 12:53:39 +0200 (CEST)
Date:   Tue, 21 Apr 2020 12:53:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: stop using ioctl_by_bdev in the s390 DASD driver
Message-ID: <20200421105339.GA23380@lst.de>
References: <20200421061226.33731-1-hch@lst.de> <b7e4a728-1f58-f304-cb5b-1aa2206a6bb4@de.ibm.com> <20200421123256.2f5d9dbd.cohuck@redhat.com> <427b0095-6a38-5632-8e46-422c7a4a552a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427b0095-6a38-5632-8e46-422c7a4a552a@de.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 21, 2020 at 12:43:03PM +0200, Christian Borntraeger wrote:
> So 3 MB seems quite a lot for special purpose Linuxes like the zfcp dumper. 

Does the zfcp dumper need DASD support at all?  We don't have to always
build in the DASD core to avoid the strange dasd-specific block_device
operation, but only ensure it is built-in if it is selected at all.
