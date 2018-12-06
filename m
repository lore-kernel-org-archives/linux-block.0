Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E7C64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FC320661
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FC320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeLFRGC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:06:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46622 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeLFRGC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 12:06:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so454824pfe.13;
        Thu, 06 Dec 2018 09:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5t+hZ+7j8D9rTXRyWIsVDBOUco0HOFTAUdSzM7YJLus=;
        b=t14HuKjo4zL5OjvInmAud4qTSEH2cknVwzlY6EE2gtIemjmpx70zoQhdBF/VwaHmzL
         9KSgsY0rkYo1YWnJEqi3hasWI+FeIBJ2zubIU8vz642sGdlcURyJk0llF+NzRYgmEUjf
         7XWRPMiZZuHVGdqQHK14GPFaEcnDcSkjl1SS7IFeUD4Geg4lL2tfdN4n56BD81ZeMCkf
         a8P0CCiwKhjCdl6Lm/B1glX51EkAkB9XNCFpsiwFY3S8QX2633TQgr2opCSM2mOXS/xH
         UwqVpZJGnu9yy5mbfIHBcmJ5mu22hXZVZcBaClVcd8iB+aR6p0nWJqr7OOw9rLJEmQm3
         pNIA==
X-Gm-Message-State: AA+aEWbfWmO1T+Cm22htdTZ+FaXVNBdH0UmpZMvmkflZ95ER9qm3qOsg
        YVGk7csmcCys375OU2kukLU=
X-Google-Smtp-Source: AFSGD/Vs6zLCckghYCfZ+/vSt9FlWnypvCijt8i8rpt+JG4xY7/+k3uFXHLnSk7sLWUBMWC8QFtwwQ==
X-Received: by 2002:a63:f412:: with SMTP id g18mr25091868pgi.262.1544115961547;
        Thu, 06 Dec 2018 09:06:01 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b185sm1764415pga.85.2018.12.06.09.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 09:06:00 -0800 (PST)
Message-ID: <1544115958.185366.253.camel@acm.org>
Subject: Re: [PATCH 1/9] scsi: flip the default on use_clustering
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Date:   Thu, 06 Dec 2018 09:05:58 -0800
In-Reply-To: <20181206155258.11465-2-hch@lst.de>
References: <20181206155258.11465-1-hch@lst.de>
         <20181206155258.11465-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 07:52 -0800, Christoph Hellwig wrote:
+AD4 Most SCSI drivers want to enable +ACI-clustering+ACI, that is merging of
+AD4 segments so that they might span more than a single page.  Remove the
+AD4 ENABLE+AF8-CLUSTERING define, and require drivers to explicitly set
+AD4 DISABLE+AF8-CLUSTERING to disable this feature.  All drivers not setting
+AD4 use+AF8-clustering at all are switched to set DISABLE+AF8-CLUSTERING to keep
+AD4 the current behavior.

Was this patch produced manually or has it been generated with the help
of a script? In the latter case it would help if that script would be
included in the patch description.

Additionally, this patch would be much easier to review if it would be
split into two patches, one that adds .use+AF8-clustering +AD0 DISABLE+AF8-CLUSTERING
from SCSI templates that implicitly disable clustering and a second patch
that removes .use+AF8-clustering +AD0 ENABLE+AF8-CLUSTERING from all SCSI drivers.

Thanks,

Bart.
