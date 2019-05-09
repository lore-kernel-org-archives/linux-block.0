Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C73FC04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A172173C
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 12:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfEIMdO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 08:33:14 -0400
Received: from verein.lst.de ([213.95.11.211]:45572 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfEIMdO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 May 2019 08:33:14 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6271A68AFE; Thu,  9 May 2019 14:32:55 +0200 (CEST)
Date:   Thu, 9 May 2019 14:32:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/dasd: fix build warning in dasd_eckd_build_cp_raw
Message-ID: <20190509123255.GA21483@lst.de>
References: <20190509100314.19152-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509100314.19152-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
