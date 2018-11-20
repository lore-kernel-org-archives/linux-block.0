Return-Path: <SRS0=hv45=N7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F42EC43610
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 09:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44E820831
	for <linux-block@archiver.kernel.org>; Tue, 20 Nov 2018 09:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mWkcNA7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44E820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbeKTUHT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:07:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTUHT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 15:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/1QD8IHz4s0ToviMsZ6K1bGk6araZkuLZ8xYzy8hZQM=; b=mWkcNA7PkKY598UVGlXbNHh/x
        YJH9PIDOJaf+FcDyvN3s0MSOqVCCRMvPnepG+ik/JBgvh3mmCckwvpvCvcaFGikJcUWdiCChFd/ZX
        U0Z7ueLiTS4o8SUb+b/mXLXDzMcBsirjcA6DzaCh73LbF+7vC3jTZp/6Bs9ltJwEvWMY+++3XHtDh
        UtGAC2UhoJnP8lQyaQNoI4PItIL74NJN+kdhWx0TfVkMUtwtCR0Cxrj1C3nnqYBNlN/ksfprWbAVI
        HrBk315ueWshOLfpArruExwgqPzwkVwO0ChizzMkfM3hsexLurKOc1b3d93Jum7OqCk5QJ9HB0kZB
        U0D0wTZnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP2Ut-0000Ox-QW; Tue, 20 Nov 2018 09:39:07 +0000
Date:   Tue, 20 Nov 2018 01:39:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: RFC: REQ_PRIO use
Message-ID: <20181120093907.GA32682@infradead.org>
References: <BN3PR0401MB1640F33FA8F3FFF251DF8266E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN3PR0401MB1640F33FA8F3FFF251DF8266E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have two places that check the flag, the writeback tracking
code:

block/blk-wbt.c:#define REQ_HIPRIO      (REQ_SYNC | REQ_META | REQ_PRIO)
block/blk-wbt.c:        if ((rw & REQ_HIPRIO) || wb_recent_wait(rwb) || current_is_kswapd())

and bcache:

drivers/md/bcache/request.c:        !(bio->bi_opf & REQ_PRIO))
drivers/md/bcache/request.c:        !(bio->bi_opf & REQ_PRIO) &&

the original idea was that not all I/O is a priority we should not
blindly boost priority for metadata.  Of course wbt actually ignores
and it and we may just give in and just check REQ_META, except for
the fact that f2fs now actually submits REQ_PRIO requests without
REQ_META..
