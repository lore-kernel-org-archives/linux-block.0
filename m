Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F66C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62D720878
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62D720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbeLFRPk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:15:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41532 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeLFRPj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 12:15:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so481592pfi.8;
        Thu, 06 Dec 2018 09:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQw5yAO3lM7TsMyzX9BuSnFZq/9Du+9gl+ALSBML/sM=;
        b=YBrAvulrd3u1AI8MP8cWYd+m6C9TvM8Z9bGZLaGA6PixKu+NtpHTDtgWcNIyhhB7g1
         ce3MU+v0Vi/qOdz38NdfogGXyo4lvWQ7IbOvSdaBZjqaYf2gPEDUVBMGVxQNb3maR0wH
         d+U60wyyK+Dz9fWtukHVTTY0XkWkwsbHrRWWGpf30iefaMd+HawFtd0OVm+PSAYBsSnD
         qjIM7Ou3OyctdGieCEd6VlljMwLfU/iLYeamazFxiq8cD2BMcyZM4Ho7p2a79vMziQ7J
         0pWce8lwKK9MuCQGV+h2YvgSCDWtD6fteQCaRDwLrr8dtb4cps8ujdq7lueoAfPr9NeQ
         AQCQ==
X-Gm-Message-State: AA+aEWbJS85gO2VAVPCJEcJJ3jFjsGA4xPd/ILmR9p0YC84Gp3dStBXn
        NAWK2uTXGIeHAx8x2o3p7QA=
X-Google-Smtp-Source: AFSGD/UQKyo9IZpS6KGNyWTP5/LwyRt5Sm++aIzGaWzX6+TTympuZdN6fIujK9w2afNk+7uID+bgqw==
X-Received: by 2002:a63:5320:: with SMTP id h32mr24869327pgb.414.1544116538928;
        Thu, 06 Dec 2018 09:15:38 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p11sm2095775pgn.60.2018.12.06.09.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 09:15:38 -0800 (PST)
Message-ID: <1544116537.185366.258.camel@acm.org>
Subject: Re: [PATCH 2/9] scsi: introduce a max_segment_size host_template
 parameters
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Date:   Thu, 06 Dec 2018 09:15:37 -0800
In-Reply-To: <20181206155258.11465-3-hch@lst.de>
References: <20181206155258.11465-1-hch@lst.de>
         <20181206155258.11465-3-hch@lst.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 07:52 -0800, Christoph Hellwig wrote:
+AD4 This allows the host driver to indicate the maximum supported
+AD4 segment size in a nice an easy way, so that the driver doesn't
+AD4 have to worry about DMA-layer imposed limitations.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

