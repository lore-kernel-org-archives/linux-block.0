Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C43C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 07:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611172073E
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 07:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgFSHq2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:46:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:56566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgFSHq2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 03:46:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CF271B195;
        Fri, 19 Jun 2020 07:46:25 +0000 (UTC)
Date:   Fri, 19 Jun 2020 09:46:25 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        Keith Busch <keith.busch@wdc.com>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv2 4/5] nvme: support for multi-command set effects
Message-ID: <20200619074625.jgeh3pynd5iff4pk@beryllium.lan>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-5-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618145354.1139350-5-kbusch@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 18, 2020 at 07:53:53AM -0700, Keith Busch wrote:
> From: Keith Busch <keith.busch@wdc.com>
> 
> The Commands Supported and Effects log page was extended with a CSI
> field that enables the host to query the log page for each command set
> supported. Retrieve this log page for each command set that an attached
> namespace supports, and save a pointer to that log in the namespace head.
> 
> Reviewed-by: Javier González <javier.gonz@samsung.com>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Keith Busch <keith.busch@wdc.com>

/me did also spot the double new line :)

Reviewed-by: Daniel Wagner <dwagner@suse.de>
