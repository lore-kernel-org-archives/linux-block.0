Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3526CC10F14
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 11:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1140520870
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 11:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfDHLNt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:13:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:56130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfDHLNr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 07:13:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A2A0EAE80;
        Mon,  8 Apr 2019 11:13:46 +0000 (UTC)
Date:   Mon, 8 Apr 2019 13:13:43 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/5] block: don't allow multiple bio_iov_iter_get_pages
 calls per bio
Message-ID: <20190408111343.GB17922@linux-x5ow.site>
References: <20190408104641.4905-1-hch@lst.de>
 <20190408104641.4905-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408104641.4905-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
