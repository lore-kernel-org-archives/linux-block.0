Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE849C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 12:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EE864D73
	for <linux-block@archiver.kernel.org>; Tue, 16 Feb 2021 12:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBPMij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:38:39 -0500
Received: from verein.lst.de ([213.95.11.211]:41094 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhBPMii (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Feb 2021 07:38:38 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3C50467373; Tue, 16 Feb 2021 13:37:56 +0100 (CET)
Date:   Tue, 16 Feb 2021 13:37:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tom Seewald <tseewald@gmail.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk
Subject: Re: [Regression] [Bisected] Errors when ejecting USB storage
 drives since v5.10
Message-ID: <20210216123755.GA4608@lst.de>
References: <CAARYdbiUBxFTY25VusuxgxqVzNRnoB61fFQeXcmsKyDP_d_ipQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAARYdbiUBxFTY25VusuxgxqVzNRnoB61fFQeXcmsKyDP_d_ipQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

... but you were using sd, not sr.

Can you give this patch a spin?

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a3d2d4bc4a3dcd..6671b4e1909777 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2116,6 +2116,14 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 			}
 		}
 		break;
+	case NOT_READY:
+		/* Medium not present */
+		if (SCpnt->device->removable && sshdr.asc == 0x3a00) {
+			req->rq_flags |= RQF_QUIET;
+			set_media_not_present(sdkp);
+			sdkp->capacity = 0;
+		}
+		break;
 	default:
 		break;
 	}
