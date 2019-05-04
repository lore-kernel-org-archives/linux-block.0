Return-Path: <SRS0=jajD=TE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954A6C43219
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 12:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699E120644
	for <linux-block@archiver.kernel.org>; Sat,  4 May 2019 12:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfEDMfM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 May 2019 08:35:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfEDMfM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 4 May 2019 08:35:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B44DAAD0;
        Sat,  4 May 2019 12:35:11 +0000 (UTC)
Date:   Sat, 4 May 2019 14:35:09 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/8] iomap: use bio_release_pages in iomap_dio_bio_end_io
Message-ID: <20190504123509.GD5329@x250>
References: <20190502233332.28720-1-hch@lst.de>
 <20190502233332.28720-5-hch@lst.de>
 <20190504123309.GC5329@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190504123309.GC5329@x250>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 04, 2019 at 02:33:09PM +0200, Johannes Thumshirn wrote:
> 
> Shouldn't this rather be:
> 
> 		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) 
> 			bio_release_pages(bio);

OK I apparently can't remember between 3 emails, sorry


Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
