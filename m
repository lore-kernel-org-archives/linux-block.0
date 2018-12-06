Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7D6C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A510F2154B
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 15:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pz8dg/+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A510F2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbeLFPxE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:53:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLFPxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 10:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9cidGPi1ugJ4aC5mhSUmo3pM0bY/PuHfOxubcqbhSlk=; b=Pz8dg/+13l59hAXDLDONk8mnb
        nuO2xBZTukE0bb5oSknlsZLiHWq+4j83HZwzIUfjF1Hb0n3VXbMdKuFueosXSmfhaNtJ1qNgpIRhU
        hYKHHQNZenLLdd9n/qpM9tvIHZDlqBDBLsezb5Hs4mTkzSX1a1DJf4dsNDxDrhQyF1J6icIP67Cxd
        971KxN3/ISPHXoZg4r3ojIhySktqZIrklI+mEIvi1c6y2J7p/IUmLFyGmDACVaiKOMwU1RonL8ox/
        HH84biL9DzELjT+NjCusNd8Kjo4Gd23llsT0iBzo5ei4tM28PjW5B5AE5mJe1Y6pdFyUHDOFGu3MW
        sDF2HhtAg==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUvxS-0008KC-RO; Thu, 06 Dec 2018 15:52:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: remove the "clustering" flag
Date:   Thu,  6 Dec 2018 07:52:49 -0800
Message-Id: <20181206155258.11465-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer has been carrying around a magic clustering flag,
which is an artefact of prehistoric scsi layer design decisions.

Originally it controller if any segment merging happens at all for a
given LLLD, but with merging moving to the block layer and massively
more complex now it now essentically means that no segment shall be
larger than a page, and no segment shall cross a page boundary if
clustering is not enabled.  Unfortunately the SCSI layer historically
defaults to disabled clustering, but fortunately most drivers actually
enable it, and very few drivers do not set an explicit flag.

So this series first flips the default to be sensible, and then replaces
the magic flag with setting an explicit dma boundary and max segment
size to reuse the existing mechanisms.  It also fixes up a few drivers
where the no clustering setting was clearly bogus, although we can
probably lift these limits for others as well eventually.
