Return-Path: <SRS0=IEWf=S7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CB9C43219
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 18:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833D32075E
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 18:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfD2SPz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:15:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39195 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2SPz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 14:15:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so1837754pfg.6;
        Mon, 29 Apr 2019 11:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZatGSz4jaw/m7hRRUKD4J48cBonQID4o101Fc0RoXys=;
        b=kk/qDA1nMiq0Fq6TiUnrOMXDswaKX2QJKuzVLQluzF73QuMuNyhAUrj0tJeDQxrOFJ
         WHreils1stUEzxUfF3WkEDRM8gFj9vRk0N5Ow2R2jtBKGmKELGTn+cZPD0U4qFT3sej0
         PvMOtHM5pD8zXX5xSFqRO37uEUoOikAbooBHaMw44edr4v6GQh782njiMhaF2EST9NA7
         LmpWg9Km4hMm26dt/f/vAguIih1MJynhfq9iwkCbJb4dMCjtdu2FtFM0IxZZoQIQHA2t
         NYTuHIWa6Lx/KrXWU/qIqYyQk7HRCvqzzzrLDikdFoHHla5UcnLwBCLsH+AI/sEjM+/p
         QbYQ==
X-Gm-Message-State: APjAAAXibKXhCZFGgRl/K0XDKJJM0U1WkKR8YDDn6g7JfUdtTUgjJLB2
        tSi5V7+86G7WmsfUUvDftGs=
X-Google-Smtp-Source: APXvYqxRNiiqFpYhLjRrSWa+LJF6eHhDX5LviWvrLlcXgF0zCrtBZDtpO0F+dQY+AI8J2aTb7RzkUw==
X-Received: by 2002:a63:f503:: with SMTP id w3mr57082522pgh.60.1556561754855;
        Mon, 29 Apr 2019 11:15:54 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id e62sm1187145pfa.50.2019.04.29.11.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 11:15:54 -0700 (PDT)
Message-ID: <1556561752.161891.165.camel@acm.org>
Subject: Re: [PATCH V4 2/3] scsi: core: avoid to pre-allocate big chunk for
 protection meta data
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Date:   Mon, 29 Apr 2019 11:15:52 -0700
In-Reply-To: <20190428073932.9898-3-ming.lei@redhat.com>
References: <20190428073932.9898-1-ming.lei@redhat.com>
         <20190428073932.9898-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2019-04-28 at 15:39 +-0800, Ming Lei wrote:
+AD4 Now scsi+AF8-mq+AF8-setup+AF8-tags() pre-allocates a big buffer for protection
+AD4 sg entries, and the buffer size is scsi+AF8-mq+AF8-sgl+AF8-size().
+AD4 
+AD4 This way isn't correct, scsi+AF8-mq+AF8-sgl+AF8-size() is used to pre-allocate
+AD4 sg entries for IO data. And the protection data buffer is much less,
+AD4 for example, one 512byte sector needs 8byte protection data, and
+AD4 the max sector number for one request is 2560(BLK+AF8-DEF+AF8-MAX+AF8-SECTORS),
+AD4 so the max protection data size is just 20k.
+AD4 
+AD4 The usual case is that one bio builds one single bip segment. Attribute
+AD4 to bio split, bio merge is seldom done for big IO, and it is only done
+AD4 in case of small bios. And protection data segment number is usually
+AD4 same with bio count in the request, so the number won't be very big,
+AD4 and allocating from slab is fast enough.
+AD4 
+AD4 Reduce to pre-allocate one sg entry for protection data, and switch
+AD4 to runtime allocation in case that the protection data segment number
+AD4 is bigger than 1. Then we can save huge pre-alocation, for example,
+AD4 500

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


