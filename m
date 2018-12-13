Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B22C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635D520870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DNQd5yHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635D520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeLMPRU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:17:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeLMPRT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OfLdo0E6k69NLTwU/uGWBuCyBVebV+7smuEzI3kiQNs=; b=DNQd5yHZZHE3D3a/onHAiJTsf
        1yQozbjgyeAJCj4LLbxE0lJG0iFqBs8O1c4Yv+QOVmy+7Oe+9gNAq0j6Y50zXj58tjPMA8Ga45ElM
        3dPAOzIwry50FomlOyP6PWUMcWctSt1mpkiSKP7HAaszRzaa0G4mhuWnRBRarYNICKqi5uKBMR13o
        m8Eiup1dEXUw7bcxnAmasw8cNPH/xU89lmvjQai+nbsWDYiZDPdwpkcGjNcJoG27Tbky+oGnluzCP
        V/ukoKmhq4n9T8AWZeC7G0rMFRNb8G9YFR/vG12WkVizf7v+u+OmJ9eXTP7t781zvdR3ZVZf64K8l
        v8ayWI4xg==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXSjg-0001CR-Tn; Thu, 13 Dec 2018 15:17:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: remove the "clustering" flag V2
Date:   Thu, 13 Dec 2018 16:17:00 +0100
Message-Id: <20181213151710.30036-1-hch@lst.de>
X-Mailer: git-send-email 2.19.2
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

Changes since V1:
 - split a patch into two
 - collected a few acks
 - fixed a changelog typo
 - only set the segment boundary, the max segment size is redundant
 - don't set dma_boundary twice in two drivers
