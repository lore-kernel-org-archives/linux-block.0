Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856AAC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D8D217D8
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 07:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeLRHI2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:08:28 -0500
Received: from verein.lst.de ([213.95.11.211]:38887 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeLRHI2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 02:08:28 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E88D568D8D; Tue, 18 Dec 2018 08:08:26 +0100 (CET)
Date:   Tue, 18 Dec 2018 08:08:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: remove the "clustering" flag V2
Message-ID: <20181218070826.GA1787@lst.de>
References: <20181213151710.30036-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213151710.30036-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Martin and others:

can we get this reviewed and merge before the end of the merge window?
That gets the clustering put of the way for the multipage-biovec work
from Ming which we want to land in the block tree early in the next
merge window.
